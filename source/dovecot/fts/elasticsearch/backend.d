module dovecot.fts.elasticsearch.backend;
import dovecot.api;

// #include "http-client.h"
// #include <json-c/json.h>

import dovecot.fts.elasticsearch.plugin;
import dovecot.fts.elasticsearch.conn;

alias fts_backend=struct_fts_backend;
alias mailbox = struct_mailbox;
alias fts_backend_update_context = struct_fts_backend_update_context;
alias mail_search_arg = struct_mail_search_arg;
alias fts_result = struct_fts_result;
alias fts_backend_build_key = struct_fts_backend_build_key;
alias fts_lookup_flags = struct_fts_lookup_flags;

/* default bulk index size of 5MB */
 //#define ELASTICSEARCH_BULK_SIZE 5000000

/* values that must be escaped in query fields */
static const(char)* es_query_escape_chars = `"\`;

/* values that must be escaped in a bulk update value field */
static const(char)* es_update_escape_chars = `"\`;

/* values that must be escaped in field names */
static const(char)* es_field_escape_chars = `.#*"`;

/* the search JSON */
__gshared auto JSON_SEARCH = 
    `{ 
        "query": { 
            "multi_match": {
                "query": "%s",
                "operator": "%s", 
                "fields": [ %s ]
            }
        },
        "fields": [ "uid", "box" ],
        "size": %lu
    }`;

/* the last_uid lookup json */
__gshared auto JSON_LAST_UID =
    `{ 
      "sort": { 
        "uid": "desc"
      },
      "query": {
        "match_all": { }
      },
      "fields": [
        "uid"
      ],
      "size": 1
    }`;

/* bulk index header */
__gshared auto JSON_BULK_HEADER =
    `{ 
      "%s": {
        "_index": "%s",
        "_type": "%s",
        "_id\": %d
      }
    }`;

struct elasticsearch_fts_backend
{
    fts_backend backend;
    elasticsearch_connection *elasticsearch_conn;
}

struct elasticsearch_fts_backend_update_context
{
    import std.bitmanip;
    fts_backend_update_context ctx;

    mailbox* prev_box;
    char[MAILBOX_GUID_HEX_LENGTH + 1] box_guid;
    
    uint prev_uid;

    /* used to build multi-part messages. */
    string_t *temp_body;
    string_t *current_field;

    /* build a json string for bulk indexing */
    string_t *json_request;

    /* temporary storage for various operations */
    string_t *temp;

    /* current request size */
    size_t request_size;

    mixin(bitfields!(
        uint,"body_open",1,
        uint,"documents_added",1,
        uint,"expunges",1,
        uint,"junk",5
    ));
}

static const(char)* es_replace(const(char)* str, const(char)* replace)
{
    string_t *ret;
    uint i;

    ret = t_str_new(strlen(str) + 16);

    for (i = 0; str[i] != '\0'; i++) {
        if (strchr(replace, str[i]) !is null)
            str_append_c(ret, '_');
        else
            str_append_c(ret, str[i]);
    }

    return str_c(ret);
}

static const(char)* es_escape(const(char)* str, const(char)* escape)
{
    string_t *ret;
    uint i;

    ret = t_str_new(strlen(str) + 16);

    for (i = 0; str[i] != '\0'; i++) {
        if (strchr(escape, str[i]) !is null)
            str_append_c(ret, '\\');

        /* escape control characters that JSON isn't a fan of */
        switch(str[i])
        {
            case '\t': str_append(ret, "\\t"); break;
            case '\b': str_append(ret, "\\b"); break;
            case '\n': str_append(ret, "\\n"); break;
            case '\r': str_append(ret, "\\r"); break;
            case '\f': str_append(ret, "\\f"); break;
            case 0x1C: str_append(ret, "0x1C"); break;
            case 0x1D: str_append(ret, "0x1D"); break;
            case 0x1E: str_append(ret, "0x1E"); break;
            case 0x1F: str_append(ret, "0x1F"); break;
            default: str_append_c(ret, str[i]); break;
        }
    }

    return str_c(ret);
}

const(char)* es_update_escape(const(char)* str)
{
    return es_escape(str, es_update_escape_chars);
}

const(char)* es_query_escape(const(char)* str)
{
    return es_escape(str, es_query_escape_chars);
}

fts_backend *fts_backend_elasticsearch_alloc()
{
    elasticsearch_fts_backend *backend;

    backend = i_new(elasticsearch_fts_backend, 1);
    backend.backend = fts_backend_elasticsearch;

    return &backend.backend;
}

int fts_backend_elasticsearch_init(fts_backend *_backend, const(char)** error_r)
{
    elasticsearch_fts_backend *backend = null;
    fts_elasticsearch_user *fuser = null;

    /* ensure our backend is provided */
    if (_backend !is null) {
        backend = cast(elasticsearch_fts_backend*)_backend;
    } else {
        *error_r = "fts_elasticsearch: error during backend initilisation";

        return -1;
    }
    
    fuser = FTS_ELASTICSEARCH_USER_CONTEXT(_backend.ns.user);

    if (fuser is null) {
        *error_r = "Invalid fts_elasticsearch setting";

        return -1;
    }

    return elasticsearch_connection_init(fuser.set.url, fuser.set.debug_, &backend.elasticsearch_conn, error_r);
}

void fts_backend_elasticsearch_deinit(fts_backend *_backend)
{
    i_free(_backend);
}

void fts_backend_elasticsearch_bulk_end(elasticsearch_fts_backend_update_context *_ctx)
{
    elasticsearch_fts_backend_update_context *ctx = null;

    /* ensure we have a context */
    if (_ctx !is null) {
        ctx = cast (elasticsearch_fts_backend_update_context *)_ctx;

        /* close up this line in the bulk request */
        str_append(ctx.json_request, "}\n");

        /* clean-up for the next message */
        str_truncate(ctx.temp_body, 0);
        str_truncate(ctx.current_field, 0);

        if (ctx.body_open) {
            ctx.body_open = false;
        }
    }
}

int fts_backend_elasticsearch_get_last_uid(fts_backend*_backend, mailbox* box, uint* last_uid_r)
{
    fts_index_header hdr;
    elasticsearch_fts_backend *backend = null;
    const(char)* box_guid = null;
    int ret;

    /* ensure our backend has been initialised */
    if (_backend is null || box is null || last_uid_r is null) {
        i_error("fts_elasticsearch: critical error in get_last_uid");

        return -1;
    } else {
        /* keep track of our backend */
        backend = cast(elasticsearch_fts_backend *)_backend;
    }

    /**
     * assume the dovecot index will always match ours for uids. this saves
     * on repeated calls to ES, particularly noticable when fts_autoindex=true.
     *
     * this has a couple of side effects:
     *  1. if the ES index has been blown away, this will return a valid
     *     last_uid that matches Dovecot and it won't realise we need updating
     *  2. if data has been indexed by Dovecot but missed by ES (outage, etc)
     *     then it won't ever make it to the ES index either.
     *
     * TODO: find a better way to implement this
     **/
    if (fts_index_get_header(box, &hdr)) {
        *last_uid_r = hdr.last_indexed_uid;

        return 0;
    } 

    if (fts_mailbox_get_guid(box, &box_guid) < 0) {
        i_error("fts-elasticsearch: get_last_uid: failed to get mbox guid");

        return -1;
    }

    /* call ES */
    ret = elasticsearch_connection_last_uid(backend.elasticsearch_conn,
        JSON_LAST_UID, box_guid);

    if (ret > 0) {
        *last_uid_r = ret;

        fts_index_set_last_uid(box, *last_uid_r);

        return 0;
    }
    
    *last_uid_r = 0;

    fts_index_set_last_uid(box, *last_uid_r);

    return 0;
}

fts_backend_update_context* fts_backend_elasticsearch_update_init(fts_backend *_backend)
{
    elasticsearch_fts_backend_update_context* ctx = null;

    ctx = i_new(elasticsearch_fts_backend_update_context, 1);
    ctx.ctx.backend = _backend;

    /* allocate strings for building messages and multi-part messages
     * with a sensible initial size. */
    ctx.current_field = str_new(default_pool, 1024);
    ctx.temp_body = str_new(default_pool, 1024 * 64);
    ctx.temp = str_new(default_pool, 1024 * 64);
    ctx.json_request = str_new(default_pool, 1024 * 64);
    ctx.request_size = 0;

    return &ctx.ctx;
}

int fts_backend_elasticsearch_update_deinit(fts_backend_update_context* _ctx)
{
    elasticsearch_fts_backend_update_context *ctx = null;
    elasticsearch_fts_backend *backend = null;

    /* validate our input parameters */
    if (_ctx is null || _ctx.backend is null) {
        i_error("fts_elasticsearch: critical error in update_deinit");

        return -1;
    } else {
        ctx = cast(elasticsearch_fts_backend_update_context *)_ctx;
        backend = cast(elasticsearch_fts_backend *)_ctx.backend;
    }

    /* clean-up: expunges don't need as much clean-up */
    if (!ctx.expunges) {
        /* this gets called when the last message is finished, so close it up */
        fts_backend_elasticsearch_bulk_end(ctx);

        /* cleanup */
        memset(ctx.box_guid, 0, sizeof(ctx.box_guid));
        str_free(&ctx.current_field);
        str_free(&ctx.temp_body);
        str_free(&ctx.temp);
        ctx.request_size = 0;
    }

    /* perform the actual post */
    elasticsearch_connection_update(backend.elasticsearch_conn,
                                    str_c(ctx.json_request));

    /* global clean-up */
    str_free(&ctx.json_request); 
    i_free(ctx);
    
    return 0;
}

void fts_backend_elasticsearch_update_set_mailbox(fts_backend_update_context *_ctx, mailbox *box)
{
    elasticsearch_fts_backend_update_context *ctx = null;
    const(char)* box_guid = null;

    if (_ctx !is null) {
        ctx = cast(elasticsearch_fts_backend_update_context *)_ctx;

        /* update_set_mailbox has been called but the previous uid is not 0;
         * clean up from our previous mailbox indexing. */
        if (ctx.prev_uid != 0) {
            fts_index_set_last_uid(ctx.prev_box, ctx.prev_uid);

            ctx.prev_uid = 0;
        }

        if (box !is null) {
            if (fts_mailbox_get_guid(box, &box_guid) < 0) {
                i_debug("fts-elasticsearch: update_set_mailbox: fts_mailbox_get_guid failed");

                _ctx.failed = true;
            }

            /* store the current mailbox we're on in our state struct */
            i_assert(strlen(box_guid) == sizeof(ctx.box_guid) - 1);
            memcpy(ctx.box_guid, box_guid, sizeof(ctx.box_guid) - 1);
        } else {
            /* a box of null appears to indicate that indexing is complete. */
            memset(ctx.box_guid, 0, sizeof(ctx.box_guid));
        }

        ctx.prev_box = box;
    } else {
        i_error("fts_elasticsearch: update_set_mailbox: context was null");

        return;
    }
}

void elasticsearch_add_update_field(string_t *temp, string_t *message, string_t *field, string_t *value)
{
    str_truncate(temp, 0);

    str_printfa(temp,
                ", \"%s\": \"%s\"",
                es_replace(str_c(field), es_field_escape_chars),
                es_update_escape(str_c(value)));

    str_append_str(message, temp);
}

void fts_backend_elasticsearch_bulk_start(elasticsearch_fts_backend_update_context *_ctx, uint uid, string_t *json_request,
                                   const(char)* action_name)
{
    elasticsearch_fts_backend_update_context *ctx = cast(elasticsearch_fts_backend_update_context *)_ctx;
    string_t *temp = str_new(default_pool, 1024);

    /* track that we've added documents */
    ctx.documents_added = true;

    /* add the header that starts the bulk transaction */
    str_printfa(temp, JSON_BULK_HEADER, action_name, ctx.box_guid, "mail", uid);
    str_append_str(json_request, temp);
    str_append(json_request, "\n");

    /* expunges don't need anything more than the action line */
    if (!ctx.expunges) {
        /* reusing the same temp variable */
        str_truncate(temp, 0);

        /* add the first two fields; these are static on every message. */
        str_printfa(temp, "{ \"uid\": %d, \"box\": \"%s\"", uid, ctx.box_guid);
        str_append_str(json_request, temp);
    }

    /* clean-up */
    str_free(&temp);
}

void fts_backend_elasticsearch_uid_changed(fts_backend_update_context *_ctx, uint uid)
{
    elasticsearch_fts_backend_update_context *ctx = cast(elasticsearch_fts_backend_update_context*) _ctx;
    elasticsearch_fts_backend *backend = cast(elasticsearch_fts_backend *)_ctx.backend;

    if (ctx.documents_added) {
        /* this is the end of an old message. nb: the last message to be indexed
         * will not reach here but will instead be caught in update_deinit. */
        fts_backend_elasticsearch_bulk_end(ctx);
    }

    /* chunk up our requests in to reasonable sizes */
    if (ctx.request_size > ELASTICSEARCH_BULK_SIZE) {  
        /* close the document */
        fts_backend_elasticsearch_bulk_end(ctx);

        /* do an early post */
        elasticsearch_connection_update(backend.elasticsearch_conn,
                                        str_c(ctx.json_request));

        /* reset our tracking variables */
        str_truncate(ctx.json_request, 0);
        ctx.request_size = 0;
    }
    
    ctx.prev_uid = uid;
    
    fts_backend_elasticsearch_bulk_start(ctx, uid, ctx.json_request, "index");
}

bool fts_backend_elasticsearch_update_set_build_key(fts_backend_update_context *_ctx, const(fts_backend_build_key)* key)
{
    elasticsearch_fts_backend_update_context* ctx = null;

    /* validate our input */
    if (_ctx is null || key is null) {
        return false;
    } else {
        ctx = cast(elasticsearch_fts_backend_update_context *)_ctx;
    }

    /* if the uid doesn't match our expected one, we've moved on to a new message */
    if (key.uid != ctx.prev_uid) {
        fts_backend_elasticsearch_uid_changed(_ctx, key.uid);
    }

    switch (key.type) {
    case FTS_BACKEND_BUILD_KEY_HDR: /* fall through */
    case FTS_BACKEND_BUILD_KEY_MIME_HDR:
        str_printfa(ctx.current_field, "%s", t_str_lcase(key.hdr_name));

        break;
    case FTS_BACKEND_BUILD_KEY_BODY_PART:
        if (!ctx.body_open) {
            ctx.body_open = true;
            str_append(ctx.current_field, "body");
        }

        break;
    case FTS_BACKEND_BUILD_KEY_BODY_PART_BINARY:
        i_unreached();
    }

    return true;
}

int fts_backend_elasticsearch_update_build_more(fts_backend_update_context* _ctx, const(ubyte)* data, size_t size)
{
    elasticsearch_fts_backend_update_context *ctx;

    if (_ctx !is null) {
        ctx = cast(elasticsearch_fts_backend_update_context *)_ctx;

        /* build more message body */
        str_append_n(ctx.temp_body, data, size);

        /* keep track of the total request size for chunking */
        ctx.request_size += size;

        return 0;
    } else {
        i_error("fts_elasticsearch: update_build_more: critical error building message body");

        return -1;
    }
}

void fts_backend_elasticsearch_update_unset_build_key(fts_backend_update_context* _ctx)
{
    elasticsearch_fts_backend_update_context *ctx = null;

    if (_ctx !is null) {
        ctx = cast(elasticsearch_fts_backend_update_context*)_ctx;

        /* field is complete, add it to our message. */
        elasticsearch_add_update_field(ctx.temp, ctx.json_request, ctx.current_field, ctx.temp_body);

        /* clean-up our temp */
        str_truncate(ctx.temp_body, 0);
        str_truncate(ctx.current_field, 0);
    }
}

void fts_backend_elasticsearch_update_expunge(fts_backend_update_context *_ctx, uint uid)
{
    elasticsearch_fts_backend_update_context *ctx = cast(elasticsearch_fts_backend_update_context *)_ctx;

    /* update the context to note that there have been expunges */
    ctx.expunges = true;

    /* add the delete action */
    fts_backend_elasticsearch_bulk_start(ctx, uid, ctx.json_request, "delete");
}

int fts_backend_elasticsearch_refresh(fts_backend *_backend)
{
    elasticsearch_fts_backend *backend = cast(elasticsearch_fts_backend *)_backend;

    elasticsearch_connection_refresh(backend.elasticsearch_conn);

    return 0;
}

int fts_backend_elasticsearch_rescan(fts_backend *backend)
{    
    return fts_backend_reset_last_uids(backend);
}

int fts_backend_elasticsearch_optimize(fts_backend *backend)
{
    return 0;
}

bool elasticsearch_add_definite_query(mail_search_arg *arg, string_t *value, string_t *fields)
{
    /* validate our input */
    if (arg is null || value is null || fields is null) {
        i_error("fts_elasticsearch: critical error while building query");

        return false;
    }

    switch (arg.type) {
    case SEARCH_TEXT:
        /* we don't actually have to do anything here; leaving the fields
         * array blank is sufficient to cause full text search with ES */

        break;
    case SEARCH_BODY:
        /* SEARCH_BODY has a hdr_field_name of null. we append a comma here 
         * because body can be selected in addition to other fields. it's 
         * trimmed later before being passed to ES if it's the last element. */
        str_append(fields, `"body",`);

        break;
    case SEARCH_HEADER: /* fall through */
    case SEARCH_HEADER_ADDRESS: /* fall through */
    case SEARCH_HEADER_COMPRESS_LWSP:
        if (!fts_header_want_indexed(arg.hdr_field_name)) {
            i_debug("fts-elasticsearch: field %s was skipped", arg.hdr_field_name);

            return false;
        }

        str_append(fields, "\"");
        str_append(fields, t_str_lcase(es_query_escape(arg.hdr_field_name)));
        str_append(fields, "\",");

        break;
    default:
        return false;
    }

    if (arg.match_not) {
        i_debug("fts-elasticsearch: arg.match_not is true");
    }
    

    return true;
}

bool elasticsearch_add_definite_query_args(string_t *fields, string_t *value, mail_search_arg* arg)
{
    bool field_added = false;

    if (fields is null || value is null || arg is null) {
        i_error("fts_elasticsearch: critical error while building query");

        return false;
    }

    for (; arg !is null; arg = arg.next) {
        /* multiple fields have an initial arg of nothing useful and subargs */
        if (arg.value.subargs !is null) {
            field_added = elasticsearch_add_definite_query_args(fields, value,
                arg.value.subargs);
        }

        if (elasticsearch_add_definite_query(arg, value, fields)) {
            /* the value is the same for every arg passed, only add the value
             * to our search json once. */
            if (!field_added) {
                /* we always want to add the value */
                str_append(value, es_query_escape(arg.value.str));
            }

            /* this is important to set. if this is false, Dovecot will fail
             * over to its regular built-in search to produce results for
             * this argument. */
            arg.match_always = true;
            field_added = true;
        }
    }

    return field_added;
}

int fts_backend_elasticsearch_lookup(fts_backend* _backend, mailbox *box, mail_search_arg* args, fts_lookup_flags flags, fts_result *result)
{
    /* state tracking */
    elasticsearch_result **es_results = null;
    bool and_args = (flags & FTS_LOOKUP_FLAG_AND_ARGS) != 0;

    /* mailbox information */
    mailbox_status status;
    const(char)* box_guid = null;

    /* temp variables */
    pool_t pool = pool_alloconly_create("fts elasticsearch search", 1024);
    int ret = -1;
    size_t num_rows = 0;
    /* json query building */
    string_t *str = str_new(pool, 1024);
    string_t *query = str_new(pool, 1024);
    string_t *fields = str_new(pool, 1024);

    /* validate our input */
    if (_backend is null || box is null || args is null || result is null) {
        i_error("fts_elasticsearch: critical error during lookup");

        return -1;
    }

    auto backend = cast (elasticsearch_fts_backend *) _backend;
    

    /* get the mailbox guid */
    if (fts_mailbox_get_guid(box, &box_guid) < 0) {
        return -1;
    }

    /* open the mailbox */
    mailbox_get_open_status(box, STATUS_UIDNEXT, &status);

    /* default ES is limited to 10,000 results */
    /* TODO: paginate? */
    if (status.uidnext >= 10000) {
        num_rows = 10000;
    } else {
        num_rows = status.uidnext;
    }

    /* attempt to build the query */
    if (!elasticsearch_add_definite_query_args(fields, query, args)) {
        return -1;
    }

    /* remove the trailing ',' */
    str_delete(fields, str_len(fields) - 1, 1);

    /* if no fields were added, add _all as our only field */
    if (str_len(fields) == 0) {
        str_append(fields, "\"_all\"");
    }

    /* parse the json */
    str_printfa(str, JSON_SEARCH, str_c(query),
                and_args == 1 ? "and" : "or", str_c(fields), num_rows);
    
    ret = elasticsearch_connection_select(backend.elasticsearch_conn, pool,
                                          str_c(str), box_guid, &es_results);

    /* build our fts_result return */
    result.box = box;
    result.scores_sorted = false;

    /* FTS_LOOKUP_FLAG_NO_AUTO_FUZZY says that exact matches for non-fuzzy searches
     * should go to maybe_uids instead of definite_uids. */
    ARRAY_TYPE(seq_range) *uids_arr = (flags & FTS_LOOKUP_FLAG_NO_AUTO_FUZZY) == 0 ?
            &result.definite_uids : &result.maybe_uids;

    if (ret > 0 && es_results !is null) {
        array_append_array(uids_arr, &es_results[0].uids);
        array_append_array(&result.scores, &es_results[0].scores);
    }

    /* clean-up */
    pool_unref(&pool);
    str_free(&str);
    str_free(&query);
    str_free(&fields);

    return ret;
}

shared static this()
{
    struct_fts_backend_vfuncs vfuncs;
    with(vfuncs)
    {
        .alloc =        &fts_backend_elasticsearch_alloc;
        .init =         &fts_backend_elasticsearch_init;
        .deinit =       &fts_backend_elasticsearch_deinit;
        .get_last_uid = &fts_backend_elasticsearch_get_last_uid;
        .update_init =  &fts_backend_elasticsearch_update_init;
        .update_deinit = &fts_backend_elasticsearch_update_deinit;
        .update_set_mailbox = &fts_backend_elasticsearch_update_set_mailbox;
        .update_expunge = &fts_backend_elasticsearch_update_expunge;
        .update_set_build_key = &fts_backend_elasticsearch_update_set_build_key;
        .update_unset_build_key = &fts_backend_elasticsearch_update_unset_build_key;
        .update_build_more = &fts_backend_elasticsearch_update_build_more;
        .refresh = &fts_backend_elasticsearch_refresh;
        .rescan = &fts_backend_elasticsearch_rescan;
        .optimize = &fts_backend_elasticsearch_optimize;
        .lookup = &fts_backend_default_can_lookup;
        .lookup_multi = &fts_backend_elasticsearch_lookup;
        .lookup_done = null;
    }
    with(fts_backend_elasticsearch)
    {
        .name = "elasticsearch".ptr;
        .flags = FTS_BACKEND_FLAG_FUZZY_SEARCH;
        .v = vfuncs;
    }
}

    
__gshared struct_fts_backend fts_backend_elasticsearch;



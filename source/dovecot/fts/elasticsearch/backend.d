module dovecot.fts.elasticsearch.backend;
import dovecot.api;
import asdf;
import dovecot.fts.elasticsearch.plugin;
import dovecot.fts.elasticsearch.conn;
import dovecot.fts.elasticsearch.util;
import dovecot.fts.elasticsearch.json;
import dovecot.fts.elasticsearch.wrap;

enum MAILBOX_GUID_HEX_LENGTH = 1024;
enum ELASTICSEARCH_BULK_SIZE = 5_000_000; // 5MiB


struct Backend
{
    fts_backend backend;
    elasticsearch_connection *elasticsearch_conn;

    this(fts_backend *_backend, const(char)** error_r)
    {
        Backend *backend = null;
        fts_elasticsearch_user *fuser = null;

        /* ensure our backend is provided */
        if (_backend !is null) {
            backend = cast(Backend*)_backend;
        } else {
            *error_r = "fts_elasticsearch: error during backend initilisation";

            return -1;
        }
        
        //fuser = FTS_ELASTICSEARCH_USER_CONTEXT(_backend.ns.user);

        if (fuser is null) {
            *error_r = "Invalid fts_elasticsearch setting";

            return -1;
        }

        return elasticsearch_connection_init(fuser.set.url, fuser.set.debug_, &backend.elasticsearch_conn, error_r);
    }

    ~this()
    {
        i_free(_backend);
    }
    
    auto getLastUID(ref Mailbox box, int* last_uid_r)
    {
        struct_fts_index_header hdr;
        Backend backend;
        int ret;

        /* ensure our backend has been initialised */
        if (_backend is null || box is null || last_uid_r is null) {
            i_error("fts_elasticsearch: critical error in get_last_uid".ptr);

            return -1;
        } else {
            /* keep track of our backend */
            backend = cast(Backend *)_backend;
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

        auto boxGUID = getGUID(mailbox);
        /* call ES */
        ret = lastUID(backend.connection, JSON_LAST_UID.ptr, boxGUID);

        if (ret > 0) {
            *last_uid_r = ret;

            //fts_index_set_last_uid(box, *last_uid_r);

            return 0;
        }
        
        *last_uid_r = 0;

        //fts_index_set_last_uid(box, *last_uid_r);

        return 0;
    }

    auto updateInit(fts_backend *_backend)
    {
        Context ctx;
        ctx = cast(Context*) i_new(ctx, 1);
        ctx.ctx.backend = _backend;

        /* allocate strings for building messages and multi-part messages
         * with a sensible initial size. */
        //ctx.current_field = str_new(default_pool, 1024);
        //ctx.temp_body = str_new(default_pool, 1024 * 64);
        //ctx.temp = str_new(default_pool, 1024 * 64);
        //ctx.json_request = str_new(default_pool, 1024 * 64);
        ctx.current_field = str_new( 1024);
        ctx.temp_body = str_new( 1024 * 64);
        ctx.temp = str_new( 1024 * 64);
        ctx.json_request = str_new( 1024 * 64);
        ctx.request_size = 0;

        return &ctx.ctx;
    }

}

struct Context
{
    import std.bitmanip;
    fts_backend_update_context ctx;
    mailbox* prev_box;
    string boxGUID;
    uint prev_uid;

    string tempBody;
    string currentField;
    string jsonRequest;
    string temp;
    bool bodyOpen;
    bool documentsAdded;
    bool expunges;
}

void setMailbox(ref Context context, Mailbox mailbox, bool isIndexingComplete = false)
{
    try
    {
        /* update_set_mailbox has been called but the previous uid is not 0;
         * clean up from our previous mailbox indexing. */
        if (context.previousUID != 0) {
            setLastUID(context.previousMailbox, context.previousUID);
            context.previousUIDs = 0;
        }

        context.boxGUID =   (!isIndexingComplete) ? getGUID(mailbox) : "";
    }
    catch(Exception e)
    {
        i_debug("fts-elasticsearch: update_set_mailbox: " ~ e.to!string);
        context.failed = true;
    }

    context.previousMailbox = mailbox;
}

 else {
        i_error("fts_elasticsearch: update_set_mailbox: context was null");

        return;
    }
}


void bulkEnd(ref Context context)
{
    /* close up this line in the bulk request */
    context.jsonRequest~= "}\n";

    /* clean-up for the next message */
    context.tempBody.length = 0;
    context.currentField.length = 0;

    if (context.bodyOpen)
        context.bodyOpen = false;
    }
}

int deinit(ref Context context)
{
    /* validate our input parameters */
    if (_ctx is null || _ctx.backend is null) {
        i_error("fts_elasticsearch: critical error in update_deinit");

        return -1;
    }

    /* clean-up: expunges don't need as much clean-up */
    if (!context.expunges) {
        /* this gets called when the last message is finished, so close it up */
        fts_backend_elasticsearch_bulk_end(ctx);
        /* cleanup */
        context.boxGUID.length = 0;
        context.currentField.length = 0 ;
        context.tempBody.length = 0;
        context.temp.length =0;
    }

    /* perform the actual post */
    update(backend.connection, context.jsonRequest);
    context.jsonRequest.length = 0;
    /* global clean-up */
    context.destroy();
    return 0;
}




void updateField(ref Context context, string field, string value)
{
    context.jsonRequest ~= format!`, "%s": "%s"`(es_replace(field, es_field_escape_chars),es_update_escape(value));
}

void bulkStart(ref Context context, uint uid, string jsonRequest, BulkAction bulkAction)
{
    // track that we've added documents
    context.documentsAdded = true;

    // add the header that starts the bulk transaction
    jsonRequest ~= format!JSON_BULK_HEADER(bulkAction.toString, context.boxGUID, "mail", uid)
                ~ "\n";
    /* expunges don't need anything more than the action line */
    if (!context.expunges)
    {
        /* add the first two fields; these are static on every message. */
        jsonRequest ~= format!`{ "uid": %s, "box": "%s"`(uid, ctx.box_guid);
    }
    context.jsonRequest = jsonRequest;
}

void uidChanged(ref Context context, uint uid)
{
    auto backend = context.backend;

    if (context.documentsAdded) {
        /* this is the end of an old message. nb: the last message to be indexed
         * will not reach here but will instead be caught in update_deinit. */
        bulkEnd(context);
    }

    /* chunk up our requests in to reasonable sizes */
    if (context.requestSize > ELASTICSEARCH_BULK_SIZE) {  
        /* close the document */
        bulkEnd(context);

        /* do an early post */
        update(connection, context.jsonRequest);

        /* reset our tracking variables */
        context.jsonRequest.length=0;
    }
    
    context.previousUID = uid;
    
    bulkStart(context, uid, context.jsonRequest, BulkAction.index);
}

enum BulkAction
{
    index,
    delete_,
}

string toString(BulkAction bulkAction)
{
    import std.conv:to;
    auto ret = bulkAction.to!string;
    return (ret[$-1]=='_')? ret[0..$-1] : ret;
}
auto setBuildKey(ref Context context, BuildKey key)
{
    /* if the uid doesn't match our expected one, we've moved on to a new message */
    if (key.uid != context.previousUID) {
        uidChanged(context, key.uid);
    }

    switch (key.type) with(FTSBackendBuildKeyType)
    {
        case header: /* fall through */
        case mimeHeader:
            //str_printfa(ctx.current_field, "%s", t_str_lcase(key.hdr_name));

            break;
        case bodyPart:
            if (!context.bodyOpen) {
                context.bodyOpen= true;
                context.currentField~="body";
            }

            break;
        case bodyPartBinary:
        default:
            //i_unreached();
    }

    return true;
}

void buildMore(ref Context context, ubyte[] data)
{
        context.tempBody ~= data[0..size];
}

void unsetBuildKey(ref Context context)
{
    /* field is complete, add it to our message. */
    updateField(context.jsonRequest, context.currentField, context.tempBody);
    context.tempBody.length = 0;
    context.currentField.length=0;
}

void updateExpunge(ref Context context, int uid)
{
    context.expunges = true;
    /* add the delete action */
    bulkStart(context, uid, context.jsonRequest, BulkAction.delete_);
}

void refresh(ref Backend backend)
{
    refresh(backend.elasticsearchConnection);
}

auto rescan(ref Backend backend)
{    
    return resetLastUIDs(backend);
}

void optimize(ref Backend backend)
{
}

auto addDefiniteQuery(ref MailSearchArg *arg, string value, string[] fields)
{
    /* validate our input */
    if (arg is null || value is null || fields is null) {
        i_error("fts_elasticsearch: critical error while building query");

        return false;
    }

    switch (arg.type)with(mail_search_arg_type)
    {
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
                //i_debug("fts-elasticsearch: field %s was skipped", arg.hdr_field_name);

                return false;
            }

            str_append(fields, "\"");
            str_append(fields, t_str_lcase(es_query_escape(arg.hdr_field_name)));
            str_append(fields, "\",");

            break;
        default:
            return false;
    }

/*    if (arg.match_not) {
        i_debug("fts-elasticsearch: arg.match_not is true");
    }
  */  

    return true;
}

bool addDefiniteQueryArgs(string[] fields, string value, MailSearchArg[] args)
{
    bool fieldAdded = false;

    for (; arg !is null; arg = arg.next) {
        /* multiple fields have an initial arg of nothing useful and subargs */
        if (arg.value.subargs !is null) {
            field_added = addDefiniteQueryArgs(fields, value, arg.value.subargs);
        }

        if (addDefiniteQuery(arg, value, fields)) {
            /* the value is the same for every arg passed, only add the value
             * to our search json once. */
            if (!field_added) {
                /* we always want to add the value */
                value~= es_query_escape(arg.value.str));
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

int lookup(ref Backend backend, mailbox* box, struct_mail_search_arg* args, fts_lookup_flags flags, fts_result *result)
{
    /* state tracking */
    Result[] results;
    //elasticsearch_result **es_results = null;
    bool and_args = (flags & FTS_LOOKUP_FLAG_AND_ARGS) != 0;

    /* mailbox information */
    MailboxStatus status;
    const(char)* box_guid = null;

    /* temp variables */
    pool_t pool = pool_alloconly_create("fts elasticsearch search", 1024);
    int ret = -1;
    size_t num_rows = 0;
    string str,query,fieldsString;

    // validate our input
    if (_backend is null || box is null || args is null || result is null) {
        i_error("fts_elasticsearch: critical error during lookup");

        return -1;
    }

    /* get the mailbox guid */
    if (fts_mailbox_get_guid(box, &box_guid) < 0) {
        return -1;
    }

    /* open the mailbox */
    auto status = box.getOpenStatus(MailboxStatusItems.uidNext);


    /* default ES is limited to 10,000 results */
    /* TODO: paginate? */
    if (status.uidnext >= 10000) {
        num_rows = 10000;
    } else {
        num_rows = status.uidnext;
    }

    /* attempt to build the query */
    if (!addDefiniteQueryArgs(fields, query, args)) {
        return -1;
    }

    /* remove the trailing ',' */
    fieldsString.length = fieldsString.length -1;

    /* if no fields were added, add _all as our only field */
    if (fieldsString.length == 0)
    {
        fieldsString = `"_all"`;
    }

    /* parse the json */
    //str_printfa(str, JSON_SEARCH, str_c(query),
      //          and_args == 1 ? "and" : "or", str_c(fields), num_rows);
    
    ret = elasticsearch_connection_select(backend.elasticsearch_conn, pool,
                                          str_c(str), box_guid, &es_results);

    /* build our fts_result return */
    //result.box = box;
    result.scoresSorted = false;

    /* FTS_LOOKUP_FLAG_NO_AUTO_FUZZY says that exact matches for non-fuzzy searches
     * should go to maybe_uids instead of definite_uids. */
    /*mixin (ARRAY_TYPE!(seq_range)) *uids_arr = (flags & FTS_LOOKUP_FLAG_NO_AUTO_FUZZY) == 0 ?
            &result.definite_uids : &result.maybe_uids;
*/
    if (ret > 0 && es_results !is null) {
        //array_append_array(uids_arr, &es_results[0].uids);
        //array_append_array(&result.scores, &es_results[0].scores);
    }

    /* clean-up */
    pool_unref(&pool);
    str_free(&str);
    str_free(&query);
    str_free(&fields);

    return ret;
}

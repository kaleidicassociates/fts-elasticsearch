module dovecot.fts.elasticsearch.conn;
/* Copyright (c) 2006-2014 Dovecot authors, see the included COPYING file */
/* Copyright (c) 2014 Joshua Atkins <josh@ascendantcom.com> */

//#include <stdio.h>

alias json_object = void*;
alias pool_t = void*;
enum elasticsearch_post_type {
    ELASTICSEARCH_POST_TYPE_UPDATE = 0,
    ELASTICSEARCH_POST_TYPE_SELECT,
    ELASTICSEARCH_POST_TYPE_LAST_UID,
    ELASTICSEARCH_POST_TYPE_REFRESH,
}
alias ARRAY_TYPE(T) = T[];
struct elasticsearch_result {
    const(char)* box_id;

    ARRAY_TYPE!(seq_range) uids;
    ARRAY_TYPE!(fts_score_map) scores;
};


alias http_response = void*;
void json_parse(json_object * jobj, elasticsearch_connection *conn);


http_client_request* elasticsearch_connection_http_request(elasticsearch_connection *conn, const(char)* url);
http_client *elasticsearch_http_client =  null;

struct elasticsearch_lookup_context
{
    pool_t result_pool;

    /* results per mailbox */
    HASH_TABLE!(char *, elasticsearch_result *) mailboxes;

    /* temporary results */
    ARRAY!( elasticsearch_result *) results;

    /* current mailbox */
    const(char)* box_guid;

    /* current message */
    int uid;
    float score;

    /* current email as a string */
    string_t *email;
    
    bool results_found;
};

struct elasticsearch_connection
{
    import std.bitmanip;
    /* ElasticSearch HTTP API information */
    char *http_host;
    in_port_t http_port;
    char *http_base_url;
    char *http_failure;
    int request_status;

    /* for streaming processing of results */
    istream *payload;
    io *io;

    elasticsearch_post_type post_type;

    /* context for the current lookup */
    elasticsearch_lookup_context *ctx;
    mixin(bitfields!(
        uint,"debug_",1,
        uint,"http_ssl",1,
        uint,"junk",6
    ));
}

int elasticsearch_connection_init(const(char)* url, bool debug_,
                                      elasticsearch_connection **conn_r,
                                      const(char)* *error_r)
{
    http_client_settings http_set;
    elasticsearch_connection *conn =  null;
    http_url *http_url =  null;
    const(char)* error =  null;

    if (error_r is  null || url is  null || conn_r is  null) {
        i_debug("fts_elasticsearch: error initialising ElasticSearch connection");
        return -1;
    }

    /* validate the url */
    if (http_url_parse(url,  null, 0, pool_datastack_create(),
               &http_url, &error) < 0) {
        *error_r = t_strdup_printf(
            "fts_elasticsearch: Failed to parse HTTP url: %s", error);

        return -1;
    }

    conn = i_new(elasticsearch_connection, 1);
    conn.http_host = i_strdup(http_url.host.name);
    conn.http_port = http_url.port;
    conn.http_base_url = i_strconcat(http_url.path, http_url.enc_query,  null);
    conn.http_ssl = http_url.have_ssl;
    conn.debug_ = debug_;

    /* guard against init being called multiple times */
    if (elasticsearch_http_client is  null) {
        memset(&http_set, 0, sizeof(http_set));
        http_set.max_idle_time_msecs = 5 * 1000;
        http_set.max_parallel_connections = 1;
        http_set.max_pipelined_requests = 1;
        http_set.max_redirects = 1;
        http_set.max_attempts = 3;
        http_set.debug_ = debug_;
        elasticsearch_http_client = http_client_init(&http_set);
    }

    *conn_r = conn;

    return 0;
}

void elasticsearch_connection_deinit(elasticsearch_connection *conn)
{
    if (conn !is  null) {
        i_free(conn.http_host);
        i_free(conn.http_base_url);
        i_free(conn);
    }
}

void elasticsearch_connection_update_response(const(http_response)* response, elasticsearch_connection *conn)
{
    if (response !is  null && conn !is  null ) {
        /* 200 OK, 204 continue */
        if (response.status / 100 != 2) {
            i_error("fts_elasticsearch: Indexing failed: %s", response.reason);
            conn.request_status = -1;
        }
    }
}

int elasticsearch_connection_update(elasticsearch_connection *conn, const(char)* cmd)
{
    const(char)* url =  null;

    if (conn !is  null && cmd !is  null) {
        /* set-up the connection */
        conn.post_type = ELASTICSEARCH_POST_TYPE_UPDATE;

        url = t_strconcat(conn.http_base_url, "/_bulk/",  null);

        elasticsearch_connection_post(conn, url, cmd);

        return conn.request_status;
    } else {
        i_debug("fts_elasticsearch: connection_update: conn is  null");

        return -1;
    }
}

int elasticsearch_connection_post(elasticsearch_connection* conn, const(char)* url, const(char)* cmd)
{
    http_client_request *http_req =  null;
    istream *post_payload =  null;

    if (conn is  null || url is  null || cmd is  null) {
        i_error("fts_elasticsearch: connection_post: critical error during POST");

        return -1;
    }

    /* binds a callback object to elasticsearch_connection_http_response */
    http_req = elasticsearch_connection_http_request(conn, url);

    post_payload = i_stream_create_from_data(cmd, strlen(cmd));
    http_client_request_set_payload(http_req, post_payload, true);
    i_stream_unref(&post_payload);
    http_client_request_submit(http_req);

    conn.request_status = 0;
    http_client_wait(elasticsearch_http_client);

    return conn.request_status;
}

void json_parse_array(json_object *jobj, char *key, elasticsearch_connection* conn)
{
    json_type type;
    json_object* jvalue =  null;
    json_object* jarray =  null;
    size_t arraylen;
    size_t i;

    /* first array is our entry object */
    jarray = jobj; 

    if (key) {
        static if( JSON_HAS_GET_EX)
            json_object_object_get_ex(jobj, key, &jarray);
        else
            jarray = json_object_object_get(jobj, key);
    }

    arraylen = json_object_array_length(jarray);

    /* iterate over the array and walk the tree */
    for (i = 0; i < arraylen; i++) {
        jvalue = json_object_array_get_idx(jarray, i);
        type = json_object_get_type(jvalue);

        /* parse further down arrays */
        if (type == json_type_array) {
            json_parse_array(jvalue,  null, conn);
        }
        else if (type != json_type_object) {
            /* nothing to do it if is not an object */
        } else {
            json_parse(jvalue, conn);
        }
    }
}

elasticsearch_result * elasticsearch_result_get(elasticsearch_connection *conn, const(char)* box_id)
{
    elasticsearch_result *result =  null;
    char *box_id_dup =  null;

    /* check if the mailbox is cached first */ 
    result = hash_table_lookup(conn.ctx.mailboxes, box_id);

    if (result !is  null) {
        return result;
    } else {
        /* mailbox is not cached, we have to query it and then cache it */
    }

    box_id_dup = p_strdup(conn.ctx.result_pool, box_id);
    result = p_new(conn.ctx.result_pool, elasticsearch_result, 1);
    result.box_id = box_id_dup;

    p_array_init(&result.uids, conn.ctx.result_pool, 32);
    p_array_init(&result.scores, conn.ctx.result_pool, 32);
    hash_table_insert(conn.ctx.mailboxes, box_id_dup, result);
    array_append(&conn.ctx.results, &result, 1);

    return result;
}

void elasticsearch_connection_last_uid_json(elasticsearch_connection* conn, char* key, json_object* val)
{
    json_object *jvalue =  null;

    if (conn !is  null && key !is  null && val !is  null) {
        /* only interested in the uid field */
        if (strcmp(key, "uid") == 0) {
            /* field is returned as an array */
            jvalue = json_object_array_get_idx(val, 0);
            conn.ctx.uid = json_object_get_int(jvalue);
        }
    } else {
        i_error("fts_elasticsearch: last_uid_json: critical error while getting last uid");
    }
}

void elasticsearch_connection_select_json(elasticsearch_connection* conn, char* key, json_object* val)
{
    json_object *jvalue;
    elasticsearch_result *result =  null;
    fts_score_map *tmp_score =  null;

    if (conn !is  null) {
        /* ensure a key and val exist before trying to process them */
        if (key !is  null && val !is  null) {
            if (strcmp(key, "uid") == 0) {
                jvalue = json_object_array_get_idx(val, 0);
                conn.ctx.uid = json_object_get_int(jvalue);
            }

            if (strcmp(key, "_score") == 0)
                conn.ctx.score = json_object_get_double(val);  

            if (strcmp(key, "box") == 0) {
                jvalue = json_object_array_get_idx(val, 0);
                conn.ctx.box_guid = json_object_get_string(jvalue);
            }
        }

        /* this is all we need for an e-mail result */
        if (conn.ctx.uid != -1 && conn.ctx.score != -1 && conn.ctx.box_guid !is  null) {
            result = elasticsearch_result_get(conn, conn.ctx.box_guid);
            tmp_score = array_append_space(&result.scores);

            seq_range_array_add(&result.uids, conn.ctx.uid);
            tmp_score.uid = conn.ctx.uid;
            tmp_score.score = conn.ctx.score;

            /* clean-up */
            conn.ctx.uid = -1;
            conn.ctx.score = -1;
            conn.ctx.box_guid =  null;
            conn.ctx.results_found = true;
        }
    } else { /* conn !is  null && key !is  null && val !is  null */
        i_error("fts_elasticsearch: select_json: critical error while processing result JSON");
    }
}

void json_parse(json_object *jobj, elasticsearch_connection *conn)
{
    json_type type;
    json_object *temp =  null;

    /+
    json_object_object_foreach(jobj, key, val) {
        /* reinitialise to temp each iteration */
        temp =  null;

        type = json_object_get_type(val);

        /* the output of the json_parse varies per post type */
        switch (conn.post_type) {
        case ELASTICSEARCH_POST_TYPE_LAST_UID:
            /* we only care about the uid field */
            if (strcmp(key, "uid") == 0) {
                elasticsearch_connection_last_uid_json(conn, key, val);
            }

            break;
        case ELASTICSEARCH_POST_TYPE_SELECT:
            elasticsearch_connection_select_json(conn, key, val);
            break;
        case ELASTICSEARCH_POST_TYPE_UPDATE:
            /* not implemented */
            break;
        case ELASTICSEARCH_POST_TYPE_REFRESH:
            /* not implemented */
            break;
        }

        /* recursively process the json */
        switch (type) {
        case json_type_boolean: /* fall through */
        case json_type_double:  /* fall through */
        case json_type_int:     /* fall through */
        case json_type_string:  /* fall through */
            break; 
        case json_type_object:
            static if (JSON_HAS_GET_EX)
                json_object_object_get_ex(jobj, key, &temp);
            else
                temp = json_object_object_get(jobj, key);
            
            json_parse(temp, conn);

            break;
        case json_type_array:
            json_parse_array(jobj, key, conn);

            break;
        case json_type_null:
            break;
        }
    }
    +/
} 

int elasticsearch_json_parse(elasticsearch_connection *conn, string_t *data)
{
    json_object *jobj =  null;

    if (data is  null) {
        i_error("fts_elasticsearch: json_parse: empty JSON result");

        return -1;
    } else {
        /* attempt to tokenise the JSON */
        jobj = json_tokener_parse(str_c(data));
    }

    if (jobj is  null) {
        /* TODO: is this because ES only returns partial JSON and chunks it and
         * we just aren't handling the HTTP chunking, or is it JSON chunking. */
        i_error("fts-elasticsearch: unable to parse response JSON");
        i_error("fts_elasticsearch: response JSON: %s", str_c(data));

        return -1;
    }

    /* finish parsing it */
    json_parse(jobj, conn);

    return 0;
}

void elasticsearch_connection_payload_input(elasticsearch_connection *conn)
{
    const(ubyte)* data =  null;
    size_t size;
    int ret = -1;

    /* continue appending data so long as it is available */
    while ((ret = i_stream_read_data(conn.payload, &data, &size, 0)) > 0) {
        str_append(conn.ctx.email, cast(const(char)* )data);

        i_stream_skip(conn.payload, size);
    }

    if (ret == 0) {
        /* we will be called again for more data */
    } else {
        if (conn.payload.stream_errno != 0) {
            i_error("fts_elasticsearch: failed to read payload from HTTP server: %m");

            conn.request_status = -1;
        } else {
            /* parse the output */
            elasticsearch_json_parse(conn, conn.ctx.email);
        }

        /* clean-up */
        str_free(&conn.ctx.email);
        io_remove(&conn.io);
        i_stream_unref(&conn.payload);
    }
}

int elasticsearch_connection_last_uid(elasticsearch_connection *conn, const(char)* query, const(char)* box_guid)
{
    elasticsearch_lookup_context lookup_context;
    const(char)* url =  null;

    if (conn is  null || query is  null || box_guid is  null) {
        i_error("fts_elasticsearch: last_uid: critical error while fetching last UID");

        return -1;
    }

    /* set-up the context */
    memset(&lookup_context, 0, sizeof(lookup_context));
    conn.ctx = &lookup_context;
    conn.ctx.uid = -1;
    conn.post_type = ELASTICSEARCH_POST_TYPE_LAST_UID;

    /* build the url */
    url = t_strconcat(conn.http_base_url, box_guid,  null);
    url = t_strconcat(url, "/mail/_search/",  null);

    /* perform the actual POST */
    elasticsearch_connection_post(conn, url, query);

    /* set during the json parsing; will be the intiailised -1 or a valid uid */
    return conn.ctx.uid;
}

void elasticsearch_connection_select_response(const(http_response)* response, elasticsearch_connection* conn)
{
    /* 404's on non-updates mean the index doesn't exist and should be indexed. 
     * we don't want to flood the error log with useless messages since dovecot
     * will redo the query automatically after indexing it. */
    if (conn.post_type != ELASTICSEARCH_POST_TYPE_UPDATE && response.status == 404) {
        conn.request_status = -1;

        return;
    }

    /* 404's usually mean the index is missing. it could mean you also hit a
     * non-ES service but this seems better than a second indices exists lookup */
    if (response.status / 100 != 2) {
        i_error("fts_elasticsearch: lookup failed: %s", response.reason);
        conn.request_status = -1;
        return;
    }

    if (response.payload is  null) {
        i_error("fts_elasticsearch: lookup failed: empty response payload");
        conn.request_status = -1;
        return;
    }

    /* TODO: read up in the dovecot source to see how we should clean these up
     * as they are causing I/O leaks. */
    i_stream_ref(response.payload);
    conn.payload = response.payload;
    conn.ctx.email = str_new(default_pool, 1024 * 1024); /* 1Mb */
    conn.io = io_add_istream(response.payload, elasticsearch_connection_payload_input, conn);
    elasticsearch_connection_payload_input(conn);
}

void elasticsearch_connection_http_response(const http_response* response, elasticsearch_connection* conn)
{
    if (response !is  null && conn !is  null) {
        switch (conn.post_type) {
        case ELASTICSEARCH_POST_TYPE_LAST_UID: /* fall through */
        case ELASTICSEARCH_POST_TYPE_SELECT:
            elasticsearch_connection_select_response(response, conn);
            break;
        case ELASTICSEARCH_POST_TYPE_UPDATE:
            elasticsearch_connection_update_response(response, conn);
            break;
        case ELASTICSEARCH_POST_TYPE_REFRESH:
            /* not implemented */
            break;
        }
    }
}

http_client_request* elasticsearch_connection_http_request(elasticsearch_connection *conn, const(char)* url)
{
    http_client_request *http_req =  null;

    if (conn !is  null && url !is  null) {
        http_req = http_client_request(elasticsearch_http_client, "POST",
                                       conn.http_host, url,
                                       elasticsearch_connection_http_response,
                                       conn);
        http_client_request_set_port(http_req, conn.http_port);
        http_client_request_set_ssl(http_req, conn.http_ssl);
        http_client_request_add_header(http_req, "Content-Type", "text/json");
    }

    return http_req;
}

int elasticsearch_connection_refresh(elasticsearch_connection *conn)
{
    const(char)* url =  null;

    /* validate input */
    if (conn is  null) {
        i_error("fts_elasticsearch: refresh: critical error");

        return -1;
    }

    /* set-up the context */
    conn.post_type = ELASTICSEARCH_POST_TYPE_REFRESH;

    /* build the url; we don't have any choice but to refresh the entire 
     * ES server here because Dovecot's refresh API doesn't give us the
     * mailbox that is being refreshed. */
    url = t_strconcat(conn.http_base_url, "/_refresh/",  null);

    /* perform the actual POST */
    elasticsearch_connection_post(conn, url, "");

    if (conn.request_status < 0) {
        return -1;
    }

    return 0;
}

int elasticsearch_connection_select(elasticsearch_connection *conn,
                                        pool_t pool, const(char)* query,
                                        const(char)* box_guid,
                                        elasticsearch_result*** box_results_r)
{
    elasticsearch_lookup_context lookup_context;
    const(char)* url =  null;

    /* validate our input */
    if (conn is  null || query is  null || box_guid is  null || box_results_r is  null) {
        i_error("fts_elasticsearch: select: critical error during select");

        return -1;
    }

    /* set-up the context */
    memset(&lookup_context, 0, sizeof(lookup_context));
    conn.ctx = &lookup_context;
    conn.ctx.result_pool = pool;
    conn.ctx.uid = -1;
    conn.ctx.score = -1;
    conn.ctx.results_found = false;
    conn.post_type = ELASTICSEARCH_POST_TYPE_SELECT;

    /* initialise our results stores */
    p_array_init(&conn.ctx.results, pool, 32);
    hash_table_create(&lookup_context.mailboxes, default_pool, 0, str_hash, strcmp);

    /* build the url */
    url = t_strconcat(conn.http_base_url, box_guid,  null);
    url = t_strconcat(url, "/mail/_search/",  null);

    /* perform the actual POST */
    elasticsearch_connection_post(conn, url, query);

    if (conn.request_status < 0) {
        /* no further processing required */
        return -1;
    }

    /* build our results to push back to the fts api */
    array_append_zero(&conn.ctx.results);
    *box_results_r = array_idx_modifiable(&conn.ctx.results, 0);

    return conn.ctx.results_found;
}
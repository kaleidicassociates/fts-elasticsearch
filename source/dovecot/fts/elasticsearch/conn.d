module dovecot.fts.elasticsearch.conn;
import dovecot.api;

import asdf;

/**
    Copyright (c) 2006-2014 Dovecot authors, see the included COPYING file
    Copyright (c) 2014 Joshua Atkins <josh@ascendantcom.com>
    Ported to the D programming language 2018 by Laeeth Isharc
*/

enum PostType
{
    update,
    select,
    lastUID,
    refresh,
}


struct SeqRange
{
    int start;
    int end;
}

struct ScoreMap
{
    int id;
    float score;
}

struct Result
{
    string boxID;
    SeqRange[] uids;
    ScoreMap[] scores;
}



struct LookupContext
{
    pool_t result_pool;
    Result[string] mailboxes;
    Result[] results; // temporary results
    string boxGUID; // current mailbox

    /* current message */
    int uid;
    float score;

    string email; // current email as a string
    
    bool resultsFound;
}

struct Connection
{
    string host;
    short port;
    string baseURL;
    string httpFailure;
    int requestStatus;

    /* for streaming processing of results */
    struct_istream *payload;
    struct_io *io;

    PostType postType;

    Context context;
    bool isDebug = false;
    bool useSSL = true;

    this(string url, bool isDebug)
    {
        if (http_url_parse(url,  null, enum_http_url_parse_flags.init, pool_datastack_create(),
               &http_url, &error) < 0) {
        error_r = t_strdup_printf("fts_elasticsearch: Failed to parse HTTP url: %s", error);

        //conn = i_new(elasticsearch_connection, 1);
        conn.http_host = i_strdup(http_url.host.name);
        conn.http_port = http_url.port;
        conn.http_base_url = i_strconcat(http_url.path, http_url.enc_query,  null);
        conn.http_ssl = http_url.have_ssl;
        conn.debug_ = debug_;

        memset(&http_set, 0, http_set.sizeof);
        http_set.max_idle_time_msecs = 5 * 1000;
        http_set.max_parallel_connections = 1;
        http_set.max_pipelined_requests = 1;
        http_set.max_redirects = 1;
        http_set.max_attempts = 3;
        http_set.debug_ = debug_;
        elasticsearch_http_client = http_client_init(&http_set);
    }

    ~this()
    {

    }

    void updateResponse(ref HttpResponse response)
    {
        if (response !is  null && conn !is  null ) {
            /* 200 OK, 204 continue */
            /+
            if (response.status / 100 != 2) {
                i_error("fts_elasticsearch: Indexing failed: %s", response.reason);
                conn.request_status = -1;
            } +/
        }
    }

    auto update(string command)
    {

        if (conn !is  null && cmd !is  null) {
            /* set-up the connection */
            this.postType = PostType.update;
            url = t_strconcat(conn.http_base_url, "/_bulk/".ptr,  null);

            elasticsearch_connection_post(conn, url, cmd);

            return conn.request_status;
        } else {
            i_debug("fts_elasticsearch: connection_update: conn is  null");
            return -1;
        }
    }

    auto post(string url, string command)
    {
        http_client_request *http_req =  null;
        struct_istream *post_payload =  null;

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

    auto lastUID(string query, string boxGUID)
    {
        enforce(!(conn is  null || query is  null || box_guid is  null),
            "fts_elasticsearch: last_uid: critical error while fetching last UID");

        connection.context = LookupContext.init;
        connection.context.uid = -1;
        connection.postType = PostType.lastUID;

        auto url = connection.baseURL ~ boxGUID ~ "/mail/_search/";
        post(connection, url,query);
        // set during the json parsing; will be the intiailised -1 or a valid uid
        return connection.context.uid;
    }

    auto selectResponse(ref HttpResponse response)
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

    void response(ref HttpResponse response)
    {
        if (conn.isAlive)
        {
            switch (this.postType) {
            case PostType.lastUID, PostType.select:
                selectResponse(response);
                break;
            case PostType.update:
                updateResponse(response);
                break;
            case PostType.refresh:
                // not implemented
                break;
            }
        }
    }

    HttpClientRequest request(string url)
    {
        HttpClientRequest ret;

        if (conn !is  null && url !is  null) {
            ret = http_client_request(elasticsearch_http_client, "POST",
                                           conn.http_host, url,
                                           elasticsearch_connection_http_response,
                                           conn);
            ret.port = this.port;
            ret.useSSL = this.useSSL;
            ret.header ~= ["Content-Type": "text/json"];
        }
        return ret;
    }

    auto refresh()
    {
        if (!conn.isAlive)
            i_error("fts_elasticsearch: refresh: critical error");
            return -1;
        }

        conn.postType = PostType.refresh;

        /* build the url; we don't have any choice but to refresh the entire 
         * ES server here because Dovecot's refresh API doesn't give us the
         * mailbox that is being refreshed. */
        auto url =this.baseURL ~  "/_refresh/";
        post(this, url, "");
        return (conn.request_status < 0);
    }

    auto select(string query, string boxGUID)
    {
        /* validate our input */
        if (conn is  null || query is  null || box_guid is  null || box_results_r is  null) {
            i_error("fts_elasticsearch: select: critical error during select");

            return -1;
        }

        /* set-up the context */
        memset(&lookup_context, 0, lookup_context.sizeof);
        conn.ctx = &lookup_context;
        this.context.resultPool = pool;
        this.context.uid = -1;
        this.context.score = -1.0;
        this.context.resultsFound = false;
        this.postType = PostType.select;

        //hash_table_create(&lookup_context.mailboxes, default_pool, 0, str_hash, strcmp);

        auto url = this.baseURL ~ boxGUID ~ "/mail/_search";
        post(this, url, query);

        if (connection.requestStatus < 0) {
            /* no further processing required */
            return [];
        }
        return this.context.results;
    }

    auto payload_input()
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
            +/
        }
    }

    auto jsonParse(string data)
    {
        json_object *jobj =  null;

        if (data is  null) {
            i_error("fts_elasticsearch: json_parse: empty JSON result");

            return -1;
        } else {
            /* attempt to tokenise the JSON */
            //jobj = json_tokener_parse(str_c(data));
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

    auto selectJSON(string key, json_object* val)
    {
        json_object *jvalue;
        elasticsearch_result *result =  null;
        struct_fts_score_map *tmp_score =  null;

        if (conn !is  null) {
            /* ensure a key and val exist before trying to process them */
            if (key !is  null && val !is  null) {
                if (strcmp(key, "uid") == 0) {
                    //jvalue = json_object_array_get_idx(val, 0);
                    //conn.ctx.uid = json_object_get_int(jvalue);
                }

                if (strcmp(key, "_score") == 0)
                    //conn.ctx.score = json_object_get_double(val);  

                if (strcmp(key, "box") == 0) {
                    //jvalue = json_object_array_get_idx(val, 0);
                    //conn.ctx.box_guid = json_object_get_string(jvalue);
                }
            }

            /* this is all we need for an e-mail result */
            if (conn.ctx.uid != -1 && conn.ctx.score != -1 && conn.ctx.box_guid !is  null) {
                result = elasticsearch_result_get(conn, conn.ctx.box_guid);
                //tmp_score = array_append_space(&result.scores);

                //seq_range_array_add(&result.uids, conn.ctx.uid);
                //tmp_score.uid = conn.ctx.uid;
                //tmp_score.score = conn.ctx.score;

                /* clean-up */
                //conn.ctx.uid = -1;
                //conn.ctx.score = -1;
                //conn.ctx.box_guid =  null;
                //conn.ctx.results_found = true;
            }
        } else { /* conn !is  null && key !is  null && val !is  null */
            i_error("fts_elasticsearch: select_json: critical error while processing result JSON");
        }
    }

    auto jsonParseArray(json_object *jobj, char *key)
    {
        //json_type type;
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
                {} // jarray = json_object_object_get(jobj, key);
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

    auto getResult(string boxID)
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

    void jsonParse(json_object *jobj)
    {
        //json_type type;
        json_object *temp =  null;

        
        json_object_object_foreach(jobj, key, val) {
            /* reinitialise to temp each iteration */
            temp =  null;

            type = json_object_get_type(val);

            /* the output of the json_parse varies per post type */
            switch (conn.postType) {
            case PostType.lastUID:
                /* we only care about the uid field */
                if (strcmp(key, "uid") == 0) {
                    elasticsearch_connection_last_uid_json(conn, key, val);
                }

                break;
            case PostType.select:
                elasticsearch_connection_select_json(conn, key, val);
                break;
            case PostType.update:
                /* not implemented */
                break;
            case PostType.refresh:
                /* not implemented */
                break;
            }

            /* recursively process the json */
            switch (type) {
            case json_type_boolean,json_type_double,json_type_int,json_type_string,json_type_null:
                break; 
            case json_type_object:
                temp = json_object_object_get(jobj, key);      
                json_parse(temp, conn);
                break;

            case json_type_array:
                json_parse_array(jobj, key, conn);
                break;
            }
        }
    } 


    auto lastUIDJson(string key, json_object* val)
    {
        json_object *jvalue =  null;

        if (conn !is  null && key !is  null && val !is  null) {
            /* only interested in the uid field */
            if (strcmp(key, "uid") == 0) {
                /* field is returned as an array */
                //jvalue = json_object_array_get_idx(val, 0);
                //conn.ctx.uid = json_object_get_int(jvalue);
            }
        } else {
            i_error("fts_elasticsearch: last_uid_json: critical error while getting last uid");
        }
    }

}
module dovecot.fts.elasticsearch.json;

/* the search JSON */
enum JSON_SEARCH = 
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
enum JSON_LAST_UID =
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
enum JSON_BULK_HEADER =
    `{ 
      "%s": {
        "_index": "%s",
        "_type": "%s",
        "_id\": %d
      }
    }`;

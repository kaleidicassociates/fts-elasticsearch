module dovecot.fts.elasticsearch.util;


/* values that must be escaped in query fields */
enum es_query_escape_chars = `"\`;

/* values that must be escaped in a bulk update value field */
enum es_update_escape_chars = `"\`;

/* values that must be escaped in field names */
enum es_field_escape_chars = `.#*"`;


string replace(string s, string replaceChars)
{
    string ret;
    foreach(c;s)
    {
        ret ~= (canFind(replaceChars,c)) ? "_" : c;
    }

    return ret;
}

string escape(string s, string escapeChars)
{
    string ret;
    uint i;

    foreach(c;s)
    {
        if (escapeChars.canFind(c))
            ret~='\\';

        switch(c)
        {
            case '\t': ret ~= "\\t"; break;
            case '\b': ret ~= "\\b"; break;
            case '\n': ret~="\\n"; break;
            case '\r': ret~="\\r"; break;
            case '\f': ret~="\\f"; break;
            case 0x1C: ret~="0x1c"; break;
            case 0x1D: ret~="0x1d"; break;
            case 0x1E: ret~="0x1e"; break;
            case 0x1F: ret ~="0x1f"; break;
            default: ret~=c; break;
        }
    }

    return ret;
}

string updateEscape(string s)
{
    return escape(s, es_update_escape_chars);
}

string queryEscape(string s)
{
    return escape(s, es_query_escape_chars);
}

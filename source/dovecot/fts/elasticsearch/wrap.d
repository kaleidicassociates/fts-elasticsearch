module dovecot.fts.elasticsearch.wrap;
import dovecot.api;

alias fts_backend=struct_fts_backend;
alias mailbox = struct_mailbox;
alias fts_backend_update_context = struct_fts_backend_update_context;
alias fts_result = FTSResult;
alias fts_backend_build_key = struct_fts_backend_build_key;
alias fts_lookup_flags = FTSLookupFlag;




auto getGUID(Mailbox mailbox)
{
    char[1024] ret;
    enforce(fts_mailbox_get_guid(mailbox.handle,ret.ptr)>0,"fts-elasticsearch: getGUID failed");
    return ret.idup;
}


extern(C) fts_backend *fts_backend_elasticsearch_alloc()
{
    Backend *backend;

    backend = cast(Backend*)i_new(backend, 1);
    backend.backend = fts_backend_elasticsearch;

    return &backend.backend;
}


/*
union union_array__keywords
{
    struct_array arr;
    const(const(const(char)*)*)* v;
    const(char)*** v_modifiable;
}

struct struct_array
{
    int* buffer;
    int element_size;
}
*/
struct MailboxStatus
{
    uint messages;
    uint recent;
    uint unseen;
    uint uidValidity;
    uint uidNext;
    uint firstUnseenSeq;
    uint firstRecentUID;
    uint last_cached_seq;
    ulong highest_modseq;
    ulong highest_pvt_modseq;
    string[] keywords;
    MailFlags permanentFlags;
    MailFlags flags;
    int permanentKeywords;
    int allow_newkeywords;
    int nonpermanent_modseqs;
    int no_modseq_tracking;
    int have_guids;
    int have_save_guids;
    int have_only_guid128;

    this(struct_mailbox_status status)
    {
        this.messages = status.messages;
        this.recent = status.recent;
        this.unseen = status.unseen;
        this.uidValidity = status.uidValidity;
        this.uidNext = status.uidNext;
        this.firstUnseenSeq = status.firstUnseenSeq;
        this.firstRecentUID = status.firstRecentUID;
        this.lastCachedSeq = status.last_cached_seq;
        this.highestModSeq = status.highest_mod_seq;
        this.highestPrivateModSeq = status.highest_pvt_modseq;
        this.keywords = status.keywords.toArray;
        this.permanentFlags = status.permanent_flags;
    }
}

auto getOpenStatus(ref Mailbox mailbox, MailboxStatusItems items)
{
    struct_mailbox_status ret;
    mailbox_get_open_status(mailbox.handle,items, &ret);
    return MailboxStatus(ret);
}

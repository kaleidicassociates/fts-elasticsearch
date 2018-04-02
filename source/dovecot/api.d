module dovecot.api;
import core.stdc.config;
import core.stdc.stdarg: va_list;
struct struct___locale_data { int dummy; }

extern(C) {
    alias unichar_t = int;
    //int ARRAY_DEFINE_TYPE(...);
    //alias normalizer_func_t = input;
    extern __gshared const(ubyte)[3] utf8_replacement_char;
    extern __gshared const(const(int)*) uni_utf8_non1_bytes;
    extern __gshared int ATTR_PURE;
    //int uni_utf8_to_ucs4(const(char)*, unknown, );
    //int uni_utf8_to_ucs4_n(const(ubyte)*, int, unknown, );
    void uni_ucs4_to_utf8(const(const unichar_t)*, int, int*, );
    void uni_ucs4_to_utf8_c(unichar_t, int*, );
    int uni_utf8_get_char(const(char)*, unichar_t*, );
    int uni_utf8_get_char_n(const(void)*, int, unichar_t*, );
    uint uni_utf8_partial_strlen_n(const(void)*, int, int*, );
    extern __gshared uint ATTR_CONST;
    int uni_utf8_to_decomposed_titlecase(const(void)*, int, int*, );
    int uni_utf8_get_valid_data();
    int uni_utf8_str_is_valid();
    int uni_utf8_data_is_valid();
    unichar_t uni_join_surrogate(unichar_t, unichar_t, );
    void uni_split_surrogate(unichar_t, unichar_t*, unichar_t*, );
}

extern(C) {




    struct struct_mail;
    struct struct_seq_range
    {
        int seq1;
        int seq2;
    }
    struct struct_mailbox;
    struct struct_mail_namespace;
    struct struct_mail_search_arg;
    struct struct_fts_backend;
    struct struct_seq_range_iter
    {
        //unknown ARRAY_TYPE;
        uint prev_n;
        uint prev_idx;
    }
    enum enum_fts_lookup_flags
    {
        FTS_LOOKUP_FLAG_AND_ARGS = 1,
        FTS_LOOKUP_FLAG_NO_AUTO_FUZZY = 2,
    }
    enum enum_fts_backend_build_key_type
    {
        FTS_BACKEND_BUILD_KEY_HDR = 0,
        FTS_BACKEND_BUILD_KEY_MIME_HDR = 1,
        FTS_BACKEND_BUILD_KEY_BODY_PART = 2,
        FTS_BACKEND_BUILD_KEY_BODY_PART_BINARY = 3,
    }
    enum
    {
        FTS_BACKEND_BUILD_KEY_HDR = 0,
        FTS_BACKEND_BUILD_KEY_MIME_HDR = 1,
        FTS_BACKEND_BUILD_KEY_BODY_PART = 2,
        FTS_BACKEND_BUILD_KEY_BODY_PART_BINARY = 3,
    }
    //void seq_range_array_add_with_init(unknown, );
    //void seq_range_array_add_range(unknown, );
    //uint seq_range_array_add_range_count(unknown, );
    struct struct_fts_backend_build_key
    {
        int uid;
        enum_fts_backend_build_key_type type;
        struct_message_part* part;
        const(char)* hdr_name;
        const(char)* body_content_type;
        const(char)* body_content_disposition;
    }
    //void seq_range_array_merge(unknown, );
    extern __gshared int ATTR_NOWARN_UNUSED_RESULT;
    //void seq_range_array_remove_nth(unknown, );
    struct struct_fts_score_map
    {
        int uid;
        float score;
    }
    struct struct_fts_result
    {
        struct_mailbox* box;
        unknown ARRAY_TYPE;
        int scores_sorted;
    }
    //void seq_range_array_invert(unknown, );
    //void seq_range_array_iter_init(struct_seq_range_iter*, unknown, );
    struct struct_fts_multi_result
    {
        int pool;
        struct_fts_result* box_results;
    }
    int seq_range_array_iter_nth();
    int fts_backend_init(const(char)*, struct_mail_namespace*, const(char)**, struct_fts_backend**, );
    void fts_backend_deinit(struct_fts_backend**, );
    int fts_backend_get_last_uid(struct_fts_backend*, struct_mailbox*, int*, );
    int fts_backend_is_updating();
    struct_fts_backend_update_context* fts_backend_update_init(struct_fts_backend*, );
    struct struct_fts_backend_update_context;
    int fts_backend_update_deinit(struct_fts_backend_update_context**, );
    void fts_backend_update_set_mailbox(struct_fts_backend_update_context*, struct_mailbox*, );
    void fts_backend_update_expunge(struct_fts_backend_update_context*, int, );
    int fts_backend_update_set_build_key();
    void fts_backend_update_unset_build_key(struct_fts_backend_update_context*, );
    int fts_backend_update_build_more(struct_fts_backend_update_context*, const(ubyte)*, int, );
    int fts_backend_refresh(struct_fts_backend*, );
    int fts_backend_rescan(struct_fts_backend*, );
    int fts_backend_optimize(struct_fts_backend*, );
    int fts_backend_can_lookup();
    int fts_backend_lookup(struct_fts_backend*, struct_mailbox*, struct_mail_search_arg*, enum_fts_lookup_flags, struct_fts_result*, );
    int fts_backend_lookup_multi(struct_fts_backend*, struct_mailbox**, struct_mail_search_arg*, enum_fts_lookup_flags, struct_fts_multi_result*, );
    void fts_backend_lookup_done(struct_fts_backend*, );
}

extern(C) {
    alias guid_128_t = int[16];
    enum enum_fsync_mode
    {
        FSYNC_MODE_OPTIMIZED = 0,
        FSYNC_MODE_NEVER = 1,
        FSYNC_MODE_ALWAYS = 2,
    }
    enum
    {
        FSYNC_MODE_OPTIMIZED = 0,
        FSYNC_MODE_NEVER = 1,
        FSYNC_MODE_ALWAYS = 2,
    }




    alias __sigset_t = _Anonymous_1;
    struct _Anonymous_1
    {
        c_ulong[16] __val;
    }
    enum enum_mailbox_log_record_type
    {
        MAILBOX_LOG_RECORD_DELETE_MAILBOX = 1,
        MAILBOX_LOG_RECORD_DELETE_DIR = 2,
        MAILBOX_LOG_RECORD_RENAME = 3,
        MAILBOX_LOG_RECORD_SUBSCRIBE = 4,
        MAILBOX_LOG_RECORD_UNSUBSCRIBE = 5,
        MAILBOX_LOG_RECORD_CREATE_DIR = 6,
    }
    enum
    {
        MAILBOX_LOG_RECORD_DELETE_MAILBOX = 1,
        MAILBOX_LOG_RECORD_DELETE_DIR = 2,
        MAILBOX_LOG_RECORD_RENAME = 3,
        MAILBOX_LOG_RECORD_SUBSCRIBE = 4,
        MAILBOX_LOG_RECORD_UNSUBSCRIBE = 5,
        MAILBOX_LOG_RECORD_CREATE_DIR = 6,
    }


    struct struct_osockaddr
    {
        ushort sa_family;
        ubyte[14] sa_data;
    }
    struct struct_mail_storage_callbacks;




    enum enum_mailbox_list_iter_flags
    {
        MAILBOX_LIST_ITER_RAW_LIST = 1,
        MAILBOX_LIST_ITER_NO_AUTO_BOXES = 4,
        MAILBOX_LIST_ITER_SKIP_ALIASES = 8,
        MAILBOX_LIST_ITER_STAR_WITHIN_NS = 16,
        MAILBOX_LIST_ITER_SELECT_SUBSCRIBED = 256,
        MAILBOX_LIST_ITER_SELECT_RECURSIVEMATCH = 512,
        MAILBOX_LIST_ITER_SELECT_SPECIALUSE = 1024,
        MAILBOX_LIST_ITER_RETURN_NO_FLAGS = 4096,
        MAILBOX_LIST_ITER_RETURN_SUBSCRIBED = 8192,
        MAILBOX_LIST_ITER_RETURN_CHILDREN = 16384,
        MAILBOX_LIST_ITER_RETURN_SPECIALUSE = 32768,
    }
    enum
    {
        MAILBOX_LIST_ITER_RAW_LIST = 1,
        MAILBOX_LIST_ITER_NO_AUTO_BOXES = 4,
        MAILBOX_LIST_ITER_SKIP_ALIASES = 8,
        MAILBOX_LIST_ITER_STAR_WITHIN_NS = 16,
        MAILBOX_LIST_ITER_SELECT_SUBSCRIBED = 256,
        MAILBOX_LIST_ITER_SELECT_RECURSIVEMATCH = 512,
        MAILBOX_LIST_ITER_SELECT_SPECIALUSE = 1024,
        MAILBOX_LIST_ITER_RETURN_NO_FLAGS = 4096,
        MAILBOX_LIST_ITER_RETURN_SUBSCRIBED = 8192,
        MAILBOX_LIST_ITER_RETURN_CHILDREN = 16384,
        MAILBOX_LIST_ITER_RETURN_SPECIALUSE = 32768,
    }
    alias timer_t = __timer_t;


    alias time_t = __time_t;
    alias sigset_t = __sigset_t;
    alias clockid_t = __clockid_t;
    alias clock_t = __clock_t;
    struct struct_timeval
    {
        __time_t tv_sec;
        __suseconds_t tv_usec;
    }
    struct struct_timespec
    {
        __time_t tv_sec;
        __syscall_slong_t tv_nsec;
    }
    enum enum_mail_namespace_type
    {
        MAIL_NAMESPACE_TYPE_PRIVATE = 1,
        MAIL_NAMESPACE_TYPE_SHARED = 2,
        MAIL_NAMESPACE_TYPE_PUBLIC = 4,
    }
    enum
    {
        MAIL_NAMESPACE_TYPE_PRIVATE = 1,
        MAIL_NAMESPACE_TYPE_SHARED = 2,
        MAIL_NAMESPACE_TYPE_PUBLIC = 4,
    }




    enum enum_mailbox_list_notify_event
    {
        MAILBOX_LIST_NOTIFY_CREATE = 1,
        MAILBOX_LIST_NOTIFY_DELETE = 2,
        MAILBOX_LIST_NOTIFY_RENAME = 4,
        MAILBOX_LIST_NOTIFY_SUBSCRIBE = 8,
        MAILBOX_LIST_NOTIFY_UNSUBSCRIBE = 16,
        MAILBOX_LIST_NOTIFY_UIDVALIDITY = 32,
        MAILBOX_LIST_NOTIFY_APPENDS = 64,
        MAILBOX_LIST_NOTIFY_EXPUNGES = 128,
        MAILBOX_LIST_NOTIFY_SEEN_CHANGES = 256,
        MAILBOX_LIST_NOTIFY_MODSEQ_CHANGES = 512,
    }
    enum
    {
        MAILBOX_LIST_NOTIFY_CREATE = 1,
        MAILBOX_LIST_NOTIFY_DELETE = 2,
        MAILBOX_LIST_NOTIFY_RENAME = 4,
        MAILBOX_LIST_NOTIFY_SUBSCRIBE = 8,
        MAILBOX_LIST_NOTIFY_UNSUBSCRIBE = 16,
        MAILBOX_LIST_NOTIFY_UIDVALIDITY = 32,
        MAILBOX_LIST_NOTIFY_APPENDS = 64,
        MAILBOX_LIST_NOTIFY_EXPUNGES = 128,
        MAILBOX_LIST_NOTIFY_SEEN_CHANGES = 256,
        MAILBOX_LIST_NOTIFY_MODSEQ_CHANGES = 512,
    }
    struct struct_module;
    struct struct_file_lock;




    struct struct_stats;






    struct struct_fs_settings;
    struct struct_dotlock;


    enum enum_uuid_format
    {
        FORMAT_RECORD = 0,
        FORMAT_COMPACT = 1,
        FORMAT_MICROSOFT = 2,
    }
    enum
    {
        FORMAT_RECORD = 0,
        FORMAT_COMPACT = 1,
        FORMAT_MICROSOFT = 2,
    }


    struct struct_ssl_iostream_settings;




    struct struct_mail_storage;






    struct struct_fs;






    enum enum_file_lock_method
    {
        FILE_LOCK_METHOD_FCNTL = 0,
        FILE_LOCK_METHOD_FLOCK = 1,
        FILE_LOCK_METHOD_DOTLOCK = 2,
    }
    enum
    {
        FILE_LOCK_METHOD_FCNTL = 0,
        FILE_LOCK_METHOD_FLOCK = 1,
        FILE_LOCK_METHOD_DOTLOCK = 2,
    }






    struct struct_message_address;
    struct struct_mail_storage_settings
    {
        const(char)* mail_location;
        const(char)* mail_attachment_fs;
        const(char)* mail_attachment_dir;
        const(char)* mail_attachment_hash;
        int mail_attachment_min_size;
        const(char)* mail_attribute_dict;
        uint mail_prefetch_count;
        const(char)* mail_cache_fields;
        const(char)* mail_always_cache_fields;
        const(char)* mail_never_cache_fields;
        const(char)* mail_server_comment;
        const(char)* mail_server_admin;
        uint mail_cache_min_mail_count;
        uint mail_cache_unaccessed_field_drop;
        int mail_cache_record_max_size;
        int mail_cache_compress_min_size;
        uint mail_cache_compress_delete_percentage;
        uint mail_cache_compress_continued_percentage;
        uint mail_cache_compress_header_continue_count;
        int mail_index_rewrite_min_log_bytes;
        int mail_index_rewrite_max_log_bytes;
        int mail_index_log_rotate_min_size;
        int mail_index_log_rotate_max_size;
        uint mail_index_log_rotate_min_age;
        uint mail_index_log2_max_age;
        uint mailbox_idle_check_interval;
        uint mail_max_keyword_length;
        uint mail_max_lock_timeout;
        uint mail_temp_scan_interval;
        uint mail_vsize_bg_after_count;
        uint max_read_count;
        int mail_save_crlf;
        const(char)* mail_fsync;
        int mmap_disable;
        int dotlock_use_excl;
        int mail_nfs_storage;
        int mail_nfs_index;
        int mailbox_list_index;
        int mailbox_list_index_very_dirty_syncs;
        int mailbox_list_index_include_inbox;
        int mail_debug;
        int mail_full_filesystem_access;
        int maildir_stat_dirs;
        int mail_shared_explicit_inbox;
        const(char)* lock_method;
        const(char)* pop3_uidl_format;
        const(char)* postmaster_address;
        const(char)* hostname;
        const(char)* recipient_delimiter;
        const(char)* ssl_client_ca_dir;
        const(char)* ssl_client_ca_file;
        const(char)* ssl_crypto_device;
        const(char)* mail_attachment_detection_options;
        enum_file_lock_method parsed_lock_method;
        enum_fsync_mode parsed_fsync_mode;
        const struct_message_address* _parsed_postmaster_address;
        const(const(char)*)* parsed_mail_attachment_content_type_filter;
        int parsed_mail_attachment_exclude_inlined;
        int parsed_mail_attachment_detection_add_flags_on_save;
        int parsed_mail_attachment_detection_add_flags_on_fetch;
    }
    struct struct_mail_user_vfuncs
    {
        void function(struct_mail_user*) deinit;
        void function(struct_mail_user*) deinit_pre;
        void function(struct_mail_user*, struct_stats*) stats_fill;
    }
    struct struct_mailbox_log_record
    {
        int type;
        int[3] padding;
        guid_128_t mailbox_guid;
        int[4] timestamp;
    }
    enum enum_namespace_flags
    {
        NAMESPACE_FLAG_INBOX_USER = 1,
        NAMESPACE_FLAG_INBOX_ANY = 2,
        NAMESPACE_FLAG_HIDDEN = 4,
        NAMESPACE_FLAG_LIST_PREFIX = 8,
        NAMESPACE_FLAG_LIST_CHILDREN = 16,
        NAMESPACE_FLAG_SUBSCRIPTIONS = 32,
        NAMESPACE_FLAG_AUTOCREATED = 4096,
        NAMESPACE_FLAG_USABLE = 8192,
        NAMESPACE_FLAG_UNUSABLE = 16384,
        NAMESPACE_FLAG_NOQUOTA = 32768,
        NAMESPACE_FLAG_NOACL = 65536,
    }
    enum
    {
        NAMESPACE_FLAG_INBOX_USER = 1,
        NAMESPACE_FLAG_INBOX_ANY = 2,
        NAMESPACE_FLAG_HIDDEN = 4,
        NAMESPACE_FLAG_LIST_PREFIX = 8,
        NAMESPACE_FLAG_LIST_CHILDREN = 16,
        NAMESPACE_FLAG_SUBSCRIPTIONS = 32,
        NAMESPACE_FLAG_AUTOCREATED = 4096,
        NAMESPACE_FLAG_USABLE = 8192,
        NAMESPACE_FLAG_UNUSABLE = 16384,
        NAMESPACE_FLAG_NOQUOTA = 32768,
        NAMESPACE_FLAG_NOACL = 65536,
    }
    const(char)* guid_generate();




    enum enum_mailbox_list_properties
    {
        MAILBOX_LIST_PROP_NO_MAILDIR_NAME = 1,
        MAILBOX_LIST_PROP_NO_ALT_DIR = 2,
        MAILBOX_LIST_PROP_NO_NOSELECT = 4,
        MAILBOX_LIST_PROP_NO_ROOT = 8,
        MAILBOX_LIST_PROP_AUTOCREATE_DIRS = 16,
        MAILBOX_LIST_PROP_NO_LIST_INDEX = 32,
    }
    enum
    {
        MAILBOX_LIST_PROP_NO_MAILDIR_NAME = 1,
        MAILBOX_LIST_PROP_NO_ALT_DIR = 2,
        MAILBOX_LIST_PROP_NO_NOSELECT = 4,
        MAILBOX_LIST_PROP_NO_ROOT = 8,
        MAILBOX_LIST_PROP_AUTOCREATE_DIRS = 16,
        MAILBOX_LIST_PROP_NO_LIST_INDEX = 32,
    }






    void guid_128_generate(guid_128_t, );
    int file_lock_method_parse();


    struct struct_mail_user_connection_data
    {
        struct_ip_addr* local_ip;
        struct_ip_addr* remote_ip;
        in_port_t local_port;
        in_port_t remote_port;
        int secured;
        int ssl_secured;
    }
    struct_mailbox_log* mailbox_log_alloc(const(char)*, );
    struct struct_mailbox_log;
    const(char)* file_lock_method_to_str(enum_file_lock_method, );
    void guid_128_empty(guid_128_t, );
    enum enum_mail_error
    {
        MAIL_ERROR_NONE = 0,
        MAIL_ERROR_TEMP = 1,
        MAIL_ERROR_UNAVAILABLE = 2,
        MAIL_ERROR_NOTPOSSIBLE = 3,
        MAIL_ERROR_PARAMS = 4,
        MAIL_ERROR_PERM = 5,
        MAIL_ERROR_NOQUOTA = 6,
        MAIL_ERROR_NOTFOUND = 7,
        MAIL_ERROR_EXISTS = 8,
        MAIL_ERROR_EXPUNGED = 9,
        MAIL_ERROR_INUSE = 10,
        MAIL_ERROR_CONVERSION = 11,
        MAIL_ERROR_INVALIDDATA = 12,
        MAIL_ERROR_LIMIT = 13,
        MAIL_ERROR_LOOKUP_ABORTED = 14,
    }
    enum
    {
        MAIL_ERROR_NONE = 0,
        MAIL_ERROR_TEMP = 1,
        MAIL_ERROR_UNAVAILABLE = 2,
        MAIL_ERROR_NOTPOSSIBLE = 3,
        MAIL_ERROR_PARAMS = 4,
        MAIL_ERROR_PERM = 5,
        MAIL_ERROR_NOQUOTA = 6,
        MAIL_ERROR_NOTFOUND = 7,
        MAIL_ERROR_EXISTS = 8,
        MAIL_ERROR_EXPUNGED = 9,
        MAIL_ERROR_INUSE = 10,
        MAIL_ERROR_CONVERSION = 11,
        MAIL_ERROR_INVALIDDATA = 12,
        MAIL_ERROR_LIMIT = 13,
        MAIL_ERROR_LOOKUP_ABORTED = 14,
    }






    void mailbox_log_free(struct_mailbox_log**, );
    struct struct_ip_addr
    {
        ushort family;
        union _Anonymous_2
        {
            struct_in6_addr ip6;
            struct_in_addr ip4;
        }
        _Anonymous_2 u;
    }
    enum _Anonymous_3
    {
        _PC_LINK_MAX = 0,
        _PC_MAX_CANON = 1,
        _PC_MAX_INPUT = 2,
        _PC_NAME_MAX = 3,
        _PC_PATH_MAX = 4,
        _PC_PIPE_BUF = 5,
        _PC_CHOWN_RESTRICTED = 6,
        _PC_NO_TRUNC = 7,
        _PC_VDISABLE = 8,
        _PC_SYNC_IO = 9,
        _PC_ASYNC_IO = 10,
        _PC_PRIO_IO = 11,
        _PC_SOCK_MAXBUF = 12,
        _PC_FILESIZEBITS = 13,
        _PC_REC_INCR_XFER_SIZE = 14,
        _PC_REC_MAX_XFER_SIZE = 15,
        _PC_REC_MIN_XFER_SIZE = 16,
        _PC_REC_XFER_ALIGN = 17,
        _PC_ALLOC_SIZE_MIN = 18,
        _PC_SYMLINK_MAX = 19,
        _PC_2_SYMLINKS = 20,
    }
    enum
    {
        _PC_LINK_MAX = 0,
        _PC_MAX_CANON = 1,
        _PC_MAX_INPUT = 2,
        _PC_NAME_MAX = 3,
        _PC_PATH_MAX = 4,
        _PC_PIPE_BUF = 5,
        _PC_CHOWN_RESTRICTED = 6,
        _PC_NO_TRUNC = 7,
        _PC_VDISABLE = 8,
        _PC_SYNC_IO = 9,
        _PC_ASYNC_IO = 10,
        _PC_PRIO_IO = 11,
        _PC_SOCK_MAXBUF = 12,
        _PC_FILESIZEBITS = 13,
        _PC_REC_INCR_XFER_SIZE = 14,
        _PC_REC_MAX_XFER_SIZE = 15,
        _PC_REC_MIN_XFER_SIZE = 16,
        _PC_REC_XFER_ALIGN = 17,
        _PC_ALLOC_SIZE_MIN = 18,
        _PC_SYMLINK_MAX = 19,
        _PC_2_SYMLINKS = 20,
    }




    alias uint8_t = __uint8_t;


    alias int8_t = __int8_t;


    enum enum___socket_type
    {
        SOCK_STREAM = 1,
        SOCK_DGRAM = 2,
        SOCK_RAW = 3,
        SOCK_RDM = 4,
        SOCK_SEQPACKET = 5,
        SOCK_DCCP = 6,
        SOCK_PACKET = 10,
        SOCK_CLOEXEC = 524288,
        SOCK_NONBLOCK = 2048,
    }
    enum
    {
        SOCK_STREAM = 1,
        SOCK_DGRAM = 2,
        SOCK_RAW = 3,
        SOCK_RDM = 4,
        SOCK_SEQPACKET = 5,
        SOCK_DCCP = 6,
        SOCK_PACKET = 10,
        SOCK_CLOEXEC = 524288,
        SOCK_NONBLOCK = 2048,
    }
    alias uint16_t = __uint16_t;
    struct struct_dirent;
    alias int16_t = __int16_t;




    void mailbox_log_set_permissions(struct_mailbox_log*, int, int, const(char)*, );


    int file_try_lock(int, const(char)*, int, enum_file_lock_method, struct_file_lock**, );


    struct struct_netent
    {
        char* n_name;
        char** n_aliases;
        int n_addrtype;
        uint32_t n_net;
    }


    alias int32_t = __int32_t;
    struct struct_iovec
    {
        void* iov_base;
        int iov_len;
    }
    alias uint32_t = __uint32_t;
    alias int64_t = __int64_t;
    struct struct_imap_match_glob;


    alias uint64_t = __uint64_t;
    struct struct_mailbox_list_notify
    {
        struct_mailbox_list* list;
        enum_mailbox_list_notify_event mask;
    }
    alias pthread_t = c_ulong;




    void mailbox_log_record_set_timestamp(struct_mailbox_log_record*, int, );


    alias sa_family_t = ushort;


    struct struct_mailbox_tree_context;
    struct struct_mail_user
    {
        int pool;
        struct_mail_user_vfuncs v;
        struct_mail_user_vfuncs* vlast;
        int refcount;
        struct_event* event;
        struct_mail_user* creator;
        struct_mail_storage_service_user* _service_user;
        const(char)* username;
        const(char)* _home;
        uid_t uid;
        gid_t gid;
        const(char)* service;
        const(char)* session_id;
        struct_mail_user_connection_data conn;
        const(char)* auth_token;
        const(char)* auth_user;
        const(const(char)*)* userdb_fields;
        time_t session_create_time;
        const struct_var_expand_table* var_expand_table;
        const(char)* error;
        const struct_setting_parser_info* set_info;
        const struct_mail_user_settings* unexpanded_set;
        struct_mail_user_settings* set;
        struct_mail_namespace* namespaces;
        struct_mail_storage* storages;
        int function(const struct_mail_storage_hooks*) ARRAY;
        normalizer_func_t* default_normalizer;
        struct_dict* _attr_dict;
        int nonexistent;
        int home_looked_up;
        int anonymous;
        int autocreated;
        int initialized;
        int namespaces_created;
        int settings_expanded;
        int mail_debug;
        int inbox_open_error_logged;
        int fuzzy_search;
        int dsyncing;
        int attr_dict_failed;
        int deinitializing;
        int admin;
        int stats_enabled;
        int session_restored;
    }


    void guid_128_copy(guid_128_t, const(const guid_128_t), );
    int mailbox_log_record_get_timestamp();
    alias in_addr_t = uint32_t;
    alias __u_char = ubyte;


    alias __u_short = ushort;







    int file_try_lock_error(int, const(char)*, int, enum_file_lock_method, struct_file_lock**, const(char)**, );
    struct struct_in_addr
    {
        in_addr_t s_addr;
    }




    struct struct_mailbox_list_notify_rec
    {
        enum_mailbox_list_notify_event events;
        const(char)* storage_name;
        const(char)* vname;
        guid_128_t guid;
        const(char)* old_vname;
    }




    alias __u_int = uint;


    struct struct_net_unix_cred
    {
        uid_t uid;
        gid_t gid;
        pid_t pid;
    }
    __uint16_t __uint16_identity(__uint16_t, );




    union _Anonymous_4
    {
        char[4] __size;
        int __align;
    }
    alias pthread_mutexattr_t = _Anonymous_4;
    alias socklen_t = __socklen_t;
    int mailbox_log_append(struct_mailbox_log*, const struct_mailbox_log_record*, );




    alias u_char = __u_char;
    alias __u_long = c_ulong;
    in_addr_t inet_addr(const(char)*, );


    enum enum_mailbox_list_flags
    {
        MAILBOX_LIST_FLAG_MAILBOX_FILES = 1,
        MAILBOX_LIST_FLAG_SECONDARY = 2,
        MAILBOX_LIST_FLAG_NO_MAIL_FILES = 4,
        MAILBOX_LIST_FLAG_NO_DELETES = 8,
    }
    enum
    {
        MAILBOX_LIST_FLAG_MAILBOX_FILES = 1,
        MAILBOX_LIST_FLAG_SECONDARY = 2,
        MAILBOX_LIST_FLAG_NO_MAIL_FILES = 4,
        MAILBOX_LIST_FLAG_NO_DELETES = 8,
    }


    alias u_short = __u_short;





    const(char)* guid_128_to_string(const(const guid_128_t), );


    struct struct_flock
    {
        short l_type;
        short l_whence;
        __off_t l_start;
        __off_t l_len;
        __pid_t l_pid;
    }


    alias u_int = __u_int;




    int file_wait_lock(int, const(char)*, int, enum_file_lock_method, uint, struct_file_lock**, );
    struct struct_mailbox_list_vfuncs
    {
        struct_mailbox_list* function() alloc;
        int function(struct_mailbox_list*, const(char)**) init;
        void function(struct_mailbox_list*) deinit;
        int function(struct_mailbox_list**, const(char)*, struct_mail_storage**) get_storage;
        char function(struct_mailbox_list*) get_hierarchy_sep;
        const(char)* function(struct_mailbox_list*, const(char)*) get_vname;
        const(char)* function(struct_mailbox_list*, const(char)*) get_storage_name;
        int function(struct_mailbox_list*, const(char)*, enum_mailbox_list_path_type, const(char)**) get_path;
        const(char)* function(struct_mailbox_list*, int) get_temp_prefix;
        const(char)* function(struct_mailbox_list*, const(char)*, const(char)*) join_refpattern;
        struct_mailbox_list_iterate_context* function(struct_mailbox_list*, const(const(char)*)*, enum_mailbox_list_iter_flags) iter_init;
        const(struct_mailbox_info)* function(struct_mailbox_list_iterate_context*) iter_next;
        int function(struct_mailbox_list_iterate_context*) iter_deinit;
        int function(struct_mailbox_list*, const(char)*, const(char)*, enum_mailbox_list_file_type, enum_mailbox_info_flags*) get_mailbox_flags;
        int function(struct_mailbox_list*, const(char)*) function(int*) bool_;
        int function(struct_mailbox_list*, struct_mailbox_list*) subscriptions_refresh;
        int function(struct_mailbox_list*, const(char)*, int) set_subscribed;
        int function(struct_mailbox_list*, const(char)*) delete_mailbox;
        int function(struct_mailbox_list*, const(char)*) delete_dir;
        int function(struct_mailbox_list*, const(char)*) delete_symlink;
        int function(struct_mailbox_list*, const(char)*, struct_mailbox_list*, const(char)*) rename_mailbox;
        int function(struct_mailbox_list*, enum_mailbox_list_notify_event, struct_mailbox_list_notify**) notify_init;
        int function(struct_mailbox_list_notify*, const(struct_mailbox_list_notify_rec)**) notify_next;
        void function(struct_mailbox_list_notify*) notify_deinit;
        void function(struct_mailbox_list_notify*, void function(void*)*, void*) notify_wait;
        void function(struct_mailbox_list_notify*) notify_flush;
    }
    alias __int8_t = byte;
    extern __gshared char* optarg;
    alias u_long = __u_long;



    struct_mailbox_log_iter* mailbox_log_iter_init(struct_mailbox_log*, );
    alias __uint8_t = ubyte;






    int guid_128_from_string(const(char)*, guid_128_t, );


    struct struct_mailbox_log_iter;
    alias quad_t = __quad_t;
    in_addr_t inet_lnaof(struct_in_addr, );




    const(struct_mailbox_log_record)* mailbox_log_iter_next(struct_mailbox_log_iter*, );






    alias u_quad_t = __u_quad_t;


    __uint32_t __uint32_identity(__uint32_t, );






    alias __int16_t = short;




    alias fsid_t = __fsid_t;


    alias __uint16_t = ushort;
    alias __int32_t = int;


    const(char)* guid_128_to_uuid_string(const(const guid_128_t), enum_uuid_format, );






    enum _Anonymous_5
    {
        IPPROTO_IP = 0,
        IPPROTO_ICMP = 1,
        IPPROTO_IGMP = 2,
        IPPROTO_IPIP = 4,
        IPPROTO_TCP = 6,
        IPPROTO_EGP = 8,
        IPPROTO_PUP = 12,
        IPPROTO_UDP = 17,
        IPPROTO_IDP = 22,
        IPPROTO_TP = 29,
        IPPROTO_DCCP = 33,
        IPPROTO_IPV6 = 41,
        IPPROTO_RSVP = 46,
        IPPROTO_GRE = 47,
        IPPROTO_ESP = 50,
        IPPROTO_AH = 51,
        IPPROTO_MTP = 92,
        IPPROTO_BEETPH = 94,
        IPPROTO_ENCAP = 98,
        IPPROTO_PIM = 103,
        IPPROTO_COMP = 108,
        IPPROTO_SCTP = 132,
        IPPROTO_UDPLITE = 136,
        IPPROTO_MPLS = 137,
        IPPROTO_RAW = 255,
        IPPROTO_MAX = 256,
    }
    enum
    {
        IPPROTO_IP = 0,
        IPPROTO_ICMP = 1,
        IPPROTO_IGMP = 2,
        IPPROTO_IPIP = 4,
        IPPROTO_TCP = 6,
        IPPROTO_EGP = 8,
        IPPROTO_PUP = 12,
        IPPROTO_UDP = 17,
        IPPROTO_IDP = 22,
        IPPROTO_TP = 29,
        IPPROTO_DCCP = 33,
        IPPROTO_IPV6 = 41,
        IPPROTO_RSVP = 46,
        IPPROTO_GRE = 47,
        IPPROTO_ESP = 50,
        IPPROTO_AH = 51,
        IPPROTO_MTP = 92,
        IPPROTO_BEETPH = 94,
        IPPROTO_ENCAP = 98,
        IPPROTO_PIM = 103,
        IPPROTO_COMP = 108,
        IPPROTO_SCTP = 132,
        IPPROTO_UDPLITE = 136,
        IPPROTO_MPLS = 137,
        IPPROTO_RAW = 255,
        IPPROTO_MAX = 256,
    }



    int mailbox_log_iter_deinit(struct_mailbox_log_iter**, );
    struct_in_addr inet_makeaddr(in_addr_t, in_addr_t, );
    enum _Anonymous_6
    {
        SHUT_RD = 0,
        SHUT_WR = 1,
        SHUT_RDWR = 2,
    }
    enum
    {
        SHUT_RD = 0,
        SHUT_WR = 1,
        SHUT_RDWR = 2,
    }


    alias pthread_condattr_t = _Anonymous_7;
    union _Anonymous_7
    {
        char[4] __size;
        int __align;
    }
    alias __uint32_t = uint;
    int file_wait_lock_error(int, const(char)*, int, enum_file_lock_method, uint, struct_file_lock**, const(char)**, );
    int guid_128_from_uuid_string(const(char)*, guid_128_t, );
    alias __int64_t = c_long;


    alias suseconds_t = __suseconds_t;
    __uint64_t __uint64_identity(__uint64_t, );
    alias loff_t = __loff_t;




    alias __uint64_t = c_ulong;


    struct struct_mailbox_info
    {
        const(char)* vname;
        const(char)* special_use;
        enum_mailbox_info_flags flags;
        struct_mail_namespace* ns;
    }
    enum enum_net_listen_flags
    {
        NET_LISTEN_FLAG_REUSEPORT = 1,
    }
    enum
    {
        NET_LISTEN_FLAG_REUSEPORT = 1,
    }
    in_addr_t inet_netof(struct_in_addr, );


    alias mailbox_list_notify_callback_t = _Anonymous_8;
    struct struct_rpcent
    {
        char* r_name;
        char** r_aliases;
        int r_number;
    }




    struct struct_stat
    {
        __dev_t st_dev;
        __ino_t st_ino;
        __nlink_t st_nlink;
        __mode_t st_mode;
        __uid_t st_uid;
        __gid_t st_gid;
        int __pad0;
        __dev_t st_rdev;
        __off_t st_size;
        __blksize_t st_blksize;
        __blkcnt_t st_blocks;
        struct_timespec st_atim;
        struct_timespec st_mtim;
        struct_timespec st_ctim;
        __syscall_slong_t[3] __glibc_reserved;
    }
    enum enum_mailbox_info_flags
    {
        MAILBOX_NOSELECT = 1,
        MAILBOX_NONEXISTENT = 2,
        MAILBOX_CHILDREN = 4,
        MAILBOX_NOCHILDREN = 8,
        MAILBOX_NOINFERIORS = 16,
        MAILBOX_MARKED = 32,
        MAILBOX_UNMARKED = 64,
        MAILBOX_SUBSCRIBED = 128,
        MAILBOX_CHILD_SUBSCRIBED = 256,
        MAILBOX_CHILD_SPECIALUSE = 512,
        MAILBOX_SPECIALUSE_ALL = 65536,
        MAILBOX_SPECIALUSE_ARCHIVE = 131072,
        MAILBOX_SPECIALUSE_DRAFTS = 262144,
        MAILBOX_SPECIALUSE_FLAGGED = 524288,
        MAILBOX_SPECIALUSE_JUNK = 1048576,
        MAILBOX_SPECIALUSE_SENT = 2097152,
        MAILBOX_SPECIALUSE_TRASH = 4194304,
        MAILBOX_SPECIALUSE_IMPORTANT = 8388608,
        MAILBOX_SELECT = 536870912,
        MAILBOX_MATCHED = 1073741824,
    }
    enum
    {
        MAILBOX_NOSELECT = 1,
        MAILBOX_NONEXISTENT = 2,
        MAILBOX_CHILDREN = 4,
        MAILBOX_NOCHILDREN = 8,
        MAILBOX_NOINFERIORS = 16,
        MAILBOX_MARKED = 32,
        MAILBOX_UNMARKED = 64,
        MAILBOX_SUBSCRIBED = 128,
        MAILBOX_CHILD_SUBSCRIBED = 256,
        MAILBOX_CHILD_SPECIALUSE = 512,
        MAILBOX_SPECIALUSE_ALL = 65536,
        MAILBOX_SPECIALUSE_ARCHIVE = 131072,
        MAILBOX_SPECIALUSE_DRAFTS = 262144,
        MAILBOX_SPECIALUSE_FLAGGED = 524288,
        MAILBOX_SPECIALUSE_JUNK = 1048576,
        MAILBOX_SPECIALUSE_SENT = 2097152,
        MAILBOX_SPECIALUSE_TRASH = 4194304,
        MAILBOX_SPECIALUSE_IMPORTANT = 8388608,
        MAILBOX_SELECT = 536870912,
        MAILBOX_MATCHED = 1073741824,
    }
    int file_lock_try_update(struct_file_lock*, int, );
    alias ino_t = __ino_t;
    void guid_128_host_hash_get(const(char)*, ubyte, );
    in_addr_t inet_network(const(char)*, );


    alias pthread_key_t = uint;


    int mailbox_list_notify_init(struct_mailbox_list*, enum_mailbox_list_notify_event, struct_mailbox_list_notify**, );
    alias __fd_mask = c_long;
    extern __gshared int optind;
    void mailbox_list_notify_deinit(struct_mailbox_list_notify**, );






    alias __quad_t = c_long;


    void file_lock_set_unlink_on_free(struct_file_lock*, int, );


    extern __gshared const struct_ip_addr net_ip4_any;


    const(char)* mailbox_list_join_refpattern(struct_mailbox_list*, const(char)*, const(char)*, );
    alias __u_quad_t = c_ulong;


    void setrpcent(int, );
    char* inet_ntoa(struct_in_addr, );


    alias pthread_once_t = int;
    extern __gshared const struct_ip_addr net_ip6_any;
    void endrpcent();




    extern __gshared int opterr;


    struct_rpcent* getrpcbyname(const(char)*, );
    void file_lock_set_close_on_free(struct_file_lock*, int, );




    union union_pthread_attr_t
    {
        char[56] __size;
        c_long __align;
    }






    int mailbox_list_notify_next(struct_mailbox_list_notify*, const struct_mailbox_list_notify_rec**, );
    struct_rpcent* getrpcbynumber(int, );




    extern __gshared const struct_ip_addr net_ip4_loopback;
    struct_rpcent* getrpcent();
    extern __gshared const struct_ip_addr net_ip6_loopback;
    int inet_pton(int, const(char)*, void*, );





    struct struct_mailbox_list_iterate_context;




    struct_mailbox_list_iterate_context* mailbox_list_iter_init(struct_mailbox_list*, const(char)*, enum_mailbox_list_iter_flags, );






    alias fd_set = _Anonymous_9;
    struct _Anonymous_9
    {
        __fd_mask[16] __fds_bits;
    }


    void mailbox_list_notify_wait(struct_mailbox_list_notify*, mailbox_list_notify_callback_t*, void*, );
    extern __gshared int optopt;




    struct_file_lock* file_lock_from_dotlock(struct_dotlock**, );






    int* __h_errno_location();



    int net_ip_compare();


    alias dev_t = __dev_t;




    int getrpcbyname_r(const(char)*, struct_rpcent*, char*, int, struct_rpcent**, );
    alias __intmax_t = c_long;






    int mail_error_from_errno();
    void file_unlock(struct_file_lock**, );
    int net_ip_cmp(const struct_ip_addr*, const struct_ip_addr*, );


    alias pthread_attr_t = union_pthread_attr_t;
    alias __uintmax_t = c_ulong;
    uint net_ip_hash(const struct_ip_addr*, );
    struct_mailbox_list_iterate_context* mailbox_list_iter_init_multiple(struct_mailbox_list*, const(const(char)*)*, enum_mailbox_list_iter_flags, );






    void file_lock_free(struct_file_lock**, );





    const(char)* inet_ntop(int, const(void)*, char*, socklen_t, );




    int getrpcbynumber_r(int, struct_rpcent*, char*, int, struct_rpcent**, );






    void mailbox_list_notify_flush(struct_mailbox_list_notify*, );






    alias gid_t = __gid_t;
    struct struct___pthread_rwlock_arch_t
    {
        uint __readers;
        uint __writers;
        uint __wrphase_futex;
        uint __writers_futex;
        uint __pad3;
        uint __pad4;
        int __cur_writer;
        int __shared;
        byte __rwelision;
        ubyte[7] __pad1;
        c_ulong __pad2;
        uint __flags;
    }


    const(char)* mail_error_eacces_msg(const(char)*, const(char)*, );
    alias pthread_mutex_t = _Anonymous_10;




    union _Anonymous_10
    {
        struct___pthread_mutex_s __data;
        char[40] __size;
        c_long __align;
    }






    const(char)* file_lock_get_path(struct_file_lock*, );
    const(char)* mail_error_create_eacces_msg(const(char)*, const(char)*, );


    int getrpcent_r(struct_rpcent*, char*, int, struct_rpcent**, );
    void file_lock_set_path(struct_file_lock*, const(char)*, );
    struct_mailbox_list_iterate_context* mailbox_list_iter_init_namespaces(struct_mail_namespace*, const(const(char)*)*, enum_mail_namespace_type, enum_mailbox_list_iter_flags, );






    alias mode_t = __mode_t;
    enum _Anonymous_11
    {
        _SC_ARG_MAX = 0,
        _SC_CHILD_MAX = 1,
        _SC_CLK_TCK = 2,
        _SC_NGROUPS_MAX = 3,
        _SC_OPEN_MAX = 4,
        _SC_STREAM_MAX = 5,
        _SC_TZNAME_MAX = 6,
        _SC_JOB_CONTROL = 7,
        _SC_SAVED_IDS = 8,
        _SC_REALTIME_SIGNALS = 9,
        _SC_PRIORITY_SCHEDULING = 10,
        _SC_TIMERS = 11,
        _SC_ASYNCHRONOUS_IO = 12,
        _SC_PRIORITIZED_IO = 13,
        _SC_SYNCHRONIZED_IO = 14,
        _SC_FSYNC = 15,
        _SC_MAPPED_FILES = 16,
        _SC_MEMLOCK = 17,
        _SC_MEMLOCK_RANGE = 18,
        _SC_MEMORY_PROTECTION = 19,
        _SC_MESSAGE_PASSING = 20,
        _SC_SEMAPHORES = 21,
        _SC_SHARED_MEMORY_OBJECTS = 22,
        _SC_AIO_LISTIO_MAX = 23,
        _SC_AIO_MAX = 24,
        _SC_AIO_PRIO_DELTA_MAX = 25,
        _SC_DELAYTIMER_MAX = 26,
        _SC_MQ_OPEN_MAX = 27,
        _SC_MQ_PRIO_MAX = 28,
        _SC_VERSION = 29,
        _SC_PAGESIZE = 30,
        _SC_RTSIG_MAX = 31,
        _SC_SEM_NSEMS_MAX = 32,
        _SC_SEM_VALUE_MAX = 33,
        _SC_SIGQUEUE_MAX = 34,
        _SC_TIMER_MAX = 35,
        _SC_BC_BASE_MAX = 36,
        _SC_BC_DIM_MAX = 37,
        _SC_BC_SCALE_MAX = 38,
        _SC_BC_STRING_MAX = 39,
        _SC_COLL_WEIGHTS_MAX = 40,
        _SC_EQUIV_CLASS_MAX = 41,
        _SC_EXPR_NEST_MAX = 42,
        _SC_LINE_MAX = 43,
        _SC_RE_DUP_MAX = 44,
        _SC_CHARCLASS_NAME_MAX = 45,
        _SC_2_VERSION = 46,
        _SC_2_C_BIND = 47,
        _SC_2_C_DEV = 48,
        _SC_2_FORT_DEV = 49,
        _SC_2_FORT_RUN = 50,
        _SC_2_SW_DEV = 51,
        _SC_2_LOCALEDEF = 52,
        _SC_PII = 53,
        _SC_PII_XTI = 54,
        _SC_PII_SOCKET = 55,
        _SC_PII_INTERNET = 56,
        _SC_PII_OSI = 57,
        _SC_POLL = 58,
        _SC_SELECT = 59,
        _SC_UIO_MAXIOV = 60,
        _SC_IOV_MAX = 60,
        _SC_PII_INTERNET_STREAM = 61,
        _SC_PII_INTERNET_DGRAM = 62,
        _SC_PII_OSI_COTS = 63,
        _SC_PII_OSI_CLTS = 64,
        _SC_PII_OSI_M = 65,
        _SC_T_IOV_MAX = 66,
        _SC_THREADS = 67,
        _SC_THREAD_SAFE_FUNCTIONS = 68,
        _SC_GETGR_R_SIZE_MAX = 69,
        _SC_GETPW_R_SIZE_MAX = 70,
        _SC_LOGIN_NAME_MAX = 71,
        _SC_TTY_NAME_MAX = 72,
        _SC_THREAD_DESTRUCTOR_ITERATIONS = 73,
        _SC_THREAD_KEYS_MAX = 74,
        _SC_THREAD_STACK_MIN = 75,
        _SC_THREAD_THREADS_MAX = 76,
        _SC_THREAD_ATTR_STACKADDR = 77,
        _SC_THREAD_ATTR_STACKSIZE = 78,
        _SC_THREAD_PRIORITY_SCHEDULING = 79,
        _SC_THREAD_PRIO_INHERIT = 80,
        _SC_THREAD_PRIO_PROTECT = 81,
        _SC_THREAD_PROCESS_SHARED = 82,
        _SC_NPROCESSORS_CONF = 83,
        _SC_NPROCESSORS_ONLN = 84,
        _SC_PHYS_PAGES = 85,
        _SC_AVPHYS_PAGES = 86,
        _SC_ATEXIT_MAX = 87,
        _SC_PASS_MAX = 88,
        _SC_XOPEN_VERSION = 89,
        _SC_XOPEN_XCU_VERSION = 90,
        _SC_XOPEN_UNIX = 91,
        _SC_XOPEN_CRYPT = 92,
        _SC_XOPEN_ENH_I18N = 93,
        _SC_XOPEN_SHM = 94,
        _SC_2_CHAR_TERM = 95,
        _SC_2_C_VERSION = 96,
        _SC_2_UPE = 97,
        _SC_XOPEN_XPG2 = 98,
        _SC_XOPEN_XPG3 = 99,
        _SC_XOPEN_XPG4 = 100,
        _SC_CHAR_BIT = 101,
        _SC_CHAR_MAX = 102,
        _SC_CHAR_MIN = 103,
        _SC_INT_MAX = 104,
        _SC_INT_MIN = 105,
        _SC_LONG_BIT = 106,
        _SC_WORD_BIT = 107,
        _SC_MB_LEN_MAX = 108,
        _SC_NZERO = 109,
        _SC_SSIZE_MAX = 110,
        _SC_SCHAR_MAX = 111,
        _SC_SCHAR_MIN = 112,
        _SC_SHRT_MAX = 113,
        _SC_SHRT_MIN = 114,
        _SC_UCHAR_MAX = 115,
        _SC_UINT_MAX = 116,
        _SC_ULONG_MAX = 117,
        _SC_USHRT_MAX = 118,
        _SC_NL_ARGMAX = 119,
        _SC_NL_LANGMAX = 120,
        _SC_NL_MSGMAX = 121,
        _SC_NL_NMAX = 122,
        _SC_NL_SETMAX = 123,
        _SC_NL_TEXTMAX = 124,
        _SC_XBS5_ILP32_OFF32 = 125,
        _SC_XBS5_ILP32_OFFBIG = 126,
        _SC_XBS5_LP64_OFF64 = 127,
        _SC_XBS5_LPBIG_OFFBIG = 128,
        _SC_XOPEN_LEGACY = 129,
        _SC_XOPEN_REALTIME = 130,
        _SC_XOPEN_REALTIME_THREADS = 131,
        _SC_ADVISORY_INFO = 132,
        _SC_BARRIERS = 133,
        _SC_BASE = 134,
        _SC_C_LANG_SUPPORT = 135,
        _SC_C_LANG_SUPPORT_R = 136,
        _SC_CLOCK_SELECTION = 137,
        _SC_CPUTIME = 138,
        _SC_THREAD_CPUTIME = 139,
        _SC_DEVICE_IO = 140,
        _SC_DEVICE_SPECIFIC = 141,
        _SC_DEVICE_SPECIFIC_R = 142,
        _SC_FD_MGMT = 143,
        _SC_FIFO = 144,
        _SC_PIPE = 145,
        _SC_FILE_ATTRIBUTES = 146,
        _SC_FILE_LOCKING = 147,
        _SC_FILE_SYSTEM = 148,
        _SC_MONOTONIC_CLOCK = 149,
        _SC_MULTI_PROCESS = 150,
        _SC_SINGLE_PROCESS = 151,
        _SC_NETWORKING = 152,
        _SC_READER_WRITER_LOCKS = 153,
        _SC_SPIN_LOCKS = 154,
        _SC_REGEXP = 155,
        _SC_REGEX_VERSION = 156,
        _SC_SHELL = 157,
        _SC_SIGNALS = 158,
        _SC_SPAWN = 159,
        _SC_SPORADIC_SERVER = 160,
        _SC_THREAD_SPORADIC_SERVER = 161,
        _SC_SYSTEM_DATABASE = 162,
        _SC_SYSTEM_DATABASE_R = 163,
        _SC_TIMEOUTS = 164,
        _SC_TYPED_MEMORY_OBJECTS = 165,
        _SC_USER_GROUPS = 166,
        _SC_USER_GROUPS_R = 167,
        _SC_2_PBS = 168,
        _SC_2_PBS_ACCOUNTING = 169,
        _SC_2_PBS_LOCATE = 170,
        _SC_2_PBS_MESSAGE = 171,
        _SC_2_PBS_TRACK = 172,
        _SC_SYMLOOP_MAX = 173,
        _SC_STREAMS = 174,
        _SC_2_PBS_CHECKPOINT = 175,
        _SC_V6_ILP32_OFF32 = 176,
        _SC_V6_ILP32_OFFBIG = 177,
        _SC_V6_LP64_OFF64 = 178,
        _SC_V6_LPBIG_OFFBIG = 179,
        _SC_HOST_NAME_MAX = 180,
        _SC_TRACE = 181,
        _SC_TRACE_EVENT_FILTER = 182,
        _SC_TRACE_INHERIT = 183,
        _SC_TRACE_LOG = 184,
        _SC_LEVEL1_ICACHE_SIZE = 185,
        _SC_LEVEL1_ICACHE_ASSOC = 186,
        _SC_LEVEL1_ICACHE_LINESIZE = 187,
        _SC_LEVEL1_DCACHE_SIZE = 188,
        _SC_LEVEL1_DCACHE_ASSOC = 189,
        _SC_LEVEL1_DCACHE_LINESIZE = 190,
        _SC_LEVEL2_CACHE_SIZE = 191,
        _SC_LEVEL2_CACHE_ASSOC = 192,
        _SC_LEVEL2_CACHE_LINESIZE = 193,
        _SC_LEVEL3_CACHE_SIZE = 194,
        _SC_LEVEL3_CACHE_ASSOC = 195,
        _SC_LEVEL3_CACHE_LINESIZE = 196,
        _SC_LEVEL4_CACHE_SIZE = 197,
        _SC_LEVEL4_CACHE_ASSOC = 198,
        _SC_LEVEL4_CACHE_LINESIZE = 199,
        _SC_IPV6 = 235,
        _SC_RAW_SOCKETS = 236,
        _SC_V7_ILP32_OFF32 = 237,
        _SC_V7_ILP32_OFFBIG = 238,
        _SC_V7_LP64_OFF64 = 239,
        _SC_V7_LPBIG_OFFBIG = 240,
        _SC_SS_REPL_MAX = 241,
        _SC_TRACE_EVENT_NAME_MAX = 242,
        _SC_TRACE_NAME_MAX = 243,
        _SC_TRACE_SYS_MAX = 244,
        _SC_TRACE_USER_EVENT_MAX = 245,
        _SC_XOPEN_STREAMS = 246,
        _SC_THREAD_ROBUST_PRIO_INHERIT = 247,
        _SC_THREAD_ROBUST_PRIO_PROTECT = 248,
    }
    enum
    {
        _SC_ARG_MAX = 0,
        _SC_CHILD_MAX = 1,
        _SC_CLK_TCK = 2,
        _SC_NGROUPS_MAX = 3,
        _SC_OPEN_MAX = 4,
        _SC_STREAM_MAX = 5,
        _SC_TZNAME_MAX = 6,
        _SC_JOB_CONTROL = 7,
        _SC_SAVED_IDS = 8,
        _SC_REALTIME_SIGNALS = 9,
        _SC_PRIORITY_SCHEDULING = 10,
        _SC_TIMERS = 11,
        _SC_ASYNCHRONOUS_IO = 12,
        _SC_PRIORITIZED_IO = 13,
        _SC_SYNCHRONIZED_IO = 14,
        _SC_FSYNC = 15,
        _SC_MAPPED_FILES = 16,
        _SC_MEMLOCK = 17,
        _SC_MEMLOCK_RANGE = 18,
        _SC_MEMORY_PROTECTION = 19,
        _SC_MESSAGE_PASSING = 20,
        _SC_SEMAPHORES = 21,
        _SC_SHARED_MEMORY_OBJECTS = 22,
        _SC_AIO_LISTIO_MAX = 23,
        _SC_AIO_MAX = 24,
        _SC_AIO_PRIO_DELTA_MAX = 25,
        _SC_DELAYTIMER_MAX = 26,
        _SC_MQ_OPEN_MAX = 27,
        _SC_MQ_PRIO_MAX = 28,
        _SC_VERSION = 29,
        _SC_PAGESIZE = 30,
        _SC_RTSIG_MAX = 31,
        _SC_SEM_NSEMS_MAX = 32,
        _SC_SEM_VALUE_MAX = 33,
        _SC_SIGQUEUE_MAX = 34,
        _SC_TIMER_MAX = 35,
        _SC_BC_BASE_MAX = 36,
        _SC_BC_DIM_MAX = 37,
        _SC_BC_SCALE_MAX = 38,
        _SC_BC_STRING_MAX = 39,
        _SC_COLL_WEIGHTS_MAX = 40,
        _SC_EQUIV_CLASS_MAX = 41,
        _SC_EXPR_NEST_MAX = 42,
        _SC_LINE_MAX = 43,
        _SC_RE_DUP_MAX = 44,
        _SC_CHARCLASS_NAME_MAX = 45,
        _SC_2_VERSION = 46,
        _SC_2_C_BIND = 47,
        _SC_2_C_DEV = 48,
        _SC_2_FORT_DEV = 49,
        _SC_2_FORT_RUN = 50,
        _SC_2_SW_DEV = 51,
        _SC_2_LOCALEDEF = 52,
        _SC_PII = 53,
        _SC_PII_XTI = 54,
        _SC_PII_SOCKET = 55,
        _SC_PII_INTERNET = 56,
        _SC_PII_OSI = 57,
        _SC_POLL = 58,
        _SC_SELECT = 59,
        _SC_UIO_MAXIOV = 60,
        _SC_IOV_MAX = 60,
        _SC_PII_INTERNET_STREAM = 61,
        _SC_PII_INTERNET_DGRAM = 62,
        _SC_PII_OSI_COTS = 63,
        _SC_PII_OSI_CLTS = 64,
        _SC_PII_OSI_M = 65,
        _SC_T_IOV_MAX = 66,
        _SC_THREADS = 67,
        _SC_THREAD_SAFE_FUNCTIONS = 68,
        _SC_GETGR_R_SIZE_MAX = 69,
        _SC_GETPW_R_SIZE_MAX = 70,
        _SC_LOGIN_NAME_MAX = 71,
        _SC_TTY_NAME_MAX = 72,
        _SC_THREAD_DESTRUCTOR_ITERATIONS = 73,
        _SC_THREAD_KEYS_MAX = 74,
        _SC_THREAD_STACK_MIN = 75,
        _SC_THREAD_THREADS_MAX = 76,
        _SC_THREAD_ATTR_STACKADDR = 77,
        _SC_THREAD_ATTR_STACKSIZE = 78,
        _SC_THREAD_PRIORITY_SCHEDULING = 79,
        _SC_THREAD_PRIO_INHERIT = 80,
        _SC_THREAD_PRIO_PROTECT = 81,
        _SC_THREAD_PROCESS_SHARED = 82,
        _SC_NPROCESSORS_CONF = 83,
        _SC_NPROCESSORS_ONLN = 84,
        _SC_PHYS_PAGES = 85,
        _SC_AVPHYS_PAGES = 86,
        _SC_ATEXIT_MAX = 87,
        _SC_PASS_MAX = 88,
        _SC_XOPEN_VERSION = 89,
        _SC_XOPEN_XCU_VERSION = 90,
        _SC_XOPEN_UNIX = 91,
        _SC_XOPEN_CRYPT = 92,
        _SC_XOPEN_ENH_I18N = 93,
        _SC_XOPEN_SHM = 94,
        _SC_2_CHAR_TERM = 95,
        _SC_2_C_VERSION = 96,
        _SC_2_UPE = 97,
        _SC_XOPEN_XPG2 = 98,
        _SC_XOPEN_XPG3 = 99,
        _SC_XOPEN_XPG4 = 100,
        _SC_CHAR_BIT = 101,
        _SC_CHAR_MAX = 102,
        _SC_CHAR_MIN = 103,
        _SC_INT_MAX = 104,
        _SC_INT_MIN = 105,
        _SC_LONG_BIT = 106,
        _SC_WORD_BIT = 107,
        _SC_MB_LEN_MAX = 108,
        _SC_NZERO = 109,
        _SC_SSIZE_MAX = 110,
        _SC_SCHAR_MAX = 111,
        _SC_SCHAR_MIN = 112,
        _SC_SHRT_MAX = 113,
        _SC_SHRT_MIN = 114,
        _SC_UCHAR_MAX = 115,
        _SC_UINT_MAX = 116,
        _SC_ULONG_MAX = 117,
        _SC_USHRT_MAX = 118,
        _SC_NL_ARGMAX = 119,
        _SC_NL_LANGMAX = 120,
        _SC_NL_MSGMAX = 121,
        _SC_NL_NMAX = 122,
        _SC_NL_SETMAX = 123,
        _SC_NL_TEXTMAX = 124,
        _SC_XBS5_ILP32_OFF32 = 125,
        _SC_XBS5_ILP32_OFFBIG = 126,
        _SC_XBS5_LP64_OFF64 = 127,
        _SC_XBS5_LPBIG_OFFBIG = 128,
        _SC_XOPEN_LEGACY = 129,
        _SC_XOPEN_REALTIME = 130,
        _SC_XOPEN_REALTIME_THREADS = 131,
        _SC_ADVISORY_INFO = 132,
        _SC_BARRIERS = 133,
        _SC_BASE = 134,
        _SC_C_LANG_SUPPORT = 135,
        _SC_C_LANG_SUPPORT_R = 136,
        _SC_CLOCK_SELECTION = 137,
        _SC_CPUTIME = 138,
        _SC_THREAD_CPUTIME = 139,
        _SC_DEVICE_IO = 140,
        _SC_DEVICE_SPECIFIC = 141,
        _SC_DEVICE_SPECIFIC_R = 142,
        _SC_FD_MGMT = 143,
        _SC_FIFO = 144,
        _SC_PIPE = 145,
        _SC_FILE_ATTRIBUTES = 146,
        _SC_FILE_LOCKING = 147,
        _SC_FILE_SYSTEM = 148,
        _SC_MONOTONIC_CLOCK = 149,
        _SC_MULTI_PROCESS = 150,
        _SC_SINGLE_PROCESS = 151,
        _SC_NETWORKING = 152,
        _SC_READER_WRITER_LOCKS = 153,
        _SC_SPIN_LOCKS = 154,
        _SC_REGEXP = 155,
        _SC_REGEX_VERSION = 156,
        _SC_SHELL = 157,
        _SC_SIGNALS = 158,
        _SC_SPAWN = 159,
        _SC_SPORADIC_SERVER = 160,
        _SC_THREAD_SPORADIC_SERVER = 161,
        _SC_SYSTEM_DATABASE = 162,
        _SC_SYSTEM_DATABASE_R = 163,
        _SC_TIMEOUTS = 164,
        _SC_TYPED_MEMORY_OBJECTS = 165,
        _SC_USER_GROUPS = 166,
        _SC_USER_GROUPS_R = 167,
        _SC_2_PBS = 168,
        _SC_2_PBS_ACCOUNTING = 169,
        _SC_2_PBS_LOCATE = 170,
        _SC_2_PBS_MESSAGE = 171,
        _SC_2_PBS_TRACK = 172,
        _SC_SYMLOOP_MAX = 173,
        _SC_STREAMS = 174,
        _SC_2_PBS_CHECKPOINT = 175,
        _SC_V6_ILP32_OFF32 = 176,
        _SC_V6_ILP32_OFFBIG = 177,
        _SC_V6_LP64_OFF64 = 178,
        _SC_V6_LPBIG_OFFBIG = 179,
        _SC_HOST_NAME_MAX = 180,
        _SC_TRACE = 181,
        _SC_TRACE_EVENT_FILTER = 182,
        _SC_TRACE_INHERIT = 183,
        _SC_TRACE_LOG = 184,
        _SC_LEVEL1_ICACHE_SIZE = 185,
        _SC_LEVEL1_ICACHE_ASSOC = 186,
        _SC_LEVEL1_ICACHE_LINESIZE = 187,
        _SC_LEVEL1_DCACHE_SIZE = 188,
        _SC_LEVEL1_DCACHE_ASSOC = 189,
        _SC_LEVEL1_DCACHE_LINESIZE = 190,
        _SC_LEVEL2_CACHE_SIZE = 191,
        _SC_LEVEL2_CACHE_ASSOC = 192,
        _SC_LEVEL2_CACHE_LINESIZE = 193,
        _SC_LEVEL3_CACHE_SIZE = 194,
        _SC_LEVEL3_CACHE_ASSOC = 195,
        _SC_LEVEL3_CACHE_LINESIZE = 196,
        _SC_LEVEL4_CACHE_SIZE = 197,
        _SC_LEVEL4_CACHE_ASSOC = 198,
        _SC_LEVEL4_CACHE_LINESIZE = 199,
        _SC_IPV6 = 235,
        _SC_RAW_SOCKETS = 236,
        _SC_V7_ILP32_OFF32 = 237,
        _SC_V7_ILP32_OFFBIG = 238,
        _SC_V7_LP64_OFF64 = 239,
        _SC_V7_LPBIG_OFFBIG = 240,
        _SC_SS_REPL_MAX = 241,
        _SC_TRACE_EVENT_NAME_MAX = 242,
        _SC_TRACE_NAME_MAX = 243,
        _SC_TRACE_SYS_MAX = 244,
        _SC_TRACE_USER_EVENT_MAX = 245,
        _SC_XOPEN_STREAMS = 246,
        _SC_THREAD_ROBUST_PRIO_INHERIT = 247,
        _SC_THREAD_ROBUST_PRIO_PROTECT = 248,
    }
    int inet_aton(const(char)*, struct_in_addr*, );
    uint gnu_dev_major(__dev_t, );
    int net_connect_udp(const struct_ip_addr*, in_port_t, const struct_ip_addr*, );
    uint gnu_dev_minor(__dev_t, );
    const(char)* file_lock_find(int, enum_file_lock_method, int, );


    alias nlink_t = __nlink_t;
    __dev_t gnu_dev_makedev(uint, uint, );


    union _Anonymous_12
    {
        struct___pthread_cond_s __data;
        char[48] __size;
        long __align;
    }
    alias pthread_cond_t = _Anonymous_12;


    enum enum_mailbox_list_path_type
    {
        MAILBOX_LIST_PATH_TYPE_DIR = 0,
        MAILBOX_LIST_PATH_TYPE_ALT_DIR = 1,
        MAILBOX_LIST_PATH_TYPE_MAILBOX = 2,
        MAILBOX_LIST_PATH_TYPE_ALT_MAILBOX = 3,
        MAILBOX_LIST_PATH_TYPE_CONTROL = 4,
        MAILBOX_LIST_PATH_TYPE_INDEX = 5,
        MAILBOX_LIST_PATH_TYPE_INDEX_PRIVATE = 6,
        MAILBOX_LIST_PATH_TYPE_INDEX_CACHE = 7,
        MAILBOX_LIST_PATH_TYPE_LIST_INDEX = 8,
    }
    enum
    {
        MAILBOX_LIST_PATH_TYPE_DIR = 0,
        MAILBOX_LIST_PATH_TYPE_ALT_DIR = 1,
        MAILBOX_LIST_PATH_TYPE_MAILBOX = 2,
        MAILBOX_LIST_PATH_TYPE_ALT_MAILBOX = 3,
        MAILBOX_LIST_PATH_TYPE_CONTROL = 4,
        MAILBOX_LIST_PATH_TYPE_INDEX = 5,
        MAILBOX_LIST_PATH_TYPE_INDEX_PRIVATE = 6,
        MAILBOX_LIST_PATH_TYPE_INDEX_CACHE = 7,
        MAILBOX_LIST_PATH_TYPE_LIST_INDEX = 8,
    }
    const(struct_mailbox_info)* mailbox_list_iter_next(struct_mailbox_list_iterate_context* );


    int net_try_bind(const struct_ip_addr*, );
    alias fd_mask = __fd_mask;
    char* inet_neta(in_addr_t, char*, int, );


    void file_lock_wait_start();
    int net_connect_unix(const(char)*, );
    void file_lock_wait_end(const(char)*, );
    alias uid_t = __uid_t;
    int net_connect_unix_with_retries(const(char)*, uint, );
    uint64_t file_lock_wait_get_total_usecs();
    int mailbox_list_iter_deinit(struct_mailbox_list_iterate_context**, );




    alias __pthread_list_t = struct___pthread_internal_list;


    struct struct___pthread_internal_list
    {
        struct___pthread_internal_list* __prev;
        struct___pthread_internal_list* __next;
    }
    char* inet_net_ntop(int, const(void)*, int, char*, int, );
    void net_disconnect(int, );






    int mailbox_list_mailbox(struct_mailbox_list*, const(char)*, enum_mailbox_info_flags*, );
    struct struct_mail_namespace_settings
    {
        const(char)* name;
        const(char)* type;
        const(char)* separator;
        const(char)* prefix;
        const(char)* location;
        const(char)* alias_for;
        int inbox;
        int hidden;
        const(char)* list;
        int subscriptions;
        int ignore_on_failure;
        int disabled;
        uint order;
        int function(struct_mailbox_settings*) ARRAY;
        struct_mail_user_settings* user_set;
    }
    union _Anonymous_13
    {
        struct___pthread_rwlock_arch_t __data;
        char[56] __size;
        c_long __align;
    }
    void net_set_nonblock(int, int, );




    alias off_t = __off_t;
    alias pthread_rwlock_t = _Anonymous_13;
    int mailbox_has_children(struct_mailbox_list*, const(char)*, );
    int inet_net_pton(int, const(char)*, void*, int, );
    void herror(const(char)*, );




    int net_set_tcp_nodelay(int, int, );


    int getopt(int, char**, const(char)*, );
    union _Anonymous_14
    {
        char[8] __size;
        c_long __align;
    }
    alias pthread_rwlockattr_t = _Anonymous_14;
    const(char)* hstrerror(int, );




    int net_set_send_buffer_size(int, int, );




    uint inet_nsap_addr(const(char)*, ubyte*, int, );
    int net_set_recv_buffer_size(int, int, );
    struct struct_mailbox_list_module_register
    {
        uint id;
    }




    enum enum_mailbox_list_file_type
    {
        MAILBOX_LIST_FILE_TYPE_UNKNOWN = 0,
        MAILBOX_LIST_FILE_TYPE_FILE = 1,
        MAILBOX_LIST_FILE_TYPE_DIR = 2,
        MAILBOX_LIST_FILE_TYPE_SYMLINK = 3,
        MAILBOX_LIST_FILE_TYPE_OTHER = 4,
    }
    enum
    {
        MAILBOX_LIST_FILE_TYPE_UNKNOWN = 0,
        MAILBOX_LIST_FILE_TYPE_FILE = 1,
        MAILBOX_LIST_FILE_TYPE_DIR = 2,
        MAILBOX_LIST_FILE_TYPE_SYMLINK = 3,
        MAILBOX_LIST_FILE_TYPE_OTHER = 4,
    }
    int mail_namespace_alloc(struct_mail_user*, void*, struct_mail_namespace_settings*, struct_mail_namespace_settings*, struct_mail_namespace**, const(char)**, );
    struct struct_hostent
    {
        char* h_name;
        char** h_aliases;
        int h_addrtype;
        int h_length;
        char** h_addr_list;
    }
    alias pid_t = __pid_t;


    int net_listen(const struct_ip_addr*, in_port_t*, int, );
    union union_mailbox_list_module_context
    {
        struct_mailbox_list_vfuncs super_;
        struct_mailbox_list_module_register* reg;
    }
    char* inet_nsap_ntoa(int, const(ubyte)*, char*, );


    int net_listen_full(const struct_ip_addr*, in_port_t*, enum_net_listen_flags*, int, );
    enum _Anonymous_15
    {
        IPPROTO_HOPOPTS = 0,
        IPPROTO_ROUTING = 43,
        IPPROTO_FRAGMENT = 44,
        IPPROTO_ICMPV6 = 58,
        IPPROTO_NONE = 59,
        IPPROTO_DSTOPTS = 60,
        IPPROTO_MH = 135,
    }
    enum
    {
        IPPROTO_HOPOPTS = 0,
        IPPROTO_ROUTING = 43,
        IPPROTO_FRAGMENT = 44,
        IPPROTO_ICMPV6 = 58,
        IPPROTO_NONE = 59,
        IPPROTO_DSTOPTS = 60,
        IPPROTO_MH = 135,
    }
    int select(int, fd_set*, fd_set*, fd_set*, struct_timeval*, );
    int net_listen_unix(const(char)*, int, );
    int socket(int, int, int, );
    alias pthread_spinlock_t = int;
    struct struct_mailbox_list_settings
    {
        const(char)* layout;
        const(char)* root_dir;
        const(char)* index_dir;
        const(char)* index_pvt_dir;
        const(char)* index_cache_dir;
        const(char)* control_dir;
        const(char)* alt_dir;
        const(char)* volatile_dir;
        const(char)* inbox_path;
        const(char)* subscription_fname;
        const(char)* list_index_fname;
        const(char)* list_index_dir;
        const(char)* maildir_name;
        const(char)* mailbox_dir_name;
        char escape_char;
        char broken_char;
        int utf8;
        int alt_dir_nocheck;
        int index_control_use_maildir_name;
        int iter_from_index_dir;
        int no_noselect;
    }
    struct struct_mailbox_list
    {
        const(char)* name;
        enum_mailbox_list_properties props;
        int mailbox_name_max_length;
        struct_mailbox_list_vfuncs v;
        struct_mailbox_list_vfuncs* vlast;
        int pool;
        struct_mail_namespace* ns;
        struct_mailbox_list_settings set;
        const struct_mail_storage_settings* mail_set;
        enum_mailbox_list_flags flags;
        struct_mailbox_permissions root_permissions;
        struct_mailbox_tree_context* subscriptions;
        time_t subscriptions_mtime;
        time_t subscriptions_read_time;
        struct_mailbox_log* changelog;
        time_t changelog_timestamp;
        struct_file_lock* lock;
        int lock_refcount;
        int guid_cache_pool;
        int function(uint8_t*, struct_mailbox_guid_cache_rec*) HASH_TABLE;
        int guid_cache_errors;
        char* last_internal_error;
        char* error_string;
        enum_mail_error error;
        int temporary_error;
        int function(struct_mail_storage_error) ARRAY;
        int index_root_dir_created;
        int list_index_root_dir_created;
        int guid_cache_updated;
        int guid_cache_invalidated;
        int last_error_is_internal;
    }


    alias id_t = __id_t;
    int mail_namespaces_init(struct_mail_user*, const(char)**, );
    int net_listen_unix_unlink_stale(const(char)*, int, );
    int socketpair(int, int, int, int*, );
    alias pthread_barrier_t = _Anonymous_16;
    union _Anonymous_16
    {
        char[32] __size;
        c_long __align;
    }


    alias ssize_t = __ssize_t;


    struct_mail_namespace* mail_namespaces_init_empty(struct_mail_user*, );


    struct struct_mailbox_settings
    {
        const(char)* name;
        const(char)* autocreate;
        const(char)* special_use;
        const(char)* driver;
        const(char)* comment;
        uint autoexpunge;
        uint autoexpunge_max_mails;
    }
    void mail_namespaces_deinit(struct_mail_namespace**, );






    int bind(int, const struct_sockaddr*, socklen_t, );




    struct struct_mail_user_module_register
    {
        uint id;
    }
    int pselect(int, fd_set*, fd_set*, fd_set*, const struct_timespec*, const(const __sigset_t)*, );






    union _Anonymous_17
    {
        char[4] __size;
        int __align;
    }
    alias pthread_barrierattr_t = _Anonymous_17;
    ssize_t net_receive(int, void*, int, );




    alias daddr_t = __daddr_t;
    void sethostent(int, );


    int mail_namespaces_init_add(struct_mail_user*, struct_mail_namespace_settings*, struct_mail_namespace_settings*, struct_mail_namespace**, const(char)**, );






    int getsockname(int, struct_sockaddr*, socklen_t*, );
    alias caddr_t = __caddr_t;






    union union_mail_user_module_context
    {
        struct_mail_user_vfuncs super_;
        struct_mail_user_module_register* reg;
    }






    struct struct___pthread_mutex_s
    {
        int __lock;
        uint __count;
        int __owner;
        uint __nusers;
        int __kind;
        short __spins;
        short __elision;
        __pthread_list_t __list;
    }






    int net_gethostbyname(const(char)*, struct_ip_addr**, uint*, );
    struct struct_mail_user_settings
    {
        const(char)* base_dir;
        const(char)* auth_socket_path;
        const(char)* mail_temp_dir;
        const(char)* mail_uid;
        const(char)* mail_gid;
        const(char)* mail_home;
        const(char)* mail_chroot;
        const(char)* mail_access_groups;
        const(char)* mail_privileged_group;
        const(char)* valid_chroot_dirs;
        uint first_valid_uid;
        uint last_valid_uid;
        uint first_valid_gid;
        uint last_valid_gid;
        const(char)* mail_plugins;
        const(char)* mail_plugin_dir;
        const(char)* mail_log_prefix;
        int function(struct_mail_namespace_settings*) ARRAY;
    }


    alias in_port_t = uint16_t;






    int mail_namespaces_init_finish(struct_mail_namespace*, const(char)**, );
    extern __gshared struct_mail_user_module_register mail_user_module_register;


    void endhostent();
    int net_gethostbyaddr(const struct_ip_addr*, const(char)**, );


    struct struct_auth_master_connection;
    extern __gshared struct_auth_master_connection* mail_user_auth_master_conn;




    alias key_t = __key_t;
    enum _Anonymous_18
    {
        IPPORT_ECHO = 7,
        IPPORT_DISCARD = 9,
        IPPORT_SYSTAT = 11,
        IPPORT_DAYTIME = 13,
        IPPORT_NETSTAT = 15,
        IPPORT_FTP = 21,
        IPPORT_TELNET = 23,
        IPPORT_SMTP = 25,
        IPPORT_TIMESERVER = 37,
        IPPORT_NAMESERVER = 42,
        IPPORT_WHOIS = 43,
        IPPORT_MTP = 57,
        IPPORT_TFTP = 69,
        IPPORT_RJE = 77,
        IPPORT_FINGER = 79,
        IPPORT_TTYLINK = 87,
        IPPORT_SUPDUP = 95,
        IPPORT_EXECSERVER = 512,
        IPPORT_LOGINSERVER = 513,
        IPPORT_CMDSERVER = 514,
        IPPORT_EFSSERVER = 520,
        IPPORT_BIFFUDP = 512,
        IPPORT_WHOSERVER = 513,
        IPPORT_ROUTESERVER = 520,
        IPPORT_1024 = 1024,
        IPPORT_USERRESERVED = 5000,
    }
    enum
    {
        IPPORT_ECHO = 7,
        IPPORT_DISCARD = 9,
        IPPORT_SYSTAT = 11,
        IPPORT_DAYTIME = 13,
        IPPORT_NETSTAT = 15,
        IPPORT_FTP = 21,
        IPPORT_TELNET = 23,
        IPPORT_SMTP = 25,
        IPPORT_TIMESERVER = 37,
        IPPORT_NAMESERVER = 42,
        IPPORT_WHOIS = 43,
        IPPORT_MTP = 57,
        IPPORT_TFTP = 69,
        IPPORT_RJE = 77,
        IPPORT_FINGER = 79,
        IPPORT_TTYLINK = 87,
        IPPORT_SUPDUP = 95,
        IPPORT_EXECSERVER = 512,
        IPPORT_LOGINSERVER = 513,
        IPPORT_CMDSERVER = 514,
        IPPORT_EFSSERVER = 520,
        IPPORT_BIFFUDP = 512,
        IPPORT_WHOSERVER = 513,
        IPPORT_ROUTESERVER = 520,
        IPPORT_1024 = 1024,
        IPPORT_USERRESERVED = 5000,
    }


    struct struct_var_expand_func_table;
    extern __gshared const struct_var_expand_func_table* mail_user_var_expand_func_table;


    void mail_namespace_ref(struct_mail_namespace*, );
    void mail_namespace_unref(struct_mail_namespace**, );


    struct_mail_user* mail_user_alloc(struct_event*, const(char)*, const struct_setting_parser_info*, const struct_mail_user_settings*, );






    int connect(int, const struct_sockaddr*, socklen_t, );




    void mail_namespaces_set_storage_callbacks(struct_mail_namespace*, struct_mail_storage_callbacks*, void*, );




    struct_hostent* gethostent();
    struct_mail_user* mail_user_alloc_nodup_set(struct_event*, const(char)*, const struct_setting_parser_info*, const struct_mail_user_settings*, );
    int getpeername(int, struct_sockaddr*, socklen_t*, );
    void mail_namespace_add_storage(struct_mail_namespace*, struct_mail_storage*, );




    alias __dev_t = c_ulong;






    alias __uid_t = uint;




    int mail_user_init(struct_mail_user*, const(char)**, );
    struct_hostent* gethostbyaddr(const(void)*, __socklen_t, int, );


    void mail_namespace_destroy(struct_mail_namespace*, );


    alias __gid_t = uint;


    alias __ino_t = c_ulong;
    int net_getunixname(int, const(char)**, );
    alias __ino64_t = c_ulong;
    void mail_user_ref(struct_mail_user*, );
    ssize_t send(int, const(void)*, int, int, );
    alias __mode_t = uint;




    struct_mail_storage* mail_namespace_get_default_storage(struct_mail_namespace*, );
    void mail_user_unref(struct_mail_user**, );




    alias __nlink_t = c_ulong;
    int net_getunixcred(int, struct_net_unix_cred*, );






    alias __off_t = c_long;
    alias __off64_t = c_long;




    struct_hostent* gethostbyname(const(char)*, );
    alias __pid_t = int;
    char mail_namespace_get_sep(struct_mail_namespace*, );
    struct_mail_user* mail_user_dup(struct_mail_user*, );
    struct struct_ip_opts
    {
        struct_in_addr ip_dst;
        char[40] ip_opts;
    }
    const(char)* net_ip2addr(const struct_ip_addr*, );






    alias __fsid_t = _Anonymous_19;
    struct _Anonymous_19
    {
        int[2] __val;
    }


    int net_addr2ip(const(char)*, struct_ip_addr*, );
    alias __clock_t = c_long;
    extern __gshared const struct_setting_parser_info mail_user_setting_parser_info;
    struct struct_setting_parser_info;


    struct_mail_user* mail_user_find(struct_mail_user*, const(char)*, );


    extern __gshared const struct_setting_parser_info mail_namespace_setting_parser_info;
    ssize_t recv(int, void*, int, int, );
    alias __rlim_t = c_ulong;


    int net_str2port(const(char)*, in_port_t*, );
    alias __rlim64_t = c_ulong;
    extern __gshared const struct_setting_parser_info mail_storage_setting_parser_info;






    alias __id_t = uint;
    extern __gshared const struct_mail_namespace_settings mail_namespace_default_settings;


    int net_str2port_zero(const(char)*, in_port_t*, );
    alias __time_t = c_long;
    extern __gshared const struct_mailbox_settings mailbox_default_settings;


    void mail_user_set_vars(struct_mail_user*, const(char)*, const struct_mail_user_connection_data*, );


    alias __useconds_t = uint;


    struct struct_ip_mreqn
    {
        struct_in_addr imr_multiaddr;
        struct_in_addr imr_address;
        int imr_ifindex;
    }
    struct_mail_namespace* mail_namespace_find(struct_mail_namespace*, const(char)*, );




    const(void)* mail_user_set_get_driver_settings(const struct_setting_parser_info*, const struct_mail_user_settings*, const(char)*, );


    alias __suseconds_t = c_long;
    struct struct_var_expand_table;
    const(struct_var_expand_table)* mail_user_var_expand_table(struct_mail_user*, );


    union union_mailbox_list_iterate_module_context
    {
        struct_mailbox_list_module_register* reg;
    }
    struct struct___pthread_cond_s
    {
        union _Anonymous_20
        {
            ulong __wseq;
            struct _Anonymous_21
            {
                uint __low;
                uint __high;
            }
            _Anonymous_21 __wseq32;
        }
        union _Anonymous_22
        {
            ulong __g1_start;
            struct _Anonymous_23
            {
                uint __low;
                uint __high;
            }
            _Anonymous_23 __g1_start32;
        }
        uint[2] __g_refs;
        uint[2] __g_size;
        uint __g1_orig_size;
        uint __wrefs;
        uint[2] __g_signals;
    }




    alias __daddr_t = int;


    ssize_t sendto(int, const(void)*, int, int, const struct_sockaddr*, socklen_t, );




    struct_hostent* gethostbyname2(const(char)*, int, );
    alias __key_t = int;


    struct_mail_namespace* mail_namespace_find_unalias(struct_mail_namespace*, const(char)**, );


    int net_str2hostport(const(char)*, in_port_t, const(char)**, in_port_t*, );
    const(struct_mail_storage_settings)* mail_user_set_get_storage_set(struct_mail_user*, );




    alias __clockid_t = int;
    struct struct_in_pktinfo
    {
        int ipi_ifindex;
        struct_in_addr ipi_spec_dst;
        struct_in_addr ipi_addr;
    }
    void mail_user_set_home(struct_mail_user*, const(char)*, );







    const(void)* mail_namespace_get_driver_settings(struct_mail_namespace*, struct_mail_storage*, );


    int net_ipport2str(const struct_ip_addr*, in_port_t, const(char)**, );






    alias __timer_t = void*;
    struct_mail_namespace* mail_namespace_find_visible(struct_mail_namespace*, const(char)*, );




    int mail_user_get_home(struct_mail_user*, const(char)**, );


    const(struct_dynamic_settings_parser)* mail_storage_get_dynamic_parsers(int, );
    struct struct_dynamic_settings_parser;
    int net_ipv6_mapped_ipv4_convert(const struct_ip_addr*, struct_ip_addr*, );
    alias __blksize_t = c_long;


    ssize_t recvfrom(int, void*, int, int, struct_sockaddr*, socklen_t*, );


    int mail_storage_get_postmaster_address();
    struct_mail_namespace* mail_namespace_find_subscribable(struct_mail_namespace*, const(char)*, );
    void mail_user_set_get_temp_prefix(int*, const struct_mail_user_settings*, );






    struct struct_mailbox_permissions
    {
        uid_t file_uid;
        gid_t file_gid;
        mode_t file_create_mode;
        mode_t dir_create_mode;
        gid_t file_create_gid;
        const(char)* file_create_gid_origin;
        int gid_origin_is_mailbox_path;
        int mail_index_permissions_set;
    }
    int gethostent_r(struct_hostent*, char*, int, struct_hostent**, int*, );


    int net_geterror(int, );




    alias __blkcnt_t = c_long;
    int mail_user_lock_file_create(struct_mail_user*, const(char)*, uint, struct_file_lock**, const(char)**, );
    alias __blkcnt64_t = c_long;
    struct struct_mailbox_list_iter_update_context
    {
        struct_mailbox_list_iterate_context* iter_ctx;
        struct_mailbox_tree_context* tree_ctx;
        struct_imap_match_glob* glob;
        enum_mailbox_info_flags leaf_flags;
        enum_mailbox_info_flags parent_flags;
        int update_only;
        int match_parents;
    }


    struct_mail_namespace* mail_namespace_find_unsubscribable(struct_mail_namespace*, const(char)*, );
    int gethostbyaddr_r(const(void)*, __socklen_t, int, struct_hostent*, char*, int, struct_hostent**, int*, );


    int fcntl(int, int, ...);


    alias __fsblkcnt_t = c_ulong;
    int mail_user_is_plugin_loaded();




    alias __fsblkcnt64_t = c_ulong;






    ssize_t sendmsg(int, const struct_msghdr*, int, );
    struct_mail_namespace* mail_namespace_find_inbox(struct_mail_namespace*, );




    struct struct_sockaddr
    {
        sa_family_t sa_family;
        char[14] sa_data;
    }






    const(char)* mail_user_plugin_getenv(struct_mail_user*, const(char)*, );
    alias __fsfilcnt_t = c_ulong;
    int net_parse_range(const(char)*, struct_ip_addr*, uint*, );





    int mail_user_plugin_getenv_bool();
    alias __fsfilcnt64_t = c_ulong;
    const(char)* mail_user_set_plugin_getenv(const struct_mail_user_settings*, const(char)*, );


    struct_mail_namespace* mail_namespace_find_prefix(struct_mail_namespace*, const(char)*, );
    int gethostbyname_r(const(char)*, struct_hostent*, char*, int, struct_hostent**, int*, );


    int mail_user_set_plugin_getenv_bool();
    alias u_int8_t = ubyte;






    alias __fsword_t = c_long;
    alias u_int16_t = ushort;
    int open(const(char)*, int, ...);
    struct_mail_namespace* mail_namespace_find_prefix_nosep(struct_mail_namespace*, const(char)*, );
    alias u_int32_t = uint;


    alias u_int64_t = c_ulong;
    alias __ssize_t = c_long;




    void mailbox_list_register_all();
    extern __gshared struct_mailbox_list_module_register mailbox_list_module_register;






    void mail_user_add_namespace(struct_mail_user*, struct_mail_namespace**, );






    alias register_t = c_long;


    int gethostbyname2_r(const(char)*, int, struct_hostent*, char*, int, struct_hostent**, int*, );
    void mailbox_lists_init();


    void mailbox_list_register(const struct_mailbox_list*, );


    alias __syscall_slong_t = c_long;


    void mailbox_list_unregister(const struct_mailbox_list*, );


    void mailbox_lists_deinit();
    void mail_namespace_finish_list_init(struct_mail_namespace*, struct_mailbox_list*, );




    void mail_user_drop_useless_namespaces(struct_mail_user*, );






    alias __syscall_ulong_t = c_ulong;




    struct struct_sockaddr_storage
    {
        sa_family_t ss_family;
        char[118] __ss_padding;
        c_ulong __ss_align;
    }


    void mailbox_list_settings_init_defaults(struct_mailbox_list_settings*, );
    const(struct_mailbox_list)* mailbox_list_find_class(const(char)*, );
    int mailbox_list_settings_parse(struct_mail_user*, const(char)*, struct_mailbox_list_settings*, const(char)**, );




    const(char)* mail_user_home_expand(struct_mail_user*, const(char)*, );
    alias __loff_t = __off64_t;




    ssize_t recvmsg(int, struct_msghdr*, int, );
    alias __qaddr_t = __quad_t;
    int mailbox_list_create(const(char)*, struct_mail_namespace*, const struct_mailbox_list_settings*, enum_mailbox_list_flags, struct_mailbox_list**, const(char)**, );
    int mail_namespace_is_shared_user_root();
    const(char)* mailbox_list_escape_name(struct_mailbox_list*, const(char)*, );
    int mail_user_try_home_expand(struct_mail_user*, const(char)**, );




    alias __caddr_t = char*;
    const(char)* mailbox_list_escape_name_params(const(char)*, const(char)*, char, char, char, const(char)*, );


    const(char)* mail_user_get_anvil_userip_ident(struct_mail_user*, );
    void mailbox_list_destroy(struct_mailbox_list**, );
    alias __intptr_t = c_long;




    enum _Anonymous_24
    {
        MSG_OOB = 1,
        MSG_PEEK = 2,
        MSG_DONTROUTE = 4,
        MSG_CTRUNC = 8,
        MSG_PROXY = 16,
        MSG_TRUNC = 32,
        MSG_DONTWAIT = 64,
        MSG_EOR = 128,
        MSG_WAITALL = 256,
        MSG_FIN = 512,
        MSG_SYN = 1024,
        MSG_CONFIRM = 2048,
        MSG_RST = 4096,
        MSG_ERRQUEUE = 8192,
        MSG_NOSIGNAL = 16384,
        MSG_MORE = 32768,
        MSG_WAITFORONE = 65536,
        MSG_BATCH = 262144,
        MSG_FASTOPEN = 536870912,
        MSG_CMSG_CLOEXEC = 1073741824,
    }
    enum
    {
        MSG_OOB = 1,
        MSG_PEEK = 2,
        MSG_DONTROUTE = 4,
        MSG_CTRUNC = 8,
        MSG_PROXY = 16,
        MSG_TRUNC = 32,
        MSG_DONTWAIT = 64,
        MSG_EOR = 128,
        MSG_WAITALL = 256,
        MSG_FIN = 512,
        MSG_SYN = 1024,
        MSG_CONFIRM = 2048,
        MSG_RST = 4096,
        MSG_ERRQUEUE = 8192,
        MSG_NOSIGNAL = 16384,
        MSG_MORE = 32768,
        MSG_WAITFORONE = 65536,
        MSG_BATCH = 262144,
        MSG_FASTOPEN = 536870912,
        MSG_CMSG_CLOEXEC = 1073741824,
    }


    void setnetent(int, );
    int mail_namespace_is_inbox_noinferiors();


    const(char)* mailbox_list_unescape_name(struct_mailbox_list*, const(char)*, );
    struct_mail_storage* mail_user_get_storage_class(struct_mail_user*, const(char)*, );




    alias __socklen_t = uint;




    const(char)* mailbox_list_unescape_name_params(const(char)*, const(char)*, char, char, char, );
    void mail_user_init_ssl_client_settings(struct_mail_user*, struct_ssl_iostream_settings*, );
    void endnetent();
    alias __sig_atomic_t = int;
    const(char)* mailbox_list_default_get_storage_name(struct_mailbox_list*, const(char)*, );






    int openat(int, const(char)*, int, ...);
    void mail_user_init_fs_settings(struct_mail_user*, struct_fs_settings*, struct_ssl_iostream_settings*, );
    const(char)* mailbox_list_default_get_vname(struct_mailbox_list*, const(char)*, );
    int mailbox_list_get_storage(struct_mailbox_list**, const(char)*, struct_mail_storage**, );
    const(char)* mailbox_list_get_unexpanded_path(struct_mailbox_list*, enum_mailbox_list_path_type, );
    int getsockopt(int, int, int, void*, socklen_t*, );




    void mailbox_list_get_default_storage(struct_mailbox_list*, struct_mail_storage**, );


    int mailbox_list_set_get_root_path();
    struct_netent* getnetent();






    struct struct_in6_addr
    {
        union _Anonymous_25
        {
            uint8_t[16] __u6_addr8;
            uint16_t[8] __u6_addr16;
            uint32_t[4] __u6_addr32;
        }
        _Anonymous_25 __in6_u;
    }
    char mailbox_list_get_hierarchy_sep(struct_mailbox_list*, );


    void mail_user_stats_fill(struct_mail_user*, struct_stats*, );


    alias blksize_t = __blksize_t;
    int mailbox_list_delete_index_control(struct_mailbox_list*, const(char)*, );
    int setsockopt(int, int, int, const(void)*, socklen_t, );


    struct_netent* getnetbyaddr(uint32_t, int, );


    void mailbox_list_get_permissions(struct_mailbox_list*, const(char)*, struct_mailbox_permissions*, );


    void mailbox_list_iter_update(struct_mailbox_list_iter_update_context*, const(char)*, );
    int mailbox_list_iter_subscriptions_refresh(struct_mailbox_list*, );




    const(struct_mailbox_info)* mailbox_list_iter_default_next(struct_mailbox_list_iterate_context*, );
    alias blkcnt_t = __blkcnt_t;


    void mailbox_list_get_root_permissions(struct_mailbox_list*, struct_mailbox_permissions*, );
    int listen(int, int, );


    enum_mailbox_list_file_type mailbox_list_get_file_type(const struct_dirent*, );
    struct_netent* getnetbyname(const(char)*, );


    alias fsblkcnt_t = __fsblkcnt_t;
    int mailbox_list_dirent_is_alias_symlink(struct_mailbox_list*, const(char)*, const struct_dirent*, );
    int mailbox_list_mkdir_root(struct_mailbox_list*, const(char)*, enum_mailbox_list_path_type, );




    int mailbox_list_try_get_absolute_path();






    int creat(const(char)*, mode_t, );


    int mailbox_list_try_mkdir_root(struct_mailbox_list*, const(char)*, enum_mailbox_list_path_type, const(char)**, );
    alias fsfilcnt_t = __fsfilcnt_t;
    extern __gshared const struct_in6_addr in6addr_any;






    extern __gshared const struct_in6_addr in6addr_loopback;
    void mailbox_permissions_copy(struct_mailbox_permissions*, const struct_mailbox_permissions*, int, );
    int accept(int, struct_sockaddr*, socklen_t*, );






    void mailbox_list_add_change(struct_mailbox_list*, enum_mailbox_log_record_type, const(const guid_128_t), );






    int mailbox_list_mkdir_missing_index_root(struct_mailbox_list*, );
    int getnetent_r(struct_netent*, char*, int, struct_netent**, int*, );
    void mailbox_name_get_sha128(const(char)*, guid_128_t, );


    int mailbox_list_mkdir_missing_list_index_root(struct_mailbox_list*, );


    struct struct_sockaddr_in
    {
        sa_family_t sin_family;
        in_port_t sin_port;
        struct_in_addr sin_addr;
        ubyte[8] sin_zero;
    }
    void mailbox_list_clear_error(struct_mailbox_list*, );




    void mailbox_list_set_error(struct_mailbox_list*, enum_mail_error, const(char)*, );
    int getnetbyaddr_r(uint32_t, int, struct_netent*, char*, int, struct_netent**, int*, );




    int mailbox_list_is_valid_name();


    void mailbox_list_set_internal_error(struct_mailbox_list*, );






    const(char)* mailbox_list_get_storage_name(struct_mailbox_list*, const(char)*, );
    int mailbox_list_set_error_from_errno();
    const(struct_mailbox_info)* mailbox_list_iter_autocreate_filter(struct_mailbox_list_iterate_context*, const struct_mailbox_info*, );
    const(char)* mailbox_list_get_vname(struct_mailbox_list*, const(char)*, );




    int getnetbyname_r(const(char)*, struct_netent*, char*, int, struct_netent**, int*, );




    int mailbox_list_lock(struct_mailbox_list*, );


    void mailbox_list_unlock(struct_mailbox_list*, );


    int shutdown(int, int, );


    int mailbox_list_get_path(struct_mailbox_list*, const(char)*, enum_mailbox_list_path_type, const(char)**, );
    struct struct_msghdr
    {
        void* msg_name;
        socklen_t msg_namelen;
        struct_iovec* msg_iov;
        int msg_iovlen;
        void* msg_control;
        int msg_controllen;
        int msg_flags;
    }
    struct struct_sockaddr_in6
    {
        sa_family_t sin6_family;
        in_port_t sin6_port;
        uint32_t sin6_flowinfo;
        struct_in6_addr sin6_addr;
        uint32_t sin6_scope_id;
    }
    int sockatmark(int, );
    struct struct_servent
    {
        char* s_name;
        char** s_aliases;
        int s_port;
        char* s_proto;
    }




    int mailbox_list_get_root_path();





    alias useconds_t = __useconds_t;
    const(char)* mailbox_list_get_root_forced(struct_mailbox_list*, enum_mailbox_list_path_type, );


    int isfdtype(int, int, );
    struct struct_ip_mreq
    {
        struct_in_addr imr_multiaddr;
        struct_in_addr imr_interface;
    }


    struct_mailbox_log* mailbox_list_get_changelog(struct_mailbox_list*, );


    void setservent(int, );


    void mailbox_list_set_changelog_timestamp(struct_mailbox_list*, time_t, );
    struct struct_cmsghdr
    {
        int cmsg_len;
        int cmsg_level;
        int cmsg_type;
        ubyte[0] __cmsg_data;
    }
    alias intptr_t = __intptr_t;
    int posix_fadvise(int, off_t, off_t, int, );
    struct struct_ip_mreq_source
    {
        struct_in_addr imr_multiaddr;
        struct_in_addr imr_interface;
        struct_in_addr imr_sourceaddr;
    }
    const(char)* mailbox_list_get_temp_prefix(struct_mailbox_list*, );


    void endservent();
    const(char)* mailbox_list_get_global_temp_prefix(struct_mailbox_list*, );
    struct_servent* getservent();




    int mailbox_list_set_subscribed(struct_mailbox_list*, const(char)*, int, );
    int mailbox_list_delete_dir(struct_mailbox_list*, const(char)*, );
    int mailbox_list_delete_symlink(struct_mailbox_list*, const(char)*, );
    struct struct_ipv6_mreq
    {
        struct_in6_addr ipv6mr_multiaddr;
        uint ipv6mr_interface;
    }


    struct_servent* getservbyname(const(char)*, const(char)*, );
    int access(const(char)*, int, );
    int posix_fallocate(int, off_t, off_t, );
    enum_mail_error mailbox_list_get_last_mail_error(struct_mailbox_list*, );


    struct_servent* getservbyport(int, const(char)*, );
    struct_cmsghdr* __cmsg_nxthdr(struct_msghdr*, struct_cmsghdr*, );




    struct struct_group_req
    {
        uint32_t gr_interface;
        struct_sockaddr_storage gr_group;
    }


    void mailbox_list_last_error_push(struct_mailbox_list*, );




    void mailbox_list_last_error_pop(struct_mailbox_list*, );


    int getservent_r(struct_servent*, char*, int, struct_servent**, );




    int mailbox_list_init_fs(struct_mailbox_list*, const(char)*, const(char)*, const(char)*, struct_fs**, const(char)**, );


    int faccessat(int, const(char)*, int, int, );


    struct struct_group_source_req
    {
        uint32_t gsr_interface;
        struct_sockaddr_storage gsr_group;
        struct_sockaddr_storage gsr_source;
    }
    int getservbyname_r(const(char)*, const(char)*, struct_servent*, char*, int, struct_servent**, );




    struct_mailbox_list* mailbox_list_fs_get_list(struct_fs*, );






    int getservbyport_r(int, const(char)*, struct_servent*, char*, int, struct_servent**, );
    struct struct_ip_msfilter
    {
        struct_in_addr imsf_multiaddr;
        struct_in_addr imsf_interface;
        uint32_t imsf_fmode;
        uint32_t imsf_numsrc;
        struct_in_addr[1] imsf_slist;
    }
    struct struct_protoent
    {
        char* p_name;
        char** p_aliases;
        int p_proto;
    }




    enum _Anonymous_26
    {
        SCM_RIGHTS = 1,
    }
    enum
    {
        SCM_RIGHTS = 1,
    }
    void setprotoent(int, );
    __off_t lseek(int, __off_t, int, );
    void endprotoent();





    struct struct_group_filter
    {
        uint32_t gf_interface;
        struct_sockaddr_storage gf_group;
        uint32_t gf_fmode;
        uint32_t gf_numsrc;
        struct_sockaddr_storage[1] gf_slist;
    }




    struct_protoent* getprotoent();
    struct_protoent* getprotobyname(const(char)*, );
    int close(int, );
    struct_protoent* getprotobynumber(int, );


    ssize_t read(int, void*, int, );
    ssize_t write(int, const(void)*, int, );






    int getprotoent_r(struct_protoent*, char*, int, struct_protoent**, );


    uint32_t ntohl(uint32_t, );




    uint16_t ntohs(uint16_t, );
    int getprotobyname_r(const(char)*, struct_protoent*, char*, int, struct_protoent**, );




    uint32_t htonl(uint32_t, );
    ssize_t pread(int, void*, int, __off_t, );




    uint16_t htons(uint16_t, );




    int getprotobynumber_r(int, struct_protoent*, char*, int, struct_protoent**, );
    ssize_t pwrite(int, const(void)*, int, __off_t, );






    int setnetgrent(const(char)*, );
    void endnetgrent();
    int getnetgrent(char**, char**, char**, );
    int pipe(int*, );


    int innetgr(const(char)*, const(char)*, const(char)*, const(char)*, );
    int getnetgrent_r(char**, char**, char**, char*, int, );
    uint alarm(uint, );
    struct struct_linger
    {
        int l_onoff;
        int l_linger;
    }
    uint sleep(uint, );







    int rcmd(char**, ushort, const(char)*, const(char)*, const(char)*, int*, );
    __useconds_t ualarm(__useconds_t, __useconds_t, );
    int rcmd_af(char**, ushort, const(char)*, const(char)*, const(char)*, int*, sa_family_t, );




    int usleep(__useconds_t, );
    int pause();




    int chown(const(char)*, __uid_t, __gid_t, );
    int rexec(char**, int, const(char)*, const(char)*, const(char)*, int*, );






    int fchown(int, __uid_t, __gid_t, );




    int lchown(const(char)*, __uid_t, __gid_t, );




    int rexec_af(char**, int, const(char)*, const(char)*, const(char)*, int*, sa_family_t, );




    int fchownat(int, const(char)*, __uid_t, __gid_t, int, );






    int chdir(const(char)*, );


    int bindresvport(int, struct_sockaddr_in*, );
    int ruserok(const(char)*, int, const(char)*, const(char)*, );


    int fchdir(int, );


    int bindresvport6(int, struct_sockaddr_in6*, );
    int ruserok_af(const(char)*, int, const(char)*, const(char)*, sa_family_t, );




    char* getcwd(char*, int, );
    int iruserok(uint32_t, int, const(char)*, const(char)*, );


    char* getwd(char*, );


    enum _Anonymous_27
    {
        _CS_PATH = 0,
        _CS_V6_WIDTH_RESTRICTED_ENVS = 1,
        _CS_GNU_LIBC_VERSION = 2,
        _CS_GNU_LIBPTHREAD_VERSION = 3,
        _CS_V5_WIDTH_RESTRICTED_ENVS = 4,
        _CS_V7_WIDTH_RESTRICTED_ENVS = 5,
        _CS_LFS_CFLAGS = 1000,
        _CS_LFS_LDFLAGS = 1001,
        _CS_LFS_LIBS = 1002,
        _CS_LFS_LINTFLAGS = 1003,
        _CS_LFS64_CFLAGS = 1004,
        _CS_LFS64_LDFLAGS = 1005,
        _CS_LFS64_LIBS = 1006,
        _CS_LFS64_LINTFLAGS = 1007,
        _CS_XBS5_ILP32_OFF32_CFLAGS = 1100,
        _CS_XBS5_ILP32_OFF32_LDFLAGS = 1101,
        _CS_XBS5_ILP32_OFF32_LIBS = 1102,
        _CS_XBS5_ILP32_OFF32_LINTFLAGS = 1103,
        _CS_XBS5_ILP32_OFFBIG_CFLAGS = 1104,
        _CS_XBS5_ILP32_OFFBIG_LDFLAGS = 1105,
        _CS_XBS5_ILP32_OFFBIG_LIBS = 1106,
        _CS_XBS5_ILP32_OFFBIG_LINTFLAGS = 1107,
        _CS_XBS5_LP64_OFF64_CFLAGS = 1108,
        _CS_XBS5_LP64_OFF64_LDFLAGS = 1109,
        _CS_XBS5_LP64_OFF64_LIBS = 1110,
        _CS_XBS5_LP64_OFF64_LINTFLAGS = 1111,
        _CS_XBS5_LPBIG_OFFBIG_CFLAGS = 1112,
        _CS_XBS5_LPBIG_OFFBIG_LDFLAGS = 1113,
        _CS_XBS5_LPBIG_OFFBIG_LIBS = 1114,
        _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS = 1115,
        _CS_POSIX_V6_ILP32_OFF32_CFLAGS = 1116,
        _CS_POSIX_V6_ILP32_OFF32_LDFLAGS = 1117,
        _CS_POSIX_V6_ILP32_OFF32_LIBS = 1118,
        _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS = 1119,
        _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS = 1120,
        _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS = 1121,
        _CS_POSIX_V6_ILP32_OFFBIG_LIBS = 1122,
        _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS = 1123,
        _CS_POSIX_V6_LP64_OFF64_CFLAGS = 1124,
        _CS_POSIX_V6_LP64_OFF64_LDFLAGS = 1125,
        _CS_POSIX_V6_LP64_OFF64_LIBS = 1126,
        _CS_POSIX_V6_LP64_OFF64_LINTFLAGS = 1127,
        _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS = 1128,
        _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS = 1129,
        _CS_POSIX_V6_LPBIG_OFFBIG_LIBS = 1130,
        _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS = 1131,
        _CS_POSIX_V7_ILP32_OFF32_CFLAGS = 1132,
        _CS_POSIX_V7_ILP32_OFF32_LDFLAGS = 1133,
        _CS_POSIX_V7_ILP32_OFF32_LIBS = 1134,
        _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS = 1135,
        _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS = 1136,
        _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS = 1137,
        _CS_POSIX_V7_ILP32_OFFBIG_LIBS = 1138,
        _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS = 1139,
        _CS_POSIX_V7_LP64_OFF64_CFLAGS = 1140,
        _CS_POSIX_V7_LP64_OFF64_LDFLAGS = 1141,
        _CS_POSIX_V7_LP64_OFF64_LIBS = 1142,
        _CS_POSIX_V7_LP64_OFF64_LINTFLAGS = 1143,
        _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS = 1144,
        _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS = 1145,
        _CS_POSIX_V7_LPBIG_OFFBIG_LIBS = 1146,
        _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS = 1147,
        _CS_V6_ENV = 1148,
        _CS_V7_ENV = 1149,
    }
    enum
    {
        _CS_PATH = 0,
        _CS_V6_WIDTH_RESTRICTED_ENVS = 1,
        _CS_GNU_LIBC_VERSION = 2,
        _CS_GNU_LIBPTHREAD_VERSION = 3,
        _CS_V5_WIDTH_RESTRICTED_ENVS = 4,
        _CS_V7_WIDTH_RESTRICTED_ENVS = 5,
        _CS_LFS_CFLAGS = 1000,
        _CS_LFS_LDFLAGS = 1001,
        _CS_LFS_LIBS = 1002,
        _CS_LFS_LINTFLAGS = 1003,
        _CS_LFS64_CFLAGS = 1004,
        _CS_LFS64_LDFLAGS = 1005,
        _CS_LFS64_LIBS = 1006,
        _CS_LFS64_LINTFLAGS = 1007,
        _CS_XBS5_ILP32_OFF32_CFLAGS = 1100,
        _CS_XBS5_ILP32_OFF32_LDFLAGS = 1101,
        _CS_XBS5_ILP32_OFF32_LIBS = 1102,
        _CS_XBS5_ILP32_OFF32_LINTFLAGS = 1103,
        _CS_XBS5_ILP32_OFFBIG_CFLAGS = 1104,
        _CS_XBS5_ILP32_OFFBIG_LDFLAGS = 1105,
        _CS_XBS5_ILP32_OFFBIG_LIBS = 1106,
        _CS_XBS5_ILP32_OFFBIG_LINTFLAGS = 1107,
        _CS_XBS5_LP64_OFF64_CFLAGS = 1108,
        _CS_XBS5_LP64_OFF64_LDFLAGS = 1109,
        _CS_XBS5_LP64_OFF64_LIBS = 1110,
        _CS_XBS5_LP64_OFF64_LINTFLAGS = 1111,
        _CS_XBS5_LPBIG_OFFBIG_CFLAGS = 1112,
        _CS_XBS5_LPBIG_OFFBIG_LDFLAGS = 1113,
        _CS_XBS5_LPBIG_OFFBIG_LIBS = 1114,
        _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS = 1115,
        _CS_POSIX_V6_ILP32_OFF32_CFLAGS = 1116,
        _CS_POSIX_V6_ILP32_OFF32_LDFLAGS = 1117,
        _CS_POSIX_V6_ILP32_OFF32_LIBS = 1118,
        _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS = 1119,
        _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS = 1120,
        _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS = 1121,
        _CS_POSIX_V6_ILP32_OFFBIG_LIBS = 1122,
        _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS = 1123,
        _CS_POSIX_V6_LP64_OFF64_CFLAGS = 1124,
        _CS_POSIX_V6_LP64_OFF64_LDFLAGS = 1125,
        _CS_POSIX_V6_LP64_OFF64_LIBS = 1126,
        _CS_POSIX_V6_LP64_OFF64_LINTFLAGS = 1127,
        _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS = 1128,
        _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS = 1129,
        _CS_POSIX_V6_LPBIG_OFFBIG_LIBS = 1130,
        _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS = 1131,
        _CS_POSIX_V7_ILP32_OFF32_CFLAGS = 1132,
        _CS_POSIX_V7_ILP32_OFF32_LDFLAGS = 1133,
        _CS_POSIX_V7_ILP32_OFF32_LIBS = 1134,
        _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS = 1135,
        _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS = 1136,
        _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS = 1137,
        _CS_POSIX_V7_ILP32_OFFBIG_LIBS = 1138,
        _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS = 1139,
        _CS_POSIX_V7_LP64_OFF64_CFLAGS = 1140,
        _CS_POSIX_V7_LP64_OFF64_LDFLAGS = 1141,
        _CS_POSIX_V7_LP64_OFF64_LIBS = 1142,
        _CS_POSIX_V7_LP64_OFF64_LINTFLAGS = 1143,
        _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS = 1144,
        _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS = 1145,
        _CS_POSIX_V7_LPBIG_OFFBIG_LIBS = 1146,
        _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS = 1147,
        _CS_V6_ENV = 1148,
        _CS_V7_ENV = 1149,
    }
    int dup(int, );


    int iruserok_af(const(void)*, int, const(char)*, const(char)*, sa_family_t, );
    int dup2(int, int, );
    extern __gshared char** __environ;




    int rresvport(int*, );




    int execve(const(char)*, char**, char**, );




    int rresvport_af(int*, sa_family_t, );


    int fexecve(int, char**, char**, );




    struct struct_addrinfo
    {
        int ai_flags;
        int ai_family;
        int ai_socktype;
        int ai_protocol;
        socklen_t ai_addrlen;
        struct_sockaddr* ai_addr;
        char* ai_canonname;
        struct_addrinfo* ai_next;
    }
    int execv(const(char)*, char**, );






    int execle(const(char)*, const(char)*, ...);




    int execl(const(char)*, const(char)*, ...);




    int execvp(const(char)*, char**, );






    int execlp(const(char)*, const(char)*, ...);
    int nice(int, );


    void _exit(int, );
    c_long pathconf(const(char)*, int, );
    c_long fpathconf(int, int, );
    c_long sysconf(int, );
    int confstr();




    __pid_t getpid();


    __pid_t getppid();




    __pid_t getpgrp();






    __pid_t __getpgid(__pid_t, );




    __pid_t getpgid(__pid_t, );
    int setpgid(__pid_t, __pid_t, );
    int getaddrinfo(const(char)*, const(char)*, const struct_addrinfo*, struct_addrinfo**, );




    int setpgrp();


    void freeaddrinfo(struct_addrinfo*, );


    const(char)* gai_strerror(int, );


    __pid_t setsid();




    __pid_t getsid(__pid_t, );
    int getnameinfo(const struct_sockaddr*, socklen_t, char*, socklen_t, char*, socklen_t, int, );
    __uid_t getuid();
    __uid_t geteuid();
    __gid_t getgid();
    __gid_t getegid();
    int getgroups(int, __gid_t*, );
    int setuid(__uid_t, );
    int setreuid(__uid_t, __uid_t, );
    int seteuid(__uid_t, );
    int setgid(__gid_t, );
    int setregid(__gid_t, __gid_t, );
    int setegid(__gid_t, );
    __pid_t fork();
    int vfork();
    char* ttyname(int, );
    int ttyname_r(int, char*, int, );
    int isatty(int, );
    int ttyslot();
    int link(const(char)*, const(char)*, );
    int linkat(int, const(char)*, int, const(char)*, int, );
    int symlink(const(char)*, const(char)*, );
    ssize_t readlink(const(char)*, char*, int, );
    int symlinkat(const(char)*, int, const(char)*, );
    ssize_t readlinkat(int, const(char)*, char*, int, );
    int unlink(const(char)*, );
    int unlinkat(int, const(char)*, int, );
    int rmdir(const(char)*, );
    __pid_t tcgetpgrp(int, );
    int tcsetpgrp(int, __pid_t, );
    char* getlogin();
    int getlogin_r(char*, int, );
    int setlogin(const(char)*, );
    int gethostname(char*, int, );
    int sethostname(const(char)*, int, );
    int sethostid(c_long, );
    int getdomainname(char*, int, );
    int setdomainname(const(char)*, int, );
    int vhangup();
    int revoke(const(char)*, );
    int profil(ushort*, int, int, uint, );
    int acct(const(char)*, );
    char* getusershell();
    void endusershell();
    void setusershell();
    int daemon(int, int, );
    int chroot(const(char)*, );
    char* getpass(const(char)*, );
    int fsync(int, );
    c_long gethostid();
    void sync();
    int getpagesize();
    int getdtablesize();
    int truncate(const(char)*, __off_t, );
    int ftruncate(int, __off_t, );
    int brk(void*, );
    void* sbrk(intptr_t, );
    c_long syscall(c_long, ...);
    int lockf(int, int, __off_t, );
    int fdatasync(int, );
    int getentropy(void*, int, );
}

extern(C) {
    struct struct_message_size;
    enum enum_mail_flags
    {
        MAIL_ANSWERED = 1,
        MAIL_FLAGGED = 2,
        MAIL_DELETED = 4,
        MAIL_SEEN = 8,
        MAIL_DRAFT = 16,
        MAIL_RECENT = 32,
        MAIL_FLAGS_MASK = 63,
        MAIL_FLAGS_NONRECENT = 31,
    }
    enum
    {
        MAIL_ANSWERED = 1,
        MAIL_FLAGGED = 2,
        MAIL_DELETED = 4,
        MAIL_SEEN = 8,
        MAIL_DRAFT = 16,
        MAIL_RECENT = 32,
        MAIL_FLAGS_MASK = 63,
        MAIL_FLAGS_NONRECENT = 31,
    }
    struct struct_mailbox_attribute_iter
    {
        struct_mailbox* box;
    }
    struct struct_buffer
    {
        const(void)* data;
        const(int) used;
        void*[5] priv;
    }
    union union_array__seq_array
    {
        struct_array arr;
        const(const(const uint32_t)*)* v;
        uint32_t** v_modifiable;
    }


    struct _Anonymous_28
    {
        c_ulong[16] __val;
    }




    struct struct_mail_index_view_log_sync_area
    {
        uint32_t log_file_seq;
        uint length;
        int log_file_offset;
    }
    uint32_t mail_index_uint32_to_offset(uint32_t, );



    uint32_t mail_index_offset_to_uint32(uint32_t, );
    union union_array__seq_array_array
    {
        struct_array arr;
        const(const union_array__seq_array*)* v;
        union_array__seq_array** v_modifiable;
    }
    union union_array__seq_range
    {
        struct_array arr;
        const(const struct_seq_range*)* v;
        struct_seq_range** v_modifiable;
    }


    void mailbox_attributes_init();
    void mailbox_attributes_deinit();
    union union_array__guid_128_t
    {
        struct_array arr;
        const(const(const guid_128_t)*)* v;
        guid_128_t** v_modifiable;
    }







    struct struct_mail_index_transaction_keyword_update
    {
        union_array__seq_range add_seq;
        union_array__seq_range remove_seq;
    }


    void mail_index_pack_num(uint8_t**, uint32_t, );


    int mailbox_attribute_value_to_string(struct_mail_storage*, const struct_mail_attribute_value*, const(char)**, );
    int mail_index_unpack_num(const(const uint8_t)**, const(const uint8_t)*, uint32_t*, );
    union union_array__view_log_sync_area
    {
        struct_array arr;
        const(const struct_mail_index_view_log_sync_area*)* v;
        struct_mail_index_view_log_sync_area** v_modifiable;
    }





    struct struct_array
    {
        int* buffer;
        int element_size;
    }
    struct struct_mail_storage_hooks
    {
        void function(struct_mail_user*) mail_user_created;
        void function(struct_mail_namespace*) mail_namespace_storage_added;
        void function(struct_mail_namespace*) mail_namespaces_created;
        void function(struct_mail_namespace*) mail_namespaces_added;
        void function(struct_mail_storage*) mail_storage_created;
        void function(struct_mailbox_list*) mailbox_list_created;
        void function(struct_mailbox*) mailbox_allocated;
        void function(struct_mailbox*) mailbox_opened;
        void function(struct_mail*) mail_allocated;
    }


    struct struct_mail_transaction_log_view;
    struct struct_mail_index_view_vfuncs
    {
        void function(struct_mail_index_view*) close;
        uint function(struct_mail_index_view*) get_messages_count;
        const(struct_mail_index_header)* function(struct_mail_index_view*) get_header;
        const(struct_mail_index_record)* function(struct_mail_index_view*, uint, struct_mail_index_map**, int*) lookup_full;
        void function(struct_mail_index_view*, uint, uint*) lookup_uid;
        void function(struct_mail_index_view*, uint, uint, uint*, uint*) lookup_seq_range;
        void function(struct_mail_index_view*, enum_mail_flags, ubyte, uint*) lookup_first;
        void function(struct_mail_index_view*, uint, union_array__keyword_indexes*) lookup_keywords;
        void function(struct_mail_index_view*, uint, uint, struct_mail_index_map**, const(void)**, int*) lookup_ext_full;
        void function(struct_mail_index_view*, struct_mail_index_map*, uint, const(void)**, int*) get_header_ext;
        int function(struct_mail_index_view*, struct_mail_index_map*, uint32_t, uint32_t*) function(int*) bool_;
    }
    struct struct_mail_index_sync_map_ctx;



    struct struct_file_create_settings;
    struct struct_mail_index_transaction_ext_hdr_update
    {
        int alloc_size;
        ubyte* mask;
        ubyte* data;
    }
    int mail_index_seq_array_lookup();
    enum enum_modify_type
    {
        MODIFY_ADD = 0,
        MODIFY_REMOVE = 1,
        MODIFY_REPLACE = 2,
    }
    enum
    {
        MODIFY_ADD = 0,
        MODIFY_REMOVE = 1,
        MODIFY_REPLACE = 2,
    }



    void mail_index_seq_array_alloc(union_array__seq_array*, int, );
    void buffer_create_from_data(int*, void*, int, );




    union union_array__string
    {
        struct_array arr;
        char*** v;
        char*** v_modifiable;
    }




    union union_array__const_string
    {
        struct_array arr;
        const(const(const(char)*)*)* v;
        const(char)*** v_modifiable;
    }
    union union_array__uint8_t
    {
        struct_array arr;
        int i;
        int** v_modifiable;
    }
    void buffer_create_from_const_data(int*, const(void)*, int, );





    enum enum_mail_index_open_flags
    {
        MAIL_INDEX_OPEN_FLAG_CREATE = 1,
        MAIL_INDEX_OPEN_FLAG_MMAP_DISABLE = 4,
        MAIL_INDEX_OPEN_FLAG_DOTLOCK_USE_EXCL = 16,
        MAIL_INDEX_OPEN_FLAG_NFS_FLUSH = 64,
        MAIL_INDEX_OPEN_FLAG_READONLY = 128,
        MAIL_INDEX_OPEN_FLAG_KEEP_BACKUPS = 256,
        MAIL_INDEX_OPEN_FLAG_NEVER_IN_MEMORY = 512,
        MAIL_INDEX_OPEN_FLAG_SAVEONLY = 1024,
        MAIL_INDEX_OPEN_FLAG_DEBUG = 2048,
        MAIL_INDEX_OPEN_FLAG_NO_DIRTY = 4096,
    }
    enum
    {
        MAIL_INDEX_OPEN_FLAG_CREATE = 1,
        MAIL_INDEX_OPEN_FLAG_MMAP_DISABLE = 4,
        MAIL_INDEX_OPEN_FLAG_DOTLOCK_USE_EXCL = 16,
        MAIL_INDEX_OPEN_FLAG_NFS_FLUSH = 64,
        MAIL_INDEX_OPEN_FLAG_READONLY = 128,
        MAIL_INDEX_OPEN_FLAG_KEEP_BACKUPS = 256,
        MAIL_INDEX_OPEN_FLAG_NEVER_IN_MEMORY = 512,
        MAIL_INDEX_OPEN_FLAG_SAVEONLY = 1024,
        MAIL_INDEX_OPEN_FLAG_DEBUG = 2048,
        MAIL_INDEX_OPEN_FLAG_NO_DIRTY = 4096,
    }


    union union_array__uint16_t
    {
        struct_array arr;
        int i;
        int** v_modifiable;
    }







    struct struct_mail_index_transaction_vfuncs
    {
        void function(struct_mail_index_transaction*) reset;
        int function(struct_mail_index_transaction*, struct_mail_index_transaction_commit_result*) commit;
        void function(struct_mail_index_transaction*) rollback;
    }
    union union_array__uint32_t
    {
        struct_array arr;
        int i;
        int** v_modifiable;
    }
    enum enum_mail_storage_flags
    {
        MAIL_STORAGE_FLAG_KEEP_HEADER_MD5 = 1,
        MAIL_STORAGE_FLAG_NO_AUTODETECTION = 2,
        MAIL_STORAGE_FLAG_NO_AUTOCREATE = 4,
        MAIL_STORAGE_FLAG_NO_AUTOVERIFY = 8,
    }
    enum
    {
        MAIL_STORAGE_FLAG_KEEP_HEADER_MD5 = 1,
        MAIL_STORAGE_FLAG_NO_AUTODETECTION = 2,
        MAIL_STORAGE_FLAG_NO_AUTOCREATE = 4,
        MAIL_STORAGE_FLAG_NO_AUTOVERIFY = 8,
    }


    union union_array__uint64_t
    {
        struct_array arr;
        int i;
        int** v_modifiable;
    }




    union union_array__keywords
    {
        struct_array arr;
        const(const(const(char)*)*)* v;
        const(char)*** v_modifiable;
    }
    union union_array__keyword_indexes
    {
        struct_array arr;
        const(const(uint)*)* v;
        uint** v_modifiable;
    }


    union union_array__uint
    {
        struct_array arr;
        const(const(uint)*)* v;
        uint** v_modifiable;
    }
    union union_array__void_array
    {
        struct_array arr;
        void*** v;
        void*** v_modifiable;
    }


    struct struct_mail_transaction_log_header
    {
        uint8_t major_version;
        uint8_t minor_version;
        uint16_t hdr_size;
        uint32_t indexid;
        uint32_t file_seq;
        uint32_t prev_file_seq;
        uint32_t prev_file_offset;
        uint32_t create_stamp;
        uint64_t initial_modseq;
        uint8_t compat_flags;
        uint8_t[3] unused;
        uint32_t unused2;
    }
    enum _Anonymous_29
    {
        _PC_LINK_MAX = 0,
        _PC_MAX_CANON = 1,
        _PC_MAX_INPUT = 2,
        _PC_NAME_MAX = 3,
        _PC_PATH_MAX = 4,
        _PC_PIPE_BUF = 5,
        _PC_CHOWN_RESTRICTED = 6,
        _PC_NO_TRUNC = 7,
        _PC_VDISABLE = 8,
        _PC_SYNC_IO = 9,
        _PC_ASYNC_IO = 10,
        _PC_PRIO_IO = 11,
        _PC_SOCK_MAXBUF = 12,
        _PC_FILESIZEBITS = 13,
        _PC_REC_INCR_XFER_SIZE = 14,
        _PC_REC_MAX_XFER_SIZE = 15,
        _PC_REC_MIN_XFER_SIZE = 16,
        _PC_REC_XFER_ALIGN = 17,
        _PC_ALLOC_SIZE_MIN = 18,
        _PC_SYMLINK_MAX = 19,
        _PC_2_SYMLINKS = 20,
    }





    enum enum_mail_storage_list_index_rebuild_reason
    {
        MAIL_STORAGE_LIST_INDEX_REBUILD_REASON_CORRUPTED = 0,
        MAIL_STORAGE_LIST_INDEX_REBUILD_REASON_NO_INBOX = 1,
        MAIL_STORAGE_LIST_INDEX_REBUILD_REASON_FORCE_RESYNC = 2,
    }
    enum
    {
        MAIL_STORAGE_LIST_INDEX_REBUILD_REASON_CORRUPTED = 0,
        MAIL_STORAGE_LIST_INDEX_REBUILD_REASON_NO_INBOX = 1,
        MAIL_STORAGE_LIST_INDEX_REBUILD_REASON_FORCE_RESYNC = 2,
    }



    union union_mail_index_transaction_module_context
    {
        struct_mail_index_transaction_vfuncs super_;
        struct_mail_index_module_register* reg;
    }



    void mail_storage_hooks_init();
    void mail_storage_hooks_deinit();
    union union_array__ip_addr
    {
        struct_array arr;
        const(const struct_ip_addr*)* v;
        struct_ip_addr** v_modifiable;
    }
    int* buffer_create_dynamic();
    void mail_storage_hooks_add(struct_module*, const struct_mail_storage_hooks*, );




    union _Anonymous_30
    {
        char[4] __size;
        int __align;
    }
    struct struct_mail_index_flag_update
    {
        uint32_t uid1;
        uint32_t uid2;
        uint16_t add_flags;
        uint16_t remove_flags;
    }







    enum enum_mailbox_flags
    {
        MAILBOX_FLAG_READONLY = 1,
        MAILBOX_FLAG_SAVEONLY = 2,
        MAILBOX_FLAG_DROP_RECENT = 4,
        MAILBOX_FLAG_NO_INDEX_FILES = 16,
        MAILBOX_FLAG_KEEP_LOCKED = 32,
        MAILBOX_FLAG_POP3_SESSION = 64,
        MAILBOX_FLAG_POST_SESSION = 128,
        MAILBOX_FLAG_IGNORE_ACLS = 256,
        MAILBOX_FLAG_OPEN_DELETED = 512,
        MAILBOX_FLAG_DELETE_UNSAFE = 1024,
        MAILBOX_FLAG_USE_STUBS = 2048,
        MAILBOX_FLAG_AUTO_CREATE = 4096,
        MAILBOX_FLAG_AUTO_SUBSCRIBE = 8192,
    }
    enum
    {
        MAILBOX_FLAG_READONLY = 1,
        MAILBOX_FLAG_SAVEONLY = 2,
        MAILBOX_FLAG_DROP_RECENT = 4,
        MAILBOX_FLAG_NO_INDEX_FILES = 16,
        MAILBOX_FLAG_KEEP_LOCKED = 32,
        MAILBOX_FLAG_POP3_SESSION = 64,
        MAILBOX_FLAG_POST_SESSION = 128,
        MAILBOX_FLAG_IGNORE_ACLS = 256,
        MAILBOX_FLAG_OPEN_DELETED = 512,
        MAILBOX_FLAG_DELETE_UNSAFE = 1024,
        MAILBOX_FLAG_USE_STUBS = 2048,
        MAILBOX_FLAG_AUTO_CREATE = 4096,
        MAILBOX_FLAG_AUTO_SUBSCRIBE = 8192,
    }
    void mail_storage_hooks_add_forced(struct_module*, const struct_mail_storage_hooks*, );
    void buffer_free(int**, );
    void mail_storage_hooks_remove(const struct_mail_storage_hooks*, );
    union union_array__unichars
    {
        struct_array arr;
        const(const(const unichar_t)*)* v;
        unichar_t** v_modifiable;
    }




    struct struct_mail_index_transaction
    {
        struct_mail_index_transaction* prev;
        struct_mail_index_transaction* next;
        int refcount;
        enum_mail_index_transaction_flags flags;
        struct_mail_index_transaction_vfuncs v;
        struct_mail_index_transaction_vfuncs* vlast;
        struct_mail_index_view* view;
        struct_mail_index_view* latest_view;
        union _Anonymous_31
        {
            struct_array arr;
            const(const struct_mail_index_record*)* v;
            struct_mail_index_record** v_modifiable;
        }
        _Anonymous_31 appends;
        uint32_t first_new_seq;
        uint32_t last_new_seq;
        uint32_t highest_append_uid;
        uint32_t min_flagupdate_seq;
        uint32_t max_flagupdate_seq;
        union _Anonymous_32
        {
            struct_array arr;
            const(const struct_mail_transaction_modseq_update*)* v;
            struct_mail_transaction_modseq_update** v_modifiable;
        }
        _Anonymous_32 modseq_updates;
        union _Anonymous_33
        {
            struct_array arr;
            const(const struct_mail_transaction_expunge_guid*)* v;
            struct_mail_transaction_expunge_guid** v_modifiable;
        }
        _Anonymous_33 expunges;
        union _Anonymous_34
        {
            struct_array arr;
            const(const struct_mail_index_flag_update*)* v;
            struct_mail_index_flag_update** v_modifiable;
        }
        _Anonymous_34 updates;
        int last_update_idx;
        ubyte[1] pre_hdr_change;
        ubyte[1] pre_hdr_mask;
        ubyte[1] post_hdr_change;
        ubyte[1] post_hdr_mask;
        union _Anonymous_35
        {
            struct_array arr;
            const(const struct_mail_index_transaction_ext_hdr_update*)* v;
            struct_mail_index_transaction_ext_hdr_update** v_modifiable;
        }
        _Anonymous_35 ext_hdr_updates;
        union_array__seq_array_array ext_rec_updates;
        union_array__seq_array_array ext_rec_atomics;
        union _Anonymous_36
        {
            struct_array arr;
            const(const struct_mail_transaction_ext_intro*)* v;
            struct_mail_transaction_ext_intro** v_modifiable;
        }
        _Anonymous_36 ext_resizes;
        union _Anonymous_37
        {
            struct_array arr;
            const(const struct_mail_transaction_ext_reset*)* v;
            struct_mail_transaction_ext_reset** v_modifiable;
        }
        _Anonymous_37 ext_resets;
        union _Anonymous_38
        {
            struct_array arr;
            const(const(const uint32_t)*)* v;
            uint32_t** v_modifiable;
        }
        _Anonymous_38 ext_reset_ids;
        union _Anonymous_39
        {
            struct_array arr;
            const(const(const uint32_t)*)* v;
            uint32_t** v_modifiable;
        }
        _Anonymous_39 ext_reset_atomic;
        union _Anonymous_40
        {
            struct_array arr;
            const(const struct_mail_index_transaction_keyword_update*)* v;
            struct_mail_index_transaction_keyword_update** v_modifiable;
        }
        _Anonymous_40 keyword_updates;
        int* attribute_updates;
        int* attribute_updates_suffix;
        uint64_t min_highest_modseq;
        uint64_t max_modseq;
        union_array__seq_range* conflict_seqs;
        union _Anonymous_41
        {
            struct_array arr;
            union_mail_index_transaction_module_context*** v;
            union_mail_index_transaction_module_context*** v_modifiable;
        }
        _Anonymous_41 module_contexts;
        int no_appends;
        int sync_transaction;
        int appends_nonsorted;
        int expunges_nonsorted;
        int drop_unnecessary_flag_updates;
        int pre_hdr_changed;
        int post_hdr_changed;
        int reset;
        int index_deleted;
        int index_undeleted;
        int commit_deleted_index;
        int tail_offset_changed;
        int log_updates;
        int log_ext_updates;
    }
    enum _Anonymous_42
    {
        IPPROTO_IP = 0,
        IPPROTO_ICMP = 1,
        IPPROTO_IGMP = 2,
        IPPROTO_IPIP = 4,
        IPPROTO_TCP = 6,
        IPPROTO_EGP = 8,
        IPPROTO_PUP = 12,
        IPPROTO_UDP = 17,
        IPPROTO_IDP = 22,
        IPPROTO_TP = 29,
        IPPROTO_DCCP = 33,
        IPPROTO_IPV6 = 41,
        IPPROTO_RSVP = 46,
        IPPROTO_GRE = 47,
        IPPROTO_ESP = 50,
        IPPROTO_AH = 51,
        IPPROTO_MTP = 92,
        IPPROTO_BEETPH = 94,
        IPPROTO_ENCAP = 98,
        IPPROTO_PIM = 103,
        IPPROTO_COMP = 108,
        IPPROTO_SCTP = 132,
        IPPROTO_UDPLITE = 136,
        IPPROTO_MPLS = 137,
        IPPROTO_RAW = 255,
        IPPROTO_MAX = 256,
    }
    void mail_storage_hooks_add_internal(const struct_mail_storage_hooks*, );
    void* buffer_free_without_data(int**, );
    union _Anonymous_43
    {
        char[4] __size;
        int __align;
    }
    enum _Anonymous_44
    {
        SHUT_RD = 0,
        SHUT_WR = 1,
        SHUT_RDWR = 2,
    }
    void mail_storage_hooks_remove_internal(const struct_mail_storage_hooks*, );
    struct struct_mail_storage_module_register
    {
        uint id;
    }
    enum enum_mail_transaction_type
    {
        MAIL_TRANSACTION_EXPUNGE = 1,
        MAIL_TRANSACTION_APPEND = 2,
        MAIL_TRANSACTION_FLAG_UPDATE = 4,
        MAIL_TRANSACTION_HEADER_UPDATE = 32,
        MAIL_TRANSACTION_EXT_INTRO = 64,
        MAIL_TRANSACTION_EXT_RESET = 128,
        MAIL_TRANSACTION_EXT_HDR_UPDATE = 256,
        MAIL_TRANSACTION_EXT_REC_UPDATE = 512,
        MAIL_TRANSACTION_KEYWORD_UPDATE = 1024,
        MAIL_TRANSACTION_KEYWORD_RESET = 2048,
        MAIL_TRANSACTION_EXT_ATOMIC_INC = 4096,
        MAIL_TRANSACTION_EXPUNGE_GUID = 8192,
        MAIL_TRANSACTION_MODSEQ_UPDATE = 32768,
        MAIL_TRANSACTION_EXT_HDR_UPDATE32 = 65536,
        MAIL_TRANSACTION_INDEX_DELETED = 131072,
        MAIL_TRANSACTION_INDEX_UNDELETED = 262144,
        MAIL_TRANSACTION_BOUNDARY = 524288,
        MAIL_TRANSACTION_ATTRIBUTE_UPDATE = 1048576,
        MAIL_TRANSACTION_TYPE_MASK = 268435455,
        MAIL_TRANSACTION_EXPUNGE_PROT = 52624,
        MAIL_TRANSACTION_EXTERNAL = 268435456,
        MAIL_TRANSACTION_SYNC = 536870912,
    }
    enum
    {
        MAIL_TRANSACTION_EXPUNGE = 1,
        MAIL_TRANSACTION_APPEND = 2,
        MAIL_TRANSACTION_FLAG_UPDATE = 4,
        MAIL_TRANSACTION_HEADER_UPDATE = 32,
        MAIL_TRANSACTION_EXT_INTRO = 64,
        MAIL_TRANSACTION_EXT_RESET = 128,
        MAIL_TRANSACTION_EXT_HDR_UPDATE = 256,
        MAIL_TRANSACTION_EXT_REC_UPDATE = 512,
        MAIL_TRANSACTION_KEYWORD_UPDATE = 1024,
        MAIL_TRANSACTION_KEYWORD_RESET = 2048,
        MAIL_TRANSACTION_EXT_ATOMIC_INC = 4096,
        MAIL_TRANSACTION_EXPUNGE_GUID = 8192,
        MAIL_TRANSACTION_MODSEQ_UPDATE = 32768,
        MAIL_TRANSACTION_EXT_HDR_UPDATE32 = 65536,
        MAIL_TRANSACTION_INDEX_DELETED = 131072,
        MAIL_TRANSACTION_INDEX_UNDELETED = 262144,
        MAIL_TRANSACTION_BOUNDARY = 524288,
        MAIL_TRANSACTION_ATTRIBUTE_UPDATE = 1048576,
        MAIL_TRANSACTION_TYPE_MASK = 268435455,
        MAIL_TRANSACTION_EXPUNGE_PROT = 52624,
        MAIL_TRANSACTION_EXTERNAL = 268435456,
        MAIL_TRANSACTION_SYNC = 536870912,
    }
    union union_mail_index_view_module_context
    {
        struct_mail_index_module_register* reg;
    }
    void hook_mail_user_created(struct_mail_user*, );
    void hook_mail_namespace_storage_added(struct_mail_namespace*, );
    enum enum_mail_index_header_compat_flags
    {
        MAIL_INDEX_COMPAT_LITTLE_ENDIAN = 1,
    }
    enum
    {
        MAIL_INDEX_COMPAT_LITTLE_ENDIAN = 1,
    }
    //alias mail_index_expunge_handler_t = ctx;






    struct struct_mail_module_register
    {
        uint id;
    }
    void hook_mail_namespaces_created(struct_mail_namespace*, );
    struct struct_mail_index_view
    {
        struct_mail_index_view* prev;
        struct_mail_index_view* next;
        int refcount;
        struct_mail_index_view_vfuncs v;
        struct_mail_index* index;
        struct_mail_transaction_log_view* log_view;
        const(char)* source_filename;
        uint source_linenum;
        uint32_t indexid;
        uint inconsistency_id;
        uint64_t highest_modseq;
        struct_mail_index_map* map;
        union _Anonymous_45
        {
            struct_array arr;
            struct_mail_index_map*** v;
            struct_mail_index_map*** v_modifiable;
        }
        _Anonymous_45 map_refs;
        uint32_t log_file_expunge_seq;
        uint32_t log_file_head_seq;
        int log_file_expunge_offset;
        int log_file_head_offset;
        union_array__view_log_sync_area syncs_hidden;
        union _Anonymous_46
        {
            struct_array arr;
            union_mail_index_view_module_context*** v;
            union_mail_index_view_module_context*** v_modifiable;
        }
        _Anonymous_46 module_contexts;
        struct_mail_index_transaction* transactions_list;
        int transactions;
        int inconsistent;
        int index_sync_view;
        int syncing;
    }
    void hook_mail_namespaces_added(struct_mail_namespace*, );



    void hook_mail_storage_created(struct_mail_storage*, );






    //alias mail_index_sync_handler_t = ctx;
    void buffer_write(int*, int, const(void)*, int, );
    void hook_mailbox_list_created(struct_mailbox_list*, );
    struct struct_mail_storage_vfuncs
    {
        const(struct_setting_parser_info)* function() get_setting_parser_info;
        struct_mail_storage* function() alloc;
        int function(struct_mail_storage*, struct_mail_namespace*, const(char)**) create;
        void function(struct_mail_storage*) destroy;
        void function(struct_mail_storage*, struct_mailbox_list*) add_list;
        void function(const(struct_mail_namespace)*, struct_mailbox_list_settings*) get_list_settings;
        int function(const struct_mail_namespace*, struct_mailbox_list_settings*) function(int*) bool_;
        struct_mailbox* function(struct_mail_storage*, struct_mailbox_list*, const(char)*, enum_mailbox_flags) mailbox_alloc;
        int function(struct_mail_storage*) purge;
        int function(struct_mail_storage*, enum_mail_storage_list_index_rebuild_reason) list_index_rebuild;
    }
    enum enum_mail_index_header_flag
    {
        MAIL_INDEX_HDR_FLAG_CORRUPTED = 1,
        MAIL_INDEX_HDR_FLAG_HAVE_DIRTY = 2,
        MAIL_INDEX_HDR_FLAG_FSCKD = 4,
    }
    enum
    {
        MAIL_INDEX_HDR_FLAG_CORRUPTED = 1,
        MAIL_INDEX_HDR_FLAG_HAVE_DIRTY = 2,
        MAIL_INDEX_HDR_FLAG_FSCKD = 4,
    }
    void hook_mailbox_allocated(struct_mailbox*, );
    void hook_mailbox_opened(struct_mailbox*, );
    alias mail_index_sync_lost_handler_t = index;
    void buffer_append(int*, const(void)*, int, );
    void hook_mail_allocated(struct_mail*, );
    void buffer_append_c(int*, ubyte, );



    struct struct_mail_index_ext
    {
        const(char)* name;
        uint32_t index_idx;
        uint32_t reset_id;
        uint32_t ext_offset;
        uint32_t hdr_offset;
        uint32_t hdr_size;
        uint16_t record_offset;
        uint16_t record_size;
        uint16_t record_align;
    }
    void buffer_insert(int*, int, const(void)*, int, );






    enum enum_mail_index_mail_flags
    {
        MAIL_INDEX_MAIL_FLAG_BACKEND = 64,
        MAIL_INDEX_MAIL_FLAG_DIRTY = 128,
        MAIL_INDEX_MAIL_FLAG_UPDATE_MODSEQ = 256,
    }
    enum
    {
        MAIL_INDEX_MAIL_FLAG_BACKEND = 64,
        MAIL_INDEX_MAIL_FLAG_DIRTY = 128,
        MAIL_INDEX_MAIL_FLAG_UPDATE_MODSEQ = 256,
    }
    void buffer_delete(int*, int, int, );
    struct _Anonymous_47
    {
        __fd_mask[16] __fds_bits;
    }
    void buffer_write_zero(int*, int, int, );





    void buffer_append_zero(int*, int, );




    void buffer_insert_zero(int*, int, int, );




    union _Anonymous_48
    {
        struct___pthread_mutex_s __data;
        char[40] __size;
        c_long __align;
    }
    struct struct_mail_index_ext_header
    {
        uint32_t hdr_size;
        uint32_t reset_id;
        uint16_t record_offset;
        uint16_t record_size;
        uint16_t record_align;
        uint16_t name_size;
    }



    void buffer_copy(int*, int, const(int)*, int, int, );





    enum _Anonymous_49
    {
        _SC_ARG_MAX = 0,
        _SC_CHILD_MAX = 1,
        _SC_CLK_TCK = 2,
        _SC_NGROUPS_MAX = 3,
        _SC_OPEN_MAX = 4,
        _SC_STREAM_MAX = 5,
        _SC_TZNAME_MAX = 6,
        _SC_JOB_CONTROL = 7,
        _SC_SAVED_IDS = 8,
        _SC_REALTIME_SIGNALS = 9,
        _SC_PRIORITY_SCHEDULING = 10,
        _SC_TIMERS = 11,
        _SC_ASYNCHRONOUS_IO = 12,
        _SC_PRIORITIZED_IO = 13,
        _SC_SYNCHRONIZED_IO = 14,
        _SC_FSYNC = 15,
        _SC_MAPPED_FILES = 16,
        _SC_MEMLOCK = 17,
        _SC_MEMLOCK_RANGE = 18,
        _SC_MEMORY_PROTECTION = 19,
        _SC_MESSAGE_PASSING = 20,
        _SC_SEMAPHORES = 21,
        _SC_SHARED_MEMORY_OBJECTS = 22,
        _SC_AIO_LISTIO_MAX = 23,
        _SC_AIO_MAX = 24,
        _SC_AIO_PRIO_DELTA_MAX = 25,
        _SC_DELAYTIMER_MAX = 26,
        _SC_MQ_OPEN_MAX = 27,
        _SC_MQ_PRIO_MAX = 28,
        _SC_VERSION = 29,
        _SC_PAGESIZE = 30,
        _SC_RTSIG_MAX = 31,
        _SC_SEM_NSEMS_MAX = 32,
        _SC_SEM_VALUE_MAX = 33,
        _SC_SIGQUEUE_MAX = 34,
        _SC_TIMER_MAX = 35,
        _SC_BC_BASE_MAX = 36,
        _SC_BC_DIM_MAX = 37,
        _SC_BC_SCALE_MAX = 38,
        _SC_BC_STRING_MAX = 39,
        _SC_COLL_WEIGHTS_MAX = 40,
        _SC_EQUIV_CLASS_MAX = 41,
        _SC_EXPR_NEST_MAX = 42,
        _SC_LINE_MAX = 43,
        _SC_RE_DUP_MAX = 44,
        _SC_CHARCLASS_NAME_MAX = 45,
        _SC_2_VERSION = 46,
        _SC_2_C_BIND = 47,
        _SC_2_C_DEV = 48,
        _SC_2_FORT_DEV = 49,
        _SC_2_FORT_RUN = 50,
        _SC_2_SW_DEV = 51,
        _SC_2_LOCALEDEF = 52,
        _SC_PII = 53,
        _SC_PII_XTI = 54,
        _SC_PII_SOCKET = 55,
        _SC_PII_INTERNET = 56,
        _SC_PII_OSI = 57,
        _SC_POLL = 58,
        _SC_SELECT = 59,
        _SC_UIO_MAXIOV = 60,
        _SC_IOV_MAX = 60,
        _SC_PII_INTERNET_STREAM = 61,
        _SC_PII_INTERNET_DGRAM = 62,
        _SC_PII_OSI_COTS = 63,
        _SC_PII_OSI_CLTS = 64,
        _SC_PII_OSI_M = 65,
        _SC_T_IOV_MAX = 66,
        _SC_THREADS = 67,
        _SC_THREAD_SAFE_FUNCTIONS = 68,
        _SC_GETGR_R_SIZE_MAX = 69,
        _SC_GETPW_R_SIZE_MAX = 70,
        _SC_LOGIN_NAME_MAX = 71,
        _SC_TTY_NAME_MAX = 72,
        _SC_THREAD_DESTRUCTOR_ITERATIONS = 73,
        _SC_THREAD_KEYS_MAX = 74,
        _SC_THREAD_STACK_MIN = 75,
        _SC_THREAD_THREADS_MAX = 76,
        _SC_THREAD_ATTR_STACKADDR = 77,
        _SC_THREAD_ATTR_STACKSIZE = 78,
        _SC_THREAD_PRIORITY_SCHEDULING = 79,
        _SC_THREAD_PRIO_INHERIT = 80,
        _SC_THREAD_PRIO_PROTECT = 81,
        _SC_THREAD_PROCESS_SHARED = 82,
        _SC_NPROCESSORS_CONF = 83,
        _SC_NPROCESSORS_ONLN = 84,
        _SC_PHYS_PAGES = 85,
        _SC_AVPHYS_PAGES = 86,
        _SC_ATEXIT_MAX = 87,
        _SC_PASS_MAX = 88,
        _SC_XOPEN_VERSION = 89,
        _SC_XOPEN_XCU_VERSION = 90,
        _SC_XOPEN_UNIX = 91,
        _SC_XOPEN_CRYPT = 92,
        _SC_XOPEN_ENH_I18N = 93,
        _SC_XOPEN_SHM = 94,
        _SC_2_CHAR_TERM = 95,
        _SC_2_C_VERSION = 96,
        _SC_2_UPE = 97,
        _SC_XOPEN_XPG2 = 98,
        _SC_XOPEN_XPG3 = 99,
        _SC_XOPEN_XPG4 = 100,
        _SC_CHAR_BIT = 101,
        _SC_CHAR_MAX = 102,
        _SC_CHAR_MIN = 103,
        _SC_INT_MAX = 104,
        _SC_INT_MIN = 105,
        _SC_LONG_BIT = 106,
        _SC_WORD_BIT = 107,
        _SC_MB_LEN_MAX = 108,
        _SC_NZERO = 109,
        _SC_SSIZE_MAX = 110,
        _SC_SCHAR_MAX = 111,
        _SC_SCHAR_MIN = 112,
        _SC_SHRT_MAX = 113,
        _SC_SHRT_MIN = 114,
        _SC_UCHAR_MAX = 115,
        _SC_UINT_MAX = 116,
        _SC_ULONG_MAX = 117,
        _SC_USHRT_MAX = 118,
        _SC_NL_ARGMAX = 119,
        _SC_NL_LANGMAX = 120,
        _SC_NL_MSGMAX = 121,
        _SC_NL_NMAX = 122,
        _SC_NL_SETMAX = 123,
        _SC_NL_TEXTMAX = 124,
        _SC_XBS5_ILP32_OFF32 = 125,
        _SC_XBS5_ILP32_OFFBIG = 126,
        _SC_XBS5_LP64_OFF64 = 127,
        _SC_XBS5_LPBIG_OFFBIG = 128,
        _SC_XOPEN_LEGACY = 129,
        _SC_XOPEN_REALTIME = 130,
        _SC_XOPEN_REALTIME_THREADS = 131,
        _SC_ADVISORY_INFO = 132,
        _SC_BARRIERS = 133,
        _SC_BASE = 134,
        _SC_C_LANG_SUPPORT = 135,
        _SC_C_LANG_SUPPORT_R = 136,
        _SC_CLOCK_SELECTION = 137,
        _SC_CPUTIME = 138,
        _SC_THREAD_CPUTIME = 139,
        _SC_DEVICE_IO = 140,
        _SC_DEVICE_SPECIFIC = 141,
        _SC_DEVICE_SPECIFIC_R = 142,
        _SC_FD_MGMT = 143,
        _SC_FIFO = 144,
        _SC_PIPE = 145,
        _SC_FILE_ATTRIBUTES = 146,
        _SC_FILE_LOCKING = 147,
        _SC_FILE_SYSTEM = 148,
        _SC_MONOTONIC_CLOCK = 149,
        _SC_MULTI_PROCESS = 150,
        _SC_SINGLE_PROCESS = 151,
        _SC_NETWORKING = 152,
        _SC_READER_WRITER_LOCKS = 153,
        _SC_SPIN_LOCKS = 154,
        _SC_REGEXP = 155,
        _SC_REGEX_VERSION = 156,
        _SC_SHELL = 157,
        _SC_SIGNALS = 158,
        _SC_SPAWN = 159,
        _SC_SPORADIC_SERVER = 160,
        _SC_THREAD_SPORADIC_SERVER = 161,
        _SC_SYSTEM_DATABASE = 162,
        _SC_SYSTEM_DATABASE_R = 163,
        _SC_TIMEOUTS = 164,
        _SC_TYPED_MEMORY_OBJECTS = 165,
        _SC_USER_GROUPS = 166,
        _SC_USER_GROUPS_R = 167,
        _SC_2_PBS = 168,
        _SC_2_PBS_ACCOUNTING = 169,
        _SC_2_PBS_LOCATE = 170,
        _SC_2_PBS_MESSAGE = 171,
        _SC_2_PBS_TRACK = 172,
        _SC_SYMLOOP_MAX = 173,
        _SC_STREAMS = 174,
        _SC_2_PBS_CHECKPOINT = 175,
        _SC_V6_ILP32_OFF32 = 176,
        _SC_V6_ILP32_OFFBIG = 177,
        _SC_V6_LP64_OFF64 = 178,
        _SC_V6_LPBIG_OFFBIG = 179,
        _SC_HOST_NAME_MAX = 180,
        _SC_TRACE = 181,
        _SC_TRACE_EVENT_FILTER = 182,
        _SC_TRACE_INHERIT = 183,
        _SC_TRACE_LOG = 184,
        _SC_LEVEL1_ICACHE_SIZE = 185,
        _SC_LEVEL1_ICACHE_ASSOC = 186,
        _SC_LEVEL1_ICACHE_LINESIZE = 187,
        _SC_LEVEL1_DCACHE_SIZE = 188,
        _SC_LEVEL1_DCACHE_ASSOC = 189,
        _SC_LEVEL1_DCACHE_LINESIZE = 190,
        _SC_LEVEL2_CACHE_SIZE = 191,
        _SC_LEVEL2_CACHE_ASSOC = 192,
        _SC_LEVEL2_CACHE_LINESIZE = 193,
        _SC_LEVEL3_CACHE_SIZE = 194,
        _SC_LEVEL3_CACHE_ASSOC = 195,
        _SC_LEVEL3_CACHE_LINESIZE = 196,
        _SC_LEVEL4_CACHE_SIZE = 197,
        _SC_LEVEL4_CACHE_ASSOC = 198,
        _SC_LEVEL4_CACHE_LINESIZE = 199,
        _SC_IPV6 = 235,
        _SC_RAW_SOCKETS = 236,
        _SC_V7_ILP32_OFF32 = 237,
        _SC_V7_ILP32_OFFBIG = 238,
        _SC_V7_LP64_OFF64 = 239,
        _SC_V7_LPBIG_OFFBIG = 240,
        _SC_SS_REPL_MAX = 241,
        _SC_TRACE_EVENT_NAME_MAX = 242,
        _SC_TRACE_NAME_MAX = 243,
        _SC_TRACE_SYS_MAX = 244,
        _SC_TRACE_USER_EVENT_MAX = 245,
        _SC_XOPEN_STREAMS = 246,
        _SC_THREAD_ROBUST_PRIO_INHERIT = 247,
        _SC_THREAD_ROBUST_PRIO_PROTECT = 248,
    }
    struct struct_mail_index_header
    {
        int major_version;
        int minor_version;
        int base_header_size;
        int header_size;
        int record_size;
        int compat_flags;
        int[3] unused;
        int indexid;
        int flags;
        int uid_validity;
        int next_uid;
        int messages_count;
        int unused_old_recent_messages_count;
        int seen_messages_count;
        int deleted_messages_count;
        int first_recent_uid;
        int first_unseen_uid_lowwater;
        int first_deleted_uid_lowwater;
        int log_file_seq;
        int log_file_tail_offset;
        int log_file_head_offset;
        int unused_old_sync_size_part1;
        int log2_rotate_time;
        int last_temp_file_scan;
        int day_stamp;
        int[8] day_first_uid;
    }





    void buffer_append_buf(int*, const(int)*, int, int, );
    enum enum_mailbox_feature
    {
        MAILBOX_FEATURE_CONDSTORE = 1,
        MAILBOX_FEATURE_QRESYNC = 2,
    }
    enum
    {
        MAILBOX_FEATURE_CONDSTORE = 1,
        MAILBOX_FEATURE_QRESYNC = 2,
    }
    union _Anonymous_50
    {
        struct___pthread_cond_s __data;
        char[48] __size;
        long __align;
    }
    union union_mail_storage_module_context
    {
        struct_mail_storage_vfuncs super_;
        struct_mail_storage_module_register* reg;
    }
    struct struct_mail_index_keyword_header
    {
        uint32_t keywords_count;
    }
    void* buffer_get_space_unsafe(int*, int, int, );



    struct struct_mail_transaction_header
    {
        uint32_t size;
        uint32_t type;
    }
    enum enum_mailbox_existence
    {
        MAILBOX_EXISTENCE_NONE = 0,
        MAILBOX_EXISTENCE_NOSELECT = 1,
        MAILBOX_EXISTENCE_SELECT = 2,
    }
    enum
    {
        MAILBOX_EXISTENCE_NONE = 0,
        MAILBOX_EXISTENCE_NOSELECT = 1,
        MAILBOX_EXISTENCE_SELECT = 2,
    }
    void* buffer_append_space_unsafe(int*, int, );
    enum enum_mail_storage_class_flags
    {
        MAIL_STORAGE_CLASS_FLAG_MAILBOX_IS_FILE = 1,
        MAIL_STORAGE_CLASS_FLAG_UNIQUE_ROOT = 2,
        MAIL_STORAGE_CLASS_FLAG_OPEN_STREAMS = 4,
        MAIL_STORAGE_CLASS_FLAG_NOQUOTA = 8,
        MAIL_STORAGE_CLASS_FLAG_NO_ROOT = 16,
        MAIL_STORAGE_CLASS_FLAG_FILE_PER_MSG = 32,
        MAIL_STORAGE_CLASS_FLAG_HAVE_MAIL_GUIDS = 64,
        MAIL_STORAGE_CLASS_FLAG_HAVE_MAIL_SAVE_GUIDS = 128,
        MAIL_STORAGE_CLASS_FLAG_BINARY_DATA = 256,
        MAIL_STORAGE_CLASS_FLAG_HAVE_MAIL_GUID128 = 512,
        MAIL_STORAGE_CLASS_FLAG_NO_LIST_DELETES = 1024,
        MAIL_STORAGE_CLASS_FLAG_STUBS = 2048,
    }
    enum
    {
        MAIL_STORAGE_CLASS_FLAG_MAILBOX_IS_FILE = 1,
        MAIL_STORAGE_CLASS_FLAG_UNIQUE_ROOT = 2,
        MAIL_STORAGE_CLASS_FLAG_OPEN_STREAMS = 4,
        MAIL_STORAGE_CLASS_FLAG_NOQUOTA = 8,
        MAIL_STORAGE_CLASS_FLAG_NO_ROOT = 16,
        MAIL_STORAGE_CLASS_FLAG_FILE_PER_MSG = 32,
        MAIL_STORAGE_CLASS_FLAG_HAVE_MAIL_GUIDS = 64,
        MAIL_STORAGE_CLASS_FLAG_HAVE_MAIL_SAVE_GUIDS = 128,
        MAIL_STORAGE_CLASS_FLAG_BINARY_DATA = 256,
        MAIL_STORAGE_CLASS_FLAG_HAVE_MAIL_GUID128 = 512,
        MAIL_STORAGE_CLASS_FLAG_NO_LIST_DELETES = 1024,
        MAIL_STORAGE_CLASS_FLAG_STUBS = 2048,
    }
    struct struct_module_context_id
    {
        uint* module_id_register;
        uint module_id;
        int module_id_set;
    }
    struct struct_mail_index_keyword_header_rec
    {
        uint32_t unused;
        uint32_t name_offset;
    }
    union _Anonymous_51
    {
        struct___pthread_rwlock_arch_t __data;
        char[56] __size;
        c_long __align;
    }
    struct_mail_index_view* mail_index_view_open_with_map(struct_mail_index*, struct_mail_index_map*, );
    struct struct_mail_transaction_modseq_update
    {
        uint32_t uid;
        uint32_t modseq_low32;
        uint32_t modseq_high32;
    }
    enum enum_mailbox_status_items
    {
        STATUS_MESSAGES = 1,
        STATUS_RECENT = 2,
        STATUS_UIDNEXT = 4,
        STATUS_UIDVALIDITY = 8,
        STATUS_UNSEEN = 16,
        STATUS_FIRST_UNSEEN_SEQ = 32,
        STATUS_KEYWORDS = 64,
        STATUS_HIGHESTMODSEQ = 128,
        STATUS_PERMANENT_FLAGS = 512,
        STATUS_FIRST_RECENT_UID = 1024,
        STATUS_LAST_CACHED_SEQ = 2048,
        STATUS_CHECK_OVER_QUOTA = 4096,
        STATUS_HIGHESTPVTMODSEQ = 8192,
    }
    enum
    {
        STATUS_MESSAGES = 1,
        STATUS_RECENT = 2,
        STATUS_UIDNEXT = 4,
        STATUS_UIDVALIDITY = 8,
        STATUS_UNSEEN = 16,
        STATUS_FIRST_UNSEEN_SEQ = 32,
        STATUS_KEYWORDS = 64,
        STATUS_HIGHESTMODSEQ = 128,
        STATUS_PERMANENT_FLAGS = 512,
        STATUS_FIRST_RECENT_UID = 1024,
        STATUS_LAST_CACHED_SEQ = 2048,
        STATUS_CHECK_OVER_QUOTA = 4096,
        STATUS_HIGHESTPVTMODSEQ = 8192,
    }
    uint module_get_context_id(struct_module_context_id*, );
    void mail_index_view_clone(struct_mail_index_view*, const struct_mail_index_view*, );
    enum enum_mail_index_sync_handler_type
    {
        MAIL_INDEX_SYNC_HANDLER_FILE = 1,
        MAIL_INDEX_SYNC_HANDLER_HEAD = 2,
        MAIL_INDEX_SYNC_HANDLER_VIEW = 4,
    }
    enum
    {
        MAIL_INDEX_SYNC_HANDLER_FILE = 1,
        MAIL_INDEX_SYNC_HANDLER_HEAD = 2,
        MAIL_INDEX_SYNC_HANDLER_VIEW = 4,
    }
    struct_mail_index_view* mail_index_view_dup_private(const struct_mail_index_view*, );
    void mail_index_view_ref(struct_mail_index_view*, );
    union _Anonymous_52
    {
        char[8] __size;
        c_long __align;
    }
    void buffer_set_used_size(int*, int, );
    void mail_index_view_unref_maps(struct_mail_index_view*, );
    struct struct_mail_transaction_expunge
    {
        uint32_t uid1;
        uint32_t uid2;
    }
    void mail_index_view_add_hidden_transaction(struct_mail_index_view*, uint32_t, int, uint, );
    struct struct_mail_index_sync_handler
    {
        mail_index_sync_handler_t* callback;
        enum_mail_index_sync_handler_type type;
    }
    struct struct_mail_transaction_expunge_guid
    {
        uint32_t uid;
        guid_128_t guid_128;
    }
    enum _Anonymous_53
    {
        IPPROTO_HOPOPTS = 0,
        IPPROTO_ROUTING = 43,
        IPPROTO_FRAGMENT = 44,
        IPPROTO_ICMPV6 = 58,
        IPPROTO_NONE = 59,
        IPPROTO_DSTOPTS = 60,
        IPPROTO_MH = 135,
    }
    struct_mail_index_view* mail_index_dummy_view_open(struct_mail_index*, );
    struct struct_mail_index_registered_ext
    {
        const(char)* name;
        uint32_t index_idx;
        uint32_t hdr_size;
        uint16_t record_size;
        uint16_t record_align;
        struct_mail_index_sync_handler sync_handler;
        mail_index_expunge_handler_t* expunge_handler;
        void* expunge_context;
        int expunge_handler_call_always;
    }
    struct struct_mail_transaction_flag_update
    {
        uint32_t uid1;
        uint32_t uid2;
        uint8_t add_flags;
        uint8_t remove_flags;
        uint8_t modseq_inc_flag;
        uint8_t padding;
    }



    int buffer_cmp();





    enum enum_mailbox_metadata_items
    {
        MAILBOX_METADATA_GUID = 1,
        MAILBOX_METADATA_VIRTUAL_SIZE = 2,
        MAILBOX_METADATA_CACHE_FIELDS = 4,
        MAILBOX_METADATA_PRECACHE_FIELDS = 8,
        MAILBOX_METADATA_BACKEND_NAMESPACE = 16,
        MAILBOX_METADATA_PHYSICAL_SIZE = 32,
        MAILBOX_METADATA_FIRST_SAVE_DATE = 64,
    }
    enum
    {
        MAILBOX_METADATA_GUID = 1,
        MAILBOX_METADATA_VIRTUAL_SIZE = 2,
        MAILBOX_METADATA_CACHE_FIELDS = 4,
        MAILBOX_METADATA_PRECACHE_FIELDS = 8,
        MAILBOX_METADATA_BACKEND_NAMESPACE = 16,
        MAILBOX_METADATA_PHYSICAL_SIZE = 32,
        MAILBOX_METADATA_FIRST_SAVE_DATE = 64,
    }






    union _Anonymous_54
    {
        char[32] __size;
        c_long __align;
    }



    struct struct_mail_transaction_keyword_update
    {
        uint8_t modify_type;
        uint8_t padding;
        uint16_t name_size;
    }



    //alias hook_mail_index_transaction_created_t = t;
    void mail_index_transaction_hook_register(hook_mail_index_transaction_created_t*, );
    struct struct_timeout;
    // FIXME
    struct struct_mail_binary_cache
    {
        struct_timeout* to;
        struct_mailbox* box;
        uint32_t uid;
        int orig_physical_pos;
        int include_hdr;
        struct_istream* input;
        int size;
    }
    void array_create_from_buffer_i(struct_array*, int*, int, );



    void mail_index_transaction_hook_unregister(hook_mail_index_transaction_created_t*, );
    union _Anonymous_55
    {
        char[4] __size;
        int __align;
    }
    struct struct_mail_index_record_map
    {
        union _Anonymous_56
        {
            struct_array arr;
            struct_mail_index_map*** v;
            struct_mail_index_map*** v_modifiable;
        }
        _Anonymous_56 maps;
        void* mmap_base;
        int mmap_size;
        int mmap_used_size;
        int* buffer;
        void* records;
        uint records_count;
        struct_mail_index_map_modseq* modseq;
        uint32_t last_appended_uid;
    }
    struct_mail_index_record* mail_index_transaction_lookup(struct_mail_index_transaction*, uint32_t, );




    void mail_index_transaction_ref(struct_mail_index_transaction*, );
    struct struct_mail_transaction_keyword_reset
    {
        uint32_t uid1;
        uint32_t uid2;
    }



    void mail_index_transaction_unref(struct_mail_index_transaction**, );


    void mail_index_transaction_reset_v(struct_mail_index_transaction*, );
    struct struct_mail_index_record
    {
        int uid;
        int flags;
    }
    enum enum_mailbox_search_result_flags
    {
        MAILBOX_SEARCH_RESULT_FLAG_UPDATE = 1,
        MAILBOX_SEARCH_RESULT_FLAG_QUEUE_SYNC = 2,
    }
    enum
    {
        MAILBOX_SEARCH_RESULT_FLAG_UPDATE = 1,
        MAILBOX_SEARCH_RESULT_FLAG_QUEUE_SYNC = 2,
    }
    void mail_index_transaction_sort_appends(struct_mail_index_transaction*, );
    struct struct_mail_transaction_header_update
    {
        uint16_t offset;
        uint16_t size;
    }
    void array_create_i(struct_array*, int, int, uint, );


    void mail_index_transaction_sort_expunges(struct_mail_index_transaction*, );
    struct struct_mail_storage_error
    {
        char* error_string;
        enum_mail_error error;
        char* last_internal_error;
        int last_error_is_internal;
    }


    uint32_t mail_index_transaction_get_next_uid(struct_mail_index_transaction*, );


    void mail_index_transaction_set_log_updates(struct_mail_index_transaction*, );
    struct struct_mail_keywords
    {
        struct_mail_index* index;
        uint count;
        int refcount;
        uint idx;
    }
    void mail_index_update_day_headers(struct_mail_index_transaction*, time_t, );




    enum MailSortType
    {
        ARRIVAL = 1,
        CC = 2,
        DATE = 4,
        FROM = 8,
        SIZE = 16,
        SUBJECT = 32,
        TO = 64,
        RELEVANCY = 128,
        DISPLAYFROM = 256,
        DISPLAYTO = 512,
        POP3_ORDER = 1024,
        MASK = 4095,
        FLAG_REVERSE = 4096,
        END = 0,
    }
    enum _Anonymous_58
    {
        MAIL_TRANSACTION_EXT_INTRO_FLAG_NO_SHRINK = 1,
    }
    enum
    {
        MAIL_TRANSACTION_EXT_INTRO_FLAG_NO_SHRINK = 1,
    }
    uint mail_index_transaction_get_flag_update_pos(struct_mail_index_transaction*, uint, uint, uint32_t, );


    struct struct_mail_index_map
    {
        struct_mail_index* index;
        int refcount;
        struct_mail_index_header hdr;
        const(void)* hdr_base;
        int* hdr_copy_buf;
        int extension_pool;
        union _Anonymous_59
        {
            struct_array arr;
            const(const struct_mail_index_ext*)* v;
            struct_mail_index_ext** v_modifiable;
        }
        _Anonymous_59 extensions;
        union _Anonymous_60
        {
            struct_array arr;
            const(const(const uint32_t)*)* v;
            uint32_t** v_modifiable;
        }
        _Anonymous_60 ext_id_map;
        union _Anonymous_61
        {
            struct_array arr;
            const(const(uint)*)* v;
            uint** v_modifiable;
        }
        _Anonymous_61 keyword_idx_map;
        struct_mail_index_record_map* rec_map;
    }





    void mail_index_transaction_lookup_latest_keywords(struct_mail_index_transaction*, uint32_t, union_array__keyword_indexes*, );
    struct struct_mail_transaction_ext_intro
    {
        uint32_t ext_id;
        uint32_t reset_id;
        uint32_t hdr_size;
        uint16_t record_size;
        uint16_t record_align;
        uint16_t flags;
        uint16_t name_size;
    }
    enum enum_mail_index_transaction_flags
    {
        MAIL_INDEX_TRANSACTION_FLAG_HIDE = 1,
        MAIL_INDEX_TRANSACTION_FLAG_EXTERNAL = 2,
        MAIL_INDEX_TRANSACTION_FLAG_AVOID_FLAG_UPDATES = 4,
        MAIL_INDEX_TRANSACTION_FLAG_FSYNC = 8,
        MAIL_INDEX_TRANSACTION_FLAG_SYNC = 16,
    }
    enum
    {
        MAIL_INDEX_TRANSACTION_FLAG_HIDE = 1,
        MAIL_INDEX_TRANSACTION_FLAG_EXTERNAL = 2,
        MAIL_INDEX_TRANSACTION_FLAG_AVOID_FLAG_UPDATES = 4,
        MAIL_INDEX_TRANSACTION_FLAG_FSYNC = 8,
        MAIL_INDEX_TRANSACTION_FLAG_SYNC = 16,
    }
    void array_free_i(struct_array*, );
    int mail_index_cancel_flag_updates();
    int mail_index_cancel_keyword_updates();







    int array_is_created_i();
    struct _Anonymous_62
    {
        int[2] __val;
    }
    struct struct_mail_index_module_register
    {
        uint id;
    }
    void mail_index_transaction_seq_range_to_uid(struct_mail_index_transaction*, union_array__seq_range*, );
    struct struct_mail_transaction_ext_reset
    {
        uint32_t new_reset_id;
        uint8_t preserve_data;
        uint8_t[3] unused_padding;
    }



    void mail_index_transaction_finish_so_far(struct_mail_index_transaction*, );
    void mail_index_transaction_finish(struct_mail_index_transaction*, );
    enum enum_mail_fetch_field
    {
        MAIL_FETCH_FLAGS = 1,
        MAIL_FETCH_MESSAGE_PARTS = 2,
        MAIL_FETCH_STREAM_HEADER = 4,
        MAIL_FETCH_STREAM_BODY = 8,
        MAIL_FETCH_DATE = 16,
        MAIL_FETCH_RECEIVED_DATE = 32,
        MAIL_FETCH_SAVE_DATE = 64,
        MAIL_FETCH_PHYSICAL_SIZE = 128,
        MAIL_FETCH_VIRTUAL_SIZE = 256,
        MAIL_FETCH_NUL_STATE = 512,
        MAIL_FETCH_STREAM_BINARY = 1024,
        MAIL_FETCH_IMAP_BODY = 4096,
        MAIL_FETCH_IMAP_BODYSTRUCTURE = 8192,
        MAIL_FETCH_IMAP_ENVELOPE = 16384,
        MAIL_FETCH_FROM_ENVELOPE = 32768,
        MAIL_FETCH_HEADER_MD5 = 65536,
        MAIL_FETCH_STORAGE_ID = 131072,
        MAIL_FETCH_UIDL_BACKEND = 262144,
        MAIL_FETCH_MAILBOX_NAME = 524288,
        MAIL_FETCH_SEARCH_RELEVANCY = 1048576,
        MAIL_FETCH_GUID = 2097152,
        MAIL_FETCH_POP3_ORDER = 4194304,
        MAIL_FETCH_REFCOUNT = 8388608,
        MAIL_FETCH_BODY_SNIPPET = 16777216,
    }
    enum
    {
        MAIL_FETCH_FLAGS = 1,
        MAIL_FETCH_MESSAGE_PARTS = 2,
        MAIL_FETCH_STREAM_HEADER = 4,
        MAIL_FETCH_STREAM_BODY = 8,
        MAIL_FETCH_DATE = 16,
        MAIL_FETCH_RECEIVED_DATE = 32,
        MAIL_FETCH_SAVE_DATE = 64,
        MAIL_FETCH_PHYSICAL_SIZE = 128,
        MAIL_FETCH_VIRTUAL_SIZE = 256,
        MAIL_FETCH_NUL_STATE = 512,
        MAIL_FETCH_STREAM_BINARY = 1024,
        MAIL_FETCH_IMAP_BODY = 4096,
        MAIL_FETCH_IMAP_BODYSTRUCTURE = 8192,
        MAIL_FETCH_IMAP_ENVELOPE = 16384,
        MAIL_FETCH_FROM_ENVELOPE = 32768,
        MAIL_FETCH_HEADER_MD5 = 65536,
        MAIL_FETCH_STORAGE_ID = 131072,
        MAIL_FETCH_UIDL_BACKEND = 262144,
        MAIL_FETCH_MAILBOX_NAME = 524288,
        MAIL_FETCH_SEARCH_RELEVANCY = 1048576,
        MAIL_FETCH_GUID = 2097152,
        MAIL_FETCH_POP3_ORDER = 4194304,
        MAIL_FETCH_REFCOUNT = 8388608,
        MAIL_FETCH_BODY_SNIPPET = 16777216,
    }
    union union_mail_index_module_context
    {
        struct_mail_index_module_register* reg;
    }
    void mail_index_transaction_export(struct_mail_index_transaction*, struct_mail_transaction_log_append_ctx*, enum_mail_index_transaction_change*, );
    void buffer_truncate_rshift_bits(int*, int, );


    enum enum_mail_index_sync_type
    {
        MAIL_INDEX_SYNC_TYPE_EXPUNGE = 2,
        MAIL_INDEX_SYNC_TYPE_FLAGS = 4,
        MAIL_INDEX_SYNC_TYPE_KEYWORD_ADD = 8,
        MAIL_INDEX_SYNC_TYPE_KEYWORD_REMOVE = 16,
    }
    enum
    {
        MAIL_INDEX_SYNC_TYPE_EXPUNGE = 2,
        MAIL_INDEX_SYNC_TYPE_FLAGS = 4,
        MAIL_INDEX_SYNC_TYPE_KEYWORD_ADD = 8,
        MAIL_INDEX_SYNC_TYPE_KEYWORD_REMOVE = 16,
    }


    int mail_transaction_expunge_guid_cmp(const struct_mail_transaction_expunge_guid*, const struct_mail_transaction_expunge_guid*, );


    struct struct_mail_index
    {
        char* dir;
        char* prefix;
        char* cache_dir;
        struct_event* event;
        struct_mail_cache* cache;
        struct_mail_transaction_log* log;
        uint open_count;
        enum_mail_index_open_flags flags;
        enum_fsync_mode fsync_mode;
        enum_mail_index_fsync_mask fsync_mask;
        mode_t mode;
        gid_t gid;
        char* gid_origin;
        struct_mail_index_optimization_settings optimization_set;
        uint32_t pending_log2_rotate_time;
        int extension_pool;
        union _Anonymous_63
        {
            struct_array arr;
            const(const struct_mail_index_registered_ext*)* v;
            struct_mail_index_registered_ext** v_modifiable;
        }
        _Anonymous_63 extensions;
        uint32_t ext_hdr_init_id;
        void* ext_hdr_init_data;
        union _Anonymous_64
        {
            struct_array arr;
            mail_index_sync_lost_handler_t*** v;
            mail_index_sync_lost_handler_t*** v_modifiable;
        }
        _Anonymous_64 sync_lost_handlers;
        char* filepath;
        int fd;
        struct_mail_index_map* map;
        time_t last_mmap_error_time;
        uint32_t indexid;
        uint inconsistency_id;
        uint32_t last_read_log_file_seq;
        uint32_t last_read_log_file_tail_offset;
        uint32_t fsck_log_head_file_seq;
        int fsck_log_head_file_offset;
        struct_mail_index_transaction_commit_result* sync_commit_result;
        enum_file_lock_method lock_method;
        uint max_lock_timeout_secs;
        int keywords_pool;
        union_array__keywords keywords;
        int function(char*, void*) HASH_TABLE;
        uint32_t keywords_ext_id;
        uint32_t modseq_ext_id;
        struct_mail_index_view* views;
        union _Anonymous_65
        {
            struct_array arr;
            union_mail_index_module_context*** v;
            union_mail_index_module_context*** v_modifiable;
        }
        _Anonymous_65 module_contexts;
        char* error;
        int nodiskspace;
        int index_lock_timeout;
        int index_delete_requested;
        int index_deleted;
        int log_sync_locked;
        int readonly;
        int mapping;
        int syncing;
        int need_recreate;
        int index_min_write;
        int modseqs_enabled;
        int initial_create;
        int initial_mapped;
        int fscked;
    }
    struct struct_mail_transaction_ext_hdr_update
    {
        uint16_t offset;
        uint16_t size;
    }





    enum enum_mail_index_fsync_mask
    {
        MAIL_INDEX_FSYNC_MASK_APPENDS = 1,
        MAIL_INDEX_FSYNC_MASK_EXPUNGES = 2,
        MAIL_INDEX_FSYNC_MASK_FLAGS = 4,
        MAIL_INDEX_FSYNC_MASK_KEYWORDS = 8,
    }
    enum
    {
        MAIL_INDEX_FSYNC_MASK_APPENDS = 1,
        MAIL_INDEX_FSYNC_MASK_EXPUNGES = 2,
        MAIL_INDEX_FSYNC_MASK_FLAGS = 4,
        MAIL_INDEX_FSYNC_MASK_KEYWORDS = 8,
    }



    void mail_index_ext_using_reset_id(struct_mail_index_transaction*, uint32_t, uint32_t, );
    struct struct_mail_transaction_ext_hdr_update32
    {
        uint32_t offset;
        uint32_t size;
    }



    enum enum_mail_index_sync_flags
    {
        MAIL_INDEX_SYNC_FLAG_FLUSH_DIRTY = 1,
        MAIL_INDEX_SYNC_FLAG_DROP_RECENT = 2,
        MAIL_INDEX_SYNC_FLAG_AVOID_FLAG_UPDATES = 4,
        MAIL_INDEX_SYNC_FLAG_REQUIRE_CHANGES = 8,
        MAIL_INDEX_SYNC_FLAG_FSYNC = 16,
        MAIL_INDEX_SYNC_FLAG_DELETING_INDEX = 32,
        MAIL_INDEX_SYNC_FLAG_TRY_DELETING_INDEX = 64,
        MAIL_INDEX_SYNC_FLAG_UPDATE_TAIL_OFFSET = 128,
    }
    enum
    {
        MAIL_INDEX_SYNC_FLAG_FLUSH_DIRTY = 1,
        MAIL_INDEX_SYNC_FLAG_DROP_RECENT = 2,
        MAIL_INDEX_SYNC_FLAG_AVOID_FLAG_UPDATES = 4,
        MAIL_INDEX_SYNC_FLAG_REQUIRE_CHANGES = 8,
        MAIL_INDEX_SYNC_FLAG_FSYNC = 16,
        MAIL_INDEX_SYNC_FLAG_DELETING_INDEX = 32,
        MAIL_INDEX_SYNC_FLAG_TRY_DELETING_INDEX = 64,
        MAIL_INDEX_SYNC_FLAG_UPDATE_TAIL_OFFSET = 128,
    }
    struct struct_mail_transaction_ext_rec_update
    {
        uint32_t uid;
    }






    struct struct_mail_transaction_ext_atomic_inc
    {
        uint32_t uid;
        int32_t diff;
    }
    struct struct_mail_transaction_boundary
    {
        uint32_t size;
    }
    struct struct_mail_transaction_log_append_ctx
    {
        struct_mail_transaction_log* log;
        int* output;
        enum_mail_transaction_type trans_flags;
        uint64_t new_highest_modseq;
        uint transaction_count;
        int index_sync_transaction;
        int tail_offset_changed;
        int sync_includes_this;
        int want_fsync;
    }
    enum enum_mail_attribute_type
    {
        MAIL_ATTRIBUTE_TYPE_PRIVATE = 0,
        MAIL_ATTRIBUTE_TYPE_SHARED = 1,
    }
    enum
    {
        MAIL_ATTRIBUTE_TYPE_PRIVATE = 0,
        MAIL_ATTRIBUTE_TYPE_SHARED = 1,
    }
    enum enum_mailbox_transaction_flags
    {
        MAILBOX_TRANSACTION_FLAG_HIDE = 1,
        MAILBOX_TRANSACTION_FLAG_EXTERNAL = 2,
        MAILBOX_TRANSACTION_FLAG_ASSIGN_UIDS = 4,
        MAILBOX_TRANSACTION_FLAG_REFRESH = 8,
        MAILBOX_TRANSACTION_FLAG_NO_CACHE_DEC = 16,
        MAILBOX_TRANSACTION_FLAG_SYNC = 32,
        MAILBOX_TRANSACTION_FLAG_NO_NOTIFY = 64,
        MAILBOX_TRANSACTION_FLAG_FILL_IN_STUB = 128,
    }
    enum
    {
        MAILBOX_TRANSACTION_FLAG_HIDE = 1,
        MAILBOX_TRANSACTION_FLAG_EXTERNAL = 2,
        MAILBOX_TRANSACTION_FLAG_ASSIGN_UIDS = 4,
        MAILBOX_TRANSACTION_FLAG_REFRESH = 8,
        MAILBOX_TRANSACTION_FLAG_NO_CACHE_DEC = 16,
        MAILBOX_TRANSACTION_FLAG_SYNC = 32,
        MAILBOX_TRANSACTION_FLAG_NO_NOTIFY = 64,
        MAILBOX_TRANSACTION_FLAG_FILL_IN_STUB = 128,
    }




    enum enum_mail_attribute_value_flags
    {
        MAIL_ATTRIBUTE_VALUE_FLAG_READONLY = 1,
        MAIL_ATTRIBUTE_VALUE_FLAG_INT_STREAMS = 2,
    }
    enum
    {
        MAIL_ATTRIBUTE_VALUE_FLAG_READONLY = 1,
        MAIL_ATTRIBUTE_VALUE_FLAG_INT_STREAMS = 2,
    }
    struct struct_mail_attachment_part
    {
        struct_message_part* part;
        const(char)* content_type;
        const(char)* content_disposition;
    }
    enum enum_mail_index_view_sync_flags
    {
        MAIL_INDEX_VIEW_SYNC_FLAG_NOEXPUNGES = 1,
        MAIL_INDEX_VIEW_SYNC_FLAG_FIX_INCONSISTENT = 2,
    }
    enum
    {
        MAIL_INDEX_VIEW_SYNC_FLAG_NOEXPUNGES = 1,
        MAIL_INDEX_VIEW_SYNC_FLAG_FIX_INCONSISTENT = 2,
    }
    struct struct_virtual_mailbox_vfuncs
    {
        void function(struct_mailbox*, struct_mailbox*, const(union_array__seq_range)*, union_array__seq_range*) get_virtual_uids;
        void function(struct_mailbox*, struct_mailbox*, const(union_array__seq_range)*, union_array__uint32_t*) get_virtual_uid_map;
        void function(struct_mailbox*, union_array__mailboxes*, int) get_virtual_backend_boxes;
    }
    struct struct_mail_attribute_value
    {
        const(char)* value;
        struct_istream* value_stream;
        time_t last_change;
        enum_mail_attribute_value_flags flags;
    }






    enum _Anonymous_66
    {
        MSG_OOB = 1,
        MSG_PEEK = 2,
        MSG_DONTROUTE = 4,
        MSG_CTRUNC = 8,
        MSG_PROXY = 16,
        MSG_TRUNC = 32,
        MSG_DONTWAIT = 64,
        MSG_EOR = 128,
        MSG_WAITALL = 256,
        MSG_FIN = 512,
        MSG_SYN = 1024,
        MSG_CONFIRM = 2048,
        MSG_RST = 4096,
        MSG_ERRQUEUE = 8192,
        MSG_NOSIGNAL = 16384,
        MSG_MORE = 32768,
        MSG_WAITFORONE = 65536,
        MSG_BATCH = 262144,
        MSG_FASTOPEN = 536870912,
        MSG_CMSG_CLOEXEC = 1073741824,
    }
    struct struct_mail_index_sync_rec
    {
        int uid1;
        int uid2;
        enum_mail_index_sync_type type;
        int add_flags;
        int remove_flags;
        uint keyword_idx;
        guid_128_t guid_128;
    }
    struct_mail_transaction_log* mail_transaction_log_alloc(struct_mail_index*, );
    void mail_transaction_log_free(struct_mail_transaction_log**, );
    int stat(const(char)*, struct_stat*, );
    int mail_transaction_log_open(struct_mail_transaction_log*, );




    int fstat(int, struct_stat*, );
    int mail_transaction_log_create(struct_mail_transaction_log*, int, );
    struct struct_mailbox_vfuncs
    {
        int function(struct_mailbox*) function(int*) bool_;
        int function(struct_mailbox*, enum_mailbox_feature) enable;
        int function(struct_mailbox*, int, enum_mailbox_existence*) exists;
        int function(struct_mailbox*) open;
        void function(struct_mailbox*) close;
        void function(struct_mailbox*) free;
        int function(struct_mailbox*, const(struct_mailbox_update)*, int) create_box;
        int function(struct_mailbox*, const(struct_mailbox_update)*) update_box;
        int function(struct_mailbox*) delete_box;
        int function(struct_mailbox*, struct_mailbox*) rename_box;
        int function(struct_mailbox*, enum_mailbox_status_items, struct_mailbox_status*) get_status;
        int function(struct_mailbox*, enum_mailbox_metadata_items, struct_mailbox_metadata*) get_metadata;
        int function(struct_mailbox*, int) set_subscribed;
        int function(struct_mailbox_transaction_context*, enum_mail_attribute_type, const(char)*, const(struct_mail_attribute_value)*) attribute_set;
        int function(struct_mailbox*, enum_mail_attribute_type, const(char)*, struct_mail_attribute_value*) attribute_get;
        struct_mailbox_attribute_iter* function(struct_mailbox*, enum_mail_attribute_type, const(char)*) attribute_iter_init;
        const(char)* function(struct_mailbox_attribute_iter*) attribute_iter_next;
        int function(struct_mailbox_attribute_iter*) attribute_iter_deinit;
        int function(struct_mailbox*, struct_mail_index_view*, uint, int) list_index_has_changed;
        void function(struct_mailbox*, struct_mail_index_transaction*, uint) list_index_update_sync;
        struct_mailbox_sync_context* function(struct_mailbox*, enum_mailbox_sync_flags) sync_init;
        int function(struct_mailbox_sync_context*, struct_mailbox_sync_status*) sync_deinit;
        void function(struct_mailbox*, uint, enum_mailbox_sync_type) sync_notify;
        void function(struct_mailbox*) notify_changes;
        struct_mailbox_transaction_context* function(struct_mailbox*, enum_mailbox_transaction_flags, const(char)*) transaction_begin;
        int function(struct_mailbox_transaction_context*, struct_mail_transaction_commit_changes*) transaction_commit;
        void function(struct_mailbox_transaction_context*) transaction_rollback;
        enum_mail_flags function(struct_mailbox*) get_private_flags_mask;
        struct_mail* function(struct_mailbox_transaction_context*, enum_mail_fetch_field, struct_mailbox_header_lookup_ctx*) mail_alloc;
        struct_mail_search_context* function(struct_mailbox_transaction_context*, struct_mail_search_args*, const(const MailSortType)*, enum_mail_fetch_field, struct_mailbox_header_lookup_ctx*) search_init;
        int function(struct_mail_search_context*) search_deinit;
        struct_mail_save_context* function(struct_mailbox_transaction_context*) save_alloc;
        int function(struct_mail_save_context*, struct_istream*) save_begin;
        int function(struct_mail_save_context*) save_continue;
        int function(struct_mail_save_context*) save_finish;
        void function(struct_mail_save_context*) save_cancel;
        int function(struct_mail_save_context*, struct_mail*) copy;
        int function(struct_mail_save_context*) transaction_save_commit_pre;
        void function(struct_mail_save_context*, struct_mail_index_transaction_commit_result*) transaction_save_commit_post;
        void function(struct_mail_save_context*) transaction_save_rollback;
    }
    enum enum_mail_attribute_internal_rank
    {
        MAIL_ATTRIBUTE_INTERNAL_RANK_DEFAULT = 0,
        MAIL_ATTRIBUTE_INTERNAL_RANK_OVERRIDE = 1,
        MAIL_ATTRIBUTE_INTERNAL_RANK_AUTHORITY = 2,
    }
    enum
    {
        MAIL_ATTRIBUTE_INTERNAL_RANK_DEFAULT = 0,
        MAIL_ATTRIBUTE_INTERNAL_RANK_OVERRIDE = 1,
        MAIL_ATTRIBUTE_INTERNAL_RANK_AUTHORITY = 2,
    }
    enum enum_mailbox_sync_flags
    {
        MAILBOX_SYNC_FLAG_FULL_READ = 1,
        MAILBOX_SYNC_FLAG_FULL_WRITE = 2,
        MAILBOX_SYNC_FLAG_FAST = 4,
        MAILBOX_SYNC_FLAG_NO_EXPUNGES = 8,
        MAILBOX_SYNC_FLAG_FIX_INCONSISTENT = 64,
        MAILBOX_SYNC_FLAG_EXPUNGE = 128,
        MAILBOX_SYNC_FLAG_FORCE_RESYNC = 256,
        MAILBOX_SYNC_FLAG_OPTIMIZE = 1024,
    }
    enum
    {
        MAILBOX_SYNC_FLAG_FULL_READ = 1,
        MAILBOX_SYNC_FLAG_FULL_WRITE = 2,
        MAILBOX_SYNC_FLAG_FAST = 4,
        MAILBOX_SYNC_FLAG_NO_EXPUNGES = 8,
        MAILBOX_SYNC_FLAG_FIX_INCONSISTENT = 64,
        MAILBOX_SYNC_FLAG_EXPUNGE = 128,
        MAILBOX_SYNC_FLAG_FORCE_RESYNC = 256,
        MAILBOX_SYNC_FLAG_OPTIMIZE = 1024,
    }
    void mail_transaction_log_close(struct_mail_transaction_log*, );
    enum enum_mail_index_view_sync_type
    {
        MAIL_INDEX_VIEW_SYNC_TYPE_FLAGS = 1,
        MAIL_INDEX_VIEW_SYNC_TYPE_MODSEQ = 2,
    }
    enum
    {
        MAIL_INDEX_VIEW_SYNC_TYPE_FLAGS = 1,
        MAIL_INDEX_VIEW_SYNC_TYPE_MODSEQ = 2,
    }
    void mail_transaction_log_indexid_changed(struct_mail_transaction_log*, );



    struct struct_mail_index_view_sync_rec
    {
        int uid1;
        int uid2;
        enum_mail_index_view_sync_type type;
        int hidden;
    }
    void mail_transaction_log_get_mailbox_sync_pos(struct_mail_transaction_log*, uint32_t*, int*, );



    void mail_transaction_log_set_mailbox_sync_pos(struct_mail_transaction_log*, uint32_t, int, );
    enum enum_mail_index_transaction_change
    {
        MAIL_INDEX_TRANSACTION_CHANGE_APPEND = 0,
        MAIL_INDEX_TRANSACTION_CHANGE_EXPUNGE = 1,
        MAIL_INDEX_TRANSACTION_CHANGE_FLAGS = 2,
        MAIL_INDEX_TRANSACTION_CHANGE_KEYWORDS = 3,
        MAIL_INDEX_TRANSACTION_CHANGE_MODSEQ = 4,
        MAIL_INDEX_TRANSACTION_CHANGE_ATTRIBUTE = 5,
        MAIL_INDEX_TRANSACTION_CHANGE_OTHERS = 6,
    }
    enum
    {
        MAIL_INDEX_TRANSACTION_CHANGE_APPEND = 0,
        MAIL_INDEX_TRANSACTION_CHANGE_EXPUNGE = 1,
        MAIL_INDEX_TRANSACTION_CHANGE_FLAGS = 2,
        MAIL_INDEX_TRANSACTION_CHANGE_KEYWORDS = 3,
        MAIL_INDEX_TRANSACTION_CHANGE_MODSEQ = 4,
        MAIL_INDEX_TRANSACTION_CHANGE_ATTRIBUTE = 5,
        MAIL_INDEX_TRANSACTION_CHANGE_OTHERS = 6,
    }
    struct_mail_transaction_log_view* mail_transaction_log_view_open(struct_mail_transaction_log*, );
    enum enum_mailbox_sync_type
    {
        MAILBOX_SYNC_TYPE_EXPUNGE = 1,
        MAILBOX_SYNC_TYPE_FLAGS = 2,
        MAILBOX_SYNC_TYPE_MODSEQ = 4,
    }
    enum
    {
        MAILBOX_SYNC_TYPE_EXPUNGE = 1,
        MAILBOX_SYNC_TYPE_FLAGS = 2,
        MAILBOX_SYNC_TYPE_MODSEQ = 4,
    }
    void mail_transaction_log_view_close(struct_mail_transaction_log_view**, );
    int fstatat(int, const(char)*, struct_stat*, int, );
    enum enum_mail_attribute_internal_flags
    {
        MAIL_ATTRIBUTE_INTERNAL_FLAG_CHILDREN = 1,
    }
    enum
    {
        MAIL_ATTRIBUTE_INTERNAL_FLAG_CHILDREN = 1,
    }



    extern __gshared struct_mail_index_module_register mail_index_module_register;
    struct struct_message_part;
    extern __gshared struct_event_category event_category_index;
    struct struct_event_category;
    int mail_transaction_log_view_set(struct_mail_transaction_log_view*, uint32_t, int, uint32_t, int, int*, const(char)**, );
    struct struct_mail_index_transaction_commit_result
    {
        int log_file_seq;
        int log_file_offset;
        int commit_size;
        enum_mail_index_transaction_change changes_mask;
        uint ignored_modseq_changes;
    }
    struct struct_mailbox_attribute_internal
    {
        enum_mail_attribute_type type;
        const(char)* key;
        enum_mail_attribute_internal_rank rank;
        enum_mail_attribute_internal_flags flags;
        int function(struct_mailbox*, const(char)*, struct_mail_attribute_value*) get;
        int function(struct_mailbox_transaction_context*, const(char)*, const(struct_mail_attribute_value)*) set;
    }
    struct struct_mail_search_args;
    void mail_index_register_expunge_handler(struct_mail_index*, uint32_t, int, mail_index_expunge_handler_t*, void*, );
    struct struct_mail_search_result;
    int mail_transaction_log_view_set_all(struct_mail_transaction_log_view*, );
    void mail_index_unregister_expunge_handler(struct_mail_index*, uint32_t, );




    void mail_index_register_sync_handler(struct_mail_index*, uint32_t, mail_index_sync_handler_t*, enum_mail_index_sync_handler_type, );
    void mail_transaction_log_view_clear(struct_mail_transaction_log_view*, uint32_t, );
    struct struct_mailbox_status
    {
        uint32_t messages;
        uint32_t recent;
        uint32_t unseen;
        uint32_t uidvalidity;
        uint32_t uidnext;
        uint32_t first_unseen_seq;
        uint32_t first_recent_uid;
        uint32_t last_cached_seq;
        uint64_t highest_modseq;
        uint64_t highest_pvt_modseq;
        const union_array__keywords* keywords;
        enum_mail_flags permanent_flags;
        enum_mail_flags flags;
        int permanent_keywords;
        int allow_new_keywords;
        int nonpermanent_modseqs;
        int no_modseq_tracking;
        int have_guids;
        int have_save_guids;
        int have_only_guid128;
    }
    void mail_index_unregister_sync_handler(struct_mail_index*, uint32_t, );




    struct struct_mail_index_base_optimization_settings
    {
        int rewrite_min_log_bytes;
        int rewrite_max_log_bytes;
    }
    int mail_transaction_log_view_next(struct_mail_transaction_log_view*, const struct_mail_transaction_header**, const(void)**, );
    void mail_index_register_sync_lost_handler(struct_mail_index*, mail_index_sync_lost_handler_t*, );
    void mailbox_attribute_register_internal(const struct_mailbox_attribute_internal*, );
    void mail_index_unregister_sync_lost_handler(struct_mail_index*, mail_index_sync_lost_handler_t*, );
    void mailbox_attribute_register_internals(const struct_mailbox_attribute_internal*, uint, );
    void* array_idx_get_space_i(struct_array*, uint, );




    void mail_transaction_log_view_mark(struct_mail_transaction_log_view*, );
    int mail_index_create_tmp_file(struct_mail_index*, const(char)*, const(char)**, );
    struct struct_mail_index_log_optimization_settings
    {
        int min_size;
        int max_size;
        uint min_age_secs;
        uint log2_max_age_secs;
    }
    int lstat(const(char)*, struct_stat*, );
    void mailbox_attribute_unregister_internal(const struct_mailbox_attribute_internal*, );
    void mail_transaction_log_view_rewind(struct_mail_transaction_log_view*, );
    int mail_index_try_open_only(struct_mail_index*, );
    void mailbox_attribute_unregister_internals(const struct_mailbox_attribute_internal*, uint, );
    void array_idx_set_i(struct_array*, uint, const(void)*, );




    void mail_index_close_file(struct_mail_index*, );
    int mail_index_reopen_if_changed(struct_mail_index*, const(char)**, );
    void mail_transaction_log_view_get_prev_pos(struct_mail_transaction_log_view*, uint32_t*, int*, );
    void array_idx_clear_i(struct_array*, uint, );
    void mail_index_write(struct_mail_index*, int, );



    void mail_index_flush_read_cache(struct_mail_index*, const(char)*, int, int, );
    uint64_t mail_transaction_log_view_get_prev_modseq(struct_mail_transaction_log_view*, );
    void* array_append_space_i(struct_array*, );
    int mailbox_attribute_set(struct_mailbox_transaction_context*, enum_mail_attribute_type, const(char)*, const struct_mail_attribute_value*, );
    int mail_index_lock_fd(struct_mail_index*, const(char)*, int, int, uint, struct_file_lock**, );
    struct struct_mail_index_cache_optimization_settings
    {
        uint unaccessed_field_drop_secs;
        uint record_max_size;
        int compress_min_size;
        uint compress_delete_percentage;
        uint compress_continued_percentage;
        uint compress_header_continue_count;
    }
    int mail_transaction_log_view_is_last();
    int mailbox_attribute_unset(struct_mailbox_transaction_context*, enum_mail_attribute_type, const(char)*, );
    struct_mail_index_map* mail_index_map_alloc(struct_mail_index*, );



    int mail_transaction_log_view_is_corrupted();
    int mailbox_attribute_get(struct_mailbox*, enum_mail_attribute_type, const(char)*, struct_mail_attribute_value*, );
    int chmod(const(char)*, __mode_t, );



    int mail_transaction_log_append_begin(struct_mail_index*, enum_mail_transaction_type, struct_mail_transaction_log_append_ctx**, );
    void* array_insert_space_i(struct_array*, uint, );
    int mail_index_map(struct_mail_index*, enum_mail_index_sync_handler_type, );




    int mailbox_attribute_get_stream(struct_mailbox*, enum_mail_attribute_type, const(char)*, struct_mail_attribute_value*, );
    void mail_transaction_log_append_add(struct_mail_transaction_log_append_ctx*, enum_mail_transaction_type, const(void)*, int, );
    int lchmod(const(char)*, __mode_t, );
    void mail_index_unmap(struct_mail_index_map**, );
    int mail_transaction_log_append_commit(struct_mail_transaction_log_append_ctx**, );
    void array_copy(struct_array*, uint, const struct_array*, uint, uint, );
    struct_mail_index_map* mail_index_map_clone(const struct_mail_index_map*, );
    struct struct_mail_index_optimization_settings
    {
        struct_mail_index_base_optimization_settings index;
        struct_mail_index_log_optimization_settings log;
        struct_mail_index_cache_optimization_settings cache;
    }
    struct struct_mailbox_cache_field
    {
        const(char)* name;
        int decision;
        time_t last_used;
    }
    struct_mailbox_attribute_iter* mailbox_attribute_iter_init(struct_mailbox*, enum_mail_attribute_type, const(char)*, );
    void mail_index_record_map_move_to_private(struct_mail_index_map*, );
    int mail_transaction_log_sync_lock(struct_mail_transaction_log*, const(char)*, uint32_t*, int*, );
    void mail_index_map_move_to_memory(struct_mail_index_map*, );
    int fchmod(int, __mode_t, );
    void mail_index_fchown(struct_mail_index*, int, const(char)*, );
    void mail_transaction_log_sync_unlock(struct_mail_transaction_log*, const(char)*, );
    const(char)* mailbox_attribute_iter_next(struct_mailbox_attribute_iter*, );
    int mailbox_attribute_iter_deinit(struct_mailbox_attribute_iter**, );
    union union_array__mailbox_cache_field
    {
        struct_array arr;
        const(const struct_mailbox_cache_field*)* v;
        struct_mailbox_cache_field** v_modifiable;
    }
    int mail_index_map_lookup_ext();
    uint32_t mail_index_map_register_ext(struct_mail_index_map*, const(char)*, uint32_t, const struct_mail_index_ext_header*, );
    struct struct_mailbox_metadata
    {
        guid_128_t guid;
        uint64_t virtual_size;
        uint64_t physical_size;
        time_t first_save_date;
        const union_array__mailbox_cache_field* cache_fields;
        enum_mail_fetch_field precache_fields;
        const(char)* backend_ns_prefix;
        enum_mail_namespace_type backend_ns_type;
    }
    void mail_transaction_log_get_head(struct_mail_transaction_log*, uint32_t*, int*, );
    int fchmodat(int, const(char)*, __mode_t, int, );
    struct struct_mail_index_sync_ctx;
    struct struct_mail_index_view_sync_ctx;
    void mail_transaction_log_get_tail(struct_mail_transaction_log*, uint32_t*, );
    int mail_index_map_get_ext_idx();
    struct_mail_index* mail_index_alloc(struct_event*, const(char)*, const(char)*, );
    const struct_mail_index_ext* mail_index_view_get_ext(struct_mail_index_view*, uint32_t, );
    void array_swap_i(struct_array*, struct_array*, );
    int mail_transaction_log_is_head_prev();
    void mail_index_free(struct_mail_index**, );
    void mail_index_map_lookup_seq_range(struct_mail_index_map*, uint32_t, uint32_t, uint32_t*, uint32_t*, );
    void mail_index_set_cache_dir(struct_mail_index*, const(char)*, );
    __mode_t umask(__mode_t, );
    int mail_transaction_log_move_to_memory(struct_mail_transaction_log*, );
    void mail_index_set_fsync_mode(struct_mail_index*, enum_fsync_mode, enum_mail_index_fsync_mask, );
    int mail_transaction_log_unlink(struct_mail_transaction_log*, );




    int mail_index_map_check_header(struct_mail_index_map*, const(char)**, );
    int mail_index_use_existing_permissions();
    void mail_index_set_permissions(struct_mail_index*, mode_t, gid_t, const(char)*, );
    int mkdir(const(char)*, __mode_t, );
    union union_mailbox_module_context
    {
        struct_mailbox_vfuncs super_;
        struct_mail_storage_module_register* reg;
    }
    int mail_index_check_header_compat();
    struct struct_mailbox_update
    {
        guid_128_t mailbox_guid;
        uint32_t uid_validity;
        uint32_t min_next_uid;
        uint32_t min_first_recent_uid;
        uint64_t min_highest_modseq;
        uint64_t min_highest_pvt_modseq;
        const struct_mailbox_cache_field* cache_updates;
    }



    void mail_index_set_lock_method(struct_mail_index*, enum_file_lock_method, uint, );
    int mail_index_map_parse_extensions(struct_mail_index_map*, );
    int mail_index_map_parse_keywords(struct_mail_index_map*, );
    struct struct_mail_msgpart_partial_cache
    {
        uint32_t uid;
        int physical_start;
        int physical_pos;
        int virtual_pos;
    }
    int mkdirat(int, const(char)*, __mode_t, );
    void mail_index_map_init_extbufs(struct_mail_index_map*, uint, );
    enum _Anonymous_67
    {
        SCM_RIGHTS = 1,
    }
    void mail_index_set_optimization_settings(struct_mail_index*, const struct_mail_index_optimization_settings*, );
    int mail_index_map_ext_get_next(struct_mail_index_map*, uint*, const struct_mail_index_ext_header**, const(char)**, );
    void mail_index_set_ext_init_data(struct_mail_index*, int, const(void)*, int, );
    struct struct_mailbox_index_vsize
    {
        uint64_t vsize;
        uint32_t highest_uid;
        uint32_t message_count;
    }
    int mail_index_map_ext_hdr_check(const struct_mail_index_header*, const struct_mail_index_ext_header*, const(char)*, const(char)**, );
    struct struct_mail_transaction_commit_changes
    {
        int pool;
        uint32_t uid_validity;
        union_array__seq_range saved_uids;
        uint ignored_modseq_changes;
        enum_mail_index_transaction_change changes_mask;
        int no_read_perm;
    }
    int mknod(const(char)*, __mode_t, __dev_t, );
    uint mail_index_map_ext_hdr_offset(uint, );
    int mail_index_open(struct_mail_index*, enum_mail_index_open_flags, );
    void mail_index_view_transaction_ref(struct_mail_index_view*, );
    struct struct_mailbox_index_pop3_uidl
    {
        uint32_t max_uid_with_pop3_uidl;
    }
    void mail_index_view_transaction_unref(struct_mail_index_view*, );
    int mail_index_open_or_create(struct_mail_index*, enum_mail_index_open_flags, );
    void mail_index_fsck_locked(struct_mail_index*, );
    int mknodat(int, const(char)*, __mode_t, __dev_t, );
    void mail_index_close(struct_mail_index*, );
    struct struct_mailbox_index_first_saved
    {
        uint32_t uid;
        uint32_t timestamp;
    }
    int mail_index_unlink(struct_mail_index*, );
    int mail_index_is_in_memory();
    int mkfifo(const(char)*, __mode_t, );
    int mail_index_move_to_memory(struct_mail_index*, );
    void mail_index_set_error_nolog(struct_mail_index*, const(char)*, );
    void mail_index_set_syscall_error(struct_mail_index*, const(char)*, );
    struct struct_mail_cache;
    struct_mail_cache* mail_index_get_cache(struct_mail_index*, );
    void mail_index_file_set_syscall_error(struct_mail_index*, const(char)*, const(char)*, );
    struct struct_mailbox_sync_rec
    {
        uint32_t seq1;
        uint32_t seq2;
        enum_mailbox_sync_type type;
    }
    void array_reverse_i(struct_array*, );
    int mkfifoat(int, const(char)*, __mode_t, );



    struct struct_mailbox_sync_status
    {
        int sync_delayed_expunges;
    }
    void array_sort_i(struct_array*, int function(const(void)*, const(void)*), );






    struct_mail_index_view* mail_index_view_open(struct_mail_index*, const(char)*, uint, );
    int utimensat(int, const(char)*, const struct_timespec*, int, );
    struct struct_mailbox_expunge_rec
    {
        uint32_t uid;
        guid_128_t guid_128;
    }



    void* array_bsearch_i(struct_array*, const(void)*, int function(const(void)*, const(void)*), );
    void mail_index_view_close(struct_mail_index_view**, );






    struct_mail_index* mail_index_view_get_index(struct_mail_index_view*, );
    int futimens(int, const struct_timespec*, );
    union union_array__mailbox_expunge_rec
    {
        struct_array arr;
        const(const struct_mailbox_expunge_rec*)* v;
        struct_mailbox_expunge_rec** v_modifiable;
    }
    int mail_index_view_get_messages_count();
    enum enum_mail_lookup_abort
    {
        MAIL_LOOKUP_ABORT_NEVER = 0,
        MAIL_LOOKUP_ABORT_READ_MAIL = 1,
        MAIL_LOOKUP_ABORT_NOT_IN_CACHE = 2,
    }
    enum
    {
        MAIL_LOOKUP_ABORT_NEVER = 0,
        MAIL_LOOKUP_ABORT_READ_MAIL = 1,
        MAIL_LOOKUP_ABORT_NOT_IN_CACHE = 2,
    }
    int mail_index_view_is_inconsistent();
    uint mail_index_view_get_transaction_count(struct_mail_index_view*, );
    const(void)* array_lsearch_i(const struct_array*, const(void)*, int function(const(void)*, const(void)*), );
    void* array_lsearch_modifiable_i(struct_array*, const(void)*, int function(const(void)*, const(void)*), );
    struct_mail_index_transaction* mail_index_transaction_begin(struct_mail_index_view*, enum_mail_index_transaction_flags, );
    enum enum_mail_access_type
    {
        MAIL_ACCESS_TYPE_DEFAULT = 0,
        MAIL_ACCESS_TYPE_SEARCH = 1,
        MAIL_ACCESS_TYPE_SORT = 2,
    }
    enum
    {
        MAIL_ACCESS_TYPE_DEFAULT = 0,
        MAIL_ACCESS_TYPE_SEARCH = 1,
        MAIL_ACCESS_TYPE_SORT = 2,
    }
    int mail_index_transaction_commit(struct_mail_index_transaction**, );
    int mail_index_transaction_commit_full(struct_mail_index_transaction**, struct_mail_index_transaction_commit_result*, );
    void mail_index_transaction_rollback(struct_mail_index_transaction**, );



    void mail_index_transaction_reset(struct_mail_index_transaction*, );





    void mail_index_transaction_set_max_modseq(struct_mail_index_transaction*, int, union_array__seq_range*, );
    int __fxstat(int, int, struct_stat*, );
    int __xstat(int, const(char)*, struct_stat*, );
    int __lxstat(int, const(char)*, struct_stat*, );
    int mail_index_transaction_get_highest_modseq();
    int __fxstatat(int, int, const(char)*, struct_stat*, int, );
    struct_mail_index_view* mail_index_transaction_get_view(struct_mail_index_transaction*, );
    int mail_index_transaction_is_expunged();
    struct_mail_index_view* mail_index_transaction_open_updated_view(struct_mail_index_transaction*, );
    struct struct_mailbox_virtual_pattern
    {
        struct_mail_namespace* ns;
        const(char)* pattern;
    }
    union union_array__mailbox_virtual_patterns
    {
        struct_array arr;
        const(const struct_mailbox_virtual_pattern*)* v;
        struct_mailbox_virtual_pattern** v_modifiable;
    }
    union union_array__mail_storage
    {
        struct_array arr;
        struct_mail_storage*** v;
        struct_mail_storage*** v_modifiable;
    }
    union union_array__mailboxes
    {
        struct_array arr;
        struct_mailbox*** v;
        struct_mailbox*** v_modifiable;
    }
    extern __gshared union_array__mail_storage mail_storage_classes;
    int mail_index_sync_begin(struct_mail_index*, struct_mail_index_sync_ctx**, struct_mail_index_view**, struct_mail_index_transaction**, enum_mail_index_sync_flags, );
    int __xmknod(int, const(char)*, __mode_t, __dev_t*, );
    alias mailbox_notify_callback_t = box;
    void mail_storage_init();
    int __xmknodat(int, int, const(char)*, __mode_t, __dev_t*, );
    void mail_storage_deinit();
    void mail_storage_register_all();
    int mail_index_sync_begin_to(struct_mail_index*, struct_mail_index_sync_ctx**, struct_mail_index_view**, struct_mail_index_transaction**, int, int, enum_mail_index_sync_flags, );
    void mail_storage_class_register(struct_mail_storage*, );
    void mail_storage_class_unregister(struct_mail_storage*, );
    struct_mail_storage* mail_storage_find_class(const(char)*, );
    int mail_index_sync_have_any();
    int mail_index_sync_have_any_expunges();
    void mail_index_sync_get_offsets(struct_mail_index_sync_ctx*, int*, int*, int*, int*, );
    int mail_index_sync_next();
    void mail_storage_unref(struct_mail_storage**, );
    int mail_index_sync_have_more();
    struct struct_mail_vfuncs
    {
        void function(struct_mail*) close;
        void function(struct_mail*) free;
        void function(struct_mail*, uint, int) set_seq;
        int function(struct_mail*, uint32_t) function(int*) bool_;
        void function(struct_mail*, int) set_uid_cache_updates;
        void function(struct_mail*) precache;
        void function(struct_mail*, enum_mail_fetch_field, struct_mailbox_header_lookup_ctx*) add_temp_wanted_fields;
        enum_mail_flags function(struct_mail*) get_flags;
        const(const(char)*)* function(struct_mail*) get_keywords;
        const(union_array__keyword_indexes)* function(struct_mail*) get_keyword_indexes;
        c_ulong function(struct_mail*) get_modseq;
        c_ulong function(struct_mail*) get_pvt_modseq;
        int function(struct_mail*, struct_message_part**) get_parts;
        int function(struct_mail*, c_long*, int*) get_date;
        int function(struct_mail*, c_long*) get_received_date;
        int function(struct_mail*, c_long*) get_save_date;
        int function(struct_mail*, int*) get_virtual_size;
        int function(struct_mail*, int*) get_physical_size;
        int function(struct_mail*, const(char)*, int, const(char)**) get_first_header;
        int function(struct_mail*, const(char)*, int, const(const(char)*)**) get_headers;
        int function(struct_mail*, struct_mailbox_header_lookup_ctx*, struct_istream**) get_header_stream;
        int function(struct_mail*, int, struct_message_size*, struct_message_size*, struct_istream**) get_stream;
        int function(struct_mail*, const(struct_message_part)*, int, int*, uint*, int*, struct_istream**) get_binary_stream;
        int function(struct_mail*, enum_mail_fetch_field, const(char)**) get_special;
        int function(struct_mail*, struct_mail**) get_backend_mail;
        void function(struct_mail*, enum_modify_type, enum_mail_flags) update_flags;
        void function(struct_mail*, enum_modify_type, struct_mail_keywords*) update_keywords;
        void function(struct_mail*, c_ulong) update_modseq;
        void function(struct_mail*, c_ulong) update_pvt_modseq;
        void function(struct_mail*, const(char)*) update_pop3_uidl;
        void function(struct_mail*) expunge;
        void function(struct_mail*, enum_mail_fetch_field, const(char)*) set_cache_corrupted;
        int function(struct_mail*, struct_istream**) istream_opened;
    }
    int mail_index_sync_has_expunges();
    void mail_index_sync_reset(struct_mail_index_sync_ctx*, );
    void mail_index_sync_set_commit_result(struct_mail_index_sync_ctx*, struct_mail_index_transaction_commit_result*, );
    void mail_index_sync_no_warning(struct_mail_index_sync_ctx*, );
    int mail_storage_purge(struct_mail_storage*, );
    void mail_index_sync_set_reason(struct_mail_index_sync_ctx*, const(char)*, );
    int mail_index_sync_commit(struct_mail_index_sync_ctx**, );
    void mail_index_sync_rollback(struct_mail_index_sync_ctx**, );
    enum_mail_error mailbox_get_last_mail_error(struct_mailbox*, );
    void mail_index_mark_corrupted(struct_mail_index*, );
    int mail_index_fsck(struct_mail_index*, );
    int mail_index_reset_fscked();
    void mail_storage_last_error_push(struct_mail_storage*, );
    struct_mail_index_view_sync_ctx* mail_index_view_sync_begin(struct_mail_index_view*, enum_mail_index_view_sync_flags, );
    void mail_storage_last_error_pop(struct_mail_storage*, );
    int mail_index_view_sync_next();
    void mail_index_view_sync_get_expunges(struct_mail_index_view_sync_ctx*, const union_array__seq_range**, );
    int mail_index_view_sync_commit(struct_mail_index_view_sync_ctx**, int*, );
    struct_mailbox* mailbox_alloc(struct_mailbox_list*, const(char)*, enum_mailbox_flags, );
    struct_mailbox* mailbox_alloc_guid(struct_mailbox_list*, const(const guid_128_t), enum_mailbox_flags, );
    const struct_mail_index_header* mail_index_get_header(struct_mail_index_view*, );
    const struct_mail_index_record* mail_index_lookup(struct_mail_index_view*, int, );
    struct_mailbox* mailbox_alloc_delivery(struct_mail_user*, const(char)*, enum_mailbox_flags, );
    const struct_mail_index_record* mail_index_lookup_full(struct_mail_index_view*, int, struct_mail_index_map**, );
    int mail_index_is_expunged();
    void mailbox_set_reason(struct_mailbox*, const(char)*, );
    void mail_index_lookup_keywords(struct_mail_index_view*, int, union_array__keyword_indexes*, );
    int mailbox_exists(struct_mailbox*, int, enum_mailbox_existence*, );
    void mail_index_map_lookup_keywords(struct_mail_index_map*, int, union_array__keyword_indexes*, );
    union union_mail_module_context
    {
        struct_mail_vfuncs super_;
        struct_mail_module_register* reg;
    }
    int mailbox_open(struct_mailbox*, );
    enum _Anonymous_68
    {
        _CS_PATH = 0,
        _CS_V6_WIDTH_RESTRICTED_ENVS = 1,
        _CS_GNU_LIBC_VERSION = 2,
        _CS_GNU_LIBPTHREAD_VERSION = 3,
        _CS_V5_WIDTH_RESTRICTED_ENVS = 4,
        _CS_V7_WIDTH_RESTRICTED_ENVS = 5,
        _CS_LFS_CFLAGS = 1000,
        _CS_LFS_LDFLAGS = 1001,
        _CS_LFS_LIBS = 1002,
        _CS_LFS_LINTFLAGS = 1003,
        _CS_LFS64_CFLAGS = 1004,
        _CS_LFS64_LDFLAGS = 1005,
        _CS_LFS64_LIBS = 1006,
        _CS_LFS64_LINTFLAGS = 1007,
        _CS_XBS5_ILP32_OFF32_CFLAGS = 1100,
        _CS_XBS5_ILP32_OFF32_LDFLAGS = 1101,
        _CS_XBS5_ILP32_OFF32_LIBS = 1102,
        _CS_XBS5_ILP32_OFF32_LINTFLAGS = 1103,
        _CS_XBS5_ILP32_OFFBIG_CFLAGS = 1104,
        _CS_XBS5_ILP32_OFFBIG_LDFLAGS = 1105,
        _CS_XBS5_ILP32_OFFBIG_LIBS = 1106,
        _CS_XBS5_ILP32_OFFBIG_LINTFLAGS = 1107,
        _CS_XBS5_LP64_OFF64_CFLAGS = 1108,
        _CS_XBS5_LP64_OFF64_LDFLAGS = 1109,
        _CS_XBS5_LP64_OFF64_LIBS = 1110,
        _CS_XBS5_LP64_OFF64_LINTFLAGS = 1111,
        _CS_XBS5_LPBIG_OFFBIG_CFLAGS = 1112,
        _CS_XBS5_LPBIG_OFFBIG_LDFLAGS = 1113,
        _CS_XBS5_LPBIG_OFFBIG_LIBS = 1114,
        _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS = 1115,
        _CS_POSIX_V6_ILP32_OFF32_CFLAGS = 1116,
        _CS_POSIX_V6_ILP32_OFF32_LDFLAGS = 1117,
        _CS_POSIX_V6_ILP32_OFF32_LIBS = 1118,
        _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS = 1119,
        _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS = 1120,
        _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS = 1121,
        _CS_POSIX_V6_ILP32_OFFBIG_LIBS = 1122,
        _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS = 1123,
        _CS_POSIX_V6_LP64_OFF64_CFLAGS = 1124,
        _CS_POSIX_V6_LP64_OFF64_LDFLAGS = 1125,
        _CS_POSIX_V6_LP64_OFF64_LIBS = 1126,
        _CS_POSIX_V6_LP64_OFF64_LINTFLAGS = 1127,
        _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS = 1128,
        _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS = 1129,
        _CS_POSIX_V6_LPBIG_OFFBIG_LIBS = 1130,
        _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS = 1131,
        _CS_POSIX_V7_ILP32_OFF32_CFLAGS = 1132,
        _CS_POSIX_V7_ILP32_OFF32_LDFLAGS = 1133,
        _CS_POSIX_V7_ILP32_OFF32_LIBS = 1134,
        _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS = 1135,
        _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS = 1136,
        _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS = 1137,
        _CS_POSIX_V7_ILP32_OFFBIG_LIBS = 1138,
        _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS = 1139,
        _CS_POSIX_V7_LP64_OFF64_CFLAGS = 1140,
        _CS_POSIX_V7_LP64_OFF64_LDFLAGS = 1141,
        _CS_POSIX_V7_LP64_OFF64_LIBS = 1142,
        _CS_POSIX_V7_LP64_OFF64_LINTFLAGS = 1143,
        _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS = 1144,
        _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS = 1145,
        _CS_POSIX_V7_LPBIG_OFFBIG_LIBS = 1146,
        _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS = 1147,
        _CS_V6_ENV = 1148,
        _CS_V7_ENV = 1149,
    }
    void mail_index_lookup_view_flags(struct_mail_index_view*, int, enum_mail_flags*, union_array__keyword_indexes*, );
    int mailbox_open_stream(struct_mailbox*, struct_istream*, );
    struct struct_mail_private
    {
        struct_mail mail;
        struct_mail_vfuncs v;
        struct_mail_vfuncs* vlast;
        struct_mail* vmail;
        uint32_t seq_pvt;
        enum_mail_fetch_field wanted_fields;
        struct_mailbox_header_lookup_ctx* wanted_headers;
        int pool;
        int data_pool;
        union _Anonymous_69
        {
            struct_array arr;
            union_mail_module_context*** v;
            union_mail_module_context*** v_modifiable;
        }
        _Anonymous_69 module_contexts;
        const(char)* get_stream_reason;
        int autoexpunged;
    }
    void mailbox_close(struct_mailbox*, );
    void mailbox_free(struct_mailbox**, );
    void mail_index_lookup_uid(struct_mail_index_view*, int, int*, );
    int mail_index_lookup_seq_range();
    int mailbox_is_any_inbox();
    int mail_index_lookup_seq();
    void mailbox_skip_create_name_restrictions(struct_mailbox*, int, );
    void mail_index_lookup_first(struct_mail_index_view*, enum_mail_flags, int, int*, );
    int mailbox_verify_create_name(struct_mailbox*, );
    void mail_index_append(struct_mail_index_transaction*, int, int*, );
    struct struct_mailbox_list_context
    {
        struct_mail_storage* storage;
        enum_mailbox_list_flags flags;
        int failed;
    }
    void mail_index_append_finish_uids(struct_mail_index_transaction*, int, union_array__seq_range*, );
    int mailbox_update(struct_mailbox*, const struct_mailbox_update*, );
    union union_mailbox_transaction_module_context
    {
        struct_mail_storage_module_register* reg;
    }
    int mailbox_delete(struct_mailbox*, );
    void mail_index_expunge(struct_mail_index_transaction*, int, );
    struct struct_mailbox_transaction_stats
    {
        c_ulong open_lookup_count;
        c_ulong stat_lookup_count;
        c_ulong fstat_lookup_count;
        c_ulong files_read_count;
        ulong files_read_bytes;
        c_ulong cache_hit_count;
    }
    int mailbox_delete_empty(struct_mailbox*, );
    void mail_index_expunge_guid(struct_mail_index_transaction*, int, const(const guid_128_t), );
    void mail_index_revert_changes(struct_mail_index_transaction*, int, );
    int mailbox_rename(struct_mailbox*, struct_mailbox*, );
    void mail_index_update_flags(struct_mail_index_transaction*, int, enum_modify_type, enum_mail_flags, );
    int mailbox_set_subscribed(struct_mailbox*, int, );
    void mail_index_update_flags_range(struct_mail_index_transaction*, int, int, enum_modify_type, enum_mail_flags, );
    int mailbox_is_subscribed();
    struct struct_mail_save_private_changes
    {
        uint mailnum;
        enum_mail_flags flags;
    }
    int mailbox_enable(struct_mailbox*, enum_mailbox_feature, );
    void mail_index_attribute_set(struct_mail_index_transaction*, int, const(char)*, int, int, );
    struct struct_mailbox_transaction_context
    {
        struct_mailbox* box;
        enum_mailbox_transaction_flags flags;
        char* reason;
        union_mail_index_transaction_module_context module_ctx;
        struct_mail_index_transaction_vfuncs super_;
        int mail_ref_count;
        struct_mail_index_transaction* itrans;
        struct_dict_transaction_context* attr_pvt_trans;
        struct_dict_transaction_context* attr_shared_trans;
        struct_mail_index_view* view;
        struct_mail_index_transaction* itrans_pvt;
        struct_mail_index_view* view_pvt;
        struct_mail_cache_view* cache_view;
        struct_mail_cache_transaction_ctx* cache_trans;
        struct_mail_transaction_commit_changes* changes;
        union _Anonymous_70
        {
            struct_array arr;
            union_mailbox_transaction_module_context*** v;
            union_mailbox_transaction_module_context*** v_modifiable;
        }
        _Anonymous_70 module_contexts;
        uint32_t prev_pop3_uidl_tracking_seq;
        uint32_t highest_pop3_uidl_uid;
        struct_mail_save_context* save_ctx;
        uint save_count;
        union _Anonymous_71
        {
            struct_array arr;
            const(const struct_mail_save_private_changes*)* v;
            struct_mail_save_private_changes** v_modifiable;
        }
        _Anonymous_71 pvt_saves;
        struct_mailbox_transaction_stats stats;
        int stats_track;
    }
    void mail_index_attribute_unset(struct_mail_index_transaction*, int, const(char)*, int, );
    void mail_index_update_modseq(struct_mail_index_transaction*, int, int, );
    void mail_index_update_highest_modseq(struct_mail_index_transaction*, int, );
    const struct_mailbox_settings* mailbox_settings_find(struct_mail_namespace*, const(char)*, );
    void mail_index_reset(struct_mail_index_transaction*, );
    void mail_index_unset_fscked(struct_mail_index_transaction*, );
    void mail_index_set_deleted(struct_mail_index_transaction*, );
    int mailbox_is_readonly();
    void mail_index_set_undeleted(struct_mail_index_transaction*, );
    int mailbox_backends_equal();
    int mail_index_is_deleted();
    int mail_index_get_modification_time(struct_mail_index*, int*, );
    int mailbox_is_inconsistent();
    int mail_index_keyword_lookup();
    void mail_index_keyword_lookup_or_create(struct_mail_index*, const(char)*, uint*, );
    int mailbox_get_status(struct_mailbox*, enum_mailbox_status_items, struct_mailbox_status*, );
    const union_array__keywords* mail_index_get_keywords(struct_mail_index*, );
    void mailbox_get_open_status(struct_mailbox*, enum_mailbox_status_items, struct_mailbox_status*, );
    union union_mail_search_module_context
    {
        struct_mail_storage_module_register* reg;
    }
    int mailbox_get_metadata(struct_mailbox*, enum_mailbox_metadata_items, struct_mailbox_metadata*, );
    struct_mail_keywords* mail_index_keywords_create_from_indexes(struct_mail_index*, const union_array__keyword_indexes*, );
    enum_mail_flags mailbox_get_private_flags_mask(struct_mailbox*, );
    struct struct_mail_search_context
    {
        struct_mailbox_transaction_context* transaction;
        struct_mail_search_args* args;
        struct_mail_search_sort_program* sort_program;
        enum_mail_fetch_field wanted_fields;
        struct_mailbox_header_lookup_ctx* wanted_headers;
        normalizer_func_t* normalizer;
        struct_mail_search_result* update_result;
        union _Anonymous_72
        {
            struct_array arr;
            struct_mail_search_result*** v;
            struct_mail_search_result*** v_modifiable;
        }
        _Anonymous_72 results;
        uint32_t seq;
        uint32_t progress_cur;
        uint32_t progress_max;
        union _Anonymous_73
        {
            struct_array arr;
            union_mail_search_module_context*** v;
            union_mail_search_module_context*** v_modifiable;
        }
        _Anonymous_73 module_contexts;
        int seen_lost_data;
        int progress_hidden;
    }
    void mail_index_keywords_ref(struct_mail_keywords*, );
    struct_mailbox_sync_context* mailbox_sync_init(struct_mailbox*, enum_mailbox_sync_flags, );
    void mail_index_keywords_unref(struct_mail_keywords**, );
    struct struct_mailbox_sync_context;
    int mailbox_sync_next();
    void mail_index_update_keywords(struct_mail_index_transaction*, int, enum_modify_type, struct_mail_keywords*, );
    int mailbox_sync_deinit(struct_mailbox_sync_context**, struct_mailbox_sync_status*, );
    int mailbox_sync(struct_mailbox*, enum_mailbox_sync_flags, );
    void mail_index_update_header(struct_mail_index_transaction*, int, const(void)*, int, int, );





    const(char)* mail_index_get_error_message(struct_mail_index*, );
    void mail_index_reset_error(struct_mail_index*, );
    void mailbox_notify_changes_stop(struct_mailbox*, );
    struct_mailbox_transaction_context* mailbox_transaction_begin(struct_mailbox*, enum_mailbox_transaction_flags, const(char)*, );
    void mail_index_sync_flags_apply(const struct_mail_index_sync_rec*, int*, );
    struct struct_mail_save_data
    {
        enum_mail_flags flags;
        enum_mail_flags pvt_flags;
        struct_mail_keywords* keywords;
        uint64_t min_modseq;
        time_t received_date;
        time_t save_date;
        int received_tz_offset;
        uint32_t uid;
        uint32_t stub_seq;
        char* guid;
        char* pop3_uidl;
        char* from_envelope;
        uint pop3_order;
        struct_ostream* output;
        struct_mail_save_attachment* attach;
    }
    int mailbox_transaction_commit(struct_mailbox_transaction_context**, );
    int mailbox_transaction_commit_get_changes(struct_mailbox_transaction_context**, struct_mail_transaction_commit_changes*, );
    int mail_index_sync_keywords_apply();
    void mailbox_transaction_rollback(struct_mailbox_transaction_context**, );
    int mail_index_ext_register();
    void mailbox_transaction_set_max_modseq(struct_mailbox_transaction_context*, uint64_t, union_array__seq_range*, );
    void mail_index_ext_register_resize_defaults(struct_mail_index*, int, int, int, int, );
    struct struct_mail_save_context
    {
        struct_mailbox_transaction_context* transaction;
        struct_mail* dest_mail;
        struct_mail* copy_src_mail;
        struct_mail_save_data data;
        int function(struct_mail_save_context*, const struct_mail_attachment_part*) function(int*) bool_;
        int unfinished;
        int finishing;
        int copying_via_save;
        int saving;
        int moving;
        int copying_or_moving;
    }
    int mail_index_ext_lookup();
    void mailbox_get_seq_range(struct_mailbox*, uint32_t, uint32_t, uint32_t*, uint32_t*, );
    void mail_index_ext_resize(struct_mail_index_transaction*, int, int, int, int, );
    void mailbox_get_uid_range(struct_mailbox*, const union_array__seq_range*, union_array__seq_range*, );
    void mail_index_ext_resize_hdr(struct_mail_index_transaction*, int, int, );
    int mailbox_get_expunges();
    void mail_index_ext_reset(struct_mail_index_transaction*, int, int, int, );
    int mailbox_get_expunged_uids();
    void mail_index_ext_reset_inc(struct_mail_index_transaction*, int, int, int, );
    struct_mailbox_header_lookup_ctx* mailbox_header_lookup_init(struct_mailbox*, const(const(char)*)*, );
    void mailbox_header_lookup_ref(struct_mailbox_header_lookup_ctx*, );
    void mailbox_header_lookup_unref(struct_mailbox_header_lookup_ctx**, );
    void mail_index_ext_set_reset_id(struct_mail_index_transaction*, int, int, );
    int mail_index_ext_get_reset_id();
    void mail_index_get_header_ext(struct_mail_index_view*, int, const(void)**, int*, );
    void mail_index_map_get_header_ext(struct_mail_index_view*, struct_mail_index_map*, int, const(void)**, int*, );
    int mailbox_search_deinit(struct_mail_search_context**, );
    struct struct_mailbox_header_lookup_ctx
    {
        struct_mailbox* box;
        int pool;
        int refcount;
        uint count;
        const(const(char)*)* name;
        uint* idx;
    }
    int mailbox_search_next();
    void mail_index_lookup_ext(struct_mail_index_view*, int, int, const(void)**, int*, );
    int mailbox_search_next_nonblock();
    void mail_index_lookup_ext_full(struct_mail_index_view*, int, int, struct_mail_index_map**, const(void)**, int*, );
    int mailbox_search_seen_lost_data();
    void mail_index_ext_get_size(struct_mail_index_map*, int, int*, int*, int*, );
    extern __gshared struct_mail_storage_module_register mail_storage_module_register;
    struct_mail_search_result* mailbox_search_result_save(struct_mail_search_context*, enum_mailbox_search_result_flags, );
    extern __gshared struct_mail_module_register mail_module_register;
    void mail_index_update_header_ext(struct_mail_index_transaction*, int, int, const(void)*, int, );
    extern __gshared struct_event_category event_category_storage;
    void mailbox_search_result_free(struct_mail_search_result**, );
    extern __gshared struct_event_category event_category_mailbox;
    extern __gshared struct_event_category event_category_mail;
    int mailbox_search_result_build(struct_mailbox_transaction_context*, struct_mail_search_args*, enum_mailbox_search_result_flags, struct_mail_search_result**, );






    const union_array__seq_range* mailbox_search_result_get(struct_mail_search_result*, );
    extern __gshared struct_mail_storage_mail_index_module mail_storage_mail_index_module;
    struct struct_mail_storage_mail_index_module
    {
        struct_module_context_id id;
    }
    int mail_index_atomic_inc_ext(struct_mail_index_transaction*, int, int, int, );
    void mail_storage_obj_ref(struct_mail_storage*, );
    void mail_storage_obj_unref(struct_mail_storage*, );
    void mailbox_search_result_sync(struct_mail_search_result*, union_array__seq_range*, union_array__seq_range*, );
    void mail_storage_clear_error(struct_mail_storage*, );
    void mail_storage_set_error(struct_mail_storage*, enum_mail_error, const(char)*, );
    int mailbox_keywords_create(struct_mailbox*, const(const(char)*)*, struct_mail_keywords**, );
    struct_mail_keywords* mailbox_keywords_create_valid(struct_mailbox*, const(const(char)*)*, );
    struct_mail_keywords* mailbox_keywords_create_from_indexes(struct_mailbox*, const union_array__keyword_indexes*, );
    void mail_storage_set_internal_error(struct_mail_storage*, );
    void mailbox_set_index_error(struct_mailbox*, );
    void mail_storage_set_index_error(struct_mail_storage*, struct_mail_index*, );
    void mailbox_keywords_ref(struct_mail_keywords*, );
    int mail_storage_set_error_from_errno();
    void mailbox_keywords_unref(struct_mail_keywords**, );
    void mail_storage_copy_list_error(struct_mail_storage*, struct_mailbox_list*, );
    int mailbox_keyword_is_valid();
    void mail_storage_copy_error(struct_mail_storage*, struct_mail_storage*, );
    struct_mail_save_context* mailbox_save_alloc(struct_mailbox_transaction_context*, );
    void mailbox_save_set_flags(struct_mail_save_context*, enum_mail_flags, struct_mail_keywords*, );
    void mail_autoexpunge(struct_mail*, );
    void mailbox_save_copy_flags(struct_mail_save_context*, struct_mail*, );
    int mail_prefetch();
    void mail_set_aborted(struct_mail*, );
    void mailbox_save_set_min_modseq(struct_mail_save_context*, uint64_t, );
    void mail_set_expunged(struct_mail*, );
    void mail_set_seq_saving(struct_mail*, uint32_t, );
    void mailbox_save_set_received_date(struct_mail_save_context*, time_t, int, );
    int mail_has_attachment_keywords();
    void mail_set_attachment_keywords(struct_mail*, );
    void mailbox_save_set_save_date(struct_mail_save_context*, time_t, );
    void mailbox_set_deleted(struct_mailbox*, );
    int mailbox_mark_index_deleted(struct_mailbox*, int, );
    void mailbox_save_set_from_envelope(struct_mail_save_context*, const(char)*, );
    void mailbox_save_set_uid(struct_mail_save_context*, uint32_t, );
    int mailbox_get_path_to(struct_mailbox*, enum_mailbox_list_path_type, const(char)**, );
    void mailbox_save_set_guid(struct_mail_save_context*, const(char)*, );
    const struct_mailbox_permissions* mailbox_get_permissions(struct_mailbox*, );
    void mailbox_refresh_permissions(struct_mailbox*, );
    void mailbox_save_set_pop3_uidl(struct_mail_save_context*, const(char)*, );
    void mailbox_save_set_pop3_order(struct_mail_save_context*, uint, );
    int mailbox_open_index_pvt(struct_mailbox*, );
    struct_mail* mailbox_save_get_dest_mail(struct_mail_save_context*, );
    int mailbox_mkdir(struct_mailbox*, const(char)*, enum_mailbox_list_path_type, );
    int mailbox_create_missing_dir(struct_mailbox*, enum_mailbox_list_path_type, );
    int mailbox_save_begin(struct_mail_save_context**, struct_istream*, );
    int mailbox_save_continue(struct_mail_save_context*, );
    int mailbox_save_finish(struct_mail_save_context**, );
    int mailbox_is_autocreated();
    void mailbox_save_cancel(struct_mail_save_context**, );
    int mailbox_is_autosubscribed();
    struct_mailbox_transaction_context* mailbox_save_get_transaction(struct_mail_save_context*, );
    int mailbox_create_fd(struct_mailbox*, const(char)*, int, int*, );
    int mailbox_copy(struct_mail_save_context**, struct_mail*, );
    int mail_storage_lock_create(const(char)*, const struct_file_create_settings*, const struct_mail_storage_settings*, struct_file_lock**, const(char)**, );
    int mailbox_move(struct_mail_save_context**, struct_mail*, );
    int mailbox_save_using_mail(struct_mail_save_context**, struct_mail*, );
    int mailbox_lock_file_create(struct_mailbox*, const(char)*, uint, struct_file_lock**, const(char)**, );
    uint mail_storage_get_lock_timeout(struct_mail_storage*, uint, );
    void mail_free(struct_mail**, );
    void mail_storage_free_binary_cache(struct_mail_storage*, );
    void mail_set_seq(struct_mail*, uint32_t, );
    enum_mail_index_open_flags mail_storage_settings_to_index_flags(const struct_mail_storage_settings*, );
    int mail_set_uid();
    void mailbox_save_context_deinit(struct_mail_save_context*, );
    enum_mail_flags mail_get_flags(struct_mail*, );
    const(const(char)*)* mail_get_keywords(struct_mail*, );
    const union_array__keyword_indexes* mail_get_keyword_indexes(struct_mail*, );
    uint64_t mail_get_modseq(struct_mail*, );
    uint64_t mail_get_pvt_modseq(struct_mail*, );
    int mail_get_parts(struct_mail*, struct_message_part**, );
    int mail_get_date(struct_mail*, time_t*, int*, );
    int mail_get_received_date(struct_mail*, time_t*, );
    int mail_get_save_date(struct_mail*, time_t*, );
    int mail_get_virtual_size(struct_mail*, int*, );
    int mail_get_physical_size(struct_mail*, int*, );
    int mail_get_first_header(struct_mail*, const(char)*, const(char)**, );
    int mail_get_first_header_utf8(struct_mail*, const(char)*, const(char)**, );
    int mail_get_headers(struct_mail*, const(char)*, const(const(char)*)**, );
    int mail_get_headers_utf8(struct_mail*, const(char)*, const(const(char)*)**, );
    int mail_get_header_stream(struct_mail*, struct_mailbox_header_lookup_ctx*, struct_istream**, );
    int mail_get_hdr_stream_because(struct_mail*, struct_message_size*, const(char)*, struct_istream**, );
    int mail_get_binary_stream(struct_mail*, const struct_message_part*, int, int*, int*, struct_istream**, );
    int mail_get_binary_size(struct_mail*, const struct_message_part*, int, int*, uint*, );
    int mail_get_special(struct_mail*, enum_mail_fetch_field, const(char)**, );
    int mail_get_backend_mail(struct_mail*, struct_mail**, );
    void mail_update_flags(struct_mail*, enum_modify_type, enum_mail_flags, );
    void mail_update_keywords(struct_mail*, enum_modify_type, struct_mail_keywords*, );
    void mail_update_modseq(struct_mail*, uint64_t, );
    void mail_update_pvt_modseq(struct_mail*, uint64_t, );
    void mail_update_pop3_uidl(struct_mail*, const(char)*, );
    void mail_expunge(struct_mail*, );
    void mail_precache(struct_mail*, );
    void mail_set_cache_corrupted(struct_mail*, enum_mail_fetch_field, const(char)*, );
    void mail_generate_guid_128_hash(const(char)*, guid_128_t, );
    int mail_parse_human_timestamp(const(char)*, time_t*, int*, );
}

extern(C) {




    struct struct_mail_thread_context;
    struct struct_mail_search_mime_part;
    enum enum_mail_thread_type
    {
        MAIL_THREAD_NONE = 0,
        MAIL_THREAD_ORDEREDSUBJECT = 1,
        MAIL_THREAD_REFERENCES = 2,
        MAIL_THREAD_REFS = 3,
    }
    enum
    {
        MAIL_THREAD_NONE = 0,
        MAIL_THREAD_ORDEREDSUBJECT = 1,
        MAIL_THREAD_REFERENCES = 2,
        MAIL_THREAD_REFS = 3,
    }
    enum enum_mail_search_arg_type
    {
        SEARCH_OR = 0,
        SEARCH_SUB = 1,
        SEARCH_ALL = 2,
        SEARCH_SEQSET = 3,
        SEARCH_UIDSET = 4,
        SEARCH_FLAGS = 5,
        SEARCH_KEYWORDS = 6,
        SEARCH_BEFORE = 7,
        SEARCH_ON = 8,
        SEARCH_SINCE = 9,
        SEARCH_SMALLER = 10,
        SEARCH_LARGER = 11,
        SEARCH_HEADER = 12,
        SEARCH_HEADER_ADDRESS = 13,
        SEARCH_HEADER_COMPRESS_LWSP = 14,
        SEARCH_BODY = 15,
        SEARCH_TEXT = 16,
        SEARCH_MODSEQ = 17,
        SEARCH_INTHREAD = 18,
        SEARCH_GUID = 19,
        SEARCH_MAILBOX = 20,
        SEARCH_MAILBOX_GUID = 21,
        SEARCH_MAILBOX_GLOB = 22,
        SEARCH_REAL_UID = 23,
        SEARCH_MIMEPART = 24,
    }
    enum
    {
        SEARCH_OR = 0,
        SEARCH_SUB = 1,
        SEARCH_ALL = 2,
        SEARCH_SEQSET = 3,
        SEARCH_UIDSET = 4,
        SEARCH_FLAGS = 5,
        SEARCH_KEYWORDS = 6,
        SEARCH_BEFORE = 7,
        SEARCH_ON = 8,
        SEARCH_SINCE = 9,
        SEARCH_SMALLER = 10,
        SEARCH_LARGER = 11,
        SEARCH_HEADER = 12,
        SEARCH_HEADER_ADDRESS = 13,
        SEARCH_HEADER_COMPRESS_LWSP = 14,
        SEARCH_BODY = 15,
        SEARCH_TEXT = 16,
        SEARCH_MODSEQ = 17,
        SEARCH_INTHREAD = 18,
        SEARCH_GUID = 19,
        SEARCH_MAILBOX = 20,
        SEARCH_MAILBOX_GUID = 21,
        SEARCH_MAILBOX_GLOB = 22,
        SEARCH_REAL_UID = 23,
        SEARCH_MIMEPART = 24,
    }
    struct struct_mail_thread_child_node
    {
        int idx;
        int uid;
        int sort_date;
    }
    int mail_thread_type_parse();
    const(char)* mail_thread_type_to_str(enum_mail_thread_type, );
    void mail_thread_deinit(struct_mail_thread_context**, );
    struct struct_mail_thread_iterate_context;
    struct_mail_thread_iterate_context* mail_thread_iterate_init(struct_mail_thread_context*, enum_mail_thread_type, int, );
    const struct_mail_thread_child_node* mail_thread_iterate_next(struct_mail_thread_iterate_context*, struct_mail_thread_iterate_context**, );
    uint mail_thread_iterate_count(struct_mail_thread_iterate_context*, );
    enum enum_mail_search_date_type
    {
        MAIL_SEARCH_DATE_TYPE_SENT = 1,
        MAIL_SEARCH_DATE_TYPE_RECEIVED = 2,
        MAIL_SEARCH_DATE_TYPE_SAVED = 3,
    }
    enum
    {
        MAIL_SEARCH_DATE_TYPE_SENT = 1,
        MAIL_SEARCH_DATE_TYPE_RECEIVED = 2,
        MAIL_SEARCH_DATE_TYPE_SAVED = 3,
    }
    int mail_thread_iterate_deinit(struct_mail_thread_iterate_context**, );
    enum enum_mail_search_arg_flag
    {
        MAIL_SEARCH_ARG_FLAG_UTC_TIMES = 1,
    }
    enum
    {
        MAIL_SEARCH_ARG_FLAG_UTC_TIMES = 1,
    }
    enum enum_mail_search_modseq_type
    {
        MAIL_SEARCH_MODSEQ_TYPE_ANY = 0,
        MAIL_SEARCH_MODSEQ_TYPE_PRIVATE = 1,
        MAIL_SEARCH_MODSEQ_TYPE_SHARED = 2,
    }
    enum
    {
        MAIL_SEARCH_MODSEQ_TYPE_ANY = 0,
        MAIL_SEARCH_MODSEQ_TYPE_PRIVATE = 1,
        MAIL_SEARCH_MODSEQ_TYPE_SHARED = 2,
    }
    struct struct_mail_search_modseq
    {
        int modseq;
        enum_mail_search_modseq_type type;
    }






    alias mail_search_foreach_callback_t = arg;
    void mail_search_arg_init(struct_mail_search_args*, struct_mail_search_arg*, int, unknown, );
    void mail_search_args_deinit(struct_mail_search_args*, );
    void mail_search_arg_deinit(struct_mail_search_arg*, );
    void mail_search_arg_one_deinit(struct_mail_search_arg*, );
    void mail_search_args_seq2uid(struct_mail_search_args*, );
    int mail_search_args_equal();
    int mail_search_arg_equals();
    int mail_search_arg_one_equals();
    void mail_search_args_ref(struct_mail_search_args*, );
    void mail_search_args_unref(struct_mail_search_args**, );
    struct_mail_search_args* mail_search_args_dup(const struct_mail_search_args*, );
    struct_mail_search_arg* mail_search_arg_dup(int, const struct_mail_search_arg*, );
    void mail_search_args_reset(struct_mail_search_arg*, int, );






    const(const(char)*)* mail_search_args_analyze(struct_mail_search_arg*, int*, int*, );
    int mail_search_args_match_mailbox();
    void mail_search_args_simplify(struct_mail_search_args*, );
    int mail_search_args_to_imap();
    int mail_search_arg_to_imap();
    void mail_search_args_to_cmdline(int*, const struct_mail_search_arg*, );
    void mail_search_args_result_serialize(const struct_mail_search_args*, int*, );
    void mail_search_args_result_deserialize(struct_mail_search_args*, const(ubyte)*, int, );
}

extern(C) {


    int* str_new();
    int* t_str_new();
    int* str_new_const();
    int* t_str_new_const();
    void str_free(int**, );
    char* str_free_without_data(int**, );
    const(char)* str_c(int*, );
    char* str_c_modifiable(int*, );
    const(ubyte)* str_data(const(int)*, );
    int str_len();
    void str_append_n(int*, const(void)*, int, );
    void str_append(int*, const(char)*, );
    void str_append_data(int*, const(void)*, int, );
    void str_append_c(int*, ubyte, );
    void str_append_str(int*, const(int)*, );
    void str_insert(int*, int, const(char)*, );
    void str_delete(int*, int, int, );
    void str_truncate(int*, int, );
}

extern(C) {


    struct struct_hash_table;


    alias hash_callback_t = p;
    alias hash_cmp_callback_t = p1;
    void hash_table_create(struct_hash_table**, int, uint, hash_callback_t*, hash_cmp_callback_t*, );
    void hash_table_create_direct(struct_hash_table**, int, uint, );
    void hash_table_destroy(struct_hash_table**, );



    void hash_table_clear(struct_hash_table*, int, );







    int hash_table_lookup_full();
    void hash_table_insert(struct_hash_table*, void*, void*, );
    void hash_table_update(struct_hash_table*, void*, void*, );
    int hash_table_try_remove();
    struct struct_hash_iterate_context;
    struct_hash_iterate_context* hash_table_iterate_init(struct_hash_table*, );



    int hash_table_iterate();
    void hash_table_iterate_deinit(struct_hash_iterate_context**, );
    void hash_table_freeze(struct_hash_table*, );
    void hash_table_thaw(struct_hash_table*, );






    void hash_table_copy(struct_hash_table*, struct_hash_table*, );



}

extern(C) {




    const(char)* str_escape(const(char)*, );
    void str_append_unescaped(int*, const(void)*, int, );
    char* str_unescape(char*, );
    int str_unescape_next(const(char)**, const(char)**, );
    const(char)* str_tabescape(const(char)*, );
    void str_append_tabescaped(int*, const(char)*, );
    void str_append_tabescaped_n(int*, const(ubyte)*, int, );
    void str_append_tabunescaped(int*, const(void)*, int, );
    char* str_tabunescape(char*, );
    const(char)* t_str_tabunescape(const(char)*, );
    char** p_strsplit_tabescaped(int, const(char)*, );
    const(const(char)*)* t_strsplit_tabescaped(const(char)*, );
    const(const(char)*)* t_strsplit_tabescaped_inplace(char*, );
}

extern(C) {
}

extern(C) {
    struct struct_event_filter;





    void fd_close_on_exec(int, bool, );




    struct _Anonymous_74
    {
        c_ulong[16] __val;
    }
    extern __gshared pool_t default_pool;


    extern __gshared const(ubyte) uchar_nul;




    enum enum_fatal_exit_status
    {
        FATAL_LOGOPEN = 80,
        FATAL_LOGWRITE = 81,
        FATAL_LOGERROR = 82,
        FATAL_OUTOFMEM = 83,
        FATAL_EXEC = 84,
        FATAL_DEFAULT = 89,
    }
    enum
    {
        FATAL_LOGOPEN = 80,
        FATAL_LOGWRITE = 81,
        FATAL_LOGERROR = 82,
        FATAL_OUTOFMEM = 83,
        FATAL_EXEC = 84,
        FATAL_DEFAULT = 89,
    }
    struct struct_event;


    extern __gshared const(ubyte)* uchar_empty_ptr;




    struct struct_tm
    {
        int tm_sec;
        int tm_min;
        int tm_hour;
        int tm_mday;
        int tm_mon;
        int tm_year;
        int tm_wday;
        int tm_yday;
        int tm_isdst;
        c_long tm_gmtoff;
        const(char)* tm_zone;
    }


    struct struct_event_log_params
    {
        enum_log_type log_type;
        const(char)* source_filename;
        uint source_linenum;
    }




    struct struct_itimerspec
    {
        struct_timespec it_interval;
        struct_timespec it_value;
    }


    void fd_debug_verify_leaks(int, int, );
    int i_snprintf(char*, int, const(char)*, ...);


    int malloc_multiply_check();


    int nearest_power();
    void fd_set_nonblock(int, bool, );
    void* i_malloc(int, );
    char* p_strdup(pool_t, const(char)*, );
    bool bits_is_power_of_two(uint64_t, );




    void* i_realloc(void*, int, int, );



    void* p_memdup(pool_t, const(void)*, int, );




    void e_error(struct_event*, const(char)*, uint, const(char)*, ...);
    char* p_strdup_empty(pool_t, const(char)*, );
    int str_to_uint(const(char)*, uint*, );


    void fd_close_maybe_stdio(int*, int*, );





    enum enum_log_type
    {
        LOG_TYPE_DEBUG = 0,
        LOG_TYPE_INFO = 1,
        LOG_TYPE_WARNING = 2,
        LOG_TYPE_ERROR = 3,
        LOG_TYPE_FATAL = 4,
        LOG_TYPE_PANIC = 5,
        LOG_TYPE_COUNT = 6,
        LOG_TYPE_OPTION = 7,
    }
    enum
    {
        LOG_TYPE_DEBUG = 0,
        LOG_TYPE_INFO = 1,
        LOG_TYPE_WARNING = 2,
        LOG_TYPE_ERROR = 3,
        LOG_TYPE_FATAL = 4,
        LOG_TYPE_PANIC = 5,
        LOG_TYPE_COUNT = 6,
        LOG_TYPE_OPTION = 7,
    }



    alias pool_t = struct_pool;
    char* p_strdup_until(pool_t, const(void)*, const(void)*, );
    int str_parse_uint(const(char)*, uint*, const(char)**, );




    struct struct_pool_vfuncs
    {
        const(char)* function(struct_pool*) get_name;
        void function(struct_pool*) ref_;
        void function(struct_pool**) unref;
        void* function(struct_pool*, int) malloc;
        void function(struct_pool*, void*) free;
        void* function(struct_pool*, void*, int, int) realloc;
        void function(struct_pool*) clear;
        int function(pool_t) function(int*) size_t;
    }
    void e_warning(struct_event*, const(char)*, uint, const(char)*, ...);
    enum enum_event_field_value_type
    {
        EVENT_FIELD_VALUE_TYPE_STR = 0,
        EVENT_FIELD_VALUE_TYPE_INTMAX = 1,
        EVENT_FIELD_VALUE_TYPE_TIMEVAL = 2,
    }
    enum
    {
        EVENT_FIELD_VALUE_TYPE_STR = 0,
        EVENT_FIELD_VALUE_TYPE_INTMAX = 1,
        EVENT_FIELD_VALUE_TYPE_TIMEVAL = 2,
    }
    char* p_strndup(pool_t, const(void)*, int, );
    uint bits_required32(uint32_t, );


    int str_to_ulong(const(char)*, c_ulong*, );







    char* p_strdup_printf(pool_t, const(char)*, ...);


    void i_close_fd_path(int*, const(char)*, const(char)*, const(char)*, const(char)*, int, );
    char* p_strdup_vprintf(pool_t, const(char)*, int, );






    int str_parse_ulong(const(char)*, c_ulong*, const(char)**, );
    void e_info(struct_event*, const(char)*, uint, const(char)*, ...);





    alias locale_t = __locale_t;




    char* p_strconcat(pool_t, const(char)*, ...);
    uint bits_required8(uint8_t, );
    struct struct_event_field
    {
        const(char)* key;
        enum_event_field_value_type value_type;
        struct _Anonymous_75
        {
            const(char)* str;
            intmax_t intmax;
            struct_timeval timeval;
        }
        _Anonymous_75 value;
    }
    int str_to_ullong(const(char)*, ulong*, );
    struct struct___locale_struct
    {
        struct___locale_data*[13] __locales;
        const(ushort)* __ctype_b;
        const(int)* __ctype_tolower;
        const(int)* __ctype_toupper;
        const(char)*[13] __names;
    }




    uint bits_required16(uint16_t, );
    int str_parse_ullong(const(char)*, ulong*, const(char)**, );
    struct struct_failure_line
    {
        pid_t pid;
        enum_log_type log_type;
        bool disable_log_prefix;
        const(char)* text;
    }
    void e_debug(struct_event*, const(char)*, uint, const(char)*, ...);




    const(char)* t_strdup(const(char)*, );


    char* i_strdup(const(char)*, );




    char* t_strdup_noconst(const(char)*, );






    uint bits_required64(uint64_t, );
    int str_to_uint32(const(char)*, uint32_t*, );
    union _Anonymous_76
    {
        char[4] __size;
        int __align;
    }
    void* alloca(int, );
    int malloc_add_check();
    char* i_strdup_empty(const(char)*, );


    const(char)* t_strdup_empty(const(char)*, );
    int str_parse_uint32(const(char)*, uint32_t*, const(char)**, );




    const(char)* t_strdup_until(const(void)*, const(void)*, );
    char* i_strdup_until(const(void)*, const(void)*, );




    alias __gwchar_t = int;






    int bcmp(const(void)*, const(void)*, int, );
    alias data_stack_frame_t = uint;


    const(char)* t_strndup(const(void)*, int, );


    struct struct_failure_context
    {
        enum_log_type type;
        int exit_status;
        const struct_tm* timestamp;
        uint timestamp_usecs;
        const(char)* log_prefix;
    }
    struct struct_event_add_field
    {
        const(char)* key;
        const(char)* value;
        intmax_t value_intmax;
        struct_timeval value_timeval;
    }


    int str_to_uint64(const(char)*, uint64_t*, );


    char* i_strndup(const(void)*, int, );




    int* __errno_location();
    alias buffer_t = struct_buffer;






    //char* i_strdup_printf(const(char)*, ...);
    //const(char)* t_strdup_printf(const(char)*, ...);






    //alias bool = int;
    int str_parse_uint64(const(char)*, uint64_t*, const(char)**);
    void bcopy(const(void)*, void*, int);
    alias string_t = struct_buffer;




    char* i_strdup_vprintf(const(char)*, int, );


    const(char)* t_strdup_vprintf(const(char)*, int, );



    extern __gshared uint data_stack_frame_id;


    struct struct_istream;
    enum _Anonymous_77
    {
        IPPROTO_IP = 0,
        IPPROTO_ICMP = 1,
        IPPROTO_IGMP = 2,
        IPPROTO_IPIP = 4,
        IPPROTO_TCP = 6,
        IPPROTO_EGP = 8,
        IPPROTO_PUP = 12,
        IPPROTO_UDP = 17,
        IPPROTO_IDP = 22,
        IPPROTO_TP = 29,
        IPPROTO_DCCP = 33,
        IPPROTO_IPV6 = 41,
        IPPROTO_RSVP = 46,
        IPPROTO_GRE = 47,
        IPPROTO_ESP = 50,
        IPPROTO_AH = 51,
        IPPROTO_MTP = 92,
        IPPROTO_BEETPH = 94,
        IPPROTO_ENCAP = 98,
        IPPROTO_PIM = 103,
        IPPROTO_COMP = 108,
        IPPROTO_SCTP = 132,
        IPPROTO_UDPLITE = 136,
        IPPROTO_MPLS = 137,
        IPPROTO_RAW = 255,
        IPPROTO_MAX = 256,
    }




    struct struct_ostream;
    const(char)* t_strconcat(const(char)*, ...);
    union _Anonymous_78
    {
        char[4] __size;
        int __align;
    }



    int str_to_uintmax(const(char)*, uintmax_t*, );


    enum _Anonymous_79
    {
        SHUT_RD = 0,
        SHUT_WR = 1,
        SHUT_RDWR = 2,
    }
    ssize_t readv(int, const struct_iovec*, int, );
    bool event_want_debug(struct_event*, const(char)*, uint, );
    alias __locale_t = struct___locale_struct;


    void* memcpy(void*, const(void)*, int, );
    void bzero(void*, int, );
    char* i_strconcat(const(char)*, ...);
    struct struct_pool
    {
        const struct_pool_vfuncs* v;
        bool alloconly_pool;
        bool datastack_pool;
    }






    alias int_least8_t = byte;



    alias lib_atexit_callback_t = void function();


    int str_parse_uintmax(const(char)*, uintmax_t*, const(char)**, );
    alias int_least16_t = short;




    void event_log(struct_event*, const struct_event_log_params*, const(char)*, ...);




    struct struct_event_passthrough
    {
        struct_event_passthrough* function(const(char)*) append_log_prefix;
        struct_event_passthrough* function(const(char)*) replace_log_prefix;
        struct_event_passthrough* function(const(char)*) set_name;
        struct_event_passthrough* function(const(char)*, uint, int) set_source;
        struct_event_passthrough* function() set_always_log_source;
        struct_event_passthrough* function(struct_event_category**) add_categories;
        struct_event_passthrough* function(struct_event_category*) add_category;
        struct_event_passthrough* function(const(struct_event_add_field)*) add_fields;
        struct_event_passthrough* function(const(char)*, const(char)*) add_str;
        struct_event_passthrough* function(const(char)*, c_long) add_int;
        struct_event_passthrough* function(const(char)*, const(struct_timeval)*) add_timeval;
        struct_event* function() event;
    }
    const(char)* t_strcut(const(char)*, char, );
    alias int_least32_t = int;





    alias failure_callback_t = ctx;
    void* memmove(void*, const(void)*, int, );






    bool str_uint_equals(const(char)*, uintmax_t, );


    alias int_least64_t = c_long;
    void event_logv(struct_event*, const struct_event_log_params*, const(char)*, int, );
    const(char)* t_str_replace(const(char)*, char, char, );
    struct struct_sigevent;
    extern __gshared const(char)*[0] failure_log_type_prefixes;




    int i_strocpy(char*, const(char)*, int, );


    extern __gshared pool_t system_pool;
    extern __gshared const(char)*[0] failure_log_type_names;




    extern __gshared struct_pool static_system_pool;




    ssize_t writev(int, const struct_iovec*, int, );


    struct struct_timezone
    {
        int tz_minuteswest;
        int tz_dsttime;
    }
    data_stack_frame_t t_push(const(char)*, );


    char* str_ucase(char*, );
    void i_log_type(const struct_failure_context*, const(char)*, ...);


    char* str_lcase(char*, );




    data_stack_frame_t t_push_named(const(char)*, ...);
    int str_to_uint_hex(const(char)*, uint*, );
    void* memccpy(void*, const(void)*, int, int, );


    const(char)* t_str_lcase(const(char)*, );


    void i_log_typev(const struct_failure_context*, const(char)*, int, );
    alias uint_least8_t = ubyte;
    alias uint_least16_t = ushort;




    const(char)* t_str_ucase(const(char)*, );




    extern __gshared pool_t unsafe_data_stack_pool;
    int str_parse_uint_hex(const(char)*, uint*, const(char)**, );




    bool t_pop(data_stack_frame_t*, );


    alias uint_least32_t = uint;






    void i_panic(const(char)*, );






    extern __gshared int dev_null_fd;


    void t_pop_last_unsafe();
    void i_fatal(const(char)*, );
    int str_to_ulong_hex(const(char)*, c_ulong*, );
    alias uint_least64_t = c_ulong;
    struct _Anonymous_80
    {
        int quot;
        int rem;
    }


    const(char)* t_str_trim(const(char)*, const(char)*, );
    alias div_t = _Anonymous_80;
    alias __timezone_ptr_t = struct_timezone;


    struct _Anonymous_81
    {
        __fd_mask[16] __fds_bits;
    }
    const(char)* p_str_trim(pool_t, const(char)*, const(char)*, );
    uint64_t bits_rotl64(uint64_t, uint, );


    pool_t pool_alloconly_create(const(char)*, int, );
    void i_error(const(char)*, ...);




    int str_parse_ulong_hex(const(char)*, c_ulong*, const(char)**, );






    const(char)* str_ltrim(const(char)*, const(char)*, );
    void* memset(void*, int, int, );


    void i_warning(const(char)*, ...);




    void i_info(const(char)*, ...);


    const(char)* t_str_ltrim(const(char)*, const(char)*, );





    int i_unlink(const(char)*, const(char)*, uint, );
    void i_debug(const(char)*, ...);
    struct_event* event_set_forced_debug(struct_event*, bool, );


    const(char)* p_str_ltrim(pool_t, const(char)*, const(char)*, );
    int str_to_ullong_hex(const(char)*, ulong*, );
    int memcmp(const(void)*, const(void)*, int, );
    const(char)* t_str_rtrim(const(char)*, const(char)*, );
    pool_t pool_alloconly_create_clean(const(char)*, int, );





    void i_fatal_status(int, const(char)*, );


    const(char)* p_str_rtrim(pool_t, const(char)*, const(char)*, );
    void event_set_global_debug_log_filter(struct_event_filter*, );
    int str_parse_ullong_hex(const(char)*, ulong*, const(char)**, );


    alias uint_fast32_t = c_ulong;
    alias ldiv_t = _Anonymous_82;
    struct _Anonymous_82
    {
        c_long quot;
        c_long rem;
    }




    int null_strcmp(const(char)*, const(char)*, );
    struct_event_filter* event_get_global_debug_log_filter();




    int null_strcasecmp(const(char)*, const(char)*, );


    int i_unlink_if_exists(const(char)*, const(char)*, uint, );




    ssize_t preadv(int, const struct_iovec*, int, __off_t, );
    uint32_t bits_rotl32(uint32_t, uint, );
    union _Anonymous_83
    {
        struct___pthread_mutex_s __data;
        char[40] __size;
        c_long __align;
    }


    int str_to_uint32_hex(const(char)*, uint32_t*, );
    int i_memcasecmp(const(void)*, const(void)*, int, );
    void event_unset_global_debug_log_filter();
    int gettimeofday(struct_timeval*, __timezone_ptr_t, );
    alias int_fast8_t = byte;
    char* index(const(char)*, int, );




    pool_t pool_datastack_create();
    void i_set_fatal_handler(void function(const struct_failure_context*, const(char)*, int)*, );


    int i_strcmp_p(const(const(char)*)*, const(const(char)*)*, );






    int str_parse_uint32_hex(const(char)*, uint32_t*, const(char)**, );
    int i_strcasecmp_p(const(const(char)*)*, const(const(char)*)*, );






    alias int_fast16_t = c_long;


    void i_getopt_reset();
    alias int_fast32_t = c_long;
    void event_set_global_debug_send_filter(struct_event_filter*, );


    alias int_fast64_t = c_long;
    clock_t clock();


    bool mem_equals_timing_safe(const(void)*, const(void)*, int, );
    int str_to_uint64_hex(const(char)*, uint64_t*, );




    pool_t pool_allocfree_create(const(char)*, );




    int settimeofday(const struct_timeval*, const struct_timezone*, );
    void i_set_error_handler(failure_callback_t*, );
    struct_event_filter* event_get_global_debug_send_filter();
    uint64_t bits_rotr64(uint64_t, uint, );
    void i_set_info_handler(failure_callback_t*, );
    int str_parse_uint64_hex(const(char)*, uint64_t*, const(char)**, );
    time_t time(time_t*, );






    char* i_strchr_to_next(const(char)*, char, );
    union _Anonymous_84
    {
        struct___pthread_cond_s __data;
        char[48] __size;
        long __align;
    }
    void i_set_debug_handler(failure_callback_t*, );




    void event_unset_global_debug_send_filter();
    struct _Anonymous_85
    {
        long quot;
        long rem;
    }
    alias lldiv_t = _Anonymous_85;
    void lib_atexit(lib_atexit_callback_t*, );


    struct_event* event_create(struct_event*, const(char)*, uint, );
    pool_t pool_allocfree_create_clean(const(char)*, );
    void i_get_failure_handlers(failure_callback_t**, failure_callback_t**, failure_callback_t**, failure_callback_t**, );




    double difftime(time_t, time_t, );
    int str_to_uintmax_hex(const(char)*, uintmax_t*, );


    ssize_t pwritev(int, const struct_iovec*, int, __off_t, );
    int str_parse_uintmax_hex(const(char)*, uintmax_t*, const(char)**, );


    void lib_atexit_priority(lib_atexit_callback_t*, int, );




    alias uint_fast8_t = ubyte;
    time_t mktime(struct_tm*, );
    int pool_get_exp_grown_size();
    int adjtime(const struct_timeval*, struct_timeval*, );




    void default_fatal_handler(const struct_failure_context*, const(char)*, int, );


    void lib_atexit_run();
    alias uint_fast16_t = c_ulong;
    void* t_malloc_no0(int, );
    uint32_t bits_rotr32(uint32_t, uint, );
    char** p_strsplit(pool_t, const(char)*, const(char)*, );




    void* t_malloc0(int, );




    alias uint_fast64_t = c_ulong;


    const(char)** t_strsplit(const(char)*, const(char)*, );
    void lib_init();
    union _Anonymous_86
    {
        struct___pthread_rwlock_arch_t __data;
        char[56] __size;
        c_long __align;
    }


    void default_error_handler(const struct_failure_context*, const(char)*, int, );
    bool lib_is_initialized();


    int str_to_uint_oct(const(char)*, uint*, );


    void lib_deinit();






    bool t_try_realloc(void*, int, );
    enum enum___itimer_which
    {
        ITIMER_REAL = 0,
        ITIMER_VIRTUAL = 1,
        ITIMER_PROF = 2,
    }
    enum
    {
        ITIMER_REAL = 0,
        ITIMER_VIRTUAL = 1,
        ITIMER_PROF = 2,
    }


    int strftime();
    uint32_t i_rand();
    int str_parse_uint_oct(const(char)*, uint*, const(char)**, );






    void* memchr(const(void)*, int, int, );
    char** p_strsplit_spaces(pool_t, const(char)*, const(char)*, );
    uint32_t i_rand_limit(uint32_t, );




    void i_syslog_fatal_handler(const struct_failure_context*, const(char)*, int, );


    int str_to_ulong_oct(const(char)*, c_ulong*, );
    int t_get_bytes_available();
    const(char)** t_strsplit_spaces(const(char)*, const(char)*, );
    uint64_t i_bswap_64(uint64_t, );
    union _Anonymous_87
    {
        char[8] __size;
        c_long __align;
    }






    int str_parse_ulong_oct(const(char)*, c_ulong*, const(char)**, );



    uint32_t i_rand_minmax(uint32_t, uint32_t, );






    void i_syslog_error_handler(const struct_failure_context*, const(char)*, int, );


    void p_strsplit_free(pool_t, char**, );
    struct_event_passthrough* event_create_passthrough(struct_event*, const(char)*, uint, );
    char* rindex(const(char)*, int, );
    const(char)* dec2str(uintmax_t, );
    void* p_malloc(pool_t, int, );


    int __ctype_get_mb_cur_max();


    int str_to_ullong_oct(const(char)*, ulong*, );
    int str_parse_ullong_oct(const(char)*, ulong*, const(char)**, );


    enum _Anonymous_88
    {
        IPPROTO_HOPOPTS = 0,
        IPPROTO_ROUTING = 43,
        IPPROTO_FRAGMENT = 44,
        IPPROTO_ICMPV6 = 58,
        IPPROTO_NONE = 59,
        IPPROTO_DSTOPTS = 60,
        IPPROTO_MH = 135,
    }


    void i_set_failure_syslog(const(char)*, int, int, );
    char* dec2str_buf(char, uintmax_t, );
    alias uintptr_t = c_ulong;
    double atof(const(char)*, );
    void* p_realloc(pool_t, void*, int, int, );
    int str_to_uint32_oct(const(char)*, uint32_t*, );
    void i_set_failure_file(const(char)*, const(char)*, );
    uint str_array_length(const(const(char)*)*, );
    struct_event* event_ref(struct_event*, );
    int atoi(const(char)*, );


    uint32_t i_bswap_32(uint32_t, );


    int strftime_l();
    struct struct_itimerval
    {
        struct_timeval it_interval;
        struct_timeval it_value;
    }
    int ffs(int, );


    int str_parse_uint32_oct(const(char)*, uint32_t*, const(char)**, );




    void i_set_failure_internal();
    const(char)* t_strarray_join(const(const(char)*)*, const(char)*, );




    void* t_buffer_get(int, );
    void event_unref(struct_event**, );


    c_long atol(const(char)*, );


    int str_to_uint64_oct(const(char)*, uint64_t*, );


    union _Anonymous_89
    {
        char[32] __size;
        c_long __align;
    }


    bool str_array_remove(const(char)**, const(char)*, );
    void i_set_failure_ignore_errors(bool, );
    void* t_buffer_reget(void*, int, );




    int str_parse_uint64_oct(const(char)*, uint64_t*, const(char)**, );


    uint bits_fraclog(uint, uint, );
    bool str_array_find(const(const(char)*)*, const(char)*, );




    alias intmax_t = __intmax_t;


    alias uintmax_t = __uintmax_t;


    int str_to_uintmax_oct(const(char)*, uintmax_t*, );




    long atoll(const(char)*, );
    uint16_t i_bswap_16(uint16_t, );
    bool str_array_icase_find(const(const(char)*)*, const(char)*, );
    void i_set_info_file(const(char)*, );
    void t_buffer_alloc(int, );






    union _Anonymous_90
    {
        char[4] __size;
        int __align;
    }
    int str_parse_uintmax_oct(const(char)*, uintmax_t*, const(char)**, );


    const(char)** p_strarray_dup(pool_t, const(const(char)*)*, );
    void t_buffer_alloc_last_full();






    void i_set_debug_file(const(char)*, );
    int strcasecmp(const(char)*, const(char)*, );
    void p_free_internal(pool_t, void*, );


    double strtod(const(char)*, char**, );
    alias __itimer_which_t = int;


    void data_stack_set_clean_after_pop(bool, );


    uint8_t i_bswap_8(uint8_t, );


    struct_tm* gmtime(const(const time_t)*, );


    char* p_array_const_string_join(pool_t, const union_array__const_string*, const(char)*, );






    void i_set_failure_prefix(const(char)*, ...);


    int strncasecmp(const(char)*, const(char)*, int, );
    struct_event* event_push_global(struct_event*, );
    void data_stack_init();




    void data_stack_deinit();
    char* strcpy(char*, const(char)*, );
    int str_to_int(const(char)*, int*, );







    void i_unset_failure_prefix();
    uint bits_fraclog_bucket_start(uint, uint, );
    int getitimer(__itimer_which_t, struct_itimerval*, );
    enum IPPORT
    {
        IPPORT_ECHO = 7,
        IPPORT_DISCARD = 9,
        IPPORT_SYSTAT = 11,
        IPPORT_DAYTIME = 13,
        IPPORT_NETSTAT = 15,
        IPPORT_FTP = 21,
        IPPORT_TELNET = 23,
        IPPORT_SMTP = 25,
        IPPORT_TIMESERVER = 37,
        IPPORT_NAMESERVER = 42,
        IPPORT_WHOIS = 43,
        IPPORT_MTP = 57,
        IPPORT_TFTP = 69,
        IPPORT_RJE = 77,
        IPPORT_FINGER = 79,
        IPPORT_TTYLINK = 87,
        IPPORT_SUPDUP = 95,
        IPPORT_EXECSERVER = 512,
        IPPORT_LOGINSERVER = 513,
        IPPORT_CMDSERVER = 514,
        IPPORT_EFSSERVER = 520,
        IPPORT_BIFFUDP = 512,
        IPPORT_WHOSERVER = 513,
        IPPORT_ROUTESERVER = 520,
        I1024 = 1024,
        IPPORT_USERRESERVED = 5000,
    }
    void p_clear(pool_t, );


    struct_event* event_pop_global(struct_event*, );
    float strtof(const(char)*, char**, );
    int str_parse_int(const(char)*, int*, const(char)**, );
    struct_tm* localtime(const(const time_t)*, );
    const(char)* i_get_failure_prefix();






    char* strncpy(char*, const(char)*, int, );
    void i_set_failure_timestamp_format(const(char)*, );
    struct_event* event_get_global();
    char* t_noalloc_strdup_vprintf(const(char)*, int, uint*, );




    uint64_t be64_to_cpu_unaligned(const(void)*, );
    int str_to_long(const(char)*, c_long*, );
    real strtold(const(char)*, char**, );






    int p_get_max_easy_alloc_size();




    int str_parse_long(const(char)*, c_long*, const(char)**, );
    int strcasecmp_l(const(char)*, const(char)*, locale_t, );
    int setitimer(__itimer_which_t, const struct_itimerval*, struct_itimerval*, );
    struct_tm* gmtime_r(const(const time_t)*, struct_tm*, );
    char* vstrconcat(const(char)*, int, int*, );






    void i_set_failure_send_ip(const struct_ip_addr*, );
    struct_event* event_set_append_log_prefix(struct_event*, const(char)*, );
    char* strcat(char*, const(char)*, );


    void i_set_failure_send_prefix(const(char)*, );




    int i_my_strcasecmp(const(char)*, const(char)*, );




    int str_to_llong(const(char)*, long*, );


    int i_my_strncasecmp(const(char)*, const(char)*, int, );




    char* strncat(char*, const(char)*, int, );
    const(char)* pool_get_name(pool_t, );
    int strncasecmp_l(const(char)*, const(char)*, int, locale_t, );
    struct_tm* localtime_r(const(const time_t)*, struct_tm*, );
    int str_parse_llong(const(char)*, long*, const(char)**, );
    struct_event* event_replace_log_prefix(struct_event*, const(char)*, );


    void i_set_failure_exit_callback(void function(int*), );
    int utimes(const(char)*, const struct_timeval*, );
    uint bits_fraclog_bucket_end(uint, uint, );




    void failure_exit(int, );
    int str_to_int32(const(char)*, int32_t*, );
    int strcmp(const(char)*, const(char)*, );




    void pool_ref(pool_t, );






    struct_event* event_set_name(struct_event*, const(char)*, );
    int str_parse_int32(const(char)*, int32_t*, const(char)**, );


    void i_failure_parse_line(const(char)*, struct_failure_line*, );
    char* asctime(const struct_tm*, );


    c_long strtol(const(char)*, char**, int, );


    int strncmp(const(char)*, const(char)*, int, );
    void failures_deinit();


    int lutimes(const(char)*, const struct_timeval*, );


    void cpu64_to_be_unaligned(uint64_t, void*, );


    int i_my_inet_aton(const(char)*, struct_in_addr*, );


    int str_to_int64(const(char)*, int64_t*, );
    void pool_unref(pool_t*, );


    char* ctime(const(const time_t)*, );
    int str_parse_int64(const(char)*, int64_t*, const(char)**, );
    c_ulong strtoul(const(char)*, char**, int, );
    struct _Anonymous_92
    {
        int[2] __val;
    }
    int strcoll(const(char)*, const(char)*, );
    struct_event* event_set_source(struct_event*, const(char)*, uint, bool, );


    int futimes(int, const struct_timeval*, );
    int strxfrm();


    int str_to_intmax(const(char)*, intmax_t*, );
    void i_my_vsyslog(int, const(char)*, int, );






    int str_parse_intmax(const(char)*, intmax_t*, const(char)**, );


    char* asctime_r(const struct_tm*, char*, );




    struct_event* event_set_always_log_source(struct_event*, );
    long strtoq(const(char)*, char**, int, );


    int pool_alloconly_get_total_used_size();




    int i_my_getpagesize();






    char* ctime_r(const(const time_t)*, char*, );
    int pool_alloconly_get_total_alloc_size();


    uint32_t be32_to_cpu_unaligned(const(void)*, );




    int str_to_uid(const(char)*, uid_t*, );


    int strcoll_l(const(char)*, const(char)*, locale_t, );
    struct_event* event_add_categories(struct_event*, struct_event_category**, );
    ulong strtouq(const(char)*, char**, int, );
    int pool_allocfree_get_total_used_size();


    int pool_allocfree_get_total_alloc_size();
    struct struct_const_iovec
    {
        const(void)* iov_base;
        int iov_len;
    }
    int str_to_gid(const(char)*, gid_t*, );




    struct_event* event_add_category(struct_event*, struct_event_category*, );
    int strxfrm_l();
    extern __gshared char*[2] __tzname;






    extern __gshared int __daylight;
    void pool_system_free(pool_t, void*, );
    extern __gshared c_long __timezone;


    int str_to_pid(const(char)*, pid_t*, );
    long strtoll(const(char)*, char**, int, );




    struct _Anonymous_93
    {
        void* iov_base;
        int iov_len;
    }
    int str_to_ino(const(char)*, ino_t*, );





    void cpu32_to_be_unaligned(uint32_t, void*, );
    extern __gshared char*[2] tzname;
    struct_event* event_add_str(struct_event*, const(char)*, const(char)*, );
    char* strdup(const(char)*, );
    int str_to_uoff(const(char)*, int*, );
    ulong strtoull(const(char)*, char**, int, );
    struct_event* event_add_int(struct_event*, const(char)*, intmax_t, );
    int str_parse_uoff(const(char)*, int*, const(char)**, );
    void tzset();


    struct_event* event_add_timeval(struct_event*, const(char)*, const struct_timeval*, );






    int str_to_time(const(char)*, time_t*, );


    uint16_t be16_to_cpu_unaligned(const(void)*, );
    extern __gshared int daylight;
    char* strndup(const(char)*, int, );
    extern __gshared c_long timezone;


    struct_event* event_add_fields(struct_event*, const struct_event_add_field*, );
    struct_event* event_get_parent(struct_event*, );
    void event_get_create_time(struct_event*, struct_timeval*, );
    int stime(const(const time_t)*, );
    bool str_is_numeric(const(char)*, char, );




    void cpu16_to_be_unaligned(uint16_t, void*, );






    bool event_get_last_send_time(struct_event*, struct_timeval*, );






    bool str_is_float(const(char)*, char, );


    ssize_t i_my_writev(int, const struct_iovec*, int, );




    const struct_event_field* event_find_field(struct_event*, const(char)*, );







    const(char)* str_num_error(const(char)*, );
    uint8_t be8_to_cpu_unaligned(const(void)*, );
    const(char)* event_find_field_str(struct_event*, const(char)*, );




    ssize_t i_my_pread(int, void*, int, off_t, );


    ssize_t i_my_pwrite(int, const(void)*, int, off_t, );


    void cpu8_to_be_unaligned(uint8_t, void*, );


    enum _Anonymous_94
    {
        MSG_OOB = 1,
        MSG_PEEK = 2,
        MSG_DONTROUTE = 4,
        MSG_CTRUNC = 8,
        MSG_PROXY = 16,
        MSG_TRUNC = 32,
        MSG_DONTWAIT = 64,
        MSG_EOR = 128,
        MSG_WAITALL = 256,
        MSG_FIN = 512,
        MSG_SYN = 1024,
        MSG_CONFIRM = 2048,
        MSG_RST = 4096,
        MSG_ERRQUEUE = 8192,
        MSG_NOSIGNAL = 16384,
        MSG_MORE = 32768,
        MSG_WAITFORONE = 65536,
        MSG_BATCH = 262144,
        MSG_FASTOPEN = 536870912,
        MSG_CMSG_CLOEXEC = 1073741824,
    }
    time_t timegm(struct_tm*, );
    const struct_event_field* event_get_fields(struct_event*, uint*, );
    time_t timelocal(struct_tm*, );


    int i_my_seteuid(uid_t, );
    struct_event_category** event_get_categories(struct_event*, uint*, );


    int dysize(int, );
    int i_my_setegid(gid_t, );
    void event_export(const struct_event*, string_t*, );
    char* i_my_basename(char*, );




    bool event_import(struct_event*, const(char)*, const(char)**, );




    int nanosleep(const struct_timespec*, struct_timespec*, );


    bool event_import_unescaped(struct_event*, const(const(char)*)*, const(char)**, );
    int clock_getres(clockid_t, struct_timespec*, );


    void event_send_abort(struct_event*, );
    int clock_gettime(clockid_t, struct_timespec*, );
    int clock_settime(clockid_t, const struct_timespec*, );
    void event_category_unregister(struct_event_category*, );
    int i_my_clock_gettime(int, struct_timespec*, );




    char* strchr(const(char)*, int, );


    void lib_event_init();


    void lib_event_deinit();
    int clock_nanosleep(clockid_t, int, const struct_timespec*, struct_timespec*, );
    void cpu64_to_le_unaligned(uint64_t, void*, );


    uint64_t cpu64_to_cpu_unaligned(const(void)*, );
    uint64_t le64_to_cpu_unaligned(const(void)*, );




    uint32_t cpu32_to_cpu_unaligned(const(void)*, );
    uint32_t le32_to_cpu_unaligned(const(void)*, );
    void cpu32_to_le_unaligned(uint32_t, void*, );


    uint16_t cpu16_to_cpu_unaligned(const(void)*, );
    void cpu16_to_le_unaligned(uint16_t, void*, );




    uint16_t le16_to_cpu_unaligned(const(void)*, );


    void cpu8_to_le_unaligned(uint8_t, void*, );




    uint8_t cpu8_to_cpu_unaligned(const(void)*, );
    uint8_t le8_to_cpu_unaligned(const(void)*, );






    int clock_getcpuclockid(pid_t, clockid_t*, );
    int timer_create(clockid_t, struct_sigevent*, timer_t*, );
    int timer_delete(timer_t, );






    int timer_settime(timer_t, int, const struct_itimerspec*, struct_itimerspec*, );
    char* strrchr(const(char)*, int, );


    int timer_gettime(timer_t, struct_itimerspec*, );
    int timer_getoverrun(timer_t, );


    uint64_t le64_to_cpu(uint64_t, );
    uint64_t be64_to_cpu(uint64_t, );
    uint64_t cpu64_to_be(uint64_t, );




    uint64_t cpu64_to_le(uint64_t, );



    uint32_t cpu32_to_le(uint32_t, );


    uint32_t le32_to_cpu(uint32_t, );
    uint32_t be32_to_cpu(uint32_t, );
    uint32_t cpu32_to_be(uint32_t, );


    uint16_t le16_to_cpu(uint16_t, );
    uint16_t cpu16_to_be(uint16_t, );
    uint16_t be16_to_cpu(uint16_t, );


    uint16_t cpu16_to_le(uint16_t, );
    uint8_t le8_to_cpu(uint8_t, );


    uint8_t be8_to_cpu(uint8_t, );
    uint8_t cpu8_to_le(uint8_t, );
    uint8_t cpu8_to_be(uint8_t, );


    int timespec_get(struct_timespec*, int, );
    char* l64a(c_long, );



    alias imaxdiv_t = _Anonymous_95;
    struct _Anonymous_95
    {
        c_long quot;
        c_long rem;
    }
    int strcspn();


    c_long a64l(const(char)*, );




    int strspn();
    c_long random();
    void srandom(uint, );
    intmax_t imaxabs(intmax_t, );
    imaxdiv_t imaxdiv(intmax_t, intmax_t, );
    char* initstate(uint, char*, int, );


    intmax_t strtoimax(const(char)*, char**, int, );
    char* setstate(char*, );
    uintmax_t strtoumax(const(char)*, char**, int, );
    char* strpbrk(const(char)*, const(char)*, );
    intmax_t wcstoimax(const(const __gwchar_t)*, __gwchar_t**, int, );
    struct struct_random_data
    {
        int32_t* fptr;
        int32_t* rptr;
        int32_t* state;
        int rand_type;
        int rand_deg;
        int rand_sep;
        int32_t* end_ptr;
    }
    uintmax_t wcstoumax(const(const __gwchar_t)*, __gwchar_t**, int, );
    int random_r(struct_random_data*, int32_t*, );
    int srandom_r(uint, struct_random_data*, );
    int initstate_r(uint, char*, int, struct_random_data*, );
    enum _Anonymous_96
    {
        SCM_RIGHTS = 1,
    }
    char* strstr(const(char)*, const(char)*, );
    int setstate_r(char*, struct_random_data*, );
    char* strtok(char*, const(char)*, );
    int rand();
    char* __strtok_r(char*, const(char)*, char**, );
    void srand(uint, );
    int rand_r(uint*, );
    char* strtok_r(char*, const(char)*, char**, );
    double drand48();
    double erand48(ushort*, );
    c_long lrand48();
    c_long nrand48(ushort*, );
    c_long mrand48();
    c_long jrand48(ushort*, );
    void srand48(c_long, );
    ushort* seed48(ushort*, );
    void lcong48(ushort*, );
    struct struct_drand48_data
    {
        ushort[3] __x;
        ushort[3] __old_x;
        ushort __c;
        ushort __init;
        ulong __a;
    }
    int strlen();
    int drand48_r(struct_drand48_data*, double*, );
    int erand48_r(ushort*, struct_drand48_data*, double*, );
    int strnlen();
    int lrand48_r(struct_drand48_data*, c_long*, );
    char* strerror(int, );
    int nrand48_r(ushort*, struct_drand48_data*, c_long*, );
    int mrand48_r(struct_drand48_data*, c_long*, );
    int jrand48_r(ushort*, struct_drand48_data*, c_long*, );
    int strerror_r(int, char*, int, );
    int srand48_r(c_long, struct_drand48_data*, );
    int seed48_r(ushort*, struct_drand48_data*, );
    int lcong48_r(ushort*, struct_drand48_data*, );
    void* malloc(int, );
    void* calloc(int, int, );
    char* strerror_l(int, locale_t, );
    void* realloc(void*, int, );
    void explicit_bzero(void*, int, );
    char* strsep(char**, const(char)*, );
    char* strsignal(int, );
    void free(void*, );
    char* __stpcpy(char*, const(char)*, );
    char* stpcpy(char*, const(char)*, );
    char* __stpncpy(char*, const(char)*, int, );
    void* valloc(int, );
    char* stpncpy(char*, const(char)*, int, );
    int posix_memalign(void**, int, int, );
    void* aligned_alloc(int, int, );
    void abort();
    int atexit(void function(), );
    int at_quick_exit(void function(), );
    int on_exit(void function(int, void*), void*, );
    void exit(int, );
    void quick_exit(int, );
    void _Exit(int, );
    char* getenv(const(char)*, );
    int putenv(char*, );
    int setenv(const(char)*, const(char)*, int, );
    int unsetenv(const(char)*, );
    int clearenv();
    char* mktemp(char*, );
    int mkstemp(char*, );
    int mkstemps(char*, int, );
    char* mkdtemp(char*, );
    int system(const(char)*, );
    char* realpath(const(char)*, char*, );


    alias __compar_fn_t = _Anonymous_97;
    void* bsearch(const(void)*, const(void)*, int, int, __compar_fn_t, );
    void qsort(void*, int, int, __compar_fn_t, );
    int abs(int, );
    c_long labs(c_long, );
    long llabs(long, );
    div_t div(int, int, );
    ldiv_t ldiv(c_long, c_long, );
    lldiv_t lldiv(long, long, );
    char* ecvt(double, int, int*, int*, );
    char* fcvt(double, int, int*, int*, );
    char* gcvt(double, int, char*, );
    char* qecvt(real, int, int*, int*, );
    char* qfcvt(real, int, int*, int*, );
    char* qgcvt(real, int, char*, );
    int ecvt_r(double, int, int*, int*, char*, int, );
    int fcvt_r(double, int, int*, int*, char*, int, );
    int qecvt_r(real, int, int*, int*, char*, int, );
    int qfcvt_r(real, int, int*, int*, char*, int, );
    int mblen(const(char)*, int, );
    int mbtowc(int*, const(char)*, int, );
    int wctomb(char*, int, );
    int mbstowcs();
    int wcstombs();
    int rpmatch(const(char)*, );
    int getsubopt(char**, char**, char**, );
    int getloadavg(double*, int, );
}

extern(C) {




    enum _Anonymous_98
    {
        _ISupper = 256,
        _ISlower = 512,
        _ISalpha = 1024,
        _ISdigit = 2048,
        _ISxdigit = 4096,
        _ISspace = 8192,
        _ISprint = 16384,
        _ISgraph = 32768,
        _ISblank = 1,
        _IScntrl = 2,
        _ISpunct = 4,
        _ISalnum = 8,
    }
    enum
    {
        _ISupper = 256,
        _ISlower = 512,
        _ISalpha = 1024,
        _ISdigit = 2048,
        _ISxdigit = 4096,
        _ISspace = 8192,
        _ISprint = 16384,
        _ISgraph = 32768,
        _ISblank = 1,
        _IScntrl = 2,
        _ISpunct = 4,
        _ISalnum = 8,
    }
    const(ushort)** __ctype_b_loc();
    const(const __int32_t)** __ctype_tolower_loc();
    const(const __int32_t)** __ctype_toupper_loc();
    int isalnum(int, );
    int isalpha(int, );
    int iscntrl(int, );
    int isdigit(int, );
    int islower(int, );
    int isgraph(int, );
    int isprint(int, );
    int ispunct(int, );
    int isspace(int, );
    int isupper(int, );
    int isxdigit(int, );
    int tolower(int, );
    int toupper(int, );
    int isblank(int, );
    int isascii(int, );
    struct _Anonymous_99
    {
        int[2] __val;
    }
    int toascii(int, );
    int _toupper(int, );
    int _tolower(int, );
    int isalnum_l(int, locale_t, );
    int isalpha_l(int, locale_t, );
    int iscntrl_l(int, locale_t, );
    int isdigit_l(int, locale_t, );
    int islower_l(int, locale_t, );
    int isgraph_l(int, locale_t, );
    int isprint_l(int, locale_t, );
    int ispunct_l(int, locale_t, );
    int isspace_l(int, locale_t, );
    int isupper_l(int, locale_t, );
    int isxdigit_l(int, locale_t, );
    int isblank_l(int, locale_t, );
    int __tolower_l(int, locale_t, );
    int tolower_l(int, locale_t, );
    int __toupper_l(int, locale_t, );
    int toupper_l(int, locale_t, );
}

extern(C) {
    void closelog();
    void openlog(const(char)*, int, int, );
    int setlogmask(int, );
    void syslog(int, const(char)*, ...);
    void i_my_vsyslog(int, const(char)*, int, );
}

extern(C) {
    enum _Anonymous_100
    {
        _PC_LINK_MAX = 0,
        _PC_MAX_CANON = 1,
        _PC_MAX_INPUT = 2,
        _PC_NAME_MAX = 3,
        _PC_PATH_MAX = 4,
        _PC_PIPE_BUF = 5,
        _PC_CHOWN_RESTRICTED = 6,
        _PC_NO_TRUNC = 7,
        _PC_VDISABLE = 8,
        _PC_SYNC_IO = 9,
        _PC_ASYNC_IO = 10,
        _PC_PRIO_IO = 11,
        _PC_SOCK_MAXBUF = 12,
        _PC_FILESIZEBITS = 13,
        _PC_REC_INCR_XFER_SIZE = 14,
        _PC_REC_MAX_XFER_SIZE = 15,
        _PC_REC_MIN_XFER_SIZE = 16,
        _PC_REC_XFER_ALIGN = 17,
        _PC_ALLOC_SIZE_MIN = 18,
        _PC_SYMLINK_MAX = 19,
        _PC_2_SYMLINKS = 20,
    }
    enum _Anonymous_101
    {
        _SC_ARG_MAX = 0,
        _SC_CHILD_MAX = 1,
        _SC_CLK_TCK = 2,
        _SC_NGROUPS_MAX = 3,
        _SC_OPEN_MAX = 4,
        _SC_STREAM_MAX = 5,
        _SC_TZNAME_MAX = 6,
        _SC_JOB_CONTROL = 7,
        _SC_SAVED_IDS = 8,
        _SC_REALTIME_SIGNALS = 9,
        _SC_PRIORITY_SCHEDULING = 10,
        _SC_TIMERS = 11,
        _SC_ASYNCHRONOUS_IO = 12,
        _SC_PRIORITIZED_IO = 13,
        _SC_SYNCHRONIZED_IO = 14,
        _SC_FSYNC = 15,
        _SC_MAPPED_FILES = 16,
        _SC_MEMLOCK = 17,
        _SC_MEMLOCK_RANGE = 18,
        _SC_MEMORY_PROTECTION = 19,
        _SC_MESSAGE_PASSING = 20,
        _SC_SEMAPHORES = 21,
        _SC_SHARED_MEMORY_OBJECTS = 22,
        _SC_AIO_LISTIO_MAX = 23,
        _SC_AIO_MAX = 24,
        _SC_AIO_PRIO_DELTA_MAX = 25,
        _SC_DELAYTIMER_MAX = 26,
        _SC_MQ_OPEN_MAX = 27,
        _SC_MQ_PRIO_MAX = 28,
        _SC_VERSION = 29,
        _SC_PAGESIZE = 30,
        _SC_RTSIG_MAX = 31,
        _SC_SEM_NSEMS_MAX = 32,
        _SC_SEM_VALUE_MAX = 33,
        _SC_SIGQUEUE_MAX = 34,
        _SC_TIMER_MAX = 35,
        _SC_BC_BASE_MAX = 36,
        _SC_BC_DIM_MAX = 37,
        _SC_BC_SCALE_MAX = 38,
        _SC_BC_STRING_MAX = 39,
        _SC_COLL_WEIGHTS_MAX = 40,
        _SC_EQUIV_CLASS_MAX = 41,
        _SC_EXPR_NEST_MAX = 42,
        _SC_LINE_MAX = 43,
        _SC_RE_DUP_MAX = 44,
        _SC_CHARCLASS_NAME_MAX = 45,
        _SC_2_VERSION = 46,
        _SC_2_C_BIND = 47,
        _SC_2_C_DEV = 48,
        _SC_2_FORT_DEV = 49,
        _SC_2_FORT_RUN = 50,
        _SC_2_SW_DEV = 51,
        _SC_2_LOCALEDEF = 52,
        _SC_PII = 53,
        _SC_PII_XTI = 54,
        _SC_PII_SOCKET = 55,
        _SC_PII_INTERNET = 56,
        _SC_PII_OSI = 57,
        _SC_POLL = 58,
        _SC_SELECT = 59,
        _SC_UIO_MAXIOV = 60,
        _SC_IOV_MAX = 60,
        _SC_PII_INTERNET_STREAM = 61,
        _SC_PII_INTERNET_DGRAM = 62,
        _SC_PII_OSI_COTS = 63,
        _SC_PII_OSI_CLTS = 64,
        _SC_PII_OSI_M = 65,
        _SC_T_IOV_MAX = 66,
        _SC_THREADS = 67,
        _SC_THREAD_SAFE_FUNCTIONS = 68,
        _SC_GETGR_R_SIZE_MAX = 69,
        _SC_GETPW_R_SIZE_MAX = 70,
        _SC_LOGIN_NAME_MAX = 71,
        _SC_TTY_NAME_MAX = 72,
        _SC_THREAD_DESTRUCTOR_ITERATIONS = 73,
        _SC_THREAD_KEYS_MAX = 74,
        _SC_THREAD_STACK_MIN = 75,
        _SC_THREAD_THREADS_MAX = 76,
        _SC_THREAD_ATTR_STACKADDR = 77,
        _SC_THREAD_ATTR_STACKSIZE = 78,
        _SC_THREAD_PRIORITY_SCHEDULING = 79,
        _SC_THREAD_PRIO_INHERIT = 80,
        _SC_THREAD_PRIO_PROTECT = 81,
        _SC_THREAD_PROCESS_SHARED = 82,
        _SC_NPROCESSORS_CONF = 83,
        _SC_NPROCESSORS_ONLN = 84,
        _SC_PHYS_PAGES = 85,
        _SC_AVPHYS_PAGES = 86,
        _SC_ATEXIT_MAX = 87,
        _SC_PASS_MAX = 88,
        _SC_XOPEN_VERSION = 89,
        _SC_XOPEN_XCU_VERSION = 90,
        _SC_XOPEN_UNIX = 91,
        _SC_XOPEN_CRYPT = 92,
        _SC_XOPEN_ENH_I18N = 93,
        _SC_XOPEN_SHM = 94,
        _SC_2_CHAR_TERM = 95,
        _SC_2_C_VERSION = 96,
        _SC_2_UPE = 97,
        _SC_XOPEN_XPG2 = 98,
        _SC_XOPEN_XPG3 = 99,
        _SC_XOPEN_XPG4 = 100,
        _SC_CHAR_BIT = 101,
        _SC_CHAR_MAX = 102,
        _SC_CHAR_MIN = 103,
        _SC_INT_MAX = 104,
        _SC_INT_MIN = 105,
        _SC_LONG_BIT = 106,
        _SC_WORD_BIT = 107,
        _SC_MB_LEN_MAX = 108,
        _SC_NZERO = 109,
        _SC_SSIZE_MAX = 110,
        _SC_SCHAR_MAX = 111,
        _SC_SCHAR_MIN = 112,
        _SC_SHRT_MAX = 113,
        _SC_SHRT_MIN = 114,
        _SC_UCHAR_MAX = 115,
        _SC_UINT_MAX = 116,
        _SC_ULONG_MAX = 117,
        _SC_USHRT_MAX = 118,
        _SC_NL_ARGMAX = 119,
        _SC_NL_LANGMAX = 120,
        _SC_NL_MSGMAX = 121,
        _SC_NL_NMAX = 122,
        _SC_NL_SETMAX = 123,
        _SC_NL_TEXTMAX = 124,
        _SC_XBS5_ILP32_OFF32 = 125,
        _SC_XBS5_ILP32_OFFBIG = 126,
        _SC_XBS5_LP64_OFF64 = 127,
        _SC_XBS5_LPBIG_OFFBIG = 128,
        _SC_XOPEN_LEGACY = 129,
        _SC_XOPEN_REALTIME = 130,
        _SC_XOPEN_REALTIME_THREADS = 131,
        _SC_ADVISORY_INFO = 132,
        _SC_BARRIERS = 133,
        _SC_BASE = 134,
        _SC_C_LANG_SUPPORT = 135,
        _SC_C_LANG_SUPPORT_R = 136,
        _SC_CLOCK_SELECTION = 137,
        _SC_CPUTIME = 138,
        _SC_THREAD_CPUTIME = 139,
        _SC_DEVICE_IO = 140,
        _SC_DEVICE_SPECIFIC = 141,
        _SC_DEVICE_SPECIFIC_R = 142,
        _SC_FD_MGMT = 143,
        _SC_FIFO = 144,
        _SC_PIPE = 145,
        _SC_FILE_ATTRIBUTES = 146,
        _SC_FILE_LOCKING = 147,
        _SC_FILE_SYSTEM = 148,
        _SC_MONOTONIC_CLOCK = 149,
        _SC_MULTI_PROCESS = 150,
        _SC_SINGLE_PROCESS = 151,
        _SC_NETWORKING = 152,
        _SC_READER_WRITER_LOCKS = 153,
        _SC_SPIN_LOCKS = 154,
        _SC_REGEXP = 155,
        _SC_REGEX_VERSION = 156,
        _SC_SHELL = 157,
        _SC_SIGNALS = 158,
        _SC_SPAWN = 159,
        _SC_SPORADIC_SERVER = 160,
        _SC_THREAD_SPORADIC_SERVER = 161,
        _SC_SYSTEM_DATABASE = 162,
        _SC_SYSTEM_DATABASE_R = 163,
        _SC_TIMEOUTS = 164,
        _SC_TYPED_MEMORY_OBJECTS = 165,
        _SC_USER_GROUPS = 166,
        _SC_USER_GROUPS_R = 167,
        _SC_2_PBS = 168,
        _SC_2_PBS_ACCOUNTING = 169,
        _SC_2_PBS_LOCATE = 170,
        _SC_2_PBS_MESSAGE = 171,
        _SC_2_PBS_TRACK = 172,
        _SC_SYMLOOP_MAX = 173,
        _SC_STREAMS = 174,
        _SC_2_PBS_CHECKPOINT = 175,
        _SC_V6_ILP32_OFF32 = 176,
        _SC_V6_ILP32_OFFBIG = 177,
        _SC_V6_LP64_OFF64 = 178,
        _SC_V6_LPBIG_OFFBIG = 179,
        _SC_HOST_NAME_MAX = 180,
        _SC_TRACE = 181,
        _SC_TRACE_EVENT_FILTER = 182,
        _SC_TRACE_INHERIT = 183,
        _SC_TRACE_LOG = 184,
        _SC_LEVEL1_ICACHE_SIZE = 185,
        _SC_LEVEL1_ICACHE_ASSOC = 186,
        _SC_LEVEL1_ICACHE_LINESIZE = 187,
        _SC_LEVEL1_DCACHE_SIZE = 188,
        _SC_LEVEL1_DCACHE_ASSOC = 189,
        _SC_LEVEL1_DCACHE_LINESIZE = 190,
        _SC_LEVEL2_CACHE_SIZE = 191,
        _SC_LEVEL2_CACHE_ASSOC = 192,
        _SC_LEVEL2_CACHE_LINESIZE = 193,
        _SC_LEVEL3_CACHE_SIZE = 194,
        _SC_LEVEL3_CACHE_ASSOC = 195,
        _SC_LEVEL3_CACHE_LINESIZE = 196,
        _SC_LEVEL4_CACHE_SIZE = 197,
        _SC_LEVEL4_CACHE_ASSOC = 198,
        _SC_LEVEL4_CACHE_LINESIZE = 199,
        _SC_IPV6 = 235,
        _SC_RAW_SOCKETS = 236,
        _SC_V7_ILP32_OFF32 = 237,
        _SC_V7_ILP32_OFFBIG = 238,
        _SC_V7_LP64_OFF64 = 239,
        _SC_V7_LPBIG_OFFBIG = 240,
        _SC_SS_REPL_MAX = 241,
        _SC_TRACE_EVENT_NAME_MAX = 242,
        _SC_TRACE_NAME_MAX = 243,
        _SC_TRACE_SYS_MAX = 244,
        _SC_TRACE_USER_EVENT_MAX = 245,
        _SC_XOPEN_STREAMS = 246,
        _SC_THREAD_ROBUST_PRIO_INHERIT = 247,
        _SC_THREAD_ROBUST_PRIO_PROTECT = 248,
    }
    struct _Anonymous_102
    {
        int[2] __val;
    }
    enum _Anonymous_103
    {
        _CS_PATH = 0,
        _CS_V6_WIDTH_RESTRICTED_ENVS = 1,
        _CS_GNU_LIBC_VERSION = 2,
        _CS_GNU_LIBPTHREAD_VERSION = 3,
        _CS_V5_WIDTH_RESTRICTED_ENVS = 4,
        _CS_V7_WIDTH_RESTRICTED_ENVS = 5,
        _CS_LFS_CFLAGS = 1000,
        _CS_LFS_LDFLAGS = 1001,
        _CS_LFS_LIBS = 1002,
        _CS_LFS_LINTFLAGS = 1003,
        _CS_LFS64_CFLAGS = 1004,
        _CS_LFS64_LDFLAGS = 1005,
        _CS_LFS64_LIBS = 1006,
        _CS_LFS64_LINTFLAGS = 1007,
        _CS_XBS5_ILP32_OFF32_CFLAGS = 1100,
        _CS_XBS5_ILP32_OFF32_LDFLAGS = 1101,
        _CS_XBS5_ILP32_OFF32_LIBS = 1102,
        _CS_XBS5_ILP32_OFF32_LINTFLAGS = 1103,
        _CS_XBS5_ILP32_OFFBIG_CFLAGS = 1104,
        _CS_XBS5_ILP32_OFFBIG_LDFLAGS = 1105,
        _CS_XBS5_ILP32_OFFBIG_LIBS = 1106,
        _CS_XBS5_ILP32_OFFBIG_LINTFLAGS = 1107,
        _CS_XBS5_LP64_OFF64_CFLAGS = 1108,
        _CS_XBS5_LP64_OFF64_LDFLAGS = 1109,
        _CS_XBS5_LP64_OFF64_LIBS = 1110,
        _CS_XBS5_LP64_OFF64_LINTFLAGS = 1111,
        _CS_XBS5_LPBIG_OFFBIG_CFLAGS = 1112,
        _CS_XBS5_LPBIG_OFFBIG_LDFLAGS = 1113,
        _CS_XBS5_LPBIG_OFFBIG_LIBS = 1114,
        _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS = 1115,
        _CS_POSIX_V6_ILP32_OFF32_CFLAGS = 1116,
        _CS_POSIX_V6_ILP32_OFF32_LDFLAGS = 1117,
        _CS_POSIX_V6_ILP32_OFF32_LIBS = 1118,
        _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS = 1119,
        _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS = 1120,
        _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS = 1121,
        _CS_POSIX_V6_ILP32_OFFBIG_LIBS = 1122,
        _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS = 1123,
        _CS_POSIX_V6_LP64_OFF64_CFLAGS = 1124,
        _CS_POSIX_V6_LP64_OFF64_LDFLAGS = 1125,
        _CS_POSIX_V6_LP64_OFF64_LIBS = 1126,
        _CS_POSIX_V6_LP64_OFF64_LINTFLAGS = 1127,
        _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS = 1128,
        _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS = 1129,
        _CS_POSIX_V6_LPBIG_OFFBIG_LIBS = 1130,
        _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS = 1131,
        _CS_POSIX_V7_ILP32_OFF32_CFLAGS = 1132,
        _CS_POSIX_V7_ILP32_OFF32_LDFLAGS = 1133,
        _CS_POSIX_V7_ILP32_OFF32_LIBS = 1134,
        _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS = 1135,
        _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS = 1136,
        _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS = 1137,
        _CS_POSIX_V7_ILP32_OFFBIG_LIBS = 1138,
        _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS = 1139,
        _CS_POSIX_V7_LP64_OFF64_CFLAGS = 1140,
        _CS_POSIX_V7_LP64_OFF64_LDFLAGS = 1141,
        _CS_POSIX_V7_LP64_OFF64_LIBS = 1142,
        _CS_POSIX_V7_LP64_OFF64_LINTFLAGS = 1143,
        _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS = 1144,
        _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS = 1145,
        _CS_POSIX_V7_LPBIG_OFFBIG_LIBS = 1146,
        _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS = 1147,
        _CS_V6_ENV = 1148,
        _CS_V7_ENV = 1149,
    }
}

extern(C) {
    struct _Anonymous_104
    {
        int[2] __val;
    }
    struct _Anonymous_105
    {
        c_long quot;
        c_long rem;
    }
}

extern(C) {
}
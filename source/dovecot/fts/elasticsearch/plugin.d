module dovecot.fts.elasticsearch.plugin;
import dovecot.api;

/* Copyright (c) 2006-2012 Dovecot authors, see the included COPYING file */
/* Copyright (c) 2014 Joshua Atkins <josh@ascendantcom.com> */


alias mail_user_module_context = union_mail_user_module_context;
alias mail_user = struct_mail_user;
alias mail_storage_hooks = struct_mail_storage_hooks;
enum DOVECOT_ABI_VERSION = "2.2";

//#define FTS_ELASTICSEARCH_USER_CONTEXT(obj) \
   // MODULE_CONTEXT(obj, fts_elasticsearch_user_module)

struct Settings
{
    bool isDebug;
    string url;
}

struct User
{
    mail_user_module_context module_ctx;  /* mail user context */
    fts_elasticsearch_settings set;      /* laoded settings */
}


extern const(char)*[] fts_elasticsearch_plugin_dependencies;
__gshared extern(C) struct_fts_backend fts_backend_elasticsearch;
//extern MODULE_CONTEXT_DEFINE(fts_elasticsearch_user_module, &mail_user_module_register);


//#include "lib.h"
//#include "array.h"
//#include <stdlib.h>

const(char)* fts_elasticsearch_plugin_version = DOVECOT_ABI_VERSION;

//fts_elasticsearch_user_module fts_elasticsearch_user_module = MODULE_CONTEXT_INIT(&mail_user_module_register);
void* fts_elasticsearch_user_module;

extern(C) int fts_elasticsearch_plugin_init_settings(mail_user *user, fts_elasticsearch_settings *set, const(char)* str)
{
    const(char)* * tmp;

    /* validate our parameters */
    if (user is null || set is null) {
        i_error("fts_elasticsearch: critical error initialisation");
        return -1;
    }

    string s = (str is null)? "" : s.fromStringz;
    foreach(col;s.split(' '))
    {
        if (col.startsWith("url="))
        {
            set.url = col[4..$];
        }
        else if (col.startsWith("debug"))
        {
            set.debug_=true;
        }
        else
        {
            i_error("fts_elasticsearch: Invalid setting: %s",col.toStringz);
            return -1;
        }

    }

    return 0;
}

void fts_elasticsearch_mail_user_create(mail_user *user, const(char)* env)
{
    fts_elasticsearch_user *fuser = null;

    /* validate our parameters */
    if (user is null || env is null) {
        i_error("fts_elasticsearch: critical error during mail user creation");
    } else {
        fuser = p_new(user.pool, fts_elasticsearch_user, 1);
        if (fts_elasticsearch_plugin_init_settings(user, &fuser.set, env) < 0) {
            /* invalid settings, disabling */
            return;
        }

        MODULE_CONTEXT_SET(user, fts_elasticsearch_user_module, fuser);
    }
}

void fts_elasticsearch_mail_user_created(mail_user *user)
{
    const(char)* env = null;

    /* validate our parameters */
    if (user is null) {
        i_error("fts_elasticsearch: critical error during mail user creation".ptr);
    } else {
        env = mail_user_plugin_getenv(user, "fts_elasticsearch".ptr);

        if (env !is null) {
            fts_elasticsearch_mail_user_create(user, env);
        }
    }
}

__gshared mail_storage_hooks fts_elasticsearch_mail_storage_hooks;
 shared static this()
{
    //fts_elasticsearch_mail_storage_hooks.mail_user_created = fts_elasticsearch_mail_user_created;
}


void fts_elasticsearch_plugin_init(struct_module* module_)
{
    fts_backend_register(&fts_backend_elasticsearch);
    mail_storage_hooks_add(module_, &fts_elasticsearch_mail_storage_hooks);
}

void fts_elasticsearch_plugin_deinit()
{
    fts_backend_unregister(fts_backend_elasticsearch.name);
    mail_storage_hooks_remove(&fts_elasticsearch_mail_storage_hooks);
}

//const(char)*[] fts_elasticsearch_plugin_dependencies = [ "fts", null ];
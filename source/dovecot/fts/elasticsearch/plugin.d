module dovecot.fts.elasticsearch.plugin;
/* Copyright (c) 2006-2012 Dovecot authors, see the included COPYING file */
/* Copyright (c) 2014 Joshua Atkins <josh@ascendantcom.com> */


#define FTS_ELASTICSEARCH_USER_CONTEXT(obj) \
    MODULE_CONTEXT(obj, fts_elasticsearch_user_module)

struct fts_elasticsearch_settings
{
    bool debug_;         /* whether or not debug is set */
    const(char)* url;    /* base URL to an ElasticSearch instance */
}

struct fts_elasticsearch_user
{
    union mail_user_module_context module_ctx;  /* mail user context */
    fts_elasticsearch_settings set;      /* laoded settings */
}

extern const(char)* fts_elasticsearch_plugin_dependencies[];
extern struct fts_backend fts_backend_elasticsearch;
extern MODULE_CONTEXT_DEFINE(fts_elasticsearch_user_module, &mail_user_module_register);


#include "lib.h"
#include "array.h"
#include "mail-user.h"
#include "mail-storage-hooks.h"

#include <stdlib.h>

const(char)* fts_elasticsearch_plugin_version = DOVECOT_ABI_VERSION;

struct fts_elasticsearch_user_module fts_elasticsearch_user_module = MODULE_CONTEXT_INIT(&mail_user_module_register);

int fts_elasticsearch_plugin_init_settings(mail_user *user, fts_elasticsearch_settings *set, const(char)* str)
{
    const(char)* const *tmp;

    /* validate our parameters */
    if (user is null || set is null) {
        i_error("fts_elasticsearch: critical error initialisation");
        return -1;
    }

    if (str is null) {
        str = "";
    }

    for (tmp = t_strsplit_spaces(str, " "); *tmp !is null; tmp++) {
        if (strncmp(*tmp, "url=", 4) == 0) {
            set->url = p_strdup(user->pool, *tmp + 4);
        } else if (strcmp(*tmp, "debug") == 0) {
            set->debug = TRUE;
        } else {
            i_error("fts_elasticsearch: Invalid setting: %s", *tmp);
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
        fuser = p_new(user->pool, struct fts_elasticsearch_user, 1);
        if (fts_elasticsearch_plugin_init_settings(user, &fuser->set, env) < 0) {
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

struct mail_storage_hooks fts_elasticsearch_mail_storage_hooks = {.mail_user_created = fts_elasticsearch_mail_user_created};
};

void fts_elasticsearch_plugin_init(Module *module_)
{
    fts_backend_register(&fts_backend_elasticsearch);
    mail_storage_hooks_add(module_, &fts_elasticsearch_mail_storage_hooks);
}

void fts_elasticsearch_plugin_deinit()
{
    fts_backend_unregister(fts_backend_elasticsearch.name);
    mail_storage_hooks_remove(&fts_elasticsearch_mail_storage_hooks);
}

const(char)* fts_elasticsearch_plugin_dependencies[] = [ "fts", null ];
#!/usr/bin/env bash

php deploy/maintenance.php start >> /var/custom_logs/maintenance.log

php admin/cli/install_database.php \
    --agree-license \
    --lang=en \
    --adminuser=$CFG_ADMIN_USERNAME \
    --adminpass=$CFG_ADMIN_PASS \
    --adminemail=$CFG_ADMIN_MAIL \
    --fullname="$CFG_SITE_FULLNAME" \
    --shortname="$CFG_SITE_SHORTNAME" \
    --summary="$CFG_SITE_FULLNAME" >> /var/custom_logs/moodle_install.log

php admin/cli/upgrade.php --non-interactive >> /var/custom_logs/moodle_upgrade.log

php deploy/maintenance.php stop >> /var/custom_logs/maintenance.log

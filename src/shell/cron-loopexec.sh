while true; do /usr/local/bin/php /var/www/html/admin/cli/cron.php >> /var/log/cron.log; sleep 60; done

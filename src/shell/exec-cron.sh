while true; do /usr/local/bin/php /var/www/html/admin/cli/cron.php >> /var/custom_logs/cron.log; sleep 60; done

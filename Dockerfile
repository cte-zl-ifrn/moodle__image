FROM moodlehq/moodle-php-apache:7.4

ARG RELEASE_VERSION

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /var/www

RUN MOODLE_VERSION=`echo $RELEASE_VERSION | cut -d . -f 1-3` \
    && curl -L -o v.tar.gz https://github.com/moodle/moodle/archive/refs/tags/v$MOODLE_VERSION.tar.gz \
    && tar -zxf v.tar.gz \
    && rm v.tar.gz \
    && rm -rf /var/www/html/ \
    && mv moodle-* html \
    && chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www \
    && mkdir /var/custom_logs/ \
    && chown -R www-data:www-data /var/custom_logs/ \
    && curl --silent --show-error https://getcomposer.org/installer | php \ 
    && mv composer.phar /usr/bin/composer

WORKDIR /var/www/html

RUN composer require sentry/sdk

ADD src/php/* /var/www/html/
ADD src/php/deploy/* /var/www/html/deploy/
ADD src/php-patch/* /var/www/patch/
ADD src/shell/* /usr/local/bin/

RUN sed -i 's/function init/function init_original/g' vendor/sentry/sentry/src/functions.php \
    && cat /var/www/patch/sentry_functions.php >> /var/www/html/vendor/sentry/sentry/src/functions.php \
    && sed -i 's/abstract class moodle_database {/abstract class moodle_database {\n    protected $last_span = null;/g' lib/dml/moodle_database.php \
    && sed -i 's/protected function query_start/protected function query_start_original/g' lib/dml/moodle_database.php \
    && sed -i 's/protected function query_end/protected function query_end_original/g' lib/dml/moodle_database.php \
    && sed -ie '$s/}/\n/g' lib/dml/moodle_database.php \
    && cat /var/www/patch/moodle_database.php >> lib/dml/moodle_database.php \
    && echo $RELEASE_VERSION > /var/www/html/tag_version.txt

RUN unlink /dev/stderr && unlink /dev/stdout

WORKDIR /var/www/html
VOLUME [ "/var/moodledata/antivirus_quarantine", "/var/moodledata/cache", "/var/moodledata/filedir", "/var/moodledata/lang", "/var/moodledata/localcache", "/var/moodledata/lock", "/var/moodledata/muc", "/var/moodledata/sessions", "/var/moodledata/temp", "/var/moodledata/trashdir" ]
EXPOSE 80
ENTRYPOINT ["docker-php-entrypoint"]
CMD ["apache2-foreground"]

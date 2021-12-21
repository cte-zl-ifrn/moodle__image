FROM moodlehq/moodle-php-apache:7.4

ARG MOODLE_VERSION

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /var/www

RUN curl -L -o v.tar.gz https://github.com/moodle/moodle/archive/refs/tags/v$MOODLE_VERSION.tar.gz \
    && tar -zxf v.tar.gz \
    && rm v.tar.gz \
    && rm -rf /var/www/html/ \
    && mv moodle-* html \
    && chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www \
    && mkdir /var/log/moodle/ \
    && chown -R www-data:www-data /var/log/moodle/ \
    && curl --silent --show-error https://getcomposer.org/installer | php \ 
    && mv composer.phar /usr/bin/composer

WORKDIR /var/www/html

RUN composer require sentry/sdk

ADD patch___* /var/www/
ADD src/* /var/www/html/

RUN sed -i 's/function init/function init_original/g' vendor/sentry/sentry/src/functions.php \
    && cat /var/www/patch___vendor__sentry__sentry__src__functions.php >> /var/www/html/vendor/sentry/sentry/src/functions.php \
    && sed -i 's/abstract class moodle_database {/abstract class moodle_database {\n    protected $last_span = null;/g' lib/dml/moodle_database.php \
    && sed -i 's/protected function query_start/protected function query_start_original/g' lib/dml/moodle_database.php \
    && sed -i 's/protected function query_end/protected function query_end_original/g' lib/dml/moodle_database.php \
    && sed -ie '$s/}//g' lib/dml/moodle_database.php \
    && cat /var/www/patch___lib__dml__moodle_database.php >> lib/dml/moodle_database.php

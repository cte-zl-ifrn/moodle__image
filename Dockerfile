FROM moodlehq/moodle-php-apache:7.4

ARG MOODLE_VERSION

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /var/www

RUN curl -L -o v.tar.gz https://github.com/moodle/moodle/archive/refs/tags/v$MOODLE_VERSION.tar.gz \
    && tar -zxvf v.tar.gz \
    && rm v.tar.gz \
    && rm -rf /var/www/html/ \
    && mv moodle-* html \
    && chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www \
    && mkdir /var/log/moodle/ \
    && chown -R www-data:www-data /var/log/moodle/

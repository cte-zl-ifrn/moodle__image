FROM moodlehq/moodle-php-apache:7.4

ARG MOODLE_VERSION

WORKDIR /var/www

RUN echo $MOODLE_VERSION

RUN curl -L -xo v$MOODLE_VERSION.zip https://github.com/moodle/moodle/archive/refs/tags/v$MOODLE_VERSION.zip \
    && unzip v$MOODLE_VERSION.zip \
    && rm -rf /var/www/html/ \
    && mv moodle-$MOODLE_VERSION html \
    && rm v$MOODLE_VERSION.zip \
    && chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www \
    && mkdir /var/log/moodle/ \
    && chown -R www-data:www-data /var/log/moodle/

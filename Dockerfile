FROM moodlehq/moodle-php-apache:7.4

ARG MOODLE_VERSION

WORKDIR /var/www

RUN echo $MOODLE_VERSION

RUN curl -L -xo v$MOODLE_VERSION.zip https://github.com/moodle/moodle/archive/refs/tags/v$MOODLE_VERSION.zip

RUN unzip v$MOODLE_VERSION.zip

RUN rm -rf /var/www/html/

RUN mv moodle-$MOODLE_VERSION html

RUN rm v$MOODLE_VERSION.zip

RUN chown -R www-data:www-data /var/www

RUN chmod -R 755 /var/www

RUN mkdir /var/log/moodle/

RUN chown -R www-data:www-data /var/log/moodle/

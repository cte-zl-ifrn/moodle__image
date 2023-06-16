FROM moodlehq/moodle-php-apache:8.1-bullseye

ENV DEBIAN_FRONTEND noninteractive
ENV ACCEPT_EULA Y
ENV MOODLE_VERSION 4.1.4

WORKDIR /var/www

RUN apt update && apt upgrade -y && apt-get install -y cron poppler-utils graphviz aspell python3

RUN    curl -L -o v$MOODLE_VERSION.tar.gz https://github.com/moodle/moodle/archive/refs/tags/v$MOODLE_VERSION.tar.gz \
    && tar -zxf v$MOODLE_VERSION.tar.gz \
    && rm v$MOODLE_VERSION.tar.gz \
    && rm -rf /var/www/html/ \
    && mv moodle-$MOODLE_VERSION html \
    && chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www

RUN    mkdir /var/moodledata  && chown -R www-data:www-data /var/moodledata \
    && mkdir /var/custom_logs && chown -R www-data:www-data /var/custom_logs

ADD --chown=www-data:www-data src/php/* /var/www/html/
ADD --chown=www-data:www-data src/php/deploy/* /var/www/html/deploy/
ADD src/shell/* /usr/local/bin/
ADD src/shell/crontab /var/spool/cron/crontabs/root

USER www-data
WORKDIR /var/www/html
EXPOSE 80
ENTRYPOINT ["/usr/local/bin/docker-php-entrypoint"]

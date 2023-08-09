FROM php:8.1.21-apache-bullseye

ARG DEBIAN_FRONTEND=noninteractive

ADD build/php-extensions.sh /tmp/build/php-extensions.sh
ADD build/locale.gen /etc/locale.gen

RUN    apt update \
    && apt upgrade -y \
    && apt-get install -y cron poppler-utils graphviz aspell python3 git vim \
    && rm -rf /var/lib/apt/lists/* \
    && /tmp/build/php-extensions.sh \
    && a2enmod headers \
    && chmod 777 /tmp \
    && chmod +t /tmp

RUN    curl -L https://github.com/moodle/moodle/archive/refs/tags/v4.1.4.tar.gz | tar -zx --strip-components=1 \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && mkdir /var/moodledata \
    && chown -R www-data:www-data /var/moodledata

ADD build/moodle-plugins.sh /tmp/build/moodle-plugins.sh
RUN /tmp/build/moodle-plugins.sh

# USER root
USER www-data
WORKDIR /var/www/html
EXPOSE 80
ENTRYPOINT ["docker-php-entrypoint"]
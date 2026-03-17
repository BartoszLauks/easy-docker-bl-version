FROM php:8.4-fpm-alpine

# System packages
RUN apk add --no-cache $PHPIZE_DEPS bash git zip unzip icu-dev zlib-dev libzip-dev libxml2-dev tzdata

# PHP extensions
RUN docker-php-ext-install pdo_mysql mysqli intl zip opcache

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# User
RUN adduser -D -u 1000 docker
WORKDIR /app

# Konfiguracja środowiska pracy
WORKDIR /app
RUN git config --global --add safe.directory /app

# Log i cron
RUN touch /var/log/schedule.log && chmod 0777 /var/log/schedule.log
ADD crontab /etc/crontabs/root

# Konfiguracja strefy czasowej
ENV TIMEZONE=UTC
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# Przełączenie na użytkownika aplikacyjnego
USER docker

# Uruchomienie cron + php-fpm w tle
CMD crond -b && php-fpm


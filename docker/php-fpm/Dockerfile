FROM php:8.3-fpm-alpine

# Instalacja pakietów systemowych i PHP-owych zależności
RUN apk update && apk add --no-cache \
    $PHPIZE_DEPS \
    bash \
    git \
    zip \
    unzip \
    tzdata \
    zlib-dev \
    libxml2-dev \
    libzip-dev \
    icu-dev \
 && rm -rf /var/cache/apk/*

# Instalacja rozszerzeń PHP
RUN docker-php-ext-configure intl \
 && docker-php-ext-install pdo_mysql mysqli zip opcache intl \
 && docker-php-ext-enable opcache

# Instalacja Composera (jako root, jako user docker wywoła error)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Utworzenie użytkownika nie-rootowego
RUN adduser -D -u 1000 docker && echo "docker:docker" | chpasswd

# Konfiguracja środowiska pracy
WORKDIR /app
RUN git config --system --add safe.directory /app

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

#!/usr/bin/env bash

rm -Rf var/cache/*

# 1 JWT
#mkdir ./config/jwt

COMPOSER_ALLOW_SUPERUSER=1 docker compose exec -T appName-php composer self-update
COMPOSER_ALLOW_SUPERUSER=1 docker compose exec -T appName-php composer update --no-interaction --classmap-authoritative --optimize-autoloader

docker compose exec -T appName-php php bin/console doctrine:database:create --if-not-exists
#Uncomment if app have any migration
#docker compose exec -T appName-php php bin/console doctrine:migrations:migrate --no-interaction

# 1 JWT 
#rm ./config/jwt/*
#openssl genrsa -out ./config/jwt/private.pem -passout pass:"1234" -aes256 4096
#openssl rsa -pubout -in ./config/jwt/private.pem -passin pass:"1234" -out ./config/jwt/public.pem

# 2JWT lexik
#docker compose exec -T appName-php php bin/console lexik:jwt:generate-keypair --overwrite

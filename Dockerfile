FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
   	libicu-dev \
   	libpq-dev \
   	git \
   	unzip \
   	&& docker-php-ext-install intl pdo pdo_pgsql opcache

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/symfony

COPY . .

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN composer install

RUN chown -R www-data:www-data /var/www/symfony
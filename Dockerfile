FROM php:8.3-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libaio1 \
    wget \
    nano \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    libzip-dev \
    zip \
    unzip \
    libcurl4-openssl-dev \
    cron \
    procps \
    libjpeg-dev \
    libfreetype6-dev \
    sqlite3

RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install PHP extensions
RUN docker-php-ext-install \
    pdo_pgsql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    curl \
    intl \
    zip \
    xml \
    sockets

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

COPY php/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Apache root + configs
ENV APACHE_DOCUMENT_ROOT /var/www/html
RUN a2enmod rewrite

WORKDIR /var/www/html

COPY . /var/www/html

COPY apache/* /etc/apache2/sites-available/000-default.conf

RUN chmod +x /var/www/html/docker-entrypoint.sh

EXPOSE 80

CMD [ "/var/www/html/docker-entrypoint.sh" ]
# Use PHP with Apache as base image
FROM php:8.1-apache

# Set working directory
WORKDIR /var/www/html

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    supervisor \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo_mysql zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy existing application directory contents
COPY . /var/www/html

# Set file permissions for Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Copy Supervisor configuration
COPY ./supervisor/laravel-worker.conf /etc/supervisor/conf.d/

# Copy Apache configuration
COPY ./apache/apache.conf /etc/apache2/sites-available/000-default.conf

# Install Laravel dependencies
RUN composer install --prefer-dist --no-scripts --no-dev --no-interaction

# Expose port 80
EXPOSE 80

# Start Apache and Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]

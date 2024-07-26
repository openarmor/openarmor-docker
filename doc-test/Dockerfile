# Use an official PHP image as a base
FROM php:7.4-apache

# Install necessary PHP extensions and tools
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libonig-dev \
    git \
    && docker-php-ext-install pdo_mysql mysqli curl json mbstring xml

# Enable Apache modules
RUN a2enmod rewrite

# Clone the openarmor-ui repository
RUN git clone https://github.com/openarmor/openarmor-ui.git /var/www/html/openarmor-ui

# Set permissions
RUN chown -R www-data:www-data /var/www/html/openarmor-ui
RUN chmod -R 755 /var/www/html/openarmor-ui

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]

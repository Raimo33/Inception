# Base image
FROM alpine:3.19

# Install dependencies
RUN apk update && apk add --no-cache \
    wget \
    php \
    php-fpm \
    php-mysqli \
    mariadb-client

# Download WordPress
RUN wget https://github.com/WordPress/WordPress/archive/refs/tags/6.5.4.tar.gz -P /var/www

WORKDIR /var/www

# Extract the WordPress files
RUN tar -xvf 6.5.4.tar.gz && rm 6.5.4.tar.gz

# Change owner of the WordPress files (group:user)
RUN chown -R root:root ./WordPress-6.5.4

# Configure PHP-FPM
COPY conf/www.conf /etc/php/php-fpm.d/www.conf

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
ENTRYPOINT ["php-fpm", "-F"]
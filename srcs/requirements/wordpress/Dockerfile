# Base image
FROM debian:11.9

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client

# Download WordPress
RUN wget https://github.com/WordPress/WordPress/archive/refs/tags/6.5.4.tar.gz -P /var/www

WORKDIR /var/www

# Extract the WordPress files
RUN tar -xvf 6.5.4.tar.gz && rm 6.5.4.tar.gz

# Change owner of the WordPress files (group:user)
RUN chown -R root:root ./WordPress-6.5.4

# Configure PHP-FPM
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
ENTRYPOINT ["php-fpm7.4", "-F"]
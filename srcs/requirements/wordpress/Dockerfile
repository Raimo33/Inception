# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:51:03 by craimond          #+#    #+#              #
#    Updated: 2024/07/05 18:18:25 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#TODO incorporare il sito, mettere il logo e altri asset in mariadb forse

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

RUN apk add --no-cache php php-fpm php-mysqli php-json php-curl php-mbstring php-xml curl

WORKDIR /var/www/html

RUN curl -o wordpress-6.5.5.tar.gz https://wordpress.org/wordpress-6.5.5.tar.gz && tar -xvf wordpress-6.5.5.tar.gz && rm -rf wordpress-6.5.5.tar.gz
RUN curl -o /tmp/wp-keys-salts api.wordpress.org/secret-key/1.1/salt/

COPY ./conf/www.conf		/etc/php8/php-fpm.d/www.conf
COPY ./conf/www.conf		/etc/php82/php-fpm.d/www.conf
COPY ./conf/wp-config.php	wordpress/wp-config.php

RUN cat /tmp/wp-keys-salts >> wordpress/wp-config.php && rm -rf /tmp/wp-keys-salts

RUN addgroup -g 1000 -S webgroup && adduser -u 1003 -G webgroup -SD wp-user
RUN chown -R wp-user:webgroup /var/log/php82

#TODO remove (DEBUG PURPOSE)
COPY ./class-wpdb.php /var/www/html/wordpress/wp-includes/class-wpdb.php

USER wp-user:webgroup
EXPOSE 9000

CMD ["/usr/sbin/php-fpm82", "-F"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -f http://localhost:9000/fpm-ping || exit 1
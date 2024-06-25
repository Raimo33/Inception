# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:51:03 by craimond          #+#    #+#              #
#    Updated: 2024/06/25 14:10:30 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache php php-fpm php-mysqli php-json php-curl php-mbstring php-xml curl shadow

WORKDIR /var/www/html

RUN curl -o wordpress-6.5.4.tar.gz https://wordpress.org/wordpress-6.5.4.tar.gz && tar -xvf wordpress-6.5.4.tar.gz && rm wordpress-6.5.4.tar.gz

RUN addgroup -g 1000 webgroup && adduser -S -G webgroup -u 1003 wp-user

COPY ./conf/www.conf		/etc/php8/php-fpm.d/www.conf
COPY ./conf/www.conf		/etc/php82/php-fpm.d/www.conf
COPY ./conf/wp-config.php	./wordpress/wp-config.php

RUN chown -R wp-user:webgroup /var/log/php82

EXPOSE 9000
USER wp-user

ENTRYPOINT ["/usr/sbin/php-fpm82"]
CMD ["-F"]
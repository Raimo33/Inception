# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:51:03 by craimond          #+#    #+#              #
#    Updated: 2024/06/21 15:30:58 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache php php-fpm php-mysqli php-json php-curl php-mbstring php-xml curl shadow

WORKDIR /var/www/html

RUN curl -o wordpress-6.5.4.tar.gz https://wordpress.org/wordpress-6.5.4.tar.gz && tar -xvf wordpress-6.5.4.tar.gz && rm wordpress-6.5.4.tar.gz

RUN addgroup -S webgroup && adduser -S -G webgroup wp-user
RUN groupmod -g 1000 webgroup

COPY ./conf/www.conf		/etc/php8/php-fpm.d/www.conf
COPY ./conf/www.conf		/etc/php82/php-fpm.d/www.conf
COPY ./conf/wp-config.php	/var/www/html/wordpress/wp-config.php

RUN chown -R wp-user:webgroup /var/www/ /var/log/php82

EXPOSE 9000
USER wp-user

ENTRYPOINT ["/usr/sbin/php-fpm82"]
CMD ["-F"]
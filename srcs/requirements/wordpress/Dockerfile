# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:51:03 by craimond          #+#    #+#              #
#    Updated: 2024/06/17 18:40:33 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache php php-fpm curl
RUN mkdir -p /var/www && cd /var/www
RUN curl -O https://wordpress.org/wordpress-6.5.4.tar.gz && tar -xvf wordpress-6.5.4.tar.gz && rm wordpress-6.5.4.tar.gz

COPY ./conf/www.conf		/etc/php8/php-fpm.d/www.conf
COPY ./conf/wp-config.php	/var/www/wordpress/wp-config.php

EXPOSE 9000

WORKDIR /var/www/wordpress

CMD ["php-fpm82", "-F"]
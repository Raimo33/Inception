# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/11 11:31:11 by craimond          #+#    #+#              #
#    Updated: 2024/07/29 14:59:17 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID

RUN apk add --no-cache php php-fpm php-session php-mysqli php-json php-iconv php-phar php-dom php-ctype php-zlib curl
ADD https://www.adminer.org/static/download/4.8.1/adminer-4.8.1.php /var/www/html/adminer/index.php

COPY ./conf/www.conf /etc/php82/php-fpm.d/www.conf

RUN adduser -u $USER_ID -SD adminer-user

USER adminer-user
EXPOSE 8080
WORKDIR /var/www/html/adminer
VOLUME 	/var/www/html/adminer
VOLUME 	/var/log

CMD ["php-fpm82", "-F"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD ["curl", "-fk", "http://adminer.backend:8080"]

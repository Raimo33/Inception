# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/11 11:31:11 by craimond          #+#    #+#              #
#    Updated: 2024/09/07 16:48:37 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID

RUN apk add --no-cache php php-fpm php-session php-mysqli php-json php-iconv php-phar php-dom php-ctype php-zlib curl
ADD --chmod=744 https://www.adminer.org/static/download/4.8.1/adminer-4.8.1.php /var/www/html/adminer/index.php

COPY ./conf/www.conf /etc/php82/php-fpm.d/www.conf

RUN touch /var/log/php82/access.log /var/log/php82/error.log

RUN adduser -u $USER_ID -SD adminer-user
RUN chown -R adminer-user /var/log/php82

USER adminer-user
EXPOSE 8080
WORKDIR /var/www/html/adminer
VOLUME 	[ "/var/www/html/adminer", "/var/log" ]

ENTRYPOINT ["php-fpm82", "-F"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD ["curl", "fks", "http://adminer.backend:8080"]
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:51:03 by craimond          #+#    #+#              #
#    Updated: 2024/06/26 20:27:11 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

RUN apk add --no-cache php php-fpm php-mysqli php-json php-curl php-mbstring php-xml curl
ADD https://wordpress.org/latest.tar.gz /var/www/html/
RUN curl -o /tmp/wp-keys-salts api.wordpress.org/secret-key/1.1/salt/

COPY ./conf/www.conf		/etc/php8/php-fpm.d/www.conf
COPY ./conf/www.conf		/etc/php82/php-fpm.d/www.conf
COPY ./conf/wp-config.php	/var/www/html/wordpress/wp-config.php

RUN cat /tmp/wp-keys-salts >> /var/www/html/wordpress/wp-config.php

RUN addgroup -g 1000 webgroup && adduser -S -G webgroup -u 1003 wp-user
RUN chown -R wp-user:webgroup /var/log/php82

USER wp-user:webgroup
WORKDIR /var/www/html/wordpress
EXPOSE 9000

ENTRYPOINT ["/usr/sbin/php-fpm82"]
CMD ["-F"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -f http://localhost:9000/fpm-ping || exit 1
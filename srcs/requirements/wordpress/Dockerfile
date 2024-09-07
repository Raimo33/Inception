# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:51:03 by craimond          #+#    #+#              #
#    Updated: 2024/09/07 15:52:08 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID GROUP_ID1 DB_NAME DB_USER DB_PASSWORD DB_HOST

RUN apk add --no-cache php php-fpm php-mysqli php-json php-curl php-mbstring php-xml php-phar php-tokenizer curl mariadb-client
ADD --chmod=755 https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

WORKDIR	/var/www/html/wordpress

RUN wp core download --version=6.5.5
RUN wp config create --skip-check --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST

COPY ./conf/www.conf		/etc/php82/php-fpm.d/www.conf
COPY ./tools/setup_wp.sh	/run/setup_wp.sh

RUN touch /var/log/setup.log /var/log/php82/access.log /var/log/php82/error.log

RUN addgroup -g $GROUP_ID1 -S wordpress-group
RUN adduser -u $USER_ID -G wordpress-group -SD wordpress-user
RUN chown -R wordpress-user /usr/local/bin/wp /var/log/php82 /var/log/setup.log
RUN chmod +x /run/setup_wp.sh

USER wordpress-user
EXPOSE 9000
VOLUME ["/var/www/html/wordpress", "/var/log"]

ENTRYPOINT ["/run/setup_wp.sh"]
CMD ["php-fpm82", "-F"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD ["curl", "fks", "https://wordpress.backend:9000"]

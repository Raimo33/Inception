# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:51:03 by craimond          #+#    #+#              #
#    Updated: 2024/07/29 16:26:00 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#TODO RIFARE IL SITO CON HUGO/JEKYLL o altri static website generator

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID GROUP_ID DB_NAME DB_USER DB_PASSWORD DB_HOST

RUN apk add --no-cache php php-fpm php-mysqli php-json php-curl php-mbstring php-xml php-phar php-tokenizer curl mariadb-client
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf		/etc/php82/php-fpm.d/www.conf
COPY ./tools/setup_wp.sh	/run/setup_wp.sh

#RUN mkdir -p /var/log/php-fpm
RUN touch /var/log/setup.log

RUN addgroup -g $GROUP_ID -S wp-group && adduser -u $USER_ID -G wp-group -SD wp-user
RUN chown -R wp-user:wp-group /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp /run/setup_wp.sh

RUN wp core download --version=6.5.5
RUN wp config create --skip-check --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST

USER wp-user:wp-group
EXPOSE 9000
WORKDIR	/var/www/html/wordpress
VOLUME	/var/www/html/wordpress
VOLUME	/var/log

ENTRYPOINT ["/run/setup_wp.sh"]
CMD ["php-fpm82", "-F"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD ["curl", "-fk", "https://wordpress.backend:9000"]

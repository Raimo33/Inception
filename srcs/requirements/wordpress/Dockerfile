# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:51:03 by craimond          #+#    #+#              #
#    Updated: 2024/07/19 10:06:45 by craimond         ###   ########.fr        #
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
COPY ./tools/install_wp.sh	/tmp/install_wp.sh

RUN addgroup -g $GROUP_ID -S wp-group && adduser -u $USER_ID -G wp-group -SD wp-user
RUN chown -R wp-user:wp-group /var/log/php82 /usr/local/bin/wp /tmp/install_wp.sh
RUN chmod +x /usr/local/bin/wp /tmp/install_wp.sh /run/setup_wp.sh

USER wp-user:wp-group
EXPOSE 9000

WORKDIR /var/www/html/wordpress
VOLUME /var/www/html/wordpress

RUN /tmp/install_wp.sh
RUN rm -rf /tmp/*

ENTRYPOINT ["/run/setup_wp.sh"]
CMD ["php-fpm82", "-F"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD ["curl", "-fk", "http://wordpress.backend:9000/fpm-ping"]

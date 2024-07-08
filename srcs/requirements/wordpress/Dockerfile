# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:51:03 by craimond          #+#    #+#              #
#    Updated: 2024/07/08 15:55:36 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#TODO incorporare il sito, mettere il logo e altri asset in mariadb forse

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG DB_NAME DB_USER DB_PASSWORD DB_HOST

RUN apk add --no-cache php php-fpm php-mysqli php-json php-curl php-mbstring php-xml php-phar tini curl
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf		/etc/php82/php-fpm.d/www.conf
COPY ./tools/setup_wp.sh	/run
COPY ./tools/install_wp.sh	/tmp

RUN addgroup -g 1000 -S webgroup && adduser -u 1003 -G webgroup -SD wp-user
RUN chown -R wp-user:webgroup /var/log/php82 /usr/local/bin/wp /tmp/install_wp.sh
RUN chmod +x /usr/local/bin/wp /tmp/install_wp.sh /run/setup_wp.sh

USER wp-user:webgroup
EXPOSE 9000

WORKDIR /var/www/html/wordpress
VOLUME /var/www/html/wordpress

RUN /tmp/install_wp.sh
RUN rm -rf /tmp/*

ENTRYPOINT ["tini", "--", "/run/setup_wp.sh"]
CMD ["php-fpm82", "-F"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -fk http://wordpress.backend:9000/fpm-ping || exit 1
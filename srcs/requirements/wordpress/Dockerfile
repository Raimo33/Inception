# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:51:03 by craimond          #+#    #+#              #
#    Updated: 2024/07/07 17:38:06 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#TODO incorporare il sito, mettere il logo e altri asset in mariadb forse

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG DB_NAME DB_USER DB_PASSWORD DB_HOST

RUN apk add --no-cache php php-fpm php-mysqli php-json php-curl php-mbstring php-xml php-phar curl
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf	/etc/php82/php-fpm.d/www.conf
COPY ./tools/			/run

RUN addgroup -g 1000 -S webgroup && adduser -u 1003 -G webgroup -SD wp-user
RUN chown -R wp-user:webgroup /var/log/php82 /usr/local/bin/wp /run/install_wp.sh
RUN chmod +x /usr/local/bin/wp /run/install_wp.sh /run/setup_wp.sh

USER wp-user:webgroup
EXPOSE 9000

WORKDIR /var/www/html/wordpress
RUN /run/install_wp.sh

ENTRYPOINT ["/run/setup_wp.sh"]
CMD ["/usr/sbin/php-fpm82", "-F"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -f http://localhost:9000/fpm-ping || exit 1
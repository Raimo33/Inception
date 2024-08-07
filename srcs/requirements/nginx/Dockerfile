# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:52:59 by craimond          #+#    #+#              #
#    Updated: 2024/08/07 11:26:04 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID GROUP_ID

RUN apk add --no-cache nginx curl

COPY ./conf/default.conf	/etc/nginx/http.d/
COPY ./conf/ssl				/etc/ssl

RUN mkdir -p /run/nginx /var/log/nginx
RUN touch /var/log/nginx/access.log /var/log/nginx/error.log

RUN addgroup -g $GROUP_ID -S wp-group
RUN adduser -u $USER_ID -G wp-group -SD nginx-user
RUN chown -R nginx-user /var/lib/nginx /run/nginx /var/log/nginx /etc/nginx/http.d
RUN chmod -R 755 /etc/ssl

USER nginx-user:wp-group
EXPOSE 443
VOLUME /var/www/html/wordpress
VOLUME /var/www/html/adminer
VOLUME /var/log

# CMD ["nginx", "-g", "daemon off;"]
CMD ["tail", "-f", "/dev/null"]
#TODO fix per qualche motivo il file .key e' vuoto

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD ["curl", "-fk", "https://nginx.backend:443"]

#TODO fix nginx | 2024/07/22 10:51:53 [error] 9#9: *1 connect() failed (111: Connection refused) while connecting to upstream, client: 192.168.1.5, server: craimond.42.fr, request: "GET / HTTP/1.1", upstream: "fastcgi://192.168.1.4:9000", host: "nginx.backend"
#succede sulla prima installazione di wordpress quando l'healthcheck di nginx prova a contattare php-fpm di wordpress che pero' non e' ancora stato avviato

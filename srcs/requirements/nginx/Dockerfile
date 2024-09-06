# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:52:59 by craimond          #+#    #+#              #
#    Updated: 2024/09/06 16:31:05 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID GROUP_ID1 GROUP_ID2

RUN apk add --no-cache nginx curl

COPY ./conf/default.conf	/etc/nginx/http.d/default.conf
COPY ./conf/ssl				/etc/ssl

RUN mkdir -p /run/nginx /var/log/nginx
RUN touch /var/log/nginx/access.log /var/log/nginx/error.log

RUN addgroup -g $GROUP_ID1 -S wordpress-group
RUN addgroup -g $GROUP_ID2 -S adminer-group
RUN adduser -u $USER_ID -SD nginx-user
RUN adduser nginx-user wordpress-group && adduser nginx-user adminer-group
RUN chown -R nginx-user /var/lib/nginx /run/nginx /var/log/nginx /etc/nginx/http.d
RUN chmod -R 755 /etc/ssl

USER nginx-user
EXPOSE 443
VOLUME ["/var/www/html/wordpress", "/var/www/html/adminer", "/var/log"]

ENTRYPOINT ["nginx", "-g", "daemon off;"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD ["curl", "-fk", "https://nginx.backend:443"]

#TODO fix nginx | 2024/07/22 10:51:53 [error] 9#9: *1 connect() failed (111: Connection refused) while connecting to upstream, client: 192.168.1.5, server: craimond.42.fr, request: "GET / HTTP/1.1", upstream: "fastcgi://192.168.1.4:9000", host: "nginx.backend"
#succede sulla prima installazione di wordpress quando l'healthcheck di nginx prova a contattare php-fpm di wordpress che pero' non e' ancora stato avviato

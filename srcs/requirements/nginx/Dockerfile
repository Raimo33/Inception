# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:52:59 by craimond          #+#    #+#              #
#    Updated: 2024/09/08 15:27:29 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID GROUP_ID1

RUN apk add --no-cache nginx curl

COPY ./conf/default.conf	/etc/nginx/http.d/default.conf

RUN mkdir -p /run/nginx
RUN touch /var/log/access.log /var/log/error.log

RUN addgroup -g $GROUP_ID1 -S wordpress-group
RUN adduser -u $USER_ID -G wordpress-group -SD nginx-user
RUN chown -R nginx-user /var/lib/nginx /run/nginx /etc/nginx/http.d /var/log/access.log /var/log/error.log /var/log/nginx

USER nginx-user
EXPOSE 443
VOLUME ["/var/www/html/wordpress", "/var/www/html/adminer", "/var/www/html/portfolio", "/etc/ssl", "/var/log"]

ENTRYPOINT ["nginx", "-g", "daemon off;"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD ["curl", "-fks", "https://nginx.backend:443"]
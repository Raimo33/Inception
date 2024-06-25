# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:52:59 by craimond          #+#    #+#              #
#    Updated: 2024/06/25 14:10:32 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache nginx shadow

RUN addgroup -g 1000 webgroup && adduser -S -G webgroup -u 1002 nginx-user

COPY ./conf/nginx.conf	/etc/nginx/nginx.conf
COPY ./conf/ssl/		/etc/ssl/

RUN mkdir -p /var/log/nginx /run/nginx
RUN chown -R nginx-user:webgroup /var/lib/nginx /var/log/nginx /etc/ssl /run/nginx
RUN chmod -R 744 /etc/ssl

#openssl genpkey -algorithm RSA -out craimond.42.fr.key
#openssl req -new -x509 -key craimond.42.fr.key -out craimond.42.fr.crt -days 365

EXPOSE 443 80

USER nginx-user

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;"]
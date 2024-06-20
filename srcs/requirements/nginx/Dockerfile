# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:52:59 by craimond          #+#    #+#              #
#    Updated: 2024/06/20 10:58:07 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache nginx shadow
RUN addgroup -S webgroup && adduser -S -G webgroup webuser
RUN groupmod -g 1000 webgroup && usermod -u 1000 webuser

COPY ./conf/nginx.conf	/etc/nginx/nginx.conf
COPY ./conf/ssl/		/etc/ssl/

RUN mkdir -p /var/log/nginx /run/nginx
RUN chown -R webuser:webgroup /var/lib/nginx /var/log/nginx /etc/ssl /run/nginx
RUN chmod -R 400 /etc/ssl
#TODO fix 

EXPOSE 443 80

USER webuser

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;"]
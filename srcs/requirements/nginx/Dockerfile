# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:52:59 by craimond          #+#    #+#              #
#    Updated: 2024/06/19 13:05:57 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache nginx
RUN addgroup -S webgroup && adduser -S webuser -G webgroup

COPY ./conf/nginx.conf	/etc/nginx/nginx.conf
COPY ./conf/ssl/		/etc/ssl/

RUN mkdir -p /var/log/nginx && mkdir -p /run/nginx
RUN chown -R webuser:webgroup /var/lib/nginx
RUN chown -R webuser:webgroup /var/log/nginx
RUN chown -R webuser:webgroup /etc/ssl
RUN chown -R webuser:webgroup /run/nginx
RUN chmod -R 400 /etc/ssl

EXPOSE 443 80

USER webuser

CMD ["nginx", "-g", "daemon off;"]
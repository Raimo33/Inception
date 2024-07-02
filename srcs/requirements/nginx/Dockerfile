# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:52:59 by craimond          #+#    #+#              #
#    Updated: 2024/07/02 14:22:39 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

RUN apk add --no-cache nginx

COPY ./conf/nginx.conf	/etc/nginx/nginx.conf

RUN addgroup -g 1000 -S webgroup && adduser -u 1002 -G webgroup -SD nginx-user

RUN mkdir -p /var/log/nginx /run/nginx
RUN chown -R nginx-user:webgroup /var/lib/nginx /var/log/nginx /etc/ssl /run/nginx
RUN chmod -R 744 /etc/ssl

EXPOSE 443 80

USER nginx-user:webgroup

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -f http://localhost:80 || exit 1
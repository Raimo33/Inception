# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:52:59 by craimond          #+#    #+#              #
#    Updated: 2024/07/11 12:29:19 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID GROUP_ID

RUN apk add --no-cache nginx tini curl

COPY ./conf/	/etc/nginx/http.d/
COPY ./conf/ssl	/etc/ssl

RUN mkdir -p /var/log/nginx /var/run/nginx

RUN addgroup -g $GROUP_ID -S webgroup && adduser -u $USER_ID -G webgroup -SD nginx-user
RUN chown -R nginx-user:webgroup /var/lib/nginx /var/log/nginx /etc/nginx/http.d /var/run/nginx
RUN chmod -R 755 /etc/ssl

USER nginx-user:webgroup
EXPOSE 443 

ENTRYPOINT ["tini", "--"]
CMD ["nginx", "-g", "daemon off;"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD ["curl", "-fk", "https://nginx.backend:443"]
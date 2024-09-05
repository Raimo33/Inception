# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/08 15:58:37 by craimond          #+#    #+#              #
#    Updated: 2024/09/05 15:56:18 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID

RUN apk add --no-cache redis tini

COPY ./conf/redis.conf	/etc/redis.conf

RUN touch /var/log/redis.log

RUN adduser -u $USER_ID -DS redis-user
RUN chown -R redis-user /var/log/redis.log

USER redis-user
EXPOSE 6379
VOLUME ["/var/log"]

ENTRYPOINT ["redis-server", "/etc/redis.conf"]

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD ["redis-cli", "-h", "redis.backend", "ping"]

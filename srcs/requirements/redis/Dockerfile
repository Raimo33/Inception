# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/08 15:58:37 by craimond          #+#    #+#              #
#    Updated: 2024/07/08 17:31:43 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

RUN apk add --no-cache redis tini

COPY ./conf/redis.conf	/etc/redis.conf

RUN adduser -u 1004 -DS redis-user

USER redis-user
EXPOSE 6379

ENTRYPOINT ["tini", "--"]
CMD ["redis-server", "/etc/redis.conf"]

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD ["redis-cli", "-h", "redis.backend", "ping"]
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/09 15:02:50 by craimond          #+#    #+#              #
#    Updated: 2024/09/15 16:09:00 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID

RUN apk add --no-cache curl
RUN curl --proto '=https' --tlsv1.2 -sSfL https://sh.vector.dev | ash -s -- -y --prefix /usr/local

COPY ./conf/vector.yml	/etc/vector/vector.yml

RUN mkdir -p /run/combined_logs /var/lib/vector

RUN adduser -u $USER_ID -SDH vector-user
RUN chown -R vector-user /var/lib/vector /etc/vector /run/combined_logs

WORKDIR /run/combined_logs
USER vector-user
EXPOSE 8686
VOLUME ["/run/combined_logs", "/var/log/mariadb", "/var/log/nginx", "/var/log/wordpress", "/var/log/redis", "/var/log/vsftpd", "/var/log/adminer"]

ENTRYPOINT ["vector", "-c", "/etc/vector/vector.yml"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD ["vector", "validate", "/etc/vector/vector.yml"]
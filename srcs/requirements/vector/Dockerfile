# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/09 15:02:50 by craimond          #+#    #+#              #
#    Updated: 2024/09/09 16:28:38 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID

RUN apk add --no-cache bash
ADD --chmod=744 https://sh.vector.dev /tmp/install_vector.sh
RUN /tmp/install_vector.sh -y && rm -f /tmp/install_vector.sh

COPY ./conf/vector.yml	/etc/vector/vector.yml

RUN mkdir -p /run/combined_logs

RUN adduser -u $USER_ID -SD vector-user
RUN chown -R vector-user /etc/vector /var/run/combined_logs

# WORKDIR
USER vector-user
# EXPOSE
VOLUME ["/run/combined_logs", "/var/log/mariadb", "/var/log/nginx", "/var/log/wordpress", "/var/log/redis", "/var/log/vsftpd", "/var/log/adminer"]

ENTRYPOINT ["vector", "-c", "/etc/vector/vector.yaml"]

# HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD []
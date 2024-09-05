# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/10 13:26:30 by craimond          #+#    #+#              #
#    Updated: 2024/09/05 18:09:30 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID

#TODO controllare se sono tutte necessarie
RUN apk add --no-cache build-base ruby ruby-dev libffi-dev openssl-dev yaml-dev zlib-dev curl
RUN gem install fluentd --no-document --version 1.12.3

COPY ./conf/fluent.conf	/etc/fluentd/conf.d/fluent.conf

RUN mkdir -p /var/lib/fluentd /run/fluentd /var/log/fluentd /fluentd

RUN adduser -u $USER_ID -SD fluentd-user
RUN chown -R fluentd-user /var/lib/fluentd /run/fluentd /var/log/fluentd /etc/fluentd/conf.d /fluentd

USER fluentd-user
WORKDIR /etc/fluentd
EXPOSE 24224
VOLUME ["/centralized-logs", "/var/log/mariadb", "/var/log/nginx", "/var/log/wordpress", "/var/log/redis", "/var/log/vsftpd", "/var/log/adminer"]

ENTRYPOINT ["fluentd", "-c", "/etc/fluentd/conf.d/fluent.conf"]
CMD ["-vv"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD ["curl", "-fk", "http://fluentd.backend:24224"]
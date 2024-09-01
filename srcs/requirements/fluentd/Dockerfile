# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/10 13:26:30 by craimond          #+#    #+#              #
#    Updated: 2024/08/10 13:37:09 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID

#TODO controllare se sono tutte necessarie
RUN apk add --no-cache build-base ca-certificates ruby ruby-dev libffi-dev openssl-dev yaml-dev zlib-dev
RUN gem install fluentd --no-document --version 1.12.3

COPY ./conf/fluentd.conf	/etc/fluentd/conf.d/fluentd.conf

RUN adduser -u $USER_ID -SD fluentd-user
RUN chown -R fluentd-user /var/lib/fluentd /run/fluentd /var/log/fluentd /etc/fluentd/conf.d

USER fluentd-user
WORKDIR /etc/fluentd
EXPOSE 24224
VOLUME 

ENTRYPOINT ["fluentd", "-c", "/etc/fluentd/conf.d/fluentd.conf"]
CMD ["-vv"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD []
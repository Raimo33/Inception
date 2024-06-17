# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:52:59 by craimond          #+#    #+#              #
#    Updated: 2024/06/17 18:52:50 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache nginx

COPY ./conf/nginx.conf	/etc/nginx/nginx.conf
COPY ./conf/ssl/		/etc/ssl/

EXPOSE 443 80

CMD ["nginx", "-g", "daemon off;"]
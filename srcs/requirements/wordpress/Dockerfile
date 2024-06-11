#base image
FROM alpine:3.19

#install dependencies
RUN apk update && apk add wget
RUN apk add php7.4 php7.4-fpm php-mysql mariadb-client
RUN wget https://github.com/WordPress/WordPress/archive/refs/tags/6.5.4.tar.gz -P /var/www

WORKDIR /var/www

#extract the wordpress files
RUN tar -xvf 6.5.4.tar.gz && rm 6.5.4.tar.gz

#change owner of the wordpress files (group:user)
RUN	chown -R root:root ./wordpress




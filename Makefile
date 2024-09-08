# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/06 01:09:08 by craimond          #+#    #+#              #
#    Updated: 2024/09/08 14:47:04 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

export USERNAME					:= $(shell whoami)

DOCKER_COMPOSE_PATH				= srcs/docker-compose.yml
DOMAIN_NAME						= craimond.42.fr
DEPS							= docker-compose hostsed openssl ca-certificates

NGINX_SSL						= srcs/requirements/nginx/conf/ssl
VSFTPD_SSL						= srcs/requirements/vsftpd/conf/ssl
NGINX_CERT						:= $(NGINX_SSL)/certs/nginx.crt
NGINX_KEY						:= $(NGINX_SSL)/private/nginx.key
VSFTPD_CERT						:= $(VSFTPD_SSL)/certs/vsftpd.crt
VSFTPD_KEY						:= $(VSFTPD_SSL)/private/vsftpd.key
CERTS_SUBJ						:= "/C=IT/ST=Italy/L=Florence/O=/OU=/CN=$(DOMAIN_NAME)"
LOCAL_CERTS_DIR					= /usr/local/share/ca-certificates/

export	MARIADB_USER_UID		= 1001
export	NGINX_USER_UID			= 1002
export	WORDPRESS_USER_UID		= 1003
export	REDIS_USER_UID			= 1004
export	VSFTPD_USER_UID			= 1005
export	ADMINER_USER_UID		= 1006
export	WORDPRESS_GROUP_GID		= 1200

export LOGS_DIR					:= /home/$(USERNAME)/logs
LOGS_SUBDIRS					= mariadb nginx wordpress redis vsftpd adminer
LOGS_DIRS						:= $(addprefix $(LOGS_DIR)/, $(LOGS_SUBDIRS))
export DATA_DIR					:= /home/$(USERNAME)/data
DATA_SUBDIRS					= mariadb wordpress
DATA_DIRS						:= $(addprefix $(DATA_DIR)/, $(DATA_SUBDIRS))

all: deps init build down up perms

deps:
	echo "installing $(DEPS)"
	sudo apt-get install -y $(DEPS) > /dev/null 2>&1
	sudo usermod -aG docker $(USERNAME)
	echo "$(DEPS) installed"

init:
	sudo mkdir -p $(DATA_DIR) $(LOGS_DIR)
	sudo mkdir -p $(DATA_DIRS) $(LOGS_DIRS)
	echo "created data and logs folders"
	hostsed add 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	echo "added DNS resolution for $(DOMAIN_NAME)"
	mkdir -p $(NGINX_SSL) $(VSFTPD_SSL) $(NGINX_SSL)/private $(NGINX_SSL)/certs $(VSFTPD_SSL)/private $(VSFTPD_SSL)/certs
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(NGINX_KEY) -out $(NGINX_CERT) -subj $(CERTS_SUBJ) > /dev/null 2>&1
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(VSFTPD_KEY) -out $(VSFTPD_CERT) -subj $(CERTS_SUBJ) > /dev/null 2>&1
	sudo cp $(NGINX_CERT) $(VSFTPD_CERT) $(LOCAL_CERTS_DIR)
	echo "created ssl certificates"
	sudo update-ca-certificates > /dev/null 2>&1
	echo "added ssl certificates to trusted list"

perms:
	sudo chown -R $(WORDPRESS_USER_UID):$(WORDPRESS_GROUP_GID) $(DATA_DIR)/wordpress
	sudo chown -R $(MARIADB_USER_UID) $(DATA_DIR)/mariadb $(LOGS_DIR)/mariadb
	sudo chown -R $(NGINX_USER_UID) $(LOGS_DIR)/nginx
	sudo chown -R $(WORDPRESS_USER_UID) $(LOGS_DIR)/wordpress
	sudo chown -R $(REDIS_USER_UID) $(LOGS_DIR)/redis
	sudo chown -R $(VSFTPD_USER_UID) $(LOGS_DIR)/vsftpd
	sudo chown -R $(ADMINER_USER_UID) $(LOGS_DIR)/adminer
	sudo chmod -R 755 $(DATA_DIR) $(LOGS_DIR)
	sudo chmod -R 774 $(DATA_DIR)/wordpress
	sudo chown -R $(NGINX_USER_UID) $(NGINX_SSL)
	sudo chown -R $(VSFTPD_USER_UID) $(VSFTPD_SSL)
	echo "set permissions for data and logs folders"

up:
	docker-compose -f $(DOCKER_COMPOSE_PATH) up -d

down:
	docker-compose -f $(DOCKER_COMPOSE_PATH) down

build:
	docker-compose -f $(DOCKER_COMPOSE_PATH) build

restart:
	docker-compose -f $(DOCKER_COMPOSE_PATH) restart

logs:
	echo "logs are stored in $(LOGS_DIR)"

#TODO fix fclean warnings

fclean:
	sudo docker-compose -f $(DOCKER_COMPOSE_PATH) down --volumes
	sudo docker system prune --all --volumes
	hostsed rm 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	echo "removed domain $(DOMAIN_NAME) from hosts file"
	sudo rm -rf $(NGINX_SSL) $(VSFTPD_SSL)
	echo "removed ssl certificates"
	sudo rm -rf $(DATA_DIR) $(LOGS_DIR)
	echo "removed data and logs folders"

re: fclean all

.PHONY: all deps init up down build restart logs fclean re
.SILENT:
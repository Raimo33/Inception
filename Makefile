# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/06 01:09:08 by craimond          #+#    #+#              #
#    Updated: 2024/08/06 02:49:01 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE_PATH		= srcs/docker-compose.yml
DOMAIN_NAME				= craimond.42.fr
DEPS					= docker-compose hostsed openssl ca-certificates

NGINX_SSL				= srcs/requirements/nginx/conf/ssl
FTP_SSL					= srcs/requirements/vsftpd/conf/ssl
NGINX_CERT				= $(NGINX_SSL)/certs/$(DOMAIN_NAME).crt
NGINX_KEY				= $(NGINX_SSL)/private/$(DOMAIN_NAME).key
FTP_CERT				= $(FTP_SSL)/certs/vsftpd.crt
FTP_KEY					= $(FTP_SSL)/private/vsftpd.key
CERTS_SUBJ				= "/C=IT/ST=Italy/L=Florence/O=/OU=/CN=$(DOMAIN_NAME)"
LOCAL_CERTS_DIR			= /usr/local/share/ca-certificates/

WP_GROUP_GID			= 1000
MYSQL_UID				= 1001
NGINX_USER_UID			= 1002
WP_USER_UID				= 1003
REDIS_USER_UID			= 1004
FTP_USER_UID			= 1005
ADMINER_USER_UID		= 1006
PORTFOLIO_USER_UI		= 1007
FLUENTD_USER_UID		= 1008

DATA_DIR				= /home/$(USERNAME)/data
DATA_SUBDIRS			= mariadb wordpress adminer
DATA_DIRS				= $(addprefix $(DATA_DIR)/, $(DATA_SUBDIRS))

export USERNAME			= $(shell whoami)

all: deps init build down up

deps:
	echo "installing $(DEPS)"
	sudo apt-get install -y $(DEPS) > /dev/null 2>&1
	sudo usermod -aG docker $(USERNAME)
	echo "$(DEPS) installed"

init:
	sudo mkdir -p $(DATA_DIRS)
	echo "created data folders"
	sudo chown -R $(MYSQL_UID) $(DATA_DIR)/mariadb
	sudo chown -R :$(WP_GROUP_GID) $(DATA_DIR)/wordpress
	sudo chown -R $(ADMINER_USER_UID) $(DATA_DIR)/adminer
	sudo chmod -R 755 $(DATA_DIR)
	sudo chmod -R 774 $(DATA_DIR)/wordpress
	echo "set permissions for data folders"
	hostsed add 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	echo "added DNS resolution for $(DOMAIN_NAME)"
	sudo mkdir -p $(NGINX_SSL) $(FTP_SSL) $(NGINX_SSL)/private $(NGINX_SSL)/certs $(FTP_SSL)/private $(FTP_SSL)/certs
	sudo openssl req -x509 -nodes -days 30 -newkey rsa:2048 -keyout $(NGINX_KEY) -out $(NGINX_CERT) -subj $(CERTS_SUBJ) > /dev/null 2>&1
	sudo openssl req -x509 -nodes -days 30 -newkey rsa:2048 -keyout $(FTP_KEY) -out $(FTP_CERT) -subj $(CERTS_SUBJ) > /dev/null 2>&1
	sudo cp $(NGINX_CERT) $(LOCAL_CERTS_DIR)
	echo "created ssl certificates"
	sudo update-ca-certificates > /dev/null 2>&1
	echo "added ssl certificates to trusted list"

up:
	docker-compose -f $(DOCKER_COMPOSE_PATH) up -d

down:
	docker-compose -f $(DOCKER_COMPOSE_PATH) down

build:
	docker-compose -f $(DOCKER_COMPOSE_PATH) build

restart:
	docker-compose -f $(DOCKER_COMPOSE_PATH) restart

logs:
	docker-compose -f $(DOCKER_COMPOSE_PATH) logs

fclean:
	sudo docker-compose -f $(DOCKER_COMPOSE_PATH) down --volumes
	sudo docker system prune --all --volumes
	hostsed rm 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	echo "removed domain $(DOMAIN_NAME) from hosts file"
	sudo rm -rf $(NGINX_SSL) $(FTP_SSL)
	echo "removed ssl certificates"
	sudo rm -rf $(DATA_DIR)
	echo "removed volumes folders"

re: fclean all

.PHONY: all deps init up down build restart logs fclean re
.SILENT:
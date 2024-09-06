# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/06 01:09:08 by craimond          #+#    #+#              #
#    Updated: 2024/09/06 16:12:44 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

USERNAME				= $(shell whoami)

DOCKER_COMPOSE_PATH		= srcs/docker-compose.yml
DOMAIN_NAME				= craimond.42.fr
DEPS					= docker-compose hostsed openssl ca-certificates

NGINX_SSL				= srcs/requirements/nginx/conf/ssl
FTP_SSL					= srcs/requirements/vsftpd/conf/ssl
NGINX_CERT				= $(NGINX_SSL)/certs/nginx.crt
NGINX_KEY				= $(NGINX_SSL)/private/nginx.key
FTP_CERT				= $(FTP_SSL)/certs/vsftpd.crt
FTP_KEY					= $(FTP_SSL)/private/vsftpd.key
CERTS_SUBJ				= "/C=IT/ST=Italy/L=Florence/O=/OU=/CN=$(DOMAIN_NAME)"
LOCAL_CERTS_DIR			= /usr/local/share/ca-certificates/

MARIADB_USER_UID		= 1001
NGINX_USER_UID			= 1002
WP_USER_UID				= 1003
REDIS_USER_UID			= 1004
VSFTPD_USER_UID			= 1005
ADMINER_USER_UID		= 1006
PORTFOLIO_USER_UID		= 1007
WP_GROUP_GID			= 1200
ADMINER_GROUP_GID		= 1201

LOGS_DIR				= /home/$(USERNAME)/logs
LOGS_SUBDIRS			= mariadb nginx wordpress redis vsftpd adminer portfolio
LOGS_DIRS				= $(addprefix $(LOGS_DIR)/, $(LOGS_SUBDIRS))
DATA_DIR				= /home/$(USERNAME)/data
DATA_SUBDIRS			= mariadb wordpress adminer
DATA_DIRS				= $(addprefix $(DATA_DIR)/, $(DATA_SUBDIRS))

all: deps init build down up

deps:
	echo "installing $(DEPS)"
	sudo apt-get install -y $(DEPS) > /dev/null 2>&1
	sudo usermod -aG docker $(USERNAME)
	echo "$(DEPS) installed"

init:
	sudo mkdir -p $(DATA_DIRS) $(LOGS_DIRS)
	echo "created data and logs folders"
	#TODO non funziona chown dei gruppi
	sudo chown -R :$(WP_GROUP_GID) $(DATA_DIR)/wordpress
	sudo chown -R :$(ADMINER_GROUP_GID) $(DATA_DIR)/adminer
	sudo chown -R $(MARIADB_USER_UID) $(DATA_DIR)/mariadb $(LOGS_DIR)/mariadb
	sudo chown -R $(NGINX_USER_UID) $(LOGS_DIR)/nginx
	sudo chown -R $(WP_USER_UID) $(LOGS_DIR)/wordpress
	sudo chown -R $(REDIS_USER_UID) $(LOGS_DIR)/redis
	sudo chown -R $(VSFTPD_USER_UID) $(LOGS_DIR)/vsftpd
	sudo chown -R $(ADMINER_USER_UID) $(LOGS_DIR)/adminer
	sudo chown -R $(PORTFOLIO_USER_UID) $(LOGS_DIR)/portfolio
	sudo chmod -R 755 $(DATA_DIR) $(LOGS_DIR)
	sudo chmod -R 774 $(DATA_DIR)/wordpress $(DATA_DIR)/adminer
	echo "set permissions for data and logs folders"
	hostsed add 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	echo "added DNS resolution for $(DOMAIN_NAME)"
	mkdir -p $(NGINX_SSL) $(FTP_SSL) $(NGINX_SSL)/private $(NGINX_SSL)/certs $(FTP_SSL)/private $(FTP_SSL)/certs
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(NGINX_KEY) -out $(NGINX_CERT) -subj $(CERTS_SUBJ) > /dev/null 2>&1
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(FTP_KEY) -out $(FTP_CERT) -subj $(CERTS_SUBJ) > /dev/null 2>&1
	sudo cp $(NGINX_CERT) $(FTP_CERT) $(LOCAL_CERTS_DIR)
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
	echo "logs are stored in $(LOGS_DIR)"

fclean:
	sudo docker-compose -f $(DOCKER_COMPOSE_PATH) down --volumes
	sudo docker system prune --all --volumes
	hostsed rm 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	echo "removed domain $(DOMAIN_NAME) from hosts file"
	sudo rm -rf $(NGINX_SSL) $(FTP_SSL)
	echo "removed ssl certificates"
	sudo rm -rf $(DATA_DIR) $(LOGS_DIR)
	echo "removed data and logs folders"

re: fclean all

.PHONY: all deps init up down build restart logs fclean re
.SILENT:
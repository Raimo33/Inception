DOCKER_COMPOSE_PATH	= srcs/docker-compose.yml
DATA_DIR			= /home/${USER}/data
DOMAIN_NAME			= craimond.42.fr

DEPS				= docker-compose hostsed openssl ca-certificates

NGINX_SSL			= srcs/requirements/nginx/conf/ssl
FTP_SSL				= srcs/requirements/vsftpd/conf/ssl
NGINX_CERT			= $(NGINX_SSL)/certs/$(DOMAIN_NAME).crt
NGINX_KEY			= $(NGINX_SSL)/private/$(DOMAIN_NAME).key
FTP_CERT			= $(FTP_SSL)/certs/vsftpd.crt
FTP_KEY				= $(FTP_SSL)/private/vsftpd.key
CERTS_SUBJ			= "/C=IT/ST=Italy/L=Florence/O=/OU=/CN=$(DOMAIN_NAME)"
LOCAL_CERTS_DIR		= /usr/local/share/ca-certificates/

WEBGROUP_GID		= 1000
MYSQL_UID			= 1001
NGINX_USER_UID		= 1002
WP_USER_UID			= 1003
REDIS_USER_UID		= 1004
FTP_USER_UID		= 1005
ADMINER_USER_UID	= 1006

all: deps init build down up

deps:
	echo "installing $(DEPS)"
	sudo apt-get install -y $(DEPS) > /dev/null 2>&1
	sudo usermod -aG docker ${USER} > /dev/null 2>&1
	echo "installed $(DEPS)"

init:
	mkdir -p $(DATA_DIR) $(DATA_DIR)/wordpress $(DATA_DIR)/mariadb $(DATA_DIR)/adminer
	sudo chown -R :$(WEBGROUP_GID) $(DATA_DIR)/wordpress
	sudo chown -R $(MYSQL_UID) $(DATA_DIR)/mariadb
	sudo chown -R $(ADMINER_USER_UID) $(DATA_DIR)/adminer
	sudo chmod -R 774 $(DATA_DIR)/wordpress
	sudo chmod -R 700 $(DATA_DIR)/mariadb
	sudo chmod -R 755 $(DATA_DIR)/adminer
	echo "created volumes folders"
	sudo hostsed add 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	echo "added DNS resolution for $(DOMAIN_NAME)"
	mkdir -p $(NGINX_SSL) $(FTP_SSL) $(NGINX_SSL)/private $(NGINX_SSL)/certs $(FTP_SSL)/private $(FTP_SSL)/certs
	openssl req -x509 -nodes -days 30 -newkey rsa:2048 -keyout $(NGINX_KEY) -out $(NGINX_CERT) -subj $(CERTS_SUBJ) > /dev/null 2>&1
	openssl req -x509 -nodes -days 30 -newkey rsa:2048 -keyout $(FTP_KEY) -out $(FTP_CERT) -subj $(CERTS_SUBJ) > /dev/null 2>&1
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

fclean: down
	docker system prune --all --volumes
	sudo hostsed rm 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	echo "removed domain $(DOMAIN_NAME) from hosts file"
	rm -rf $(NGINX_SSL) $(FTP_SSL)
	echo "removed ssl certificates"
	sudo rm -rf $(DATA_DIR)
	echo "removed volumes folders"

re: fclean all

.PHONY:
.SILENT:

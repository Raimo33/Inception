DOCKER_COMPOSE_PATH = srcs/docker-compose.yml
DATA_DIR = /home/${USER}/data
DOMAIN_NAME = craimond.42.fr

DEPS = docker docker-compose hostsed openssl

NGINX_SSL = srcs/requirements/nginx/conf/ssl
FTP_SSL = srcs/requirements/ftp/conf/ssl
NGINX_CERT = $(NGINX_SSL)/certs/$(DOMAIN_NAME).crt
NGINX_KEY = $(NGINX_SSL)/private/$(DOMAIN_NAME).key
FTP_CERT = $(FTP_SSL)/certs/vsftpd.crt
FTP_KEY = $(FTP_SSL)/private/vsftpd.key
CERTS_SUBJ = "/C=IT/ST=Italy/L=Florence/O=''/OU=''/CN=$(DOMAIN_NAME)"

all: deps init build up

deps:
	sudo apt-get install -y $(DEPS)
	sudo usermod -aG docker ${USER}

init:
	mkdir -p $(DATA_DIR) $(DATA_DIR)/wordpress $(DATA_DIR)/mariadb
	sudo chown -R :1000 $(DATA_DIR)/wordpress
	sudo chown -R 1001 $(DATA_DIR)/mariadb
	sudo chmod -R 774 $(DATA_DIR)/wordpress
	sudo chmod -R 700 $(DATA_DIR)/mariadb
	sudo hostsed add 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	mkdir -p $(NGINX_SSL) $(FTP_SSL) $(NGINX_SSL)/private $(NGINX_SSL)/certs $(FTP_SSL)/private $(FTP_SSL)/certs
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(NGINX_KEY) -out $(NGINX_CERT) -subj $(CERTS_SUBJ) > /dev/null
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(FTP_KEY) -out $(FTP_CERT) -subj $(CERTS_SUBJ) > /dev/null

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
	docker system prune --all --force --volumes
	sudo hostsed rm 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	rm -rf $(NGINX_SSL) $(FTP_SSL)
	sudo rm -rf $(DATA_DIR)

re: fclean all

.PHONY: all up down build build-nocache restart rebuild logs
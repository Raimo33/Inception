DOCKER_COMPOSE_PATH = srcs/docker-compose.yml
DATA_DIR = /home/${USER}/data

all: init build up

init:
	mkdir -p $(DATA_DIR)
	mkdir -p $(DATA_DIR)/wordpress $(DATA_DIR)/mariadb
	sudo chown -R :1000 $(DATA_DIR)/wordpress
	sudo chown -R 1001 $(DATA_DIR)/mariadb
	sudo chmod -R 774 $(DATA_DIR)/wordpress
	sudo chmod -R 700 $(DATA_DIR)/mariadb

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
	sudo rm -rf $(DATA_DIR)

re: fclean all

.PHONY: all up down build build-nocache restart rebuild logs

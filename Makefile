DOCKER_COMPOSE_PATH = srcs/docker-compose.yml
DATA_DIR = /home/${USER}/data

all: init build up

init: ## Initialize the project
	mkdir -p $(DATA_DIR)
	mkdir -p $(DATA_DIR)/wordpress $(DATA_DIR)/mariadb
	sudo chown -R :1000 $(DATA_DIR)/wordpress
	sudo chown -R 1001 $(DATA_DIR)/mariadb
	sudo chmod -R 750 $(DATA_DIR)/wordpress
	sudo chmod -R 700 $(DATA_DIR)/mariadb

up: ## Start all services
	docker-compose -f $(DOCKER_COMPOSE_PATH) up -d

down: ## Stop all services
	docker-compose -f $(DOCKER_COMPOSE_PATH) down

build: ## Build or rebuild services
	docker-compose -f $(DOCKER_COMPOSE_PATH) build

build-nocache: fclean init## Build or rebuild services without cache
	docker-compose -f $(DOCKER_COMPOSE_PATH) build --no-cache

restart: ## Restart all services
	docker-compose -f $(DOCKER_COMPOSE_PATH) restart

logs: ## View output from containers
	docker-compose -f $(DOCKER_COMPOSE_PATH) logs

fclean:
	sudo rm -rf $(DATA_DIR)

.PHONY: all up down build build-nocache restart rebuild logs

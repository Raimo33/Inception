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

restart: ## Restart all services
	docker-compose -f $(DOCKER_COMPOSE_PATH) restart

logs: ## View output from containers
	docker-compose -f $(DOCKER_COMPOSE_PATH) logs

fclean: down ## Stop all services and remove all volumes
	sudo docker system prune --all --force --volumes
	sudo rm -rf $(DATA_DIR)

re: fclean all

.PHONY: all up down build build-nocache restart rebuild logs

DOCKER_COMPOSE_PATH = srcs/docker-compose.yml
WORDPRESS_DATA_DIR = /home/${USER}/data/wordpress
MARIADB_DATA_DIR = /home/${USER}/data/mariadb

all: init build up

init: ## Initialize the project
	mkdir -p $(WORDPRESS_DATA_DIR) $(MARIADB_DATA_DIR)
	sudo chown -R :1000 $(WORDPRESS_DATA_DIR)
	sudo chown -R 1001 $(MARIADB_DATA_DIR)
	sudo chmod -R 750 $(WORDPRESS_DATA_DIR)
	sudo chmod -R 700 $(MARIADB_DATA_DIR)

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
	sudo rm -rf WORDPRESS_DATA_DIR
	sudo rm -rf MARIADB_DATA_DIR

.PHONY: all up down build build-nocache restart rebuild logs

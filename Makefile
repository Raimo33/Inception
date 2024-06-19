DOCKER_COMPOSE_PATH = srcs/docker-compose.yml

all: init build up

init: ## Initialize the project
	mkdir -p /home/${USER}/data/wordpress /home/${USER}/data/mariadb
	sudo chown -R 1000:1000 /home/${USER}/data/wordpress
	sudo chown -R 1001:1001 /home/${USER}/data/mariadb
	sudo chmod -R 755 /home/${USER}/data/wordpress
	sudo chmod -R 755 /home/${USER}/data/mariadb

up: ## Start all services
	docker-compose -f $(DOCKER_COMPOSE_PATH) up

down: ## Stop all services
	docker-compose -f $(DOCKER_COMPOSE_PATH) down

build: ## Build or rebuild services
	docker-compose -f $(DOCKER_COMPOSE_PATH) build

build-nocache: ## Build or rebuild services without cache
	docker-compose -f $(DOCKER_COMPOSE_PATH) build --no-cache

restart: ## Restart all services
	docker-compose -f $(DOCKER_COMPOSE_PATH) restart

logs: ## View output from containers
	docker-compose -f $(DOCKER_COMPOSE_PATH) logs

.PHONY: all up down build build-nocache restart rebuild logs

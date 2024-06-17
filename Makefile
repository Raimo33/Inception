BUILD_DIR = ./requirements
DOCKER_CONTAINERS = nginx wordpress mariadb
DOCKER_COMPOSE_PATH = srcs/docker-compose.yml

all: up

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

.PHONY: all up down build restart logs clean rebuild

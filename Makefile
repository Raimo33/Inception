BUILD_DIR = ./requirements
DOCKER_CONTAINERS = nginx wordpress mariadb
DOCKER_COMPOSE_PATH = srcs/docker-compose.yml
PROJECT_NAME = ft_inception

all: up

up: ## Start all services
	docker-compose -f -p -d --build $(PROJECT_NAME) $(DOCKER_COMPOSE_PATH) up

down: ## Stop all services
	docker-compose -f $(DOCKER_COMPOSE_PATH) down

build: ## Build or rebuild services
	docker-compose -f $(DOCKER_COMPOSE_PATH) build

restart: ## Restart all services
	docker-compose -f $(DOCKER_COMPOSE_PATH) restart

logs: ## View output from containers
	docker-compose -f $(DOCKER_COMPOSE_PATH) logs

rebuild: clean build up ## Clean, build, and start all services

.PHONY: all up down build restart logs clean rebuild

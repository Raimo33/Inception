DOCKER_COMPOSE_PATH = srcs/docker-compose.yml

all: up

up: ## Start all services
	docker-compose -f $(DOCKER_COMPOSE_PATH) up -d

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

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/10 17:50:43 by craimond          #+#    #+#              #
#    Updated: 2024/06/13 15:54:52 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

BUILD_DIR = ./requirements
DOCKER_CONTAINERS = nginx wordpress mariadb
DOCKER_COMPOSE = srcs/docker-compose.yml

all: up

up: ## Start all services
	docker-compose -f $(DOCKER_COMPOSE) up -d

down: ## Stop all services
	docker-compose -f $(DOCKER_COMPOSE) down

build: ## Build or rebuild services
	docker-compose -f $(DOCKER_COMPOSE) build

restart: ## Restart all services
	docker-compose -f $(DOCKER_COMPOSE) restart

logs: ## View output from containers
	docker-compose -f $(DOCKER_COMPOSE) logs -f

clean: ## Remove all containers, networks, and volumes
	docker-compose -f $(DOCKER_COMPOSE) down -v --rmi all --remove-orphans

rebuild: clean build up ## Clean, build, and start all services

.PHONY: all up down build restart logs clean rebuild

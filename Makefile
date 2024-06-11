# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/10 17:50:43 by craimond          #+#    #+#              #
#    Updated: 2024/06/10 17:55:55 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

BUILD_DIR = ./requirements
DOCKER_CONTAINERS = nginx wordpress mariadb

all: up

up: ## Start all services
	docker-compose -f docker-compose.yml up -d --build

down: ## Stop all services
	docker-compose -f docker-compose.yml down

build: ## Build or rebuild services
	docker-compose -f docker-compose.yml build

restart: ## Restart all services
	docker-compose -f docker-compose.yml restart

logs: ## View output from containers
	docker-compose -f docker-compose.yml logs -f

clean: ## Remove all containers, networks, and volumes
	docker-compose -f docker-compose.yml down -v --rmi all --remove-orphans

rebuild: clean build up ## Clean, build, and start all services

.PHONY: all up down build restart logs clean rebuild

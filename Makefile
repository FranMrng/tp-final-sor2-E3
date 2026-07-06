.PHONY: help install up down

COMPOSE = docker compose -f configs/docker-compose.yml

help:
	@echo " make install - Instala dependencias (Docker, Auditd, Filebeat) y configura el SO."
	@echo " make up - Levanta el stack ELK con Docker Compose."
	@echo " make down - Detiene y elimina los contenedores del stack ELK." 

install:
	sudo bash setup.sh

up:
	docker compose -f configs/docker-compose.yml up -d 

down:
	docker compose -f configs/docker-compose.yml down

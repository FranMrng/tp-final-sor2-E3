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

setpasswd:
	$(COMPOSE) up -d elasticsearch
	@echo "Esperando a que Elasticsearch este listo..."
	@until $(COMPOSE) exec -T elasticsearch curl -k -s -u elastic:labosor2 https://localhost:9200 > /dev/null 2>&1; do \
		printf "."; \
		sleep 40; \
	done
	$(COMPOSE) exec -T elasticsearch bash -c "bin/elasticsearch-reset-password -u kibana_system -s --batch <<< 'kibana123'"

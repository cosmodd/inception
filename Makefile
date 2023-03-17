# Paths
DOCKER_COMPOSE = ./srcs/docker-compose.yml

all:
	@docker-compose -f $(DOCKER_COMPOSE) up -d

build:
	@docker-compose -f $(DOCKER_COMPOSE) up -d --build

down:
	@docker-compose -f $(DOCKER_COMPOSE) down

re: down build

clean:
	@docker system prune -a

fclean:
	@docker system prune -a --volumes

.PHONY: all build down re clean fclean
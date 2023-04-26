# Paths
DOCKER_COMPOSE	= ./srcs/docker-compose.yml
ENV_FILE		= ./srcs/.env
DATA_DIR		= /var/data/

# Parameters
DOCKER_PARAMS	= -f $(DOCKER_COMPOSE) --env-file $(ENV_FILE)

all:
	@docker-compose $(DOCKER_PARAMS) up -d

build:
	@docker-compose $(DOCKER_PARAMS) up -d --build

down:
	@docker-compose $(DOCKER_PARAMS) down

re: down build

clean:
	@docker system prune -a

fclean:
	@docker system prune -a --volumes

.PHONY: all build down re clean fclean

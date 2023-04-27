# Binaries
DOCKER			=	docker
DOCKER_COMPOSE	=	docker compose

# Paths
COMPOSE_FILE	=	./srcs/docker-compose.yml
ENV_FILE		=	./srcs/.env
DATA_DIR		=	~/data

# Parameters
DOCKER_PARAMS	=	-f $(COMPOSE_FILE) --env-file $(ENV_FILE)

all: init-volumes
	@${DOCKER_COMPOSE} $(DOCKER_PARAMS) up -d

build: init-volumes
	@${DOCKER_COMPOSE} $(DOCKER_PARAMS) up -d --build

init-volumes:
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p $(DATA_DIR)/wordpress

down:
	@${DOCKER_COMPOSE} $(DOCKER_PARAMS) down

re: down build

clean:
	@${DOCKER} system prune -a

fclean:
	@${DOCKER} system prune -a --volumes
	@rm -rf $(DATA_DIR)

.PHONY: all build down re clean fclean init-volumes

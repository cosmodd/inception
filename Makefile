################################################################################
# Constants                                                                    #
################################################################################
NAME			:=	inception

# Binaries
DOCKER			:=	docker
DOCKER_COMPOSE	:=	docker compose

# Paths
COMPOSE_FILE	:=	srcs/docker-compose.yml
ENV_FILE		:=	srcs/.env
DATA_DIR		:=	${HOME}/data

# Parameters
DOCKER_PARAMS	:=	-f $(COMPOSE_FILE) --env-file $(ENV_FILE)

################################################################################
# Rules                                                                        #
################################################################################
# Build the containers if they are not built yet and start them
all: init-volumes
	@echo "[+] Starting ${NAME}..."
	@${DOCKER_COMPOSE} $(DOCKER_PARAMS) up -d

up: all

# Rebuild the containers and start them
build: init-volumes
	@echo "[+] Building and starting ${NAME}..."
	@${DOCKER_COMPOSE} $(DOCKER_PARAMS) up -d --build

# Create the volumes directories if they don't exist
# -p: create parent directories if needed
init-volumes:
	@if [ ! -d $(DATA_DIR) ]; then echo "[+] Creating volumes directories..."; fi;
	@if [ ! -d $(DATA_DIR)/mariadb ]; then mkdir -p $(DATA_DIR)/mariadb; fi;
	@if [ ! -d $(DATA_DIR)/wordpress ]; then mkdir -p $(DATA_DIR)/wordpress; fi;

# Stops and removes the containers, networks
down:
	@echo "[+] Stopping ${NAME}..."
	@${DOCKER_COMPOSE} $(DOCKER_PARAMS) down

stop: down

# Stops the project, rebuilds the containers and starts them
re: down build

# Stops the project and removes all unused containers, networks,
# images and volumes
# -: ignore errors from commands
clean: down
	@echo "[+] Cleaning ${NAME}..."
	-@${DOCKER} system prune -af
	@echo "[+] Removing volumes..."
	-@${DOCKER} volume rm $$(${DOCKER} volume ls -qf dangling=true)
	@sudo rm -rf $(DATA_DIR)

.PHONY: all up build init-volumes down stop re clean

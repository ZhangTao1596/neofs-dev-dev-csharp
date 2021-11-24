
build.storage:
	@echo "build storage..."
	@docker build \
		--build-arg storage_git=${STORAGE_GIT} \
		--build-arg storage_ver=${STORAGE_VER} \
		-t neofs-storage:latest ./services/storage

up.storage:
	@echo "start storage..."
	@docker-compose --env-file .env -f ./services/storage/docker-compose.yml up -d

down.storage:
	@docker-compose --env-file .env -f ./services/storage/docker-compose.yml down

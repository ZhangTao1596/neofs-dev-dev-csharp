
build.ir:
	@echo "build ir..."
	@docker build \
		--build-arg ir_git=${IR_GIT} \
		--build-arg ir_ver=${IR_VER} \
		-t neofs-ir:latest ./services/ir

up.ir:
	@echo "start ir..."
	@docker-compose --env-file .env -f ./services/ir/docker-compose.yml up -d

down.ir:
	@docker-compose --env-file .env -f ./services/ir/docker-compose.yml down

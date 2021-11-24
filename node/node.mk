build.node:
	@echo "build neo-cli..."
	@docker build \
		--build-arg node_git=${NODE_GIT} \
		--build-arg node_ver=${NODE_VER} \
		--build-arg modules_git=${MODULES_GIT} \
		--build-arg modules_ver=${MODULES_VER} \
		-t neo-cli:latest ./node

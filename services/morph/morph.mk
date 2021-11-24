up.morph:
	@echo "start morph..."
	@docker-compose --env-file .env -f ./services/morph/docker-compose.yml up -d

down.morph:
	@docker-compose --env-file .env -f ./services/morph/docker-compose.yml down

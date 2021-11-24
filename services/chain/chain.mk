up.chain:
	@echo "start chain..."
	@docker-compose --env-file .env -f ./services/chain/docker-compose.yml up -d

down.chain:
	@docker-compose --env-file .env -f ./services/chain/docker-compose.yml down

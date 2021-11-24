NETWORK = neofs_network

up.network:
	@echo "start network ${NETWORK}..."
	@docker network create --gateway ${IPV4_PREFIX}.1 --subnet ${IPV4_PREFIX}.0/24 neofs_network

down.network:
	@echo "remove network ${NETWORK}"
	@docker network rm ${NETWORK}

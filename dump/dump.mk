include ./node/*.mk

NEOFS_CONTRACTS_VERSION = v0.12.1
NEOFS_CONTRACTS_FILE=neofs-contract-${NEOFS_CONTRACTS_VERSION}.tar.gz
NEOFS_CONTRACTS_URL = https://github.com/nspcc-dev/neofs-contract/releases/download/$(NEOFS_CONTRACTS_VERSION)/$(NEOFS_CONTRACTS_FILE)
NEOFS_CONTRACTS_PATH=./vendor
WORKDIR = $(shell pwd)

dump.get:
	@echo $(NEOFS_CONTRACTS_URL)
	@curl -sSL ${NEOFS_CONTRACTS_URL} -o ${NEOFS_CONTRACTS_PATH}/${NEOFS_CONTRACTS_FILE}
	@mkdir ${NEOFS_CONTRACTS_PATH}/neofs-contracts
	@tar -xf ${NEOFS_CONTRACTS_PATH}/${NEOFS_CONTRACTS_FILE} -C ${NEOFS_CONTRACTS_PATH}/neofs-contracts --strip-components 1

dump.chain: build.node dump.get
	@docker run --init --name dump -v $(WORKDIR)/services/chain/config.json:/neo-cli/config.json \
    	-v $(WORKDIR)/services/chain/DBFTPlugin/config.json:/neo-cli/Plugins/DBFTPlugin/config.json \
    	-v $(WORKDIR)/services/chain/wallet.json:/neo-cli/wallet.json \
    	-v $(WORKDIR)/vendor/neofs-contracts:/neofs-contracts \
    	-v $(WORKDIR)/dump/chain.expect:/deploy.expect \
      	-v $(WORKDIR)/dump/run.sh:/run.sh \
		--stop-signal SIGTERM \
		neo-cli:latest /run.sh
	@docker cp dump:/neo-cli/chain.0.acc ./vendor/chain.0.acc
	@docker cp dump:/script_hashes.txt ./vendor/chain.script_hashes.txt
	@docker rm -f dump

dump.morph: build.node dump.get
	@docker run --init --name dump -v $(WORKDIR)/services/morph/config.json:/neo-cli/config.json \
    	-v $(WORKDIR)/services/morph/DBFTPlugin/config.json:/neo-cli/Plugins/DBFTPlugin/config.json \
    	-v $(WORKDIR)/services/morph/wallet.json:/neo-cli/wallet.json \
    	-v $(WORKDIR)/vendor/neofs-contracts:/neofs-contracts \
    	-v $(WORKDIR)/dump/morph.expect:/deploy.expect \
      	-v $(WORKDIR)/dump/run.sh:/run.sh \
		--stop-signal SIGTERM \
		neo-cli:latest /run.sh
	@docker cp dump:/neo-cli/chain.0.acc ./vendor/morph.0.acc
	@docker cp dump:/script_hashes.txt ./vendor/morph.script_hashes.txt
	@docker rm -f dump

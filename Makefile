include ./dump/*.mk
include services/*/*.mk

include .env

chain_data=chain.0.acc
morph_data=morph.0.acc
locde_data=UNLOCODE-linux.zip

.PHONY: dump
clean:
	@rm -rf ./vendor
	@mkdir ./vendor

.PHONY: dump
dump: clean dump.chain dump.morph

get.dump:
	@rm -rf ./vendor
	@mkdir ./vendor
	@echo "download chain data..."
	@curl -sSL ${RELEASE_URL}/${chain_data} -o ./vendor/${chain_data}
	@curl -sSL ${RELEASE_URL}/${morph_data} -o ./vendor/${morph_data}
	@curl -sSL ${RELEASE_URL}/${locde_data} -o ./vendor/${locde_data}
	@unzip ./vendor/${locde_data} -d ./vendor/

.PHONY: build
build: build.node build.ir build.storage

up: get.dump build hosts up.network up.chain up.morph up.storage up.ir 

.PHONY: down
down: down.storage down.ir down.morph down.chain down.network

.PHONY: hosts
hosts:
	@rm -f ./vendor/hosts
	@echo "${IPV4_PREFIX}.50 chain.${LOCAL_DOMAIN}" > ./vendor/hosts
	@echo "${IPV4_PREFIX}.61 ir01.${LOCAL_DOMAIN}" >> ./vendor/hosts
	@echo "${IPV4_PREFIX}.90 morph.${LOCAL_DOMAIN}" >> ./vendor/hosts
	@echo "${IPV4_PREFIX}.71 s01.${LOCAL_DOMAIN}" >> ./vendor/hosts
	@echo "${IPV4_PREFIX}.72 s02.${LOCAL_DOMAIN}" >> ./vendor/hosts
	@echo "${IPV4_PREFIX}.73 s03.${LOCAL_DOMAIN}" >> ./vendor/hosts
	@echo "${IPV4_PREFIX}.74 s04.${LOCAL_DOMAIN}" >> ./vendor/hosts
	@cat ./vendor/hosts

.PHONY: help
help:
	@echo '  Usage:'
	@echo '    make <target>'
	@echo ''
	@echo '  Targets:'
	@echo '    up 		start neofs private network'
	@echo '    down 	stop neofs private network'

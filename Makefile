# Including this first means we have defaults... that we override with .env
include env.template
include .env
export
ENVFILE ?= env.template

help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

certs: certs-cn certs-server certs-client ## Generate full certificate stack

certs-cn: ## Generates your cert CA
	bash ./certs/generate-certificates.sh generate_CA

certs-server: ## Generates your server certificate
	bash ./certs/generate-certificates.sh generate_server

certs-client: ## Generates your client certificate
	bash ./certs/generate-certificates.sh generate_client

envfile: ## Initializes the .env file
	cp -f $(ENVFILE) .env

# clean: ## Resets your config directories

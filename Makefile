.DEFAULT_GOAL := help
current_dir = $(shell pwd)
dockerVlang=docker run -it --rm -v ${current_dir}:/app vlang:buster 

.PHONY:help
help: ## Print this message
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sort | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\x1b[36m\1\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY:build-docker
build-docker: ## build the docker image
	docker build docker -t vlang:buster

.PHONY:tests
tests: build-docker ## Run tests
	$(dockerVlang) v test .

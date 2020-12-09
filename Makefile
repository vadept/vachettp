.DEFAULT_GOAL := help

help: ## Print this message
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sort | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\x1b[36m\1\x1b[m:\2/' | column -c2 -t -s :)"

tests: ## Run tests
	v request_parser_test.v
	v request_test.v

.PHONY: install
install:
	brew install markdownlint-cli2

.PHONY: lint
lint:
	markdownlint-cli2 --fix "**/*.md"

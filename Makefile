.PHONY: install
install:
	brew install markdownlint-cli2
	go install github.com/mrtazz/checkmake/cmd/checkmake@latest

.PHONY: lint
lint:
	checkmake Makefile
	markdownlint-cli2 --fix "**/*.md"

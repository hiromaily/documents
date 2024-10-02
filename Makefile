.PHONY: install
install:
	brew install markdownlint-cli2
	go install github.com/mrtazz/checkmake/cmd/checkmake@latest

.PHONY: lint
lint:
	markdownlint-cli2 --fix "**/*.md"
	checkmake Makefile

# https://github.com/hiromaily/markdown-link-validator-go
# run `make build` in repository
.PHONY: img-lint
img-lint:
	md-link-lint

IMAGE_NAME = sqlfluff-local
PWD := $(shell pwd)

.PHONY: build-image
build-image:
	docker build --progress=plain -t $(IMAGE_NAME) .

# make format SQL=sample_mysql.sql
.PHONY: format
format:
	docker run --rm -v $(PWD):/workspace $(IMAGE_NAME) fix /workspace/$(SQL)

# make lint SQL=sample_mysql.sql
.PHONY: lint
lint:
	docker run --rm -v $(PWD):/workspace $(IMAGE_NAME) lint /workspace/$(SQL)

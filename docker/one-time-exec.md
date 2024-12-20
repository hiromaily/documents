# 1回限りの実行

```Makefile
SQL_LINT_IMAGE_NAME = sqlfluff-local:latest
PWD := $(shell pwd)

.PHONY: build-sqlfluff-image
build-sqlfluff-image:
    docker build --progress=plain -t $(SQL_LINT_IMAGE_NAME) .

# format 実行例
# e.g. make format SQL=sample_mysql.sql
.PHONY: format-sql
format-sql:
    docker run --rm -v $(PWD):/workspace $(SQL_LINT_IMAGE_NAME) fix /workspace/$(SQL)
```

- `--rm`: 実行後にcontainerを削除
- `-v`: 実行時にlocalのhostをマウント

## ホストディレクトリをボリュームとしてマウントする場合の注意点

ホストのディレクトリをコンテナ内のディレクトリにマウントする場合、コンテナ内のマウント先ディレクトリの元々存在していたファイルやディレクトリは隠される

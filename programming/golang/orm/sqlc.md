# Go sqlc

SQLをコンパイルしてGoのコードを生成する

- [Official](https://sqlc.dev/)
- [github: sqlc](https://github.com/sqlc-dev/sqlc)

## [Install](https://docs.sqlc.dev/en/latest/overview/install.html)


```sh
go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
```

## Setup packages in project

- [Getting started with MySQL](https://docs.sqlc.dev/en/latest/tutorials/getting-started-mysql.html)
- [Getting started with PostgreSQL](https://docs.sqlc.dev/en/latest/tutorials/getting-started-postgresql.html)

### sqlの用意

```
cd [project/pkgs]
mkdir sqls
```
利用するsqlファイルを用意する。(外部から参照するのでもOK)

- Create
- Select
- Insert
- Update
- Delete

### sqlc.yaml


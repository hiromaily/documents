# sqlfluff

- [sqlfluff](https://github.com/sqlfluff/sqlfluff)
  - Python製
  - [Official](https://docs.sqlfluff.com/en/stable/index.html)
  - [SQLFluffを導入しました](https://qiita.com/n-gondo123/items/455047a063d39789df2b)

## [CLI コマンド](https://docs.sqlfluff.com/en/stable/reference/cli.html)

```sh
sqlfluff --help
Usage: sqlfluff [OPTIONS] COMMAND [ARGS]...

  SQLFluff is a modular SQL linter for humans.

Options:
  --version   Show the version and exit.
  -h, --help  Show this message and exit.

Commands:
  dialects  Show the current dialects available.
  fix       Fix SQL files.
  format    Autoformat SQL files.
  lint      Lint SQL files via passing a list of files or using stdin.
  parse     Parse SQL files and just spit out the result.
  render    Render SQL files and just spit out the result.
  rules     Show the current rules in use.
  version   Show the version of sqlfluff.

  Examples:

  .. code-block:: sh

     sqlfluff lint --dialect postgres .

     sqlfluff lint --dialect mysql --rules ST05 my_query.sql

     sqlfluff fix --dialect sqlite --rules LT10,ST05 src/queries

     sqlfluff parse --dialect duckdb --templater jinja path/my_query.sql
```

dockerで実行する例

```sh
# format
docker run --rm -v $(pwd)/sqlc/queries:/workspace sqlfluff-local:latest fix -v --config /.sqlfluff query.sql

# lint
docker run --rm -v $(pwd)/sqlc/queries:/workspace sqlfluff-local:latest lint -v --config /.sqlfluff query.sql
```

## [Config ファイル](https://docs.sqlfluff.com/en/stable/configuration/setting_configuration.html)

```config
[sqlfluff]
dialect = mysql
templater = placeholder

[sqlfluff:templater:placeholder]
param_regex = sqlc\.slice\([\'"][a-zA-Z_][a-zA-Z_0-9]*[\'"]\)|\?
```

- [Rules](https://docs.sqlfluff.com/en/stable/reference/rules.html)
- [Ignoring Errors & Files](https://docs.sqlfluff.com/en/stable/configuration/ignoring_configuration.html)

## [Placeholder](https://docs.sqlfluff.com/en/stable/configuration/templating/placeholder.html)

## Example

- [Dockerfile](./example/Dockerfile)
- [Makefile](./example/Makefile)

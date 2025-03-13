# Prompt例

## プロジェクトの新規作成

Chatを開いて`/new`コマンド入力後、promptを入力する。

### Case1: PythonによるCLIアプリケーションの作成

1. 条件の整理
   - CLI Application using Python with latest version.
   - 5 subcommands. sub command would be added as development progress.
   - Each sub commands with specific operations and dependencies on internal modules.
   - Use Clean architecture.
   - There are layers for entities, use cases, interfaces, and infrastructure.
   - Implement dependency inversion for loose coupling.
   - Set up a CLI presentation layer using Click or Typer.
   - Include testing structure, dependency management, and configuration handling.
   - Use uv as package management.


```
/new Python CLI application with 5 subcommands, each with specific operations and dependencies on internal modules. Use a Layered architecture with dependency injection, including core business logic, infrastructure, and usecase layers. Include testing setup and dependency management using uv.
```

```
/new Python CLI application with 5 subcommands using Clean Architecture. Include layers for entities, use cases, interfaces, and infrastructure. Implement dependency inversion for loose coupling. Set up a CLI presentation layer using Click or Typer. Include testing structure, dependency management, and configuration handling. Use uv as package management.
```

```
/new Python CLI application with 5 subcommands using Clean Architecture. Each subcommand should have specific operations and depend on internal modules. Use `uv` as the package management tool. Include layers for entities, use cases, interfaces, and infrastructure to follow Clean Architecture principles. Implement dependency inversion for loose coupling. Use Typer as the CLI framework. Configure popular linting tools like flake8, black, isort, and mypy for static type checking and code formatting. Use pytest as the test framework and include a basic test structure. Ensure type annotations are used throughout the project for all variables and functions. uv must be used as task runner as well. Task includes, run subcommand each, lint code, run test.
```

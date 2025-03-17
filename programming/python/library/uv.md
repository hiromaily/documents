# uv

[uv](https://github.com/astral-sh/uv)は、高速なPythonパッケージおよびプロジェクトマネージャーで複数のツールを統合し、Pythonプロジェクトの管理を効率化することを目的としており、Langchainでも利用されている。

[Document](https://docs.astral.sh/uv/)

**主な機能**  

- **速度**: `uv`は、従来のツール（例：`pip`）に比べて**10〜100倍速い**とされている。
- **包括的な管理**: `pip`、`pip-tools`、`pipx`、`poetry`、`pyenv`、`twine`、`virtualenv`などの機能を統合している。
- **ユニバーサルロックファイル**: 依存関係管理のためのユニバーサルロックファイルを提供する。
- **スクリプトサポート**: インライン依存メタデータを使用してスクリプトを実行できる。
- **Pythonバージョン管理**: 複数のPythonバージョンをインストールおよび管理できる。
- **ツール実行**: Pythonパッケージとして公開されたコマンドラインツールを実行およびインストールする。
- **Cargoスタイルのワークスペース**: スケーラブルなプロジェクト構造をサポートする。
- **ディスクスペース効率**: 依存関係の重複を排除するためのグローバルキャッシュを利用する。

**インストール**  

`uv`は、スタンドアロンインストーラーまたはPyPIから`pip`や`pipx`を使用してインストールできる

```bash
# pipを使用してインストール
pip install uv

# uvを更新
uv self update
```

**プロジェクト管理**  
`uv`は、ロックファイルやワークスペースをサポートし、プロジェクトの依存関係と環境を管理する。また、プロジェクトのビルドや公開もサポートしている。

**スクリプト管理**  
インラインメタデータを使用して依存関係を持つスクリプトを作成し、隔離された環境で実行できる。

**Pythonバージョン管理**  
`uv`を使用すると、異なるPythonバージョンを簡単にインストールおよび切り替えることができる。

**pipインターフェース**  
`uv`は、一般的な`pip`コマンドのドロップイン置き換えを提供し、依存関係のバージョンオーバーライドやプラットフォームに依存しない解決などの高度な機能を強化している。

## Install

```sh
# Install
curl -LsSf https://astral.sh/uv/install.sh | sh

To add $HOME/.local/share/../bin to your PATH, either restart your shell or run:

    source $HOME/.local/share/../bin/env (sh, bash, zsh)
```

## 使い方

### 1. Python Scriptsの実行

- **Basic script execution**:

  ```bash
  uv run example.py
  ```

  This runs a script without requiring manual dependency management.

- **Inline dependencies**:
  Add metadata directly in the script to specify dependencies:

  ```python
  # /// script
  # dependencies = ["requests"]
  # ///
  import requests
  print(requests.__version__)
  ```

  Run the script:

  ```bash
  uv run example.py
  ```

- **Using different Python versions**:

  ```bash
  uv run --python 3.10 example.py
  ```

### 2. Task Automation

Define tasks in `pyproject.toml` using `uvx`:

```toml
[tool.uv.tasks]
fmt = "ruff format"
test = "pytest tests --cov=src"
typecheck = "mypy --ignore-missing-imports ."
```

Run tasks:

```bash
uvx fmt
uvx test
uvx typecheck
```

This centralizes task definitions for easier management.

### 3. Creating and Managing Projects

- **Initialize a new project**:

   ```bash
   uv init my_project
   cd my_project
   uv run main.py
   ```

   This sets up a basic Python project with essential files like `pyproject.toml`.

   ```
   └── aiagent-cli
       ├── README.md
       ├── main.py
       ├── pyproject.toml
       └── .python-version
   ```

- **Add dependencies**:

   内部的に、`.venv`が作成される
   ```bash
   uv add requests flask
   uv add flake8 black isort mypy pytest --dev
   ```

### 4. Debugging and One-Shot Scripts

Use `uv run` for one-shot utilities with inline dependencies:

```python
# /// script
# dependencies = ["boto3", "click"]
# ///
import boto3, click

@click.command()
def debug_s3():
    print("Debugging S3 issues...")
debug_s3()
```

Run the script directly:

```bash
uv run debug_s3_access.py https://example-s3-url.com/file.jpg
```

This avoids manual dependency installation.

### 5. GUI Applications

Run GUI scripts with dependencies:

```python
from tkinter import Tk, ttk

root = Tk()
root.title("uv GUI")
frm = ttk.Frame(root, padding=10)
frm.grid()
ttk.Label(frm, text="Hello World").grid(column=0, row=0)
root.mainloop()

```
Execute with `uv`:

```bash
uv run example.pyw
```

### 6. Using `tox` with `uv`

Install `tox` for task automation:

```bash
uv tool install tox --with tox-uv
```

Define tasks in `pyproject.toml` and use `tox` to execute them across environments.

### 7. Continuous Testing

Use tools like `pytest-watch` (`ptw`) for live testing:

```bash
uv run ptw . --now -vv
```

This runs tests continuously as code changes.

## References

- [uv の使い方](https://note.com/npaka/n/n44c54312fb04)
- [さらなる進化を遂げた「uv」の新機能](https://gihyo.jp/article/2024/09/monthly-python-2409)

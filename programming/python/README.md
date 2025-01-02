# Python

## メモ

- pytest
  - Python 用 UnitTest モジュール

## Pythonのバージョン管理

- pyenv
- asdf

### pyenv

pythonのversionを複数管理できるもの

```sh
brew install pyenv
pyenv install 3.12.7
pyenv local 3.12.7
python -V
```

### asdf

Python のバージョン管理 (Python だけでなく Node.js, Goなど様々なRuntime の管理が可能)

```sh
asdf plugin add python
asdf install python 3.12.8
asdf local python 3.12.8
python -V
```

## pip: パッケージ管理システム

`pip` は Python のパッケージ管理システムであり、Python パッケージインデックス（PyPI）からパッケージをインストール、管理するためのツール。
pipだけで、プロジェクトごとの依存関係の管理には追加の工夫が必要。具体的には、仮想環境（例えば venv）を使用し、各プロジェクトごとに独立したパッケージのセットアップを行うことが一般的。

```sh

# パッケージのインストール
pip install package_name

# 特定のバージョンのインストール
pip install package_name==x.y.z

# ローカルファイルまたはURLからパッケージをインストール
pip install /path/to/package.whl

pip install https://example.com/package.tar.gz

# インストール
pip install requests

# 仮想環境やプロジェクトにインストールされているパッケージのリストをファイルに保存
pip freeze > requirements.txt

# `pip` のアップグレード
pip install --upgrade pip

# パッケージのアップグレード
pip install --upgrade package_name
```

## Project毎の仮想環境の用意 (依存関係のバージョン管理)

- Poetry
- venv
- conda

### Poetry

Poetry は、依存関係管理とパッケージの公開を一括でサポートするツールであり、スムーズなワークフローと高い操作性が特徴。pipは不要。

```sh
# https://python-poetry.org/docs/#installing-with-the-official-installer
# Install
curl -sSL https://install.python-poetry.org | python3 -
poetry --version

# create project
poetry new browser-use-example

# create project at current directory
poetry init
```

#### Poetryによるプロジェクトの基本設定例

```sh
poetry add -D flake8 black isort mypy pytest
poetry add --group dev Flake8-pyproject
```

1. **flake8**
   - Pythonのコードスタイルや構文をチェックするためのLinter。
   - PEP 8のガイドラインに基づいてコードのスタイルを保証し、エラーや警告を出す。

2. **black**
   - Pythonのコードフォーマッターで、PEP 8に準拠したフォーマットスタイルを適用する
   - コードの見た目を統一し、可読性を向上する

3. **isort**
   - Pythonのインポート文を自動的にソートする。
   - インポートをアルファベット順やグループ別に整理し、コードの可読性を向上させる。

4. **mypy**
   - Pythonの静的型チェックを実行するツール。
   - 型のエラーを事前に検出して、コードの安定性を向上させる。

5. **pytest**
   - Pythonのテストフレームワーク。
   - テストコードを書いて、コードの正確性を確認する。

6. **Flake8-pyproject**
   - flake8をpyproject.tomlファイルの設定をサポートする追加パッケージ
   - pyproject.tomlに設定を追加することで、flake8の挙動を制御する

### venv

python3.3以降のバージョンであればデフォルトで入っている、仮想環境を構築するコマンドラインツールで、`Virtualenv`から仮想環境の基本部分だけをPython公式として採用し同梱されたものとなる。仮想環境によって `pip` による環境構築をプロジェクトごとに独立させることができる。

## 2024 現在、Python を使った repository

- [ocr-py](https://github.com/hiromaily/ocr-py)

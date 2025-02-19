# Python

## Python のバージョン管理

- pyenv
- asdf

### pyenv

python の version を複数管理できるもの

```sh
brew install pyenv
pyenv install 3.12.7
pyenv local 3.12.7
python -V
```

### asdf

Python のバージョン管理 (Python だけでなく Node.js, Go など様々な Runtime の管理が可能)

```sh
asdf plugin add python
asdf install python 3.12.8
asdf local python 3.12.8
python -V
```

## pip: パッケージ管理システム

`pip` は Python のパッケージ管理システムであり、Python パッケージインデックス（PyPI）からパッケージをインストール、管理するためのツール。
pip だけで、プロジェクトごとの依存関係の管理には追加の工夫が必要。具体的には、仮想環境（例えば venv）を使用し、各プロジェクトごとに独立したパッケージのセットアップを行うことが一般的。

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

## Project 毎の仮想環境の用意 (依存関係のバージョン管理)

- Poetry
- venv
- conda

### [uv](https://github.com/astral-sh/uv)

高速なPythonパッケージ管理ツール

- Ref: [uv の使い方](https://note.com/npaka/n/n44c54312fb04)

### [Poetry](https://python-poetry.org/)

Poetry は、依存関係管理とパッケージの公開を一括でサポートするツールであり、スムーズなワークフローと高い操作性が特徴。pip は不要。

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

#### Poetry によるプロジェクトの基本設定例

```sh
poetry add -D flake8 black isort mypy pytest
poetry add --group dev Flake8-pyproject
```

1. **flake8**

   - Python のコードスタイルや構文をチェックするための Linter。
   - PEP 8 のガイドラインに基づいてコードのスタイルを保証し、エラーや警告を出す。

2. **black**

   - Python のコードフォーマッターで、PEP 8 に準拠したフォーマットスタイルを適用する
   - コードの見た目を統一し、可読性を向上する

3. **isort**

   - Python のインポート文を自動的にソートする。
   - インポートをアルファベット順やグループ別に整理し、コードの可読性を向上させる。

4. **mypy**

   - Python の静的型チェックを実行するツール。
   - 型のエラーを事前に検出して、コードの安定性を向上させる。

5. **pytest**

   - Python のテストフレームワーク。
   - テストコードを書いて、コードの正確性を確認する。

6. **Flake8-pyproject**
   - flake8 を pyproject.toml ファイルの設定をサポートする追加パッケージ
   - pyproject.toml に設定を追加することで、flake8 の挙動を制御する

### venv

python3.3 以降のバージョンであればデフォルトで入っている、仮想環境を構築するコマンドラインツールで、`Virtualenv`から仮想環境の基本部分だけを Python 公式として採用し同梱されたものとなる。仮想環境によって `pip` による環境構築をプロジェクトごとに独立させることができる。

## 2024 現在、Python を使った 個人repository

- [ocr-py](https://github.com/hiromaily/ocr-py)
- [browser-use-example](https://github.com/hiromaily/browser-use-example)

## `__init__.py`ファイル

Python の`__init__.py`ファイルは、ディレクトリを Python パッケージとして扱うことを示す特別なファイル

## References

- [『現場のPython』を読んでPythonでWeb Appを作るために必要なものが大体わかった気になった](https://blog.inorinrinrin.com/entry/2025/01/13/075841)
  - Poetry
  - black: フォーマッター
  - mypy: 型リンター
  - tox: lint, format, unit testのコマンドとかを一律で管理してくれるツール
  - struct-log: ロガー
  - Strawberry: GraphQLを使うためのライブラリ
  - uvicorn: 開発用のWebサーバー
  - sqlalchemy: ORM
  - pytest-cov: カバレッジ測定ツール
  - factory-boy: テストデータをいい感じに生成してくれるツール
  - freezegun: テストコードで時刻をモックするためのライブラリ
- [Pyhton基礎 100本ノック](https://zenn.dev/python_academia/books/eabcc6b22afff5)
- [Pythonの達人を目指して～Effective Pythonで学ぶコーディングテクニック～（前編）](https://qiita.com/NSS_FS_ENG/items/952072774acaaff8917d)

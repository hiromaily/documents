# Python の Linter/Formatter

## Linter

- **flake8:**

  - Python のコードスタイルや潜在的なエラーをチェックする汎用的な linter 。
  - PEP 8 のガイドラインに基づいてコードのスタイルを保証し、エラーや警告を出す。
  - **pycodestyle**、**pyflakes**、**mccabe**をまとめたラッパー。
  - これらのツールをまとめて使用することで、コードのスタイルや論理的なエラーを包括的にチェックできる。

- **Flake8-pyproject**

  - flake8 を pyproject.toml ファイルの設定をサポートする追加パッケージ
  - pyproject.toml に設定を追加することで、flake8 の挙動を制御する

- **pylint:**

  - Python の汎用的な linter で、VSCode のデフォルトの linter として使われている。
  - オプションが豊富で多くのチェック項目に対応していますが、最近は flake8 の方が支持されている傾向がある。

- **Ruff:**
  - 比較的新しい Python の linter で、静的コード解析ツールとして使われている。
  - コードの品質、可読性、開発効率の向上に役立つ。

## Formatter

- **black:**

  - コードフォーマッターとして、設定できるオプションが少なくシンプルな使い勝手で、多くのプロジェクトで採用されている。
  - スペースの数や改行の位置、コメントの書き方など、コードのスタイルを統一することができる。

- **yapf:**

  - Google が開発しているコードフォーマッターで、カスタマイズ性が高く、多くの項目をオプションで設定できる。
  - ベースのコードスタイルを pycodestyle や Google 独自のスタイルから選べるなど、機能が豊富。

- **autopep8:**
  - 昔からあるフォーマッターで、VSCode のデフォルトのフォーマッターとしても使われている。
  - 特徴は`--aggressive`オプションの数によって強さが変わること。

## Linter / Formatter

- **ruff**
  - Python の Linter 兼 Formatter

## Importer

- **isort**

  - Python のインポート文を自動的にソートする。
  - インポートをアルファベット順やグループ別に整理し、コードの可読性を向上させる。

## Type Checker

- **mypy**

  - Python の静的型チェックを実行するツール。
  - 型のエラーを事前に検出して、コードの安定性を向上させる。

## [Rust で書かれた高速な Python 型チェッカー 3 選](https://zenn.dev/nishikoh/articles/31441fa8fe1f73)

- [pylyzer](https://github.com/mtshiba/pylyzer)
- [Red Knot](https://github.com/astral-sh/ruff/tree/main/crates/red_knot)
- [Pyrefly(pyre2)](https://github.com/facebook/pyrefly)

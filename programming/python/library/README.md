# Python Library

## ロギング (Logger)

- **[Loguru](https://github.com/Delgan/loguru)**: Pythonでのログ記録を簡単かつ強力にするライブラリです。設定が容易で、`from loguru import logger`と書くだけで使用を開始できる。
- ~~**[logzero](https://github.com/metachris/logzero)**: 標準のloggingライブラリよりも簡単に使えるログ出力ライブラリの一つ。~~
  - Archived

## データベースORM (Object-Relational Mapping)

- **SQLAlchemy**: 最も広く使われているPythonのORMライブラリ。
- **Django ORM**: Django Webフレームワークに組み込まれたORMで、単独でも使用可能。

## テスト (Testing)

- **pytest**: 柔軟なテストケースが書けるサードパーティ製のテストフレームワーク。Pythonのテストコードを書く際のデファクトスタンダードになりつつある。
- **unittest**: Python標準ライブラリに含まれるテストフレームワークです。セットアップが不要で、簡単なテストケースを書くのに適している。

## リンター (Linter)

- **pylint**: Pythonコードの静的解析ツールとして広く使われている。
- **flake8**: PEP 8スタイルガイドに基づいてコードをチェックする人気のリンター。

## タスクランナー (Task Runner)

- **Invoke**: Pythonの関数としてタスクを定義し、デコレータで登録できるタスクランナー。
- **Fabric2**: Invokeと同様の機能を持ち、さらにリモートサーバーでの実行も可能。
- **Doit**: マルチコアを有効に使用して並列にタスクを実行できるタスクランナー。
- **taskipy**: タスクランナー

## Web スクレイピング

- **Beautiful Soup**: HTMLやXMLファイルからデータを抽出するためのライブラリです。
- **Scrapy**: 大規模なWebスクレイピングプロジェクトのためのフレームワークです。

## ネットワーキング

- **Requests**: HTTPリクエストを簡単に送信するためのライブラリです。
- **Twisted**: イベント駆動型ネットワークエンジンです。

## 非同期処理

- **asyncio**: 標準ライブラリ

標準機能のasyncとawaitキーワードを使って非同期処理を行えばよさそう

## GUI開発

- **PyQt**: Qtフレームワークを使用したGUIアプリケーション開発のためのライブラリです。
- **Tkinter**: Python標準ライブラリに含まれるGUIツールキットです。

## CLI開発

- **argparse**: argparseは、Pythonの標準ライブラリに含まれており、追加のインストールなしで使用できます[4]。サブコマンドの実装が可能で、以下のような特徴があります：
  - `subparsers`を使用してサブコマンドを作成できる
  - ヘルプメッセージの自動生成機能がある
  - 基本的な引数の解析が可能
- **Click**: Clickは、より直感的なAPIを提供するサードパーティライブラリです。以下の特徴があります：
  - デコレータを使用して簡単にコマンドを定義できる
  - ネストされたコマンド（サブコマンド）のサポート
  - 自動的なヘルプページの生成
- **Typer**: Typerは、Clickをベースにしており、より現代的なPythonの機能を活用しています[4]：
  - Python 3の型ヒントを活用した直感的な記述が可能
  - `@app.command()`デコレータを使用して簡単にサブコマンドを定義できる
  - Clickとの互換性がある
- **Python Fire**: Google製のPython Fireは、既存のPythonコードを簡単にCLIに変換できるライブラリです[1][3]：
  - Pythonの関数やクラスを自動的にCLIに変換
  - 最小限のコード変更で既存のコードをCLI化できる
  - サブコマンドの自動生成

## データ分析・科学計算

- **NumPy**: 数値計算のための基本的なライブラリで、多次元配列オブジェクトと関連ツールを提供します。
- **Pandas**: データ操作と分析のための高性能で使いやすいデータ構造とツールを提供します。
- **SciPy**: 科学技術計算のためのライブラリで、最適化、線形代数、積分、補間などの機能を提供します。

## 機械学習

- **Scikit-learn**: 機械学習のための簡単で効率的なツールを提供するライブラリです。
- **TensorFlow**: Googleが開発した、機械学習と深層学習のためのオープンソースライブラリです。
- **PyTorch**: Facebookが開発した、柔軟性の高い深層学習フレームワークです。

## データ可視化

- **Matplotlib**: 2D描画ライブラリで、出版品質のグラフや図を作成できます。
- **Seaborn**: Matplotlibをベースにした統計データ可視化ライブラリです。
- **Plotly**: インタラクティブなグラフを作成するためのライブラリです。

## 自然言語処理

- **NLTK (Natural Language Toolkit)**: 人間の言語データを扱うためのライブラリです。
- **spaCy**: 高度な自然言語処理タスクのための産業用ライブラリです。

## その他の注目すべきライブラリ

- **Celery**: 分散システムで使用される、メッセージ処理とタスクスケジューリングのためのライブラリです[3]。
- **Dramatiq**: シンプルさ、信頼性、パフォーマンスを重視したバックグラウンドタスク処理ライブラリです[3]。


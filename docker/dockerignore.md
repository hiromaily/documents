# dockerignore ファイル

`.dockerignore`ファイルは、Docker がイメージをビルドするときに無視するファイルやディレクトリを指定するためのファイル。これにより、不要なファイルがDockerイメージに含まれるのを防ぎ、ビルドの効率を向上させることができる。使い方はシンプルで、無視したいファイルやディレクトリのパスを記述する。

`.dockerignore` ファイルを適切に設定することで、Docker イメージのサイズを減らし、ビルド速度を向上させることが可能。

## コメント

`#`から始まる行はコメントとして扱われる。

```dockerignore
# コメント
```

## 特定のファイルを無視

```dockerignore
secret.txt
```

## 特定のディレクトリを無視

```dockerignore
logs/
temp/
```

## パターンを使って無視

- ワイルドカード `*` を使用してパターンマッチングを行う。

```dockerignore
*.log    # すべての.logファイルを無視
**/temp/*  # 任意のディレクトリにあるtempディレクトリ内のすべてのファイル
```

## 否定パターン

除外したファイルやディレクトリでも、特定のものを含めたい場合に使う。否定パターンは `!` を用いて記述する。

```dockerignore
logs/*
!logs/important.log   # logs/ディレクトリ内の全てを無視するが、important.logは含める
```

## 標準的な`.dockerignore`ファイルの例

```dockerignore
# 環境設定
.env

# コンパイルされたソース
*.o
*.pyc

# ログファイル
logs/
*.log

# メディア
*.png
*.jpg

# 応答ファイル
# テスト結果を無視する
tests/results/

# ノードモジュール
node_modules/
```

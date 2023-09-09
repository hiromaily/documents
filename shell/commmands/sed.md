# sed command

- 、UNIX 系 OS でよく利用されるコマンド/プログラムの一つで、入力された文字（テキスト）データを 1 行ずつ読み込んで指定された処理を適用して出力するもの
  - 一般的に文字列の置換などに使われることが多い
- stream editor の略

## 書式

```
sed [オプション] コマンド 入力ファイル名
```

## ChatGPT の活用

- 例えば、以下のケース。ファイル内に以下のような文字列があり、右辺の値を`22.8.2`に変更したい

```sh
QUORUM_VERSION=22.7.5
```

```sh
sed -i 's/QUORUM_VERSION=[0-9]\+\.[0-9]\+\.[0-9]\+/QUORUM_VERSION=22.8.2/g' file.txt
```

## `sed`の代替え

- ksh、bash、zsh なら一行の文字列の置換に sed コマンドは実行コストが高いため不要
- sed は複数行のテキストを正規表現で置換するために使う
- シェル言語ネイティブの文字列処理の方法は`変数展開`を使う

### 方法

- sed の場合

```sh
ret=$(echo "$line" | sed "s/from/to/")
```

- shell script の native 機能の場合

```sh
ret=${line/from/to}
```

### 参考

- [【脱 sed】いい加減シェルスクリプトで文字列を sed で置換するなんてやめよう](https://qiita.com/ko1nksm/items/b4b342f77f6d3ee1a0a9)

## MacOS と Linux では、sed の動作が異なる

- [Mac と Linux では、sed の動作が異なるので注意](https://it-ojisan.tokyo/mac-linux-sed/)
- MacOS では、`gsed`を使う
- これによるエラーも頻繁に発生するので、Mac の場合は両方試してみるといいかもしれない

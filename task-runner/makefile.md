# Makefile

Makefile は `make` コマンドと連携してプログラムのビルドプロセスを自動化するための設定ファイル。C や C++などのコンパイルが必要なプログラムでよく使われるが、他の言語やツールでも利用可能。

## 書き方のサンプル

- [mk](https://github.com/hiromaily/mk/blob/master/Makefile)
- [Markdown 50のルール](https://qiita.com/antk/items/e11cac45f9da343e7bf0)

## 基本的な構造

Makefile の内容は主に`ターゲット`、`依存関係`、および`コマンド`で構成されている。

```makefile
ターゲット: 依存関係
    コマンド
```

```makefile
all: myprogram

myprogram: main.o util.o
    gcc -o myprogram main.o util.o

main.o: main.c
    gcc -c main.c

util.o: util.c
    gcc -c util.c

clean:
    rm -f myprogram main.o util.o
```

## 項目説明

1. **ターゲット (`target`)**:

   - ターゲットは、`make` コマンドに実行される目的（生成物）を示す。例えば、上記の例では `myprogram` や `clean` がターゲットにあたる。

2. **依存関係 (`dependencies`)**:

   - ターゲットが依存するファイルや他のターゲットを示す。`myprogram` は `main.o` と `util.o` に依存する。

3. **コマンド (`commands`)**:
   - 各ターゲットを生成するために実行されるコマンドを指定する。これらは依存関係が実行されてから、実行される。
   - コマンドは`tab`文字で始める

## クリーンアップ

クリーンアップ用のターゲットもよく設定され、ビルド結果を削除するために使用される。

```makefile
clean:
    rm -f myprogram main.o util.o
```

## 変数

Makefile では変数を使ってコードを再利用することができる。

```makefile
CC = gcc
CFLAGS = -Wall -g

all: myprogram

myprogram: main.o util.o
    $(CC) $(CFLAGS) -o myprogram main.o util.o

main.o: main.c
    $(CC) $(CFLAGS) -c main.c

util.o: util.c
    $(CC) $(CFLAGS) -c util.c

clean:
    rm -f myprogram main.o util.o
```

## パターンルール

多くのファイルに共通するルールがある場合、パターンルールを使って効率化できる。

```makefile
%.o: %.c
    $(CC) $(CFLAGS) -c $< -o $@
```

## 依存関係の自動生成

大規模なプロジェクトでは依存関係を手動で管理するのが大変なので、自動生成することが一般的。

```Makefile
depend:
    gcc -MM *.c > dependencies.mk

include dependencies.mk
```

`dependencies.mk` には `gcc -MM` コマンドで生成された依存関係のリストが含まれます。

## 実行方法

作成した Makefile と同じディレクトリでシェルやコマンドラインから以下のようにしてビルドを実行する。

```sh
make
```

特定のターゲットをビルドする場合：

```sh
make myprogram
```

クリーンアップする場合：

```sh
make clean
```

## Makefile の Linter

- [checkmake](https://github.com/mrtazz/checkmake)

```sh
go install github.com/mrtazz/checkmake/cmd/checkmake@latest
```

# Shell

- シェルとは、オペレーティングシステム（OS）の操作を行うためのコマンドインターフェイスを指す

## 主要な shell の種類

- sh: Borrne Shell
- bash: Bourne-Again shell
- zsh: Z shell
- csh: C shell
- tcsh
- ksh

### bash

- bash とは UNIX 系システムで用いられているシェル
- Bourne Again Shell の略
- フリーソフトウェア財団（Free Software Foundation、FSF）の GNU プロジェクトにより開発された
- bash は Bourne Shell のフリーソフトウェア版として機能を継承しつつ、C Shell や KornShell の機能を取り入れたシェル

### `sh`と`bash`の違い

## シェバン (shebang)

- `#!` から始まる 1 行目のこと。起動してスクリプトを読み込むインタプリタを指定する
  - e.g. `#!/bin/bash`, `#!/bin/sh`
- シバンの参照先は、実行可能バイナリでなければならない
- env を用いたトリックは PATH 環境変数に依存する
  - e.g. `#!/usr/bin/env python3`
  - `env`コマンドは環境変数を設定してコマンドを実行するときに使うコマンド

### `#!/usr/bin/env python` の意味

- `#!/usr/bin/python`
  - `/usr/bin/python script.py` が実行される
- `#!/usr/bin/env python`
  - ただし、システムによっては、Python のインストールパスが異なる場合があるためこの記述によって、env コマンドの効果で、PATH 環境変数の通っている場所から、Python インタープリタを探索して実行することになる
  - これにより、pyenv で指定した環境から読み込むことができるようになる
  - ただし、alias で、`alias python=/usr/bin/python3`としていても、python によって python3 が読まれるということはない

## POSIX (Portable Operating System Interface) ポジックス

- カーネルの機能を呼び出すシステムコールを C 言語から利用するための API 仕様や標準ライブラリ関数などを定めており、POSIX 仕様のみを用いて開発されたプログラムは POSIX 準拠の OS ならばどれでも同じように動作させることができる
- POSIX 標準はいわゆる UNIX 系 OS の多くが対応しているほか、Windows など UNIX 系以外の OS でもオプション機能などの形で POSIX サポートが提供されている
- シェルスクリプトは環境依存が激しく、どこでも動くシェルスクリプトを書くのは難しい
  - 標準的なコマンド（POSIX コマンド含む）に完全な互換性がない
  - 全く同じ動作をするシェルが一つもない
- 一部のシェルで実装されている `POSIX モード`を使うことである程度この問題を軽減できる

### POSIX モード

- シェルの動作を POSIX 準拠に高めるために一部のシェルに搭載されている機能
- POSIX モードでもシェル間で完全な互換性はない
- POSIX モードでシェルスクリプトを動かす方法としては、シバンに `#!/bin/sh` を使って sh でシェルスクリプト実行する方法がよく使われる
- ただし、`/bin/sh` の実体は OS によって異なる。
  - CentOS: bash
  - Debian/Ubuntu: dash
  - FreeBSD: FreeBSD sh (ash 系のシェル)
  - MacOS: bash -> つまり、シェバンはどちらでも同じ

```sh
❯ /bin/sh --version
GNU bash, version 3.2.57(1)-release (arm64-apple-darwin21)
Copyright (C) 2007 Free Software Foundation, Inc.
```

- POSIX モードに切り替える他の方法としては、sh 以外の名前で起動したときに `set -o posix`をセットする。
- yash 以外は、POSIX と矛盾する動作だけを POSIX 準拠に変更し、拡張機能はそのまま使える
- しかし、bash を POSIX モードにしたとしてもほとんどの拡張機能は無効にはならない

## [`.`] によるファイル実行

- `source`は`ファイルからコマンドを読み込んで現在のシェルで実行する`コマンドであり、「.」コマンドも同じように動作する
- これらは、Bash などのシェル自身が処理を行う`内部コマンド`

```sh
source file_path [args]
. file_path [args]
```

- 通常、`./script.sh`や`bash script.sh`として実行する場合は、`別のシェルで実行`することになる
  - 以下 script を例に、これを実行すると、`foo`と表示される

```sh
#!/bin/bash

FOO=foo
echo $FOO
```

- この後、`echo $FOO`と実行しても、なにも表示されない
- しかし、`. script.sh`を実行後、`echo $FOO`と実行すると、`foo`と表示される

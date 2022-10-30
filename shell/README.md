# Shell
- シェルとは、オペレーティングシステム（OS）の操作を行うためのコマンドインターフェイスを指す

## bash
- bashとはUNIX系システムで用いられているシェル
- Bourne Again Shellの略
- フリーソフトウェア財団（Free Software Foundation、FSF）のGNUプロジェクトにより開発された
- bashはBourne Shellのフリーソフトウェア版として機能を継承しつつ、C ShellやKornShellの機能を取り入れたシェル

## シェバン (shebang)
  - `#!` から始まる1行目のこと。起動してスクリプトを読み込むインタプリタを指定する
    - e.g. `#!/bin/bash`, `#!/bin/sh`
  - シバンの参照先は、実行可能バイナリでなければならない
  - envを用いたトリックはPATH環境変数に依存する
    - e.g. `#!/usr/bin/env python3`
    - `env`コマンドは環境変数を設定してコマンドを実行するときに使うコマンド

### `#!/usr/bin/env python` の意味
- `#!/usr/bin/python`
  - `/usr/bin/python script.py` が実行される
- `#!/usr/bin/env python`
  - ただし、システムによっては、Pythonのインストールパスが異なる場合があるためこの記述によって、envコマンドの効果で、PATH環境変数の通っている場所から、Pythonインタープリタを探索して実行することになる
  - これにより、pyenvで指定した環境から読み込むことができるようになる
  - ただし、aliasで、`alias python=/usr/bin/python3`としていても、pythonによってpython3が読まれるということはない


## POSIX (Portable Operating System Interface) ポジックス
- カーネルの機能を呼び出すシステムコールをC言語から利用するためのAPI仕様や標準ライブラリ関数などを定めており、POSIX仕様のみを用いて開発されたプログラムはPOSIX準拠のOSならばどれでも同じように動作させることができる
- POSIX標準はいわゆるUNIX系OSの多くが対応しているほか、WindowsなどUNIX系以外のOSでもオプション機能などの形でPOSIXサポートが提供されている
- シェルスクリプトは環境依存が激しく、どこでも動くシェルスクリプトを書くのは難しい
  - 標準的なコマンド（POSIX コマンド含む）に完全な互換性がない
  - 全く同じ動作をするシェルが一つもない
- 一部のシェルで実装されている `POSIX モード`を使うことである程度この問題を軽減できる


### POSIXモード
- シェルの動作を POSIX 準拠に高めるために一部のシェルに搭載されている機能
- POSIXモードでもシェル間で完全な互換性はない
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

- POSIX モードに切り替える他の方法としては、sh以外の名前で起動したときに `set -o posix`をセットする。
- yash以外は、POSIX と矛盾する動作だけを POSIX 準拠に変更し、拡張機能はそのまま使える
- しかし、bash を POSIX モードにしたとしてもほとんどの拡張機能は無効にはならない


## [`.`] によるファイル実行
- `source`は`ファイルからコマンドを読み込んで現在のシェルで実行する`コマンドであり、「.」コマンドも同じように動作する
- これらは、Bashなどのシェル自身が処理を行う`内部コマンド`
```
source file_path [args]
. file_path [args]
```
- 通常、`./script.sh`や`bash script.sh`として実行する場合は、`別のシェルで実行`することになる
  - 以下scriptを例に、これを実行すると、`foo`と表示される
```sh
#!/bin/bash

FOO=foo
echo $FOO
```
  - この後、`echo $FOO`と実行しても、なにも表示されない
  - しかし、`. script.sh`を実行後、`echo $FOO`と実行すると、`foo`と表示される


## MacOSとLinuxでは、sedの動作が異なる
- [MacとLinuxでは、sedの動作が異なるので注意](https://it-ojisan.tokyo/mac-linux-sed/)
- MacOSでは、`gsed`を使う
- これによるエラーも頻繁に発生するので、Macの場合は両方試してみるといいかもしれない


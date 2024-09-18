# POSIX (Portable Operating System Interface) ポジックス

- カーネルの機能を呼び出すシステムコールを C 言語から利用するための API 仕様や標準ライブラリ関数などを定めており、`POSIX 仕様のみを用いて開発されたプログラムは POSIX 準拠の OS ならばどれでも同じように動作させることができる`
- POSIX 標準はいわゆる UNIX 系 OS の多くが対応しているほか、Windows など UNIX 系以外の OS でもオプション機能などの形で POSIX サポートが提供されている
- `シェルスクリプトは環境依存が激しく、どこでも動くシェルスクリプトを書くのは難しい`
  - 標準的なコマンド（POSIX コマンド含む）に完全な互換性がない
  - `全く同じ動作をするシェルが一つもない`
- 一部のシェルで実装されている `POSIX モード`を使うことである程度この問題を軽減できる

## POSIX モード

- シェルの動作を POSIX 準拠に高めるために一部のシェルに搭載されている機能
- POSIX モードでもシェル間で完全な互換性はない
- POSIX モードでシェルスクリプトを動かす方法としては、シェバンに `#!/bin/sh` を使って sh でシェルスクリプト実行する方法がよく使われる [重要]
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

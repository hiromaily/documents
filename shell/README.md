# Shell

- シェルとは、オペレーティングシステム（OS）の操作を行うためのコマンドインターフェイスを指す

- [explainshell.com](https://explainshell.com/)

## 主要な shell の種類

- sh: Borrne Shell
- bash: Bourne-Again shell
- zsh: Z shell
- csh: C shell
- tcsh
- ksh
- [fish](https://github.com/fish-shell/fish-shell)
- [elvish](https://github.com/elves/elvish)

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

# Zsh Plugin

## [enhanced](https://github.com/babarot/enhancd)

`cd`コマンドを履歴から表示する。

```sh
> cd [Enter]
history1...
history2
...
> 
```

## [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)

入力履歴から補完する。
使い方は、途中まで入力したあと、カーソルの↑↓で履歴を表示し、選択する

別の履歴からの検索手段として、以下のようなzsh functionでも対応可能

```sh
fh() {
  cmd=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
  echo $cmd
  eval $cmd
}
```

## [history-search-multi-word](https://github.com/zdharma/history-search-multi-word)

`Ctrl`+`R`キーを入力すると、プロンプトから履歴を検索することができる

## [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)

Syntax Highlighting

## [olets/zsh-abbr](https://github.com/olets/zsh-abbr)

aliasと同じような機能だが、履歴にaliasの展開後のコマンドが残ることになる

## [fzf](https://github.com/junegunn/fzf)

コマンド履歴など、様々な検索に利用できる

## [exa](https://github.com/ogham/exa)

`ls`コマンドのリッチバージョン

2024年、こちらは利用できなくなっている

```sh
 exa has been disabled because it is not maintained upstream! It was disabled on 2024-01-24.
```

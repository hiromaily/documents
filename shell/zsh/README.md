# Zsh

## [XDG Base Directory Specification](../../macos/setup.md#xdg-base-directory-specification)

## パフォーマンスチューニングのための計測

```sh
# 先頭に記述
zmodload zsh/zprof && zprof
```

```sh
# .zshrcの最後に記述
if (which zprof > /dev/null 2>&1) ;then
  zprof
fi
```

```sh
# 測定
$ time (zsh -i -c exit)
```

## xx`env`は遅いので遅延ロードできるようにしておく

```sh
direnv() {
  unfunction "$0"
  source <(direnv hook zsh)
  $0 "$@"
}

goenv() {
  unfunction "$0"
  source <(goenv init -)
  $0 "$@"
}

pyenv() {
  unfunction "$0"
  source <(pyenv init -)
  $0 "$@"
}
```

## 分割された外部ファイルのロード `.zsh/***.zsh`

```sh
ZSHHOME="${HOME}/.zsh"

if [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi
```

## `.zshrc`をコンパイルする

- `.zshrc`を変更したときに手動でコンパイルする場合
- 自動コンパイル（ただし最初の１回は手動実行が必要）

```sh
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
   zcompile ~/.zshrc
fi
```

- 完全自動実行

```sh
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
   zcompile ~/.zshrc
fi
```

```sh
$ zcompile ~/.zshrc
```

## [zsh のプラグインマネージャー](framework.md)は遅い

- 個人的には、[Zim](https://zimfw.sh/) 押し

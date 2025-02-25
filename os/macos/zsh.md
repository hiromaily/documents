# zsh setup

## References

- [.zprofile, .zshrc, .zenv, OMG! What Do I Put Where?!](https://www.zerotohero.dev/zshell-startup-files/)
- [macOS, Zsh, and more](https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2)
- [Top popular Zsh plugins on GitHub (2021)](https://safjan.com/top-popular-zsh-plugins-on-github-2021/)
- [awesome-zsh-plugins](https://project-awesome.org/unixorn/awesome-zsh-plugins)
- [ひさしぶりに zsh に戻りました](https://blog.nishimu.land/entry/2022/03/21/003009)

## Install newest zsh

```sh
brew install zsh
```

## Install zim

- [install](https://zimfw.sh/docs/install/)
- [Zim フレームワークで Zsh 環境を構築する](https://takuyatsuchida.com/build-zsh-environment-by-zim-framework/)
- [zim is faster than zint](https://www.reddit.com/r/zsh/comments/sojfbw/anyone_used_zshellzi/)

```sh
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
```

## Add modules in `.zimrc`

### eriner (theme)

- <https://zimfw.sh/docs/themes/>
- <https://github.com/zimfw/eriner>
- <https://stackoverflow.com/questions/42271657/oh-my-zsh-showing-weird-character-on-terminal#_=>_

- `.zimrc`

```sh
zmodule eriner
zimfw install
```

### Powerlevel10k (theme)

- <https://github.com/romkatv/powerlevel10k>

- `.zimrc`

```sh
zmodule romkatv/powerlevel10k --use degit
zimfw install
```

### zsh-autosuggestions

- <https://github.com/zsh-users/zsh-autosuggestions>
- not required thanks to zim

### zsh-abbr

- <https://github.com/olets/zsh-abbr>

- `.zimrc`

```sh
zmodule olets/zsh-abbr
zimfw install
# then add .config/zsh/abbreviations and modify
```

### enhancd

- <https://github.com/b4b4r07/enhancd>
- <https://liginc.co.jp/448630>

- `.zimrc`

```sh
zmodule b4b4r07/enhancd
zimfw install
```

### zdharma/history-search-multi-word [ctrl+R]

- <https://github.com/zdharma/history-search-multi-word>

- `.zimrc`

```sh
zmodule zdharma/history-search-multi-word
zimfw install
```

### zdharma/fast-syntax-highlighting

- <https://github.com/zdharma/fast-syntax-highlighting>

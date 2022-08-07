# MacOS Setup

## Install home brew

$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## Setup zsh

### References

- [.zprofile, .zshrc, .zenv, OMG! What Do I Put Where?!](https://www.zerotohero.dev/zshell-startup-files/)
- [macOS, Zsh, and more](https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2)
- [Top popular Zsh plugins on GitHub (2021)](https://safjan.com/top-popular-zsh-plugins-on-github-2021/)
- [awesome-zsh-plugins](https://project-awesome.org/unixorn/awesome-zsh-plugins)
- [ひさしぶりに zsh に戻りました](https://blog.nishimu.land/entry/2022/03/21/003009)

### XDG Base Directory Specification

- [ホームディレクトリのドットファイルを整理する](https://chiyosuke.blogspot.com/2019/04/blog-post_27.html)

- /etc/zshenv

```bash
ZDOTDIR=$HOME/.config/zsh
```

- ~/.config/zsh/.zshenv

```bash
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
export HISTFILE="$XDG_DATA_HOME"/zsh/history
```

### Install newest zsh

```bash
brew install zsh
```

### Install zim

- [install](https://zimfw.sh/docs/install/)
- [Zim フレームワークで Zsh 環境を構築する](https://takuyatsuchida.com/build-zsh-environment-by-zim-framework/)
- [zim is faster than zint](https://www.reddit.com/r/zsh/comments/sojfbw/anyone_used_zshellzi/)

```bash
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
```

### Add modules in `.zimrc`

#### eriner (theme)

- https://zimfw.sh/docs/themes/
- https://github.com/zimfw/eriner
- https://stackoverflow.com/questions/42271657/oh-my-zsh-showing-weird-character-on-terminal#_=_

- `.zimrc`

```bash
zmodule eriner
zimfw install
```

#### Powerlevel10k (theme)

- https://github.com/romkatv/powerlevel10k

- `.zimrc`

```bash
zmodule romkatv/powerlevel10k --use degit
zimfw install
```

#### zsh-autosuggestions

- https://github.com/zsh-users/zsh-autosuggestions
- not required thanks to zim

#### zsh-abbr

- https://github.com/olets/zsh-abbr

- `.zimrc`

```bash
zmodule olets/zsh-abbr
zimfw install
# then add .config/zsh/abbreviations and modify
```

#### enhancd

- https://github.com/b4b4r07/enhancd
- https://liginc.co.jp/448630

- `.zimrc`

```bash
zmodule b4b4r07/enhancd
zimfw install
```

#### zdharma/history-search-multi-word [ctrl+R]

- https://github.com/zdharma/history-search-multi-word

- `.zimrc`

```bash
zmodule zdharma/history-search-multi-word
zimfw install
```

#### zdharma/fast-syntax-highlighting

- https://github.com/zdharma/fast-syntax-highlighting

### fzf

- [Ctrl-r] -> 履歴
- [Ctrl-t] -> 現在のディレクトリ検索

```bash
brew install fzf
/opt/homebrew/opt/fzf/install
mv .fzf.zsh .config/zsh/
```

- `.zprofile`

```
# fzf
[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh
```

### fig [WIP]

- https://fig.io/

## Install tools by brew

```bash
brew install zsh
brew install wget
brew install nmap
brew install tmux
brew install git
brew install git-lfs
brew install jq
brew install fd    # https://github.com/sharkdp/fd file search: e.g. fd filename
brew install fzf
(brew --prefix)/opt/fzf/install
brew install bat   # https://github.com/sharkdp/bat like cat
brew install peco
brew install exa
brew install tree
brew install truncate
brew install readline
brew install httpie
brew install direnv
brew install go
brew install node
brew install nodebrew
brew install protobuf
brew install bufbuild/buf/buf
brew install go-task/tap/go-task
brew install yarn
brew install neovim
```

- Add path in `.zprofile`

```
export PATH=$HOME/.nodebrew/current/bin:$PATH
```

## Golang settings

```bash
mkdir -p ~/go/pkg
mkdir -p ~/go/src
mkdir -p ~/go/bin

# install
go install golang.org/x/tools/cmd/goimports@latest
```

## NeoVIM settings

```
brew install neovim
mkdir -p ~/.config/nvim/plugged
touch ~/.config/nvim/init.vim
```

- `.config/zsh/.alias.zsh`

```
alias vim='nvim'
```

- `.config/nvim/init.vim`

```
set number             "行番号を表示
set autoindent         "改行時に自動でインデントする
set tabstop=2          "タブを何文字の空白に変換するか
set shiftwidth=2       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set splitright         "画面を縦分割する際に右に開く
set clipboard=unnamed  "yank した文字列をクリップボードにコピー
set hls                "検索した文字をハイライトする
```

## 既存のマシンからの設定引き継ぎ

- home ディレクトリのファイルを既存マシンからコピー
  - `.gitconfig`
  - `.gitignore_global`
  - `.zshrc` (参考にするだけ) => zim があれば、今までの設定はいらないかも。
  - `.zprofile` => 必要な環境変数だけコピー
  - `.alias.zsh` => 一度見直し、必要なものだけ利用

### XDG Base Directory Specification

- install 済みの Application の設定を変更する

#### git config

- https://git-scm.com/docs/git-config#Documentation/git-config.txt---global

  - `~/.gitconfig`は`$XDG_CONFIG_HOME/git/config`に置き換えられる

- https://git-scm.com/docs/gitignore#_description
  - `~/.gitignore_global`は`$XDG_CONFIG_HOME/git/ignore`に置き換えられる

#### `~/.yarnrc`

- https://wiki.archlinux.jp/index.php/XDG_Base_Directory

- `.zshrc`

```
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn"'
```

- これはうまくいかなかった。
  - https://github.com/yarnpkg/yarn/issues/2334

#### Docker

- https://docs.docker.com/engine/reference/commandline/cli/
- `.zprofile`

```
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
```

#### `~/.lesshst`

- `.zprofile`

```
export LESSHISTFILE="$XDG_STATE_HOME"/less/history
```

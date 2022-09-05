# Setup for Ubuntu

## Install .deb file on Ubuntu
```
sudo dpkg -i package.deb
sudo apt install -f
```
- [TODO] これは`.alias.zsh`に`Alias`としてに追加しておく


## Install Basics
### Terminal apps
- [Hyper](https://hyper.is/#installation)
  - 以下に続く、Zim等の設定が反映されない
- Ubuntu Budgie Desktop をinstallしたら、`Tilix`がインストールされていた。
  - `shortcut`の項にて、最低限、Copy, Pasteの設定は入れておく
  - 
### XDG Base Directory Specification
- /etc/zshenv

- [zshで/etc/zshenvや/etc/zprofileが読まれない問題](https://zenn.dev/ota42y/articles/41c40ddef10a59)
- Ubuntuで`zsh`をinstallした後、`/etc/zsh`以下にあるファイルを読み込むように変更されていたため、`/etc/zsh/zshenv` を修正する
- `/etc/zsh/zshenv`
```bash
ZDOTDIR=$HOME/.config/zsh
```

- `~/.config/zsh/.zshenv`

```bash
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
export HISTFILE="$XDG_DATA_HOME"/zsh/history
```

### Install newest zsh

```bash
sudo apt install zsh
sudo apt install neovim
sudo apt install fzf
sudo apt install exa
sudo apt install bat
sudo apt install unrar

# check
echo $SHELL
which zsh
chsh -s $(which zsh)
```

#### Install zim
- [install](https://zimfw.sh/docs/install/)
- `$ZDOTDIR/.zimrc`
```
# custom by myself
zmodule romkatv/powerlevel10k --use degit
zmodule b4b4r07/enhancd
zmodule zsh-users/zsh-history-substring-search
zmodule zdharma/history-search-multi-word
zmodule zdharma/fast-syntax-highlighting
zmodule olets/zsh-abbr
zmodule fzf
```
- Then restart shell

#### Install font for Powerlevel10k
- [Powerlevel10k: Font](https://github.com/romkatv/powerlevel10k/blob/master/font.md)
- fontをDownload後、fontファイルをダブルクリックでinstallする
- `Budgie Desktop Settings` を開き、`Fonts`の`Monospace`でfont:`MesloLGS NF Regular`選択する


#### `.zprofile`
```bash
# fzf
[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh

#------------------------------------------------------------------------------
# environment varibles
#------------------------------------------------------------------------------
# CARGO RUST
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CARGO_CONFIG="$XDG_CONFIG_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
# no needs, this script just sets $PATH if not set yet.
#[ -f $CARGO_CONFIG/env ] && source $CARGO_CONFIG/env

# GOPATH
export GOPATH=$(go env GOPATH)

# PATH
export PATH=$HOME/.nodebrew/current/bin:$CARGO_HOME/bin:$GOPATH/bin:$PATH

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
```


#### `.zshrc`
```bash
# alias
[ -f ~/.config/zsh/.alias.zsh ] && source ~/.config/zsh/.alias.zsh
[ -f ~/.config/zsh/.alias.dev.zsh ] && source ~/.config/zsh/.alias.dev.zsh

# zpath
fpath+=~/.config/zsh/zfunc
```

#### その他必要なファイル群をzsh配下に 作成する
```
mkdir zfunc
touch .alias.zsh
touch .alias.dev.zsh
```


### 日本語入力
- `Budgie Control Center`の`Keyboard`の設定内、`Input Source Switching`の項を確認
- `Keyboard Shortcuts`で変更が可能。`Super` + `Space`が一般的

### 日本語が入力できない問題への対処
- 以下を実行し、input-sourceの確認
```bash
gsettings get org.gnome.desktop.input-sources sources
# [('ibus', 'mozc-jp'), ('xkb', 'us'), ]
```

- `IBus  is  an  Intelligent Input Bus. It is a new input framework for Linux OS`　
- `ibus-setup`コマンドで、設定ファイルが表示される。
  - `Keyboard Shortcuts`-`Next input method:` で、shortcutの追加が必要
  - Restartしたら切り替えが動作するようになった


## Ubuntu Workspace
- ワークスペース切り替え ... `Ctrl`+`Alt` と `矢印キー`

## Gestures
- [mouse](https://help.ubuntu.com/stable/ubuntu-help/mouse.html.en)
- [touchscreen-gestures](https://help.ubuntu.com/stable/ubuntu-help/touchscreen-gestures.html.en)
- `Ubuntu Budgie Desktop`の場合は選択できない？？

## Install theme
- `Ubuntu Budgie Desktop`の場合、`Budgie Themes & Layouts`から選択が可能
- [gnome-look.org](https://www.gnome-look.org/browse?cat=135&ord=rating)

```
sudo apt install [package name]-theme
```

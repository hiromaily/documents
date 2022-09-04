# Setup for Ubuntu

## Ubuntuのboot USBをMacで作成する
- OS imageをダウンロード
- USBメモリを`FAT32`にフォーマット
- [etcher](https://www.balena.io/etcher/)をインストール

## Clean install from USB
- OS 起動前での BIOS へのアクセスにはキーボード上の`F2`を押下したまま、`電源ボタン`を押し、`F2` キーは押したまま


## Install Install Budgie Desktop 
```
sudo apt update && sudo apt upgrade -y
sudo apt install ubuntu-budgie-desktop
# default display manager => lightdm
```
- Then Log Out 
- Switch to Budgie Desktop at Login in Ubuntu from right bottom corner

## Upgrade version from 20.04 to 22.04
```
sudo apt update 
sudo apt upgrade
sudo apt dist-upgrade
sudo apt autoremove
sudo apt install update-manager-core
sudo do-release-upgrade 
```

## Install .deb file on Ubuntu
```
sudo dpkg -i package.deb
sudo apt install -f
```

## Install theme
[gnome-look.org](https://www.gnome-look.org/browse?cat=135&ord=rating)

```
sudo apt install [package name]-theme
```

## Install Basics
### Terminal apps
- [Hyper](https://hyper.is/#installation)

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
- `Budgie Desktop Settings` を開き、`Fonts`の`Monospace`でfontを選択する


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


### Ubuntu Workspace



# Setup for Ubuntu

## Install .deb file on Ubuntu

```sh
sudo dpkg -i package.deb
sudo apt install -f
```

- [TODO] これは`.alias.zsh`に`Alias`としてに追加しておく

## Install Basics

### Terminal apps

- [Hyper](https://hyper.is/#installation)
  - 以下に続く、Zim 等の設定が反映されない
- Ubuntu Budgie Desktop を install したら、`Tilix`がインストールされていた。
  - `shortcut`の項にて、最低限、Copy, Paste の設定は入れておく
  -

### XDG Base Directory Specification

- /etc/zshenv

- [zsh で/etc/zshenv や/etc/zprofile が読まれない問題](https://zenn.dev/ota42y/articles/41c40ddef10a59)
- Ubuntu で`zsh`を install した後、`/etc/zsh`以下にあるファイルを読み込むように変更されていたため、`/etc/zsh/zshenv` を修正する
- `/etc/zsh/zshenv`

```sh
ZDOTDIR=$HOME/.config/zsh
```

- `~/.config/zsh/.zshenv`

```sh
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
export HISTFILE="$XDG_DATA_HOME"/zsh/history
```

### Install newest zsh

```sh
sudo apt install zsh
sudo apt install tmux
sudo apt install neovim
sudo apt install build-essential
sudo apt install fzf
sudo apt install exa
sudo apt install bat
sudo apt install unrar
sudo apt install git
sudo apt install golang-go

# check
echo $SHELL
which zsh
chsh -s $(which zsh)
```

#### Install zim

- [install](https://zimfw.sh/docs/install/)
- `$ZDOTDIR/.zimrc`

```sh
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
- font を Download 後、font ファイルをダブルクリックで install する
- `Budgie Desktop Settings` を開き、`Fonts`の`Monospace`で font:`MesloLGS NF Regular`選択する

#### `.zprofile`

```sh
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

```sh
# alias
[ -f ~/.config/zsh/.alias.zsh ] && source ~/.config/zsh/.alias.zsh
[ -f ~/.config/zsh/.alias.dev.zsh ] && source ~/.config/zsh/.alias.dev.zsh

# zpath
fpath+=~/.config/zsh/zfunc
```

#### その他必要なファイル群を zsh 配下に 作成する

```sh
mkdir zfunc
touch .alias.zsh
touch .alias.dev.zsh
```

#### History File

- Ubuntu の場合は `~/.local/share/zsh/` ディレクトリを作成する必要がある

## Git Setup

```sh
ssh-keygen -t ed25519 -f ~/.ssh/id_github -C "hiromaily@gmail.com"
ssh-add ~/.ssh/id_github
# ssh-add -l
# cat ~/.ssh/id_github.pub
```

## Docker Setup

### Get Docker package

```sh
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release
# Add official Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# Add it to repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# check file
cat /etc/apt/sources.list.d/docker.list
sudo apt update
# check docker version
sudo apt info docker-ce
```

### Install Docker

```sh
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker <user-name>
# re-login
```

### Check Docker

```sh
sudo docker run hello-world
```

### dconf-editor

設定管理ツール

```sh
sudo apt update
sudo install dconf-editor
```

### video 編集

- [kdenlive](https://kdenlive.org/en/download/)

```sh
sudo add-apt-repository ppa:kdenlive/kdenlive-stable
sudo apt update
sudo apt install kdenlive
```

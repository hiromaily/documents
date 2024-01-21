# MacOS Setup

## やるべきこと

[既存のマシンからの設定引き継ぎ](#既存のマシンからの設定引き継ぎ)のセクションも参考に

- Chrome, vscode の install
- homebrew の install
- `XDG Base Directory` の設定
- 最新の zsh の install と設定
  - zsh framework を install (zim framework)
    - Powerlevel10k (theme)は別途追加
- brew で各 tool を install
- git config の設定
- NeoVIM の設定
- go の設定
- node の設定
- rust の設定

## Install home brew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## XCode CLI の Install

- if needed

```sh
xcode-select --install
```

## Install tools by brew

```sh
brew install zsh
brew install wget
brew install exa
brew install tree
brew install jq
brew install fd      # https://github.com/sharkdp/fd file search: e.g. fd filename
brew install fzf
(brew --prefix)/opt/fzf/install
brew install bat     # https://github.com/sharkdp/bat like cat
brew install peco
brew install ripgrep
brew install neovim
brew install nmap
brew install iproute2mac
brew install tmux
brew install git
brew install git-lfs
brew install truncate
brew install readline
brew install httpie
brew install direnv
brew install go
brew install node
#brew install nvm # voltaのほうが良さそう
brew install protobuf
brew install bufbuild/buf/buf
brew install go-task/tap/go-task
brew install yarn
brew install figlet
```

## Golang settings

```sh
mkdir -p ~/go/pkg
mkdir -p ~/go/src
mkdir -p ~/go/bin

# install
go install golang.org/x/tools/cmd/goimports@latest
```

## Node settings

- [volta 設定](../nodejs/version-manager.md)

## Rust settings

- [install](https://rust-lang.github.io/rustup/installation/index.html)
- configure `.zprofile`

```sh
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CARGO_CONFIG="$XDG_CONFIG_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export PATH=$CARGO_HOME/bin:$PATH
#[ -f $CARGO_CONFIG/env ] && source $CARGO_CONFIG/env
```

```sh
mkdir ~/.config/cargo
mkdir ~/.local/share/cargo
mkdir ~/.local/share/rustup

brew install rustup-init
rustup-init

rustup completions zsh > ~/.config/zsh/zfunc/_rustup

#mv ~/.cargo/env ~/.config/cargo/
#mv ~/.cargo/bin ~/.local/share/cargo/ # $CARGO_HOME/
#mv ~/.rustup/* ~/.local/share/rustup/
```

- configure `.zshrc`

```sh
fpath+=~/.config/zsh/zfunc
```

- check

```sh
rustup --version
cargo --version
rustc --version
```

## NeoVIM settings

```sh
brew install neovim
mkdir -p ~/.config/nvim/plugged
touch ~/.config/nvim/init.vim
```

- `.config/zsh/.alias.zsh`

```sh
alias vim='nvim'
```

- `.config/nvim/init.vim`

```sh
set number             "行番号を表示
set autoindent         "改行時に自動でインデントする
set tabstop=2          "タブを何文字の空白に変換するか
set shiftwidth=2       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set splitright         "画面を縦分割する際に右に開く
set clipboard=unnamed  "yank した文字列をクリップボードにコピー
set hls                "検索した文字をハイライトする
```

## fzf

- [Ctrl-r] -> 履歴
- [Ctrl-t] -> 現在のディレクトリ検索

```bash
brew install fzf
/opt/homebrew/opt/fzf/install
mv .fzf.zsh .config/zsh/
```

- `.zprofile`

```sh
# fzf
[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh
```

## fig [WIP]

- https://fig.io/

## 既存のマシンからの設定引き継ぎ

- home ディレクトリのファイルを既存マシンからコピー
  - `.gitconfig`
  - `.gitignore_global`
  - `.zshrc` (参考にするだけ) => zim があれば、今までの設定はいらないかも。
  - `.zprofile` => 必要な環境変数だけコピー
  - `.alias.zsh` => 一度見直し、必要なものだけ利用

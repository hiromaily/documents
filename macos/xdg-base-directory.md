# XDG Base Directory

## XDG Base Directory Specification

- [ホームディレクトリのドットファイルを整理する](https://chiyosuke.blogspot.com/2019/04/blog-post_27.html)
  - /etc/zshenv

```sh
ZDOTDIR=$HOME/.config/zsh
```

- ~/.config/zsh/.zshenv

```sh
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
export HISTFILE="$XDG_DATA_HOME"/zsh/history
```

## XDG Base Directory Specification の引き継ぎ

- install 済みの Application の設定を変更する

### git config

- <https://git-scm.com/docs/git-config#Documentation/git-config.txt---global>

  - `~/.gitconfig`は`$XDG_CONFIG_HOME/git/config`に置き換えられる

- <https://git-scm.com/docs/gitignore#_description>
  - `~/.gitignore_global`は`$XDG_CONFIG_HOME/git/ignore`に置き換えられる

### `~/.volta`

```.zprofile
export VOLTA_HOME="$HOME/.config/volta"
export PATH="$PATH:$VOLTA_HOME/bin"
```

### `~/.yarnrc`

- <https://wiki.archlinux.jp/index.php/XDG_Base_Directory>

- `.zshrc`

```sh
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn"'
```

- これはうまくいかなかった。
  - <https://github.com/yarnpkg/yarn/issues/2334>

### Docker

- <https://docs.docker.com/engine/reference/commandline/cli/>
- `.zprofile`

```sh
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
```

### `~/.lesshst`

- `.zprofile`

```sh
export LESSHISTFILE="$XDG_STATE_HOME"/less/history
```

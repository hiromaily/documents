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

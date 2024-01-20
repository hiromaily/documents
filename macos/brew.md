# brew

- [official](https://brew.sh/ja/)

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Apple Silicon MacOS の場合 (??)

```sh
zsh: command not found: brew
```

```sh
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/your-name/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
```

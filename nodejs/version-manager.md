# Version Manager

## [volta](https://github.com/volta-cli/volta)

```sh
curl https://get.volta.sh | bash
volta install node
volta install npm

# これはuserのdefaultをセットする意味もある
volta install node@16
volta install node@18

# installした一覧を表示する
volta list all

# nodeのpathが通ってない場合
volta setup

# project内でnodeや、npmのバージョンを固定する場合
volta pin node@18
volta pin npm@10

node -v
npm -v
```

### volta command

```sh
❯ volta --help
Volta 1.1.1
The JavaScript Launcher ⚡

    To install a tool in your toolchain, use `volta install`.
    To pin your project's runtime or package manager, use `volta pin`.

USAGE:
    volta [FLAGS] [SUBCOMMAND]

FLAGS:
        --verbose
            Enables verbose diagnostics

        --quiet
            Prevents unnecessary output

    -v, --version
            Prints the current version of Volta

    -h, --help
            Prints help information


SUBCOMMANDS:
    fetch          Fetches a tool to the local machine
    install        Installs a tool in your toolchain
    uninstall      Uninstalls a tool from your toolchain
    pin            Pins your project's runtime or package manager
    list           Displays the current toolchain
    completions    Generates Volta completions
    which          Locates the actual binary that will be called by Volta
    setup          Enables Volta for the current user / shell
    run            Run a command with custom Node, npm, pnpm, and/or Yarn versions
    help           Prints this message or the help of the given subcommand(s)
```

## [nvm](https://github.com/nvm-sh/nvm)

```sh
brew install nvm
```

## [nodebrew](https://github.com/hokaccha/nodebrew)

```sh
brew install nodebrew
```

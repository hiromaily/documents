# Git Submodules

- [Git Tools - Submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules)

## submodule の追加

```sh
# private repository with ssh
git submodule add git@github.com:hiromaily/documents.git docs

## public
git submodule add https://github.com/hiromaily/documents.git docs
```

- これにより、repository の root に、`.gitmodules`と、submodule で指定した repository のディレクトリができる
- `.gitmodules`は mapping するための configuration ファイルとなる
- ここで追加されたファイルやディレクトリは自動的に`git add`された状態となる

## submodule を含む repository を clone する

```sh
git clone https://github.com/hiromaily/documents.git --recursive
```

## submodule のファイルを跡から取得する

```sh
git submodule update --init
```

## submodule の status を確認

```sh
git submodule foreach git fetch # サブモジュールの最新情報を取得
git submodule status
```

## submodule の revision 変更 (submodules の更新)

1. submodule のディレクトリに入り、対象のブランチやコミットを checkout する
2. submodule ディレクトリから抜け出し、その submodule のディレクトリを`git add`する

## submodule の注意点

- 親 repository と内部で参照している submodule は連動していないため、親 repository でブランチや revision を変えても同期されない
- この問題を fix するために以下コマンドが必要となる

```sh
git submodule update
```

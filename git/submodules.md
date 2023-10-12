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

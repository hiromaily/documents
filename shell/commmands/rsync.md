# rsync

- リモート環境とファイルやディレクトリを「同期（sync）する」
- ローカル環境のみでも使用できる
- `変更があった分だけ更新する` という機能がある

## Command

```sh
rsync [オプション] 同期元(コピー元) 同期先(コピー先)
```

## 用途

- ディレクトリ単位のバックアップなど
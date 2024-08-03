# User Permission

- [Docker コンテナの実行ユーザーと権限の関係](https://qiita.com/yitakura731/items/36a2ba117ccbc8792aa7)

## 予備知識

- `adduser`コマンド ... 新しいユーザーを追加
- `addgroup`コマンド ... 新しいグループを追加

## Dockerfile

- [USER](https://docs.docker.jp/engine/reference/builder.html#user)
  - `USER <ユーザ>[:<グループ>]`
  - ユーザに対して所属グループの指定が無ければ、イメージ（または以降の命令）の実行時に root グループとして実行される

## [Rootless モード](https://docs.docker.jp/engine/security/rootless.html)

- Docker デーモンとコンテナを root 以外のユーザが実行できるようにするもの
- デーモンやコンテナ・ランタイムにおける潜在的な脆弱性を回避する
- 補足
  - Docker では，通常管理者権限（root）を通じて操作するため、Root 以外のユーザーは Docker を使用できない
  - 非推奨だが、簡単に一般ユーザーでも Docker を利用できる方法として、利用するユーザーを`docker`というグループに追加する
- まず、Rootless Docker を別途 install せねばならない
  - [Run the Docker daemon as a non-root user (Rootless mode)](https://docs.docker.com/engine/security/rootless/)
  - [Rootless Docker を安全に一般ユーザで実行する](https://e-penguiner.com/rootless-docker-for-nonroot/)

## Github Action で Permission に問題がある場合

```yaml
run: sudo chown -R runner:docker your/target-dir
 or
run: sudo chown -R your/target-dir
```

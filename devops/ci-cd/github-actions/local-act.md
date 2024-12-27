# Act

[github: act](https://github.com/nektos/act)は、GitHub Actionsをローカルで実行できるCLIツール

## Install

```sh
# MacOS
brew install act
```

## [使い方ガイド](https://nektosact.com/usage/index.html)

actを実行するのは、projectのroot

```sh
act

# 特定のジョブを実行する
act -j job-id

# 特定のワークフローファイル内にあるワークフローを実行する場合
act -W .github/workflows/deploy.yml

# イベントの種類を指定する
act push
```

## References

- [ローカルで GitHub Actions が実行できる act のお作法を整理する](https://zenn.dev/simpleform_blog/articles/2b030b5f9e842c)

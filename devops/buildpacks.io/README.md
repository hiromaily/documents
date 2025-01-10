# Buildpacks.io / Cloud Native Buildpacks（CNBs）

- [Official](https://buildpacks.io/)
- [github: Cloud Native Buildpacks](https://github.com/buildpacks)

Cloud Native Buildpacks（CNBs）とは、ソースコードを直接コンテナイメージに変換するためのツール。
これらの特徴により、開発者がDockerfileを学習したり、Dockerfileを書いたりする必要がなくなり、コンテナイメージのビルドプロセスが簡素化される。

## 特徴

1. **Dockerfileの不要化**: CNBsはアプリケーションの構成を自動的に検知し、それに適したビルドプロセスを選択してコンテナイメージをビルドする。つまり、Dockerfileを書く必要がなくなり、ビルドのベストプラクティスを学習する手間も減る。

2. **ビルドプロセスの自動化**: CNBsはビルドパック（Buildpack）というモジュールを使用してソースコードを解析し、適切なビルドプロセスを実行する。ビルドパックは複数の言語やフレームワークに対応し、自動的にビルドプロセスを選択する。

3. **複数のクラウドでの実行可能**: CNBsで生成されるイメージはOCI（Open Container Initiative）イメージ形式を採用しており、複数のクラウドプラットフォームで実行できる。

4. **主な構成要素**: CNBsの主な構成要素には、ビルドパック（Buildpack）、スタック（Stack）、ビルダー（Builder）の3つがある。ビルドパックはソースコードの種類を検出してビルドを実行し、スタックはビルド用と実行用のイメージを提供し、ビルダーはビルドパック、Lifecycle、スタックを含むイメージ。

5. **Cloud Native Computing Foundationのサポート**: CNBsはCloud Native Computing Foundation（CNCF）が支援するプロジェクトであり、PivotalとHerokuが共同で発足させた。

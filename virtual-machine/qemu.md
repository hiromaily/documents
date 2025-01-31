# QEMU

QEMU (Quick Emulator) は、オープンソースのホスト用プラットフォーム仮想化ソフトウェア。QEMUを使用すると、異なるアーキテクチャ間でソフトウェアを実行することができ、仮想マシンの作成やエミュレーションを行うために広く利用されている。
例えば、QEMUを使用すると、x86アーキテクチャのマシン上でARMアーキテクチャのバイナリやOSを実行することが可能になる。これにより、異なるハードウェアアーキテクチャ向けのソフトウェアをクロスコンパイルしてテストするなどの作業が容易になる。

## GitHub Actions での QEMU の利用

GitHub ActionsでDocker上に異なるアーキテクチャのコンテナをビルドする場合、QEMUを使用してクロスコンパイルやエミュレーションを行う。これにより、GitHub Actionsで例えば`arm64`アーキテクチャ用のバイナリをx86アーキテクチャのビルドマシン上でビルドできるようになる。

## QEMUの設定手順

1. **GitHub ActionsのワークフローにQEMUをセットアップする**： [`docker/setup-qemu-action`](https://github.com/docker/setup-qemu-action) を使用してQEMUをセットアップする。

2. **Docker Buildxをセットアップする**： `docker/setup-buildx-action` を使用してBuildxをセットアップし、異なるアーキテクチャ向けのビルドを可能にする。

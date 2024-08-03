# Docker イメージの Architecture

- Docker イメージも、イメージを実行するハードウェアと同じアーキテクチャのハードウェアでビルドする必要がある

## CPU アーキテクチャの種類

### よく見かけるのは、

- x86
- x64
- x86_64
- amd64
- arm
- arm64 (IntelMac の場合、`uname -m`で確認できる)

### 命令セット

- `x86`, `x64` は CISC(Complex Instruction Set Computer) と呼ばれる命令セット
- `arm` は RISC(Reduced Instruction Set Computer) と呼ばれる命令セット

### ビット数

- `x86` は 32bit
- `x64` は 64bit

### 開発会社

- `x86`, `x64` は、インテル社、AMD 社が開発
- `arm` は Arm 社が開発
- `amd` は Advanced Micro Devices 社

### 確認方法

```sh
uname -m
```

### [Docker でサポートされているアーキテクチャー](https://github.com/docker-library/official-images?tab=readme-ov-file#architectures-other-than-amd64)

- Architectures officially supported by Docker, Inc. for running Docker
  - ARMv6 32-bit (arm32v6): https://hub.docker.com/u/arm32v6/
  - ARMv7 32-bit (arm32v7): https://hub.docker.com/u/arm32v7/
  - ARMv8 64-bit (arm64v8): https://hub.docker.com/u/arm64v8/
  - Linux x86-64 (amd64): https://hub.docker.com/u/amd64/
  - Windows x86-64 (windows-amd64): https://hub.docker.com/u/winamd64/

## Docker でアーキテクチャの指定方法

### Docker の image を build 時にアーキテクチャを指定する

```sh
docker build --platform linux/amd64 ...
```

### Dockerfile で CPU アーキテクチャを指定する場合

```
FROM --platform=linux/amd64 ubuntu:22.04
```

### docker-compose.yml で CPU アーキテクチャを指定する場合

```yml
services:
  web:
    image: ubuntu:22.04
    platform: linux/amd64
```

### Mac の M2 の場合

Apple Silicon Mac の`Docker Desktop`は CPU をエミュレーションできる[QEMU](https://www.qemu.org/)が含まれている。デフォルトでは`docker build`を実行する PC の CPU アーキテクチャでビルドされるが、コマンド指定や Dockerfile で CPU アーキテクチャを指定することで、ビルド時に指定の CPU アーキテクチャでビルドできる。

[Rancher Desktop](https://docs.rancherdesktop.io/ui/preferences/virtual-machine/emulation/)においても、[Preferences] -> [Virtual Machine] -> [Emulation] にて　`Virtual Machine Type`を `QEMU` (Default)か`VZ`を選ぶことができる

この Emulation の機能によって、Apple Silicon でも x86 (amd64)アーキテクチャのイメージを動作させることができている？
動かし方は、`--platform linux/amd64` を指定して x86 用イメージを明示的に取得して、実行する。

[Docker on Apple Silicon Mac: How to Run x86 Containers with Rosetta 2](https://levelup.gitconnected.com/docker-on-apple-silicon-mac-how-to-run-x86-containers-with-rosetta-2-4a679913a0d5)の記事によると、`Running x86 containers on Apple Silicon Macs just got easier thanks to newly added Docker’s Rosetta support`とあるが、`Apple Rosetta 2`もまた Emulator であり、QEMU を使う必要がない。QEMU emulation はいろいろ問題があるらしい。

## [Multi-platform images](https://docs.docker.com/build/building/multi-platform/)

- Docker イメージは複数のプラットフォームをサポートできる
- 1 つのイメージに異なるアーキテクチャ、場合によっては Windows などの異なるオペレーティング・システムが含まれる可能性がある
- マルチプラットフォーム対応のイメージを実行すると、Docker は自動的に OS とアーキテクチャに合ったイメージを選択する

### Image の構築方法

#### 通常

- ビルドを実行するとき、`--platform`フラグを設定して、ビルド出力のターゲット・プラット フォームを指定することができる
  - 例えば、`linux/amd64`、`linux/arm64`、`darwin/amd64` など
- デフォルトでは、一度に単一のプラットフォーム向けにしかビルドできない

#### 戦略

- 3 つの異なる戦略を用いて Multi-platform images を構築することができる
  - kernel の [QEMU](https://docs.docker.com/build/building/multi-platform/#qemu) emulation support を使う
  - 異なるアーキテクチャの複数のノードに支えられた単一のビルダー上に構築
  - Dockerfile の Stage を使って異なるアーキテクチャにクロスコンパイルする

## [docker buildx](https://docs.docker.com/engine/reference/commandline/buildx/)

`buildx` is a Docker CLI plugin for extended build capabilities with [BuildKit](https://github.com/moby/buildkit)

どうやらこれも`QEMU`と同様、multi-platform image の作成に必要のようだ

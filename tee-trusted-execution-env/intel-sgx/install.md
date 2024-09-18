# Install Intel SGX

## Intel SGX の初期設定 (ASUS UX430U x Ubuntu22.04)

- `F2`キーを押しながら電源を入れて、BIOS 画面を表示
- `F7`キーで`Advanced Mode`に切り替える
- 特に設定項目がない？

## Intel SGX for Linux

- [Github: Intel SGX for Linux OS](https://github.com/intel/linux-sgx)

- Intel SGX は、特定のコードやデータを開示や変更から保護しようとするアプリケーション開発者向けの Intel テクノロジー
- Linux SGX ソフトウェア スタックは、以下で構成される
  - SGX ドライバー
  - SGX SDK
  - SGX プラットフォーム ソフトウェア (PSW)
- SGX SDK および SGX PSW は、linux-sgx プロジェクトでホストされている

- SGXDataCenterAttestationPrimitives プロジェクト

  - Linux SGX ソフトウェア スタック用の out-of-tree ドライバーを維持する
  - これは、ドライバーのアップストリーム プロセスが完了するまで使用される
  - これは、 Flexible Launch Control と Intel AES New Instructions をサポートするプラットフォームで使用され、以下をサポートする
    - Elliptic Curve Digital Signature Algorithm (ECDSA) ベースの認証
    - Enhanced Privacy Identification (EPID) ベースの認証

- linux-sgx-driver プロジェクト

  - Linux SGX ソフトウェア スタック用の他の out-of-tree ドライバーをホストする
  - これは、ドライバーのアップストリーム プロセスが完了するまで使用される
  - これは、 Flexible Launch Control のないプラットフォーム
  - Enhanced Privacy Identification (EPID) ベースの構成証明をサポートするために使用される

- intel-device-plugins-for-kubernetes プロジェクト

  - ユーザーは Kubernetes クラスターで SGX エンクレーブを実行するコンテナー アプリケーションを実行できる
  - また、クラスターで ECDSA ベースの構成証明をセットアップする方法についても説明する

- intel-sgx-ssl プロジェクト
  - SGX エンクレーブ アプリケーション向けの完全な強度の汎用暗号化ライブラリを提供する
  - これは、基礎となる OpenSSL オープン ソース プロジェクトに基づいている
  - SGX は、次のように SGXSSL ベースの SDK を構築するためのビルドの組み合わせを提供する
  - ユーザーは、この暗号化ライブラリを SGX エンクレーブ アプリケーションで個別に利用することもできる

### Intel SGX SDK ~~および Intel SGX PSW パッケージ~~ のビルド

- Ubuntu 22.04 にて実行

1. 必要なツールをインストール

    ```sh
    sudo apt install build-essential ocaml ocamlbuild automake autoconf libtool wget python-is-python3 libssl-dev git cmake perl
    sudo apt install libssl-dev libcurl4-openssl-dev protobuf-compiler libprotobuf-dev debhelper cmake reprepro unzip pkgconf libboost-dev libboost-system-dev protobuf-c-compiler libprotobuf-c-dev lsb-release
    ```

2. ソースコードをダウンロード

    ```sh
    git clone https://github.com/intel/linux-sgx.git
    # ビルド済みのバイナリがダウンロードされる
    cd linux-sgx && make preparation
    ```

3. ツールのインストール

    ```sh
    sudo cp external/toolset/Ubuntu20.04/* /usr/local/bin
    which ar as ld objcopy objdump ranlib
    ```

4. SGX SDK のビルド（デフォルトで OK）

    ```sh
    # デフォルト
    make sdk

    # または

    # SGXSSL とオープンソースの文字列/数学を使用して SDK を構築
    make sdk USE_OPT_LIBS=0

    # または

    # デバッグ情報を出力
    make sdk DEBUG=1
    ```

5. 生成されたファイルを消去

    ```sh
    make clean
    ```

6. SGX SDK インストーラーをビルド

    ```sh
    make sdk_install_pkg
    ```

    - これにより、`linux/installer/bin/sgx_linux_x64_sdk_xxxxx.bin*` が作成される

7. デフォルト構成で、Intel SGX PSW をビルド

    ```sh
    make psw
    ```

    - 以下エラーが発生: [Error while executing "make psw"](https://github.com/intel/linux-sgx/issues/466)

        ```sh
        ❯ make psw
        make -C psw/ USE_OPT_LIBS=1
        make[1]: Entering directory '/home/hy/work/linux-sgx/psw'
        make -C uae_service/linux/
        make[2]: Entering directory '/home/hy/work/linux-sgx/psw/uae_service/linux'
        make -C ../../../psw/ae/aesm_service/source/core/ipc
        make[3]: Entering directory '/home/hy/work/linux-sgx/psw/ae/aesm_service/source/core/ipc'
        protoc  messages.proto --cpp_out=.
        make[3]: Leaving directory '/home/hy/work/linux-sgx/psw/ae/aesm_service/source/core/ipc'
        g++ -Wnon-virtual-dtor -std=c++14 -fstack-protector-strong -O2 -D_FORTIFY_SOURCE=2 -UDEBUG -DNDEBUG -ffunction-sections -fdata-sections -Wall -Wextra -Winit-self -Wpointer-arith -Wreturn-type -Waddress -Wsequence-point -Wformat-security -Wmissing-include-dirs -Wfloat-equal -Wundef -Wshadow -Wcast-align -Wconversion -Wredundant-decls -DITT_ARCH_IA64 -fcf-protection -fPIC -Werror -Wno-unused-parameter -g -DPROTOBUF_INLINE_NOT_IN_HEADERS=0 -Wno-deprecated-declarations -I. -I/home/hy/work/linux-sgx/common -I/home/hy/work/linux-sgx/common/inc -I/home/hy/work/linux-sgx/common/inc/internal  -I/home/hy/work/linux-sgx/psw/ae/common -I/home/hy/work/linux-sgx/psw/ae/inc -I/home/hy/work/linux-sgx/psw/ae/inc/internal -I/opt/intel/sgxsdk/include -I/home/hy/work/linux-sgx/external/epid-sdk -I../../../psw/ae/aesm_service/source/core/ipc -I../uae_wrapper/inc -I../../../psw/ae/aesm_service/source/core/ipc -I/home/hy/work/linux-sgx/psw/ae/aesm_service/source -I/home/hy/work/linux-sgx/psw/ae/aesm_service/source/common -c ../uae_wrapper/src/AEServicesImpl.cpp -o AEServicesImpl.o
        cc1plus: error: /opt/intel/sgxsdk/include: No such file or directory [-Werror=missing-include-dirs]
        cc1plus: all warnings being treated as errors
        make[2]: *** [Makefile:182: AEServicesImpl.o] Error 1
        make[2]: Leaving directory '/home/hy/work/linux-sgx/psw/uae_service/linux'
        make[1]: *** [Makefile:49: uae_service] Error 2
        make[1]: Leaving directory '/home/hy/work/linux-sgx/psw'
        make: *** [Makefile:62: psw] Error 2
        ```

    - [issue](https://github.com/intel/linux-sgx/issues/466) には、`You need to install the SDK before building PSW`とある

### Intel SGX SDK をインストールする

- Ubuntu 22.04 にて実行

1. 必要なツールをインストール

    ```sh
    sudo apt install build-essential python-is-python3
    ```

2. インストール

    ```sh
    cd linux/installer/bin

    # インストールパスを指定する必要がある
    export SDK_INSTALL_PATH_PREFIX=/opt/intel
    sudo ./sgx_linux_x64_sdk_${version}.bin --prefix $SDK_INSTALL_PATH_PREFIX

    # 環境変数の設定（.zprofile 等に設定しておく）
    source /opt/intel/sgxsdk/environment
    ```

### Intel SGX PSW パッケージのビルド

1. デフォルト構成で、Intel SGX PSW をビルド

    ```sh
    make psw
    ```

2. 生成されたファイルを消去

    ```sh
    make clean
    ```

3. Intel SGX PSW インストーラーをビルド

    ```sh
    make deb_psw_pkg
    ```

    - これにより、`./linux/installer/deb`ディレクトリ下に様々なファイルができる
        - `libsgx-enclave-common/`
        - `libsgx-epid/`
        - `libsgx-headers/`
        - `libsgx-launch/`
        - `libsgx-quote-ex/`
        - `libsgx-uae-service/`
        - `libsgx-urts/`
        - `local_repo_tool/`
        - `sgx-aesm-service/`

4. ローカル Debian パッケージリポジトリをビルド

    - 実行したがエラーが発生: [Can't make deb_local_repo](https://github.com/intel/linux-sgx/issues/587)

        ```sh
        make deb_local_repo
        # ./linux/installer/common/local_repo_builder/local_repo_builder.sh debian build
        # make: *** [Makefile:245: deb_local_repo] Error 249
        ```

    - [issue](https://github.com/intel/linux-sgx/issues/587) によると、`apt install reprepro` が必要？？  
      - これは `Debian package repository producer` とあるが、既にインストールされていた
      - 実際に実行されているのは、`./linux/installer/deb/local_repo_tool/debian_repo.sh` 内の `local_repo_build()`

        ```sh
        {
            local_repo_clean
            code_name=$(lsb_release -cs)
            deb_pkgs=$(find ${SOURCE_PKG_DIR} -type f \( -name "*.deb" -o -name "*.ddeb" \))
            if [[ ${deb_pkgs} != "" ]]
            then
                reprepro --confdir ${REPO_CONFIG_DIR} --outdir ${LOCAL_REPO_DIR} --dbdir ${LOCAL_REPO_DIR}/db --ignore=extension includedeb ${code_name} ${deb_pkgs} 2>/dev/null
            fi
        }
        ```

    - 一旦、ファイルに修正を加え、`2>/dev/null` を外し、再度実行してみる

        ```sh
        Cannot find definition of distribution 'jammy'!
        There have been errors!
        ```

    - Ubuntu 22.04 固有の問題
        - `./linux/installer/deb/local_repo_tool/conf/distributions` ファイルに以下を追加

            ```sh
            Origin: Intel Corporation
            Label: Intel Corporation
            Codename: jammy
            Architectures: amd64
            Components: main
            Description: ubuntu/jammy repository for SGX PSW
            DebIndices: Packages .
            ```

    - 再度実行

        ```sh
        make deb_local_repo

        # Local repository is successfully generated at /home/hy/work/linux-sgx/linux/installer/deb/local_repo_tool/../sgx_debian_local_repo.
        # Please follow the instructions in README to use this repository.
        ```

5. [WIP] ローカル Debian パッケージリポジトリをシステムリポジトリ構成に追加する

    - 追加後、`sudo apt update` でエラーが発生。`Release` ファイルは存在するが、`InRelease` ファイルは存在しない

        ```sh
        sudo vim /etc/apt/sources.list
        # e.g.
        # deb [trusted=yes arch=amd64] file:/PATH_TO_LOCAL_REPO focal main
        deb [trusted=yes arch=amd64] file:/home/hy/work/linux-sgx/linux/installer/deb/sgx_debian_local_repo jammy main
        sudo apt update
        # N: Download is performed unsandboxed as root as file '/home/hy/work/linux-sgx/linux/installer/deb/sgx_debian_local_repo/dists/jammy/InRelease' couldn't be accessed by user '_apt'. - pkgAcquire::Run (13: Permission denied)
        ```

    - WIP
        - `/opt/local` を使うべきだった？

        ```sh
        deb [trusted=yes arch=amd64] file:/opt/local/linux-sgx/linux/installer/deb/sgx_debian_local_repo focal main
        ```

    - 以下対応したが、うまくいかなかった。。。
        - `Release` ファイルは存在するので、これをコピーして `InRelease` を作成し、`chmod` で全権限を与えてみる
        - 以下コマンドの実行

            ```sh
            usermod -aG hy _apt
            # sudo chown -Rv _apt:root /home/hy/work/linux-sgx/linux/installer/deb/sgx_debian_local_repo/
            # sudo chmod -Rv 775 /home/hy/work/linux-sgx/linux/installer/deb/sgx_debian_local_repo/
            ```

### Intel SGX PSW のインストール

#### 今回使用した検証環境について

- 条件に `第 6 世代インテル(R) Core(TM) プロセッサー以降` とある
- 今回使用したマシンは`ASUS` の `UX430U`で、Processor は`i5-8250U`でこれは第 8 世代なので問題なさそう

#### Intel SGX PSW

- Intel SGX PSW は SGX SDK に対する、いわゆるランタイム

- SGX PSW は、起動、EPID ベースの構成証明、およびアルゴリズムに依存しない構成証明の 3 つのサービスを提供する
- SGX PSW は小さなパッケージに分割され、ユーザーはインストールする機能とサービスを選択できる
- 必要なパッケージをインストールするには、個別のパッケージを使用する方法と、ビルド システムによって生成されたローカル リポジトリを使用する方法の 2 つがある
- システムが依存関係を自動的に解決するため、ローカル リポジトリを使用することを勧められる

#### Install

1. 必要となるライブラリをインストール

    ```sh
    sudo apt install libssl-dev libcurl4-openssl-dev libprotobuf-dev
    ```

2. ローカルリポジトリの使用（推奨）

3. ローンチサービス

    ```sh
    sudo apt install libsgx-launch libsgx-urts
    ```

    または

    ```sh
    cd ./linux/installer/deb/libsgx-launch/
    sudo apt install libsgx-launch_2.17.101.1-jammy1_amd64.deb

    cd ./linux/installer/deb/libsgx-enclave-common
    sudo apt install libsgx-enclave-common_2.17.101.1-jammy1_amd64.deb

    cd ./linux/installer/deb/libsgx-urts
    sudo apt install libsgx-urts_2.17.101.1-jammy1_amd64.deb
    ```

4. EPID ベースの認証サービス

    ```sh
    sudo apt install libsgx-epid libsgx-urts
    ```

    または

    ```sh
    cd ./linux/installer/deb/libsgx-epid
    sudo apt install libsgx-epid_2.17.101.1-jammy1_amd64.deb
    ```

5. アルゴリズムに依存しない認証サービス

    ```sh
    sudo apt install libsgx-quote-ex libsgx-urts
    ```

    または

    ```sh
    cd ./linux/installer/deb/libsgx-quote-ex
    sudo apt install libsgx-quote-ex_2.17.101.1-jammy1_amd64.deb
    ```

6. DCAP ECDSA ベースのサービス

    ```sh
    sudo apt install libsgx-dcap-ql
    ```

    または

    ```sh
    cd ./linux/installer/deb/sgx-aesm-service
    ```

    - WIP

        ```sh
        ibsgx-ae-qe3
        libsgx-ae-id-enclave

        libsgx-qe3-logic_1.14.100.3-jammy1_amd64.deb
        libsgx-pce-logic
        libsgx-dcap-quote-verify

        libsgx-dcap-ql_1.14.100.3-jammy1_amd64.deb
        ```

### コード サンプルを使用して Intel SGX SDK パッケージをテストする

- シミュレーション モードで実行する

```sh
cd /opt/intel/sgxsdk/SampleCode/LocalAttestation
sudo make SGX_MODE=SIM
cd bin
./app
# Succeed to load enclaves
# Succeed to establish secure channel
# Succeed to exchange secure message
# Succeed to close Session
```

### ハードウェア モードでのコード サンプルのコンパイルと実行

- Intel SGX ハードウェア対応マシンを使用している場合は、コード サンプルをハードウェア モードで実行できる
- 以下、`./app`実行後、エラーが発生: [Requires libsgx_urts.so to run in SGX hardware mode](https://github.com/hyperledger-labs/minbft/issues/93)

```sh
cd /opt/intel/sgxsdk/SampleCode/LocalAttestation
sudo make
cd bin
./app
# ./app: error while loading shared libraries: libsgx_urts.so: cannot open shared object file: No such file or directory
```

- [issue](https://github.com/hyperledger-labs/minbft/issues/93)には、`we need to install a driver and a platform software (PSW) in addition to the SDK to run the command in the hardware mode` とある

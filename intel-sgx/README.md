# Intel SGX
- [Intel SGX for Linux OS](https://www.intel.com/content/www/us/en/developer/tools/software-guard-extensions/linux-overview.html)
- [Github: Intel SGX for Linux OS](https://github.com/intel/linux-sgx)

- [Intel SGX入門 - SGX基礎知識編](https://qiita.com/Cliffford/items/2f155f40a1c3eec288cf)
- [Intel SGX入門 - SGXプログラミング編](https://qiita.com/Cliffford/items/c6c0c696d4cc6d60d515)
- [Intel SGX - Remote Attestation概説](https://qiita.com/Cliffford/items/095b1df450583b4803f2)
- [Intel SGX - Provisioning解説](https://qiita.com/Cliffford/items/19145f6fa0340013f94f)
- [Intel SGX](https://hazm.at/mox/security/tee/intel-sgx/index.html)
  - 概要、Intel SGX 開発環境の構築、Intel SGX 開発など

## Intel SGXの初期設定 (ASUS UX430U x Ubuntu22.04)
- `F2`キーを押しながら電源を入れて、BIOS画面を表示
- `F7`キーで`Advanced Mode`に切り替える
- 特に設定項目がない？

## Intel SGX for Linux
- [Github: Intel SGX for Linux OS](https://github.com/intel/linux-sgx)

- Intel SGXは、特定のコードやデータを開示や変更から保護しようとするアプリケーション開発者向けの Intel テクノロジー
- Linux SGX ソフトウェア スタックは、以下で構成される
  - SGX ドライバー
  - SGX SDK
  - SGX プラットフォーム ソフトウェア (PSW)
- SGX SDK および SGX PSW は、linux-sgxプロジェクトでホストされている

- SGXDataCenterAttestationPrimitivesプロジェクト
  - Linux SGX ソフトウェア スタック用のout-of-tree ドライバーを維持する
  - これは、ドライバーのアップストリーム プロセスが完了するまで使用される
  - これは、 Flexible Launch ControlとIntel AES New Instructionsをサポートするプラットフォームで使用され、以下をサポートする
    - Elliptic Curve Digital Signature Algorithm (ECDSA) ベースの認証
    - Enhanced Privacy Identification (EPID) ベースの認証

- linux-sgx-driverプロジェクト
  - Linux SGX ソフトウェア スタック用の他のout-of-treeドライバーをホストする
  - これは、ドライバーのアップストリーム プロセスが完了するまで使用される
  - これは、 Flexible Launch Controlのないプラットフォーム
  - Enhanced Privacy Identification (EPID) ベースの構成証明をサポートするために使用される

- intel-device-plugins-for-kubernetesプロジェクト
  - ユーザーはKubernetes クラスターで SGX エンクレーブを実行するコンテナー アプリケーションを実行できる
  - また、クラスターで ECDSA ベースの構成証明をセットアップする方法についても説明する

- intel-sgx-sslプロジェクト
  - SGX エンクレーブ アプリケーション向けの完全な強度の汎用暗号化ライブラリを提供する
  - これは、基礎となる OpenSSL オープン ソース プロジェクトに基づいている
  - SGX は、次のように SGXSSL ベースの SDK を構築するためのビルドの組み合わせを提供する
  - ユーザーは、この暗号化ライブラリを SGX エンクレーブ アプリケーションで個別に利用することもできる

### Intel SGX SDK ~~および Intel SGX PSW パッケージ~~ のビルド
- Ubuntu22.04 にて実行

1. 必要なツールをinstall
```
sudo apt install build-essential ocaml ocamlbuild automake autoconf libtool wget python-is-python3 libssl-dev git cmake perl
sudo apt install libssl-dev libcurl4-openssl-dev protobuf-compiler libprotobuf-dev debhelper cmake reprepro unzip pkgconf libboost-dev libboost-system-dev protobuf-c-compiler libprotobuf-c-dev lsb-release
```

2. ソースコードをdownload
```
git clone https://github.com/intel/linux-sgx.git
# build済のバイナリがdownloadされる
cd linux-sgx && make preparation
```
3. toolのinstall
```
sudo cp external/toolset/Ubuntu20.04/* /usr/local/bin
which ar as ld objcopy objdump ranlib
```

4. SGX SDKのbuild (DefaultでOK)
```
# Default
make sdk

 or

# SGXSSL とオープン ソースの文字列/数学を使用して SDK を構築
make sdk USE_OPT_LIBS=0

 or
# DEBUG情報を出力
make sdk DEBUG=1
```

5. 生成されたファイルを消去する (このタイミングで必要か？)
```
make clean
```

6. SGX SDK Installerをbuild
```
make sdk_install_pkg
```
- これにより、`linux/installer/bin/sgx_linux_x64_sdk_xxxxx.bin*` が作成される

7.  デフォルト構成で、Intel SGX PSW をbuild
```
make psw
```
- 以下エラーが発生: [Error while executing "make psw"](https://github.com/intel/linux-sgx/issues/466)
```
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
- [issue]((https://github.com/intel/linux-sgx/issues/466))には、`You need to install the SDK before building PSW`とある


### Intel SGX SDK をInstallする
- Ubuntu22.04 にて実行

1. 必要なtoolをinstall
```
sudo apt install build-essential python-is-python3
```

2. Install
```
cd linux/installer/bin

# インストール パスを指定する必要がある
export SDK_INSTALL_PATH_PREFIX=/opt/intel
sudo ./sgx_linux_x64_sdk_${version}.bin --prefix $SDK_INSTALL_PATH_PREFIX

# 環境変数の設定(.zprofile等に設定しておく)
source /opt/intel/sgxsdk/environment
```

### Intel SGX PSW パッケージのビルド
1.  デフォルト構成で、Intel SGX PSW をbuild
```
make psw
```

2. 生成されたファイルを消去する (このタイミングで必要か？)
```
make clean
```

3. Intel SGX PSW インストーラーをbuild
```
make deb_psw_pkg
```
- これにより、`./linux/installer/deb`ディレクトリ下に様々なファイルができる
  - libsgx-enclave-common/
  - libsgx-epid/
  - libsgx-headers/
  - libsgx-launch/
  - libsgx-quote-ex/
  - libsgx-uae-service/
  - libsgx-urts/
  - local_repo_tool/
  - sgx-aesm-service/

### Intel SGX PSW のインストール
- 条件に `第 6 世代インテル(R) Core(TM) プロセッサー以降` とある
- 今回使用したマシンは`ASUS` の `UX430U`で、Processorは`i5-8250U`でこれは第8世代なので問題なさそう

- Intel SGX PSW は SGX SDK に対する、いわゆるランタイム

- SGX PSW は、起動、EPID ベースの構成証明、およびアルゴリズムに依存しない構成証明の 3 つのサービスを提供する
- SGX PSW は小さなパッケージに分割され、ユーザーはインストールする機能とサービスを選択できる
- 必要なパッケージをインストールするには、個別のパッケージを使用する方法と、ビルド システムによって生成されたローカル リポジトリを使用する方法の 2 つがある
- システムが依存関係を自動的に解決するため、ローカル リポジトリを使用することを勧められる

1. 必要となるライブラリをinstall
```
sudo apt install libssl-dev libcurl4-openssl-dev libprotobuf-dev
```

2. ローカル リポジトリの使用（推奨）

  1. ローンチサービス
```
sudo apt install libsgx-launch libsgx-urts
```

  2. EPID ベースの認証サービス
```
sudo apt install libsgx-epid libsgx-urts
```

  3. アルゴリズムに依存しない認証サービス
```
sudo apt install libsgx-quote-ex libsgx-urts
```

  4. DCAP ECDSA ベースのサービス
```
sudo apt install libsgx-dcap-ql
```


### コード サンプルを使用してIntel SGX SDK パッケージをテストする
- シミュレーション モードで実行する
```
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
```
cd /opt/intel/sgxsdk/SampleCode/LocalAttestation
sudo make
cd bin
./app
# ./app: error while loading shared libraries: libsgx_urts.so: cannot open shared object file: No such file or directory
```
- [issue](https://github.com/hyperledger-labs/minbft/issues/93)には、`we need to install a driver and a platform software (PSW) in addition to the SDK to run the command in the hardware mode` とある


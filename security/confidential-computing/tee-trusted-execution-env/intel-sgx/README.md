# Intel SGX

データを外部攻撃者だけでなく OS や VMM からすら秘匿してプログラムを実行するテクノロジーで、データを保護できるだけでなく、補助記憶装置への暗号化してのストアや遠隔認証も可能

## MEE (Memory Encryption Engine)

Intel 製 CPU 内の Uncore 部分に組み込まれているユニットで、Enclave を実現する。組み合わせる技術は以下の通りで、AES 暗号ベースであるため実行速度が極めて高速

- Tweaked 128bit AES/CTR
- マークル木の複雑な組み合わせ
- Carter-Wegman 式メッセージ認証符号

## Enclave

MEE (Memory Encryption Engine) によって RAM 上に生成される AES 暗号ベースの保護領域
実際にデータを格納する EPC (Enclave Page Cache)とその他 13 の構造体によって構成される

Enclave の操作やアクセス等には必ず Intel CPU による専用の CPU 命令を介さねばならない

- スーバーバイザ用命令: Enclave の生成、EPC のページ操作など
- ユーザー用命令: Enclave への侵入・脱出など
  これらを介さない不正なアクセスの試みを検知すると、MEE は即座にマシンの電源を落とす

## Intel SGX が対策できる脅威モデル

- 別プロセスによる攻撃
- OS や VMM による攻撃
- オフチップハードウェアへの攻撃に対応
- サイドチャネル攻撃への対策が別途必要

## シーリングとアンシーリング

- シーリング: Envlave 内のデータを以下の 2 つの内いずれかから導かれる鍵を用いた 128bit AES/GCM で暗号化し、不揮発性メモリに書き出す処理
  - MRENCRACE: Envlave 自体に固有なハッシュ値
  - MRSIGNER: Envlave 署名者に固有なハッシュ値
- アンシーリング: シーリングしたデータを Envlave にロードし複合

## AE: Architectual Enclave

- SGX が内部で使用するシステム用 Enclave
  - PvE: SGX 初使用時にマシンをアクティベイトし、EPID メンバ秘密鍵をシーリングしてストア (PvE は初回以降起動しない)
  - QE: PvE のストアした鍵に唯一アクセス権を持つ Enclave
- ユーザーがこれらに直接アクセスする方法はない

## Remote Attestation

クラウドモデルの SGX アプリケーションなど、遠隔の SGX マシン上の Enclave を使用したい場合、Enclave 自体の正当性に加え、遠隔マシン自体の CPU の正当性も検証する

- SGX マシンと非 SGX マシンとの間で、RA 後の TLS 通信用のセッション鍵を交換する
- 非 SGX マシンで、SGX マシンの CPU と Enclave の完全性を検証する

- RA は基本的に楕円曲線ディフィー・ヘルマン鍵共有プロトコル(EC-DHKE)に基づいている
- EC-DHKE に加え、RA は SGX マシンの Enclave と CPU の検証を実行する

### IntelSGX DCAP (SGX Data Center Attestation Primitives)

- データセンタやクラウド事業者(3rd-party)が自前で Attestation Server を運用するための拡張機能
- PCK(Provisioning Certification Key)と証明書が、3rd-party に配布され、中間 CA(Certificate Authority: 認証局)的な役割を持つ
- Intel に依存しない Remote Attestation

- IAS (IntelSGX Attestation Service): Intel が提供している RA。
- MAAS:

## Reference

- [Intel SGX for Linux OS](https://www.intel.com/content/www/us/en/developer/tools/software-guard-extensions/linux-overview.html)
- [Github: Intel SGX for Linux OS](https://github.com/intel/linux-sgx)
- [Intel SGX 入門 - SGX 基礎知識編](https://qiita.com/Cliffford/items/2f155f40a1c3eec288cf)
- [Intel SGX 入門 - SGX プログラミング編](https://qiita.com/Cliffford/items/c6c0c696d4cc6d60d515)
- [Intel SGX - Remote Attestation 概説](https://qiita.com/Cliffford/items/095b1df450583b4803f2)
- [Intel SGX - Provisioning 解説](https://qiita.com/Cliffford/items/19145f6fa0340013f94f)
- [Intel SGX](https://hazm.at/mox/security/tee/intel-sgx/index.html)
  - 概要、Intel SGX 開発環境の構築、Intel SGX 開発など

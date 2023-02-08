# LCP

LCP(Light Client Proxy)は、検証対象の Chain(以下、Upstream)に対して、検証側 Chain(Downstream)の代わりに Light Client 検証を行い、Downstream chain 側はその妥当性を低コストで検証可能にする Proof を生成するミドルウェア。
これは TEE を用いて Enclave 内で Light Client 検証を実行し、低コストで対象 Chain の妥当性の確認を可能にする新たな Proxy 方式となる。

## References

- [Docs](https://docs.lcp.network/ja/)
- [Github](https://github.com/datachainlab/lcp)

## 関連技術

- TEE(Trusted Execution Environment)
  - 代表的な実装
    - Intel SGX
    - AMD SEV
  - Enclave
  - Remote Attestation
- [ELC (Enclave Light Client)](https://docs.lcp.network/ja/protocol/elc/)
- [ICS-02](https://github.com/cosmos/ibc/tree/main/spec/core/ics-002-client-semantics)

## LCP による問題点の解消

Cross-chain の通信のための検証方式として、互いの Chain の consensus を検証する`Light Client`方式があるが、`検証コストの高さ`と`実装コストの高さによる拡張性の低さ`が問題となる。この課題を解決するために、`ibc-proxy`があるが、このアーキテクチャは proxy chain を信頼したうえで運用せねばならない。
ただし、LCP においても TEE を信頼する必要がある。

## 概要

- TEE を用いて Enclave 内で Light Client 検証を実行する。
- これにより、対象 Chain に対する on-chain での Light Client 検証は不要となる。
- 代わりに Enclave 内で生成された検証結果の commitment に対する 1 つの署名の検証のみ行う。
- この結果、以下が実現される。
  - オンチェーンでの署名検証コストの削減
  - 検証トランザクションのサイズ削減 (e.g. target chain の validators info が不要)

## LCP 側の挙動

- SGX を用いて Enclave 内で Light Client 検証を行い、その結果を示す commitment と proof を生成する
- この proof は Enclave 内で生成された鍵による単一の署名
- そして、Downstream は直接 Upstream を検証する代わりに生成された commitment と proof を検証する
- このときの検証に用いる鍵は、Remote Attestation を通して Enclave 内の鍵を検証の前に Downstream 上に登録する必要がある

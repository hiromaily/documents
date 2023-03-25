# TEE (Trusted Execution Environment)

コンピュータリソースを信頼可能な領域と信頼できない領域に分け、信頼可能な領域で機密性の高いデータを扱う事で、データを保護しながらのプログラム実行を可能とする
つまり、`信頼可能な実行環境`ということ
`秘密にしたいデータを信頼可能な領域に配置し、その信頼可能領域内でそのデータを用いた処理を完結させる`事を実現するための、ハードウェア支援技術

## 領域

信頼可能な領域: 信頼可能なハードウェア及びそれによりメモリ上に生成された保護領域を指す
信頼できない領域: それ以外のすべて。OS や VMM すら非信頼領域として扱う

## 実例

信頼可能領域は`CPU内`で、CPU によって生成された RAM 上の保護領域及びその間の通信路が TEE となる

## TEE 技術

- [Intel SGX](./intel-sgx/README.md)
- [Arm TrustZone](https://www.arm.com/ja/technologies/trustzone-for-cortex-a)
- [AMD SEV (Secure Encrypted Virtualization)](https://www.amd.com/en/developer/sev.html)
- [Keystone Envlave](https://riscv.org/wp-content/uploads/2018/12/Keystone-Enclave-An-Open-Source-Secure-Enclave-for-RISC-V.pdf)

## References

[TEE とは？ by プライバシーテック研究所](https://acompany.tech/privacytechlab/trusted-execution-environment/)

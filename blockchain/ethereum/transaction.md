# Transaction の作成から送信まで

## [eth_sendTransaction](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sendtransaction)の実行に伴うフローについて

- Transaction の作成
  - その Account から有効な Nonce を設定する
  - Gas Estimation
- Transaction への署名
  - sender の private key を使って署名をし、この署名は sender によって transaction が作成されたことの暗号証明及び改竄されていないことの証明となる
- transaction を Ethereum Network に bloadcast する
- Transaction を受け取った Node は、その署名、Nonce 等を検証する
- 検証が問題なければ、Node は Transaction を Transaction pool に追加する
- Ethereum2.0 以前では、Miner が Mining を行うことになる。Ethereum2.0 では Validator が検証する。

### 署名について

- 署名をすることによってデジタル署名が作成される。これが証明に使われる

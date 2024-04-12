# CLIを使ったDemo時のRelayerの設定

## 1. fixtureの作成
### Tendermint
- tendermintのコンテナからkey_seed.jsonをlocalにコピー
- tendermint向けCLI用に、seed.json, app.toml, client.toml, config.toml, keyring-testをlocalにコピー
  - これはCLIの初期化処理でもいい

### Fabric

### EVMチェーン(Ethereum)


## 2. relayer初期化処理 (init-rly)
- あらかじめ`relayer-util`に変数を定義しておく
  - RELAYER_CONF ... configファイル
  - RLY_BINARY ... 実行ファイル
  - RLY ... 実行ファイルとoptionをまとめた実行コマンド
  - CHAINID_ONE ... ibc0
  - CHAINID_TWO ... ibc1
  - RLYKEY ... testkey
  - PATH_NAME ... ibc01
- `${RLY} config init` を実行
  - デフォルトのhomeディレクトリを作成し、defaultのconfig設定を書き込む
- `${RLY} chains add-dir configs/relayer/demo/` を実行
  - testnet用のconfigurationを追加する


### Fabric (追加処理)
- `${RLY} fabric wallet populate` を実行
- `${RLY} fabric chaincode init` を実行

### Tendermint (追加処理)
- `${RLY} tendermint keys restore ibc0 testkey "$SEED0"` を実行

## 3. WIP:Handshake

## 4. WIP:CLIの初期化

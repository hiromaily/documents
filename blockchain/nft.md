# NFT

NFT(Non-Fungible Token、非代替性トークン)とは、ブロックチェーンを基盤にして作成された代替不可能なデジタルデータのこと。
仮想通貨の取引などで、使われる`ERC20`ではなく、NFT マーケットでは`ERC721`が使われる。

## NFT 化されているものの例

画像でも動画でもあらゆるデジタルデータを NFT 化することができる

- デジタルアート
- トレーディングカード
- デジタルファッション
- ゲームアセット
- デジタルフォト
- デジタルミュージック
- 仮想空間の土地　など

## NFT マーケットプレイス

- `OpenSea` などの NFT マーケットプレイスで Mint を行うのが一般的
  - NFT マーケットプレイスに用意されている Mint のサービスを使う
  - Mint 専用のサイトやプラットフォームを使う
  - ブロックチェーンゲームの中で、ゲームアイテムなどの NFT を Mint する
- あらゆるデジタルデータを NFT 化できる
- スマートコントラクトを用いている

### 内部的な機能

- Mint
- Transfer

## ERC-721

非代替トークン

### ERC-721 の Interface

```solidity
interface ERC721 {

  event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
  event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
  function balanceOf(address _owner) external view returns (uint256);
  function ownerOf(uint256 _tokenId) external view returns (address);
  function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
  function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
  function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
  function approve(address _approved, uint256 _tokenId) external payable;
  function setApprovalForAll(address _operator, bool _approved) external;
  function getApproved(uint256 _tokenId) external view returns (address);
  function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}
```

- `balanceOf`: 引数に指定したアドレスが所有している NFT の数を取得することができます
- `ownerOf`: 引数に指定した NFT の tokenId の所有者のアドレスを取得することができます。
- `safeTransferFrom`: 第 1 引数に NFT の所有者のアドレス、第 2 引数に NFT の譲渡先のアドレス、第 3 引数に NFT の tokenId を渡すことで第２引数に指定したアドレスへ NFT の所有権を移動させることができます。
- `approve`: 引数に渡したアドレスに対して指定した NFT の tokenId の転送許可を与えることができます。
- `setApprovalForAll`: 引数で渡した owner のアドレスが持つすべての NFT の転送権限を operator に与えることができます。
- `getApproved`: 指定した tokenId に転送許可が与えられているアドレスを取得することができます。
- `isApprovedForAll`: owner が operator に転送許可を与えているかどうかを判定する。

NFT を発行する mint 関数は ERC721 のサブクラスである`ERC721Mintable`で定義されている。これは、所有者のアドレスと tokenId を渡すことで NFT と所有者を紐づける

```solidity
function _mint(address _to, uint256 _tokenId) returns (bool);
function _safeMint(address _to, uint256 _tokenId) returns (bool);
```

このままだと`IPFS`にあるメタデータの URI と tokenId がマッピングされていないので`ERC721URIStorage`というサブクラスを使用する

```solidity
function tokenURI(uint256 tokenId) public view virtual override returns (string memory)
function _setTokenURI(uint256 tokenId, string memory _tokenURI)
function _burn(uint256 tokenId)
```

### OpenSea

手順は以下の通り

1. Metamask といった Wallet を用意
2. Wallet と OpenSea を接続する
3. NFT 化したい画像や音声といったデータを用意
4. NFT の mint を行う

OpenSea で Mint を行う際は、発行手数料やネットワーク手数料（ガス代）が一切かからない

#### [OpenSea] Mint 時に設定できる情報

- デジタルデータ
- Name
- External link
- Description
- Collection (カテゴリ)
- Supply (Default: 1)
- Blockchain: Ethereum or Polygon

### NFT の Storage

[ipfs](https://docs.ipfs.tech/how-to/best-practices-for-nft-data/)が使われるはず

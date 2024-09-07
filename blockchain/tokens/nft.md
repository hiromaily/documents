# Non-Fungible Tokens (NFTs) 非代替性トークン

- 固有の方法で、人や物を識別するために使われ ry
- ブロックチェーン上で発行および取引される
- NFT と暗号資産の違いは、端的に言えばトークンが代替性か非代替性かどうかという点
- NFT の取引の大半はこのイーサリアムブロックチェーン上で取引されている

|      | 暗号資産                       | NFT                         |
| ---- | ------------------------------ | --------------------------- |
| 特徴 | 代替可能トークン               | 非代替性トークン            |
| 意味 | 同じトークンが存在する         | 同じトークンが存在しない    |
| 分割 | 可能                           | 不可能                      |
| ERC  | ERC20, ERC1155                 | ERC721, ERC1155             |
| 例   | 通貨やポイントなど数量的なもの | デジタルアートなど 1 点もの |

## 用途

- コピーが容易なデジタルデータに対し、ブロックチェーン技術を活用することで、唯一無二な資産的価値を付与する
- 偽造不可な鑑定書・所有証明書付きのデジタルデータ

## NFT の代表的な取引サービス

- [OpenSea](https://opensea.io/)

## [ERC-721: Non-Fungible Token Standard](https://eips.ethereum.org/EIPS/eip-721)

- NFT に対する標準規格
- NFT はそれぞれがユニークな存在であり、発行日、希少性、および外見などの点で、同一のスマートコントラクトで発行される他のトークンとは異なる値を持つことができる

### Method

```solidity
// 引数に指定したアドレスが所有しているNFTの数を取得する
function balanceOf(address _owner) external view returns (uint256);

// 引数に指定したNFTのtokenIdの所有者のアドレスを取得する
function ownerOf(uint256 _tokenId) external view returns (address);

// 第1引数にNFTの所有者のアドレス、第2引数にNFTの譲渡先のアドレス、第3引数にNFTのtokenIdを渡す
// これにより、第２引数に指定したアドレスへNFTの所有権を移動させる
function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
function transferFrom(address _from, address _to, uint256 _tokenId) external payable;

// 引数に渡したアドレスに対して指定したNFTのtokenIdの転送許可を与える
function approve(address _approved, uint256 _tokenId) external payable;

// 引数で渡したownerのアドレスが持つすべてのNFTの転送権限をoperatorに与える
function setApprovalForAll(address _operator, bool _approved) external;

// 指定したtokenIdに転送許可が与えられているアドレスを取得する
function getApproved(uint256 _tokenId) external view returns (address);

// ownerがoperatorに転送許可を与えているかどうかを判定する
function isApprovedForAll(address _owner, address _operator) external view returns (bool);
```

### Event

```solidity
event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
```

## NFT の発行について

- NFT を発行する関数は ERC721 のサブクラスである`ERC721Mintable`で定義されている

```solidity
function _mint(address _to, uint256 _tokenId) returns (bool);
function _safeMint(address _to, uint256 _tokenId) returns (bool);
```

- 具体的には、IPFS にあるメタデータの URI と tokenId をマッピングする
- これには、`ERC721URIStorage`というサブクラスを使用する

```solidity
function tokenURI(uint256 tokenId) public view virtual override returns (string memory)
function _setTokenURI(uint256 tokenId, string memory _tokenURI)
function _burn(uint256 tokenId)
```

- 実際の実行は、以下のようなコードになるはず

```solidity
function safeMint(address to, string memory uri, uint256 tokenId) public {
  _safeMint(to, tokenId);
  _setTokenURI(tokenId, uri);
}
```

## 　ユースケース

- NFT 作成 -> `safMint(to, uri, tokenId)`
- NFT 出品 -> `approve(_approved, tokenId)`
- NFT 購入 -> `safeTransferFrom(from, to, tokenId)`

## [OpenZeppelin: ERC721](https://docs.openzeppelin.com/contracts/4.x/erc721)

- [openzeppelin-contracts/contracts/token/ERC721/ERC721.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/8186c07a83c09046c6fbaa90a035ee47e4d7d785/contracts/token/ERC721/ERC721.sol)

```solidity
abstract contract ERC721 is Context, ERC165, IERC721, IERC721Metadata, IERC721Errors {
    using Strings for uint256;

    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    mapping(uint256 tokenId => address) private _owners;

    mapping(address owner => uint256) private _balances;

    mapping(uint256 tokenId => address) private _tokenApprovals;

    mapping(address owner => mapping(address operator => bool)) private _operatorApprovals;

    /**
     * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }
    ...
}
```

## References

- [ERC-721 非代替性トークン（NFT）規格](https://ethereum.org/ja/developers/docs/standards/tokens/erc-721/)
- [Etherscan: Top NFTs](https://etherscan.io/nft-top-contracts)
- [OpenZeppelin: ERC721](https://docs.openzeppelin.com/contracts/4.x/erc721)
- [NFT の規格 ERC721 を解説](https://tech-lab.sios.jp/archives/32656)

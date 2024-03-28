# ERC: Ethereum Request for Comments

- [Ethereum Request for Comments (ERCs)](https://github.com/ethereum/ERCs)
  - ERC は EIP から切り離された
- [Ethereum Improvement Proposals (EIPs)](https://github.com/ethereum/eips)
- [Ethereum Improvement Proposals / ERC](https://eips.ethereum.org/erc)

## [ERC20: Token Standard](https://eips.ethereum.org/EIPS/eip-20)

A standard interface for tokens.

The following standard allows for the implementation of a standard API for tokens within smart contracts. This standard provides basic functionality to transfer tokens, as well as allow tokens to be approved so they can be spent by another on-chain third party.

## [ERC721: Non-Fungible Token Standard](https://eips.ethereum.org/EIPS/eip-721)

A standard interface for non-fungible tokens, also known as deeds.

The following standard allows for the implementation of a standard API for NFTs within smart contracts. This standard provides basic functionality to track and transfer NFTs.

We considered use cases of NFTs being owned and transacted by individuals as well as consignment to third party brokers/wallets/auctioneers (“operators”). NFTs can represent ownership over digital or physical assets. We considered a diverse universe of assets, and we know you will dream up many more:

- Physical property — houses, unique artwork
- Virtual collectibles — unique pictures of kittens, collectible cards
- “Negative value” assets — loans, burdens and other responsibilities

In general, all houses are distinct and no two kittens are alike. NFTs are distinguishable and you must track the ownership of each one separately.

# Cross Chain

様々な interoperability solutions が存在するがそれに関連する用語をここで整理する

## Interoperability Protocols

Utilize interoperability protocols like `Cosmos IBC`, `Polkadot`, or `Interledger` to facilitate token transfers between different blockchains. These protocols provide frameworks for building cross-chain communication and asset transfer mechanisms.

### Cosmos (Inter-Blockchain Communication Protocol - IBC)

Cosmos provides a framework for building interconnected blockchains, allowing tokens and data to be transferred between different chains within the Cosmos ecosystem.

### Polkadot (Cross-Chain Message Passing - XCMP)

Polkadot's XCMP protocol enables communication between parachains (parallel blockchains) within the Polkadot network, allowing for cross-chain asset transfers and inter-chain messaging.

### Interledger Protocol (ILP)

ILP is an open protocol suite for sending payments across different ledgers and payment networks. It enables interoperability between various blockchain and non-blockchain-based payment systems.

## Bridge Protocols

These protocols facilitate the transfer of assets between different blockchain networks. Bridges act as connectors between two or more blockchains, allowing tokens to be locked on one chain and minted or issued on another. Examples include

### TokenBridge

TokenBridge is a bridge solution developed by the POA Network for transferring tokens between Ethereum-based networks and other blockchains like xDai Chain or Binance Smart Chain.

### Chainlink

Chainlink provides decentralized oracle networks that enable smart contracts to securely interact with external data sources and off-chain systems, facilitating cross-chain communication and interoperability.

## Atomic Swaps

As discussed earlier, atomic swaps allow for direct peer-to-peer trading of assets between different blockchain networks without the need for intermediaries. Atomic swaps rely on cryptographic techniques like Hashed Timelock Contracts (HTLCs) to ensure trustless and secure cross-chain transactions.

## Wrapped Tokens

Create wrapped versions of the token on different chains. For example, you can create wrapped USDC tokens on Ethereum and Polygon, which represent the same value as the original USDC but are compatible with the respective chains.

## Decentralized Exchanges (DEXs)

Integrate decentralized exchanges that support cross-chain trading. DEXs like `Uniswap`, `SushiSwap`, or `PancakeSwap` have started supporting multiple chains, allowing users to swap tokens across different networks seamlessly.

## Layer 2 Solutions

Implement layer 2 scaling solutions like `Optimistic Rollups` or `zkRollups`, which can facilitate faster and cheaper token transfers across multiple chains while maintaining compatibility with the Ethereum network.

## Bridge Tokens

Introduce intermediary bridge tokens that represent the value of the original token on a different chain. Users can swap these bridge tokens for the corresponding native tokens on the destination chain.

## Smart Contract Solutions

Develop custom smart contracts that facilitate token swaps between different chains. These smart contracts can use oracles to verify token transfers and ensure trustless execution of cross-chain swaps.

## Trusted Third Party

これは特定の Authority を信用する前提が必要となる

## Relayer

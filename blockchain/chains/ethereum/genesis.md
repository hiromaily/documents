# Genesis Configuration

- [Genesis file items by Hyperledger BESU](https://besu.hyperledger.org/en/stable/public-networks/reference/genesis-items/)
- [Chain Specification - Wiki](https://openethereum.github.io/Chain-specification)
- [Genesis JSON at Klaytn Docs]

## From Source Code in go-ethereum

- [go-ethereum: ChainConfig](https://github.com/ethereum/go-ethereum/blob/v1.10.26/params/config.go#L348-L388)

```
type ChainConfig struct {
 ChainID *big.Int `json:"chainId"` // chainId identifies the current chain and is used for replay protection

 HomesteadBlock *big.Int `json:"homesteadBlock,omitempty"` // Homestead switch block (nil = no fork, 0 = already homestead)

 DAOForkBlock   *big.Int `json:"daoForkBlock,omitempty"`   // TheDAO hard-fork switch block (nil = no fork)
 DAOForkSupport bool     `json:"daoForkSupport,omitempty"` // Whether the nodes supports or opposes the DAO hard-fork

 // EIP150 implements the Gas price changes (https://github.com/ethereum/EIPs/issues/150)
 EIP150Block *big.Int    `json:"eip150Block,omitempty"` // EIP150 HF block (nil = no fork)
 EIP150Hash  common.Hash `json:"eip150Hash,omitempty"`  // EIP150 HF hash (needed for header only clients as only gas pricing changed)

 EIP155Block *big.Int `json:"eip155Block,omitempty"` // EIP155 HF block
 EIP158Block *big.Int `json:"eip158Block,omitempty"` // EIP158 HF block

 ByzantiumBlock      *big.Int `json:"byzantiumBlock,omitempty"`      // Byzantium switch block (nil = no fork, 0 = already on byzantium)
 ConstantinopleBlock *big.Int `json:"constantinopleBlock,omitempty"` // Constantinople switch block (nil = no fork, 0 = already activated)
 PetersburgBlock     *big.Int `json:"petersburgBlock,omitempty"`     // Petersburg switch block (nil = same as Constantinople)
 IstanbulBlock       *big.Int `json:"istanbulBlock,omitempty"`       // Istanbul switch block (nil = no fork, 0 = already on istanbul)
 MuirGlacierBlock    *big.Int `json:"muirGlacierBlock,omitempty"`    // Eip-2384 (bomb delay) switch block (nil = no fork, 0 = already activated)
 BerlinBlock         *big.Int `json:"berlinBlock,omitempty"`         // Berlin switch block (nil = no fork, 0 = already on berlin)
 LondonBlock         *big.Int `json:"londonBlock,omitempty"`         // London switch block (nil = no fork, 0 = already on london)
 ArrowGlacierBlock   *big.Int `json:"arrowGlacierBlock,omitempty"`   // Eip-4345 (bomb delay) switch block (nil = no fork, 0 = already activated)
 GrayGlacierBlock    *big.Int `json:"grayGlacierBlock,omitempty"`    // Eip-5133 (bomb delay) switch block (nil = no fork, 0 = already activated)
 MergeNetsplitBlock  *big.Int `json:"mergeNetsplitBlock,omitempty"`  // Virtual fork after The Merge to use as a network splitter
 ShanghaiBlock       *big.Int `json:"shanghaiBlock,omitempty"`       // Shanghai switch block (nil = no fork, 0 = already on shanghai)
 CancunBlock         *big.Int `json:"cancunBlock,omitempty"`         // Cancun switch block (nil = no fork, 0 = already on cancun)

 // TerminalTotalDifficulty is the amount of total difficulty reached by
 // the network that triggers the consensus upgrade.
 TerminalTotalDifficulty *big.Int `json:"terminalTotalDifficulty,omitempty"`

 // TerminalTotalDifficultyPassed is a flag specifying that the network already
 // passed the terminal total difficulty. Its purpose is to disable legacy sync
 // even without having seen the TTD locally (safer long term).
 TerminalTotalDifficultyPassed bool `json:"terminalTotalDifficultyPassed,omitempty"`

 // Various consensus engines
 Ethash *EthashConfig `json:"ethash,omitempty"`
 Clique *CliqueConfig `json:"clique,omitempty"`
}

// EthashConfig is the consensus engine configs for proof-of-work based sealing.
type EthashConfig struct{}

// CliqueConfig is the consensus engine configs for proof-of-authority based sealing.
type CliqueConfig struct {
 Period uint64 `json:"period"` // Number of seconds between blocks to enforce
 Epoch  uint64 `json:"epoch"`  // Epoch length to reset votes and checkpoint
}

```

## Genesis Files Example

```json
{
  "config": {
    "chainId": 12345,
    "homesteadBlock": 0,
    "eip150Block": 0,
    "eip155Block": 0,
    "eip158Block": 0,
    "byzantiumBlock": 0,
    "constantinopleBlock": 0,
    "petersburgBlock": 0,
    "istanbulBlock": 0,
    "berlinBlock": 0,
    "londonBlock": 0,
    "clique": {
      "period": 5,
      "epoch": 30000
    }
  },
  "difficulty": "1",
  "gasLimit": "8000000",
  "extradata": "0x00000000000000000000000000000000000000000000000000000000000000007df9a875a174b3bc565e6424a0050ebc1b2d1d820000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "alloc": {
    "7df9a875a174b3bc565e6424a0050ebc1b2d1d82": { "balance": "300000" },
    "f41c74c9ae680c1aa78f42e5647a62f353b7bdde": { "balance": "400000" }
  }
}
```

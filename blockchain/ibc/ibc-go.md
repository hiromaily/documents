# ibc-go

IBC を Golang で実装したもの  
2022 Nov 時点で version は`5.0`
常に最新の`Cosmos SDK`を追従する形でバージョンアップが行われている様子

## References

- [Github](https://github.com/cosmos/ibc-go)
- [Roadmap](https://github.com/cosmos/ibc-go/blob/main/docs/roadmap/roadmap.md)

## ibc-go directory

- [docs](https://github.com/cosmos/ibc-go/tree/main/docs) ... documentations
- [e2e](https://github.com/cosmos/ibc-go/tree/main/e2e) ... e2e environment
- modules
  - apps
    - 27-interchain-accounts
    - 29-fee
    - transfer ... Token Transfer
  - core
    - 02-client ... [ICS-2 Client Semantics](https://github.com/cosmos/ibc/tree/main/spec/core/ics-002-client-semantics) 実装
    - 03-connection ... [ICS-3 Connection Semantics](https://github.com/cosmos/ibc/tree/main/spec/core/ics-003-connection-semantics) 実装
    - 04-channel ... [ICS-4 Channel & Packet Semantics](https://github.com/cosmos/ibc/tree/main/spec/core/ics-004-channel-and-packet-semantics) 実装
    - 05-port ... [ICS-5 Port Allocation](https://github.com/cosmos/ibc/tree/main/spec/core/ics-005-port-allocation) 実装
    - 23-commitment ... [ICS-23 Vector Commitments](https://github.com/cosmos/ibc/tree/main/spec/core/ics-023-vector-commitments) 実装
    - 24-host ... [ICS-24 Host State Machine Requirements](https://github.com/cosmos/ibc/tree/main/spec/core/ics-024-host-requirements) 実装
    - ante ... [ADR 010 Modular AnteHandler](https://docs.cosmos.network/main/architecture/adr-010-modular-antehandler)
    - client (cli)
    - exported
    - keeper
    - legacy
    - migrations
    - simulation
    - spec
      - [01_concepts.md](https://github.com/cosmos/ibc-go/blob/main/modules/core/spec/01_concepts.md)
    - types
    - genesis.go
  - light-client
    - 06-solomachine
    - 07-tendermint
- testing
  - [IBC Testing Package](https://github.com/cosmos/ibc-go/tree/main/testing)

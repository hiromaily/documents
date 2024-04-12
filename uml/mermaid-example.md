# Mermaid

Github の Markdown ファイルに「Mermaid」で図を挿入可能

- [Official](https://mermaid.js.org/#/)
- [Live Editor](https://mermaid.live/)
- [VS Code Marketplace for mermaid](https://marketplace.visualstudio.com/search?term=mermaid&target=VSCode&category=All%20categories&sortBy=Relevance)

## シーケンス図

```mermaid
sequenceDiagram
    participant F as Frontend
    participant B as Backend
    participant S as Source chain
    participant D as Destination chain

    F->>+S: Submit transaction (e.g. call swap() function)
    S->>S: execute function
    S-->>-F: Return transaction hash

    loop Polling
        F->>B: call Backend APIs
        B->>S: call JSON-RPC to get states, logs
        S-->>B: Responses
        B->>D: call JSON-RPC to get states, logs
        D-->>+B: Responses
        B->>B: format data
        B-->>-F: Responses
        Note over F,B: Response would include<br/>* cross-chain tx status<br/>* cross-chain tx estimated time<br/>* tx hash of dst chain
        alt status is completed or failed
            F-->F: stop polling
        end
    end
```

## TODO: 状態遷移図

- [状態遷移図とは?](https://jp.mathworks.com/discovery/state-diagram.html)

```plantuml
@startuml
[*] --> PENDING : start
PENDING --> PENDING : timeout occurred: isTimeout=true
PENDING : [tx is still in memPool]
PENDING : default timeout: isTimeout=false
PENDING : timeout occurred: isTimeout=true
DROPPED : [tx is gone]
DROPPED : tx is not monitored by worker anymore
PENDING --> DROPPED : transaction replaced
PENDING --> CONTAINED : contained
CONTAINED : [block contains tx, but not finalized]
CONTAINED --> PENDING : return to pending by reorg
CONTAINED --> SUCCESS : success
SUCCESS : [tx is finalized]
SUCCESS : this tx is not updated by worker
SUCCESS : tx is not monitored by worker anymore
CONTAINED --> FAILURE : failure
FAILURE : [tx is failed]
FAILURE : this tx is not updated by worker
FAILURE : tx is not monitored by worker anymore
@enduml
```

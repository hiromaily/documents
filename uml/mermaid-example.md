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

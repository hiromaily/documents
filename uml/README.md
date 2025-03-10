# UML (Unified Modeling Language)

統一モデリング言語 (UML) は、ソフトウェアエンジニア開発の世界において、ビジネスユーザーを始め、システムを理解しようとするあらゆるユーザーが理解できる視覚化のための共通言語を打ち立てることを目的のために作られたモデリング手法

## Tools

- [PlantUML](https://github.com/plantuml/plantuml)
- [Mermaid](https://mermaid.js.org/#/)
  - Github の Markdown ファイルに「Mermaid」で図を挿入可能

## PlantUML でサポートされている Diagram

- Sequence diagram
- Usecase diagram
- Class diagram
- Object diagram
- Activity diagram (Beta) (Find the legacy syntax here)
- Component diagram
- Deployment diagram
- State diagram
- Timing diagram

## [シーケンス図: Sequence diagram](https://plantuml.com/sequence-diagram)

## [TODO] [状態遷移図: State diagram](https://plantuml.com/state-diagram)

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

## References

- [Diagram as Code](https://blog.bytebytego.com/p/diagram-as-code)
  - 1. Diagrams
  - 2. Mermaid
  - 3. ASCII editor
  - 4. PlantUML
  - 5. Markmap
  - 6. Go diagrams

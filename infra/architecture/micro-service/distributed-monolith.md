# 分散モノリス / Distributed Monolith

**Distributed Monolith（分散モノリス）**とは、名前が示す通り、分散システムの形態を持ちながら、実際には複数のサービスが強く相互依存しているため、運用上はモノリシックな性質を持つアーキテクチャスタイルのことを指す。これは`マイクロサービスアーキテクチャの失敗パターン`としてよく言及される。

分散モノリスは、マイクロサービスアーキテクチャの目的（サービスの独立性、スケーラビリティ、故障と障害の分離）を達成するためには避けるべき状況。これを防ぐためには、設計段階からサービスのモジュラリティや独立性を意識し、複雑な依存関係を避けるための対策を講じることが重要。

## 特徴と問題点

1. **相互依存性**:
   多くの依存関係によって各サービスが密接に結びついており、サービス一つだけを独立してデプロイやスケールすることが難しくなっている。

2. **デプロイの困難さ**:
   サービスが強く依存し合っているため、変更や更新を行う際には関連するすべてのサービスを一緒にデプロイする必要がある。これにより、デプロイメントの頻度が制限され、運用が複雑化する。

3. **統合テストの困難さ**:
   相互依存するサービスのすべてを一緒にテストするため、テストの範囲が広がり、問題の検出と修正が困難になる。

4. **スケーラビリティの制限**:
   一部の機能やサービスを独立してスケールすることが難しく、全体のスケーラビリティが制限されがち。

5. **故障分離の欠如**:
   一つのサービスが障害を起こすと、相互依存する他のサービスにも影響を与え、全体のシステムがダウンするリスクが高まる。

6. **運用の複雑性**:
   各サービスの運用とモニタリングが必要でありながら、運用上の独立性が欠如しているため、管理が非常に複雑になる。

## 典型的な原因

1. **設計の不備**:
   マイクロサービスとして設計を始めたものの、サービス間の結合度を下げるための十分な設計ができておらず、結果として複雑な依存関係が残る。

2. **データベースの共有**:
   複数のマイクロサービスで一つのデータベースを共有することで、サービス間の結合度が高まる。

3. **APIの設計ミス**:
   サービス間通信を適切に設計できず、あるサービスが他のサービスの内部実装に依存する形になってしまう。

4. **統一的なリリースサイクル**:
   各サービスが独立してリリースされるのではなく、すべてのサービスが一緒にリリースされる形を取るため、更新や修正が一部のサービスだけに限定されず他のサービスにも波及する。

### 対策と改善方法

1. **サービス単位の独立性確保**:
   各サービスが他のサービスと疎結合になっていることを確認し、サービス間の結合度を下げる努力を行う。

2. **各サービスのデータ管理**:
   可能な限り各サービスが独自のデータベースを管理し、データの共有を最小限に抑る。

3. **API ゲートウェイの導入**:
   サービス間通信や外部アクセスを一元管理するAPIゲートウェイを導入し、サービス間の直接的な依存を減少させる。

4. **統合テストから契約テストへの移行**:
   サービス間のインターフェイスを契約ベースでテストすることにより、各サービスの独立性を保持しながら信頼性を向上させる。

5. **デプロイとリリースの戦略**:
   各サービスが独立してデプロイおよびリリースを管理できるようにするため、CI/CD パイプラインを適切に設計する。

6. **監視とフォルトトレランス**:
   サービス間の故障が他のサービスに影響を与えないように、監視とフォルトトレランスのメカニズムを強化する。

## 分散モノリス(Distributed Monolith) と モジュラーモノリス(Modular Monolith) の違い

いずれもモノリスアーキテクチャーの変種

### 1. 分散モノリス (Distributed Monolith)

- **定義**: 複数のサービスを分散配置するように見えても、実態はモノリスアーキテクチャーに近い構成を採用している
- **特徴**:
  - それぞれのサービスが独立しているように見えるが、実際には緊密に繋がれており、 service間の境界が曖昧である。
  - サービス間の通信では、ネットワーク上でAPIを介して行われるが、モジュラーモノリスでは各モジュール間のインタフェースがプロセス内で行われるのに対し、分散モノリスはプロセス間で行われる。
  - 複数のサービスを個別にデプロイするが、システム全体の依存関係が複雑で、サービス間でデプロイメントの連鎖があるため、実際に独立してデプロイすることが難しいことが多い。

### 2. モジュラーモノリス (Modular Monolith)

- **定義**: モジュラーモノリスは、モノリスアーキテクチャーの内部をモジュール化した設計。
- **特徴**:
  - モジュール間の境界を明確に定義し、内部的にモジュールを独立して作業可能な状態にする。
  - モジュール間の通信は、プロセス内でAPIやイベントを介して行われる。
  - デプロイメントは一括で行われるが、各モジュールの開発は独立して進行可能。
  - 各モジュールの責任範囲が明確に定義され、開発者の理解や管理が容易。

### 主な違い

1. **デプロイメントの単位**: 分散モノリスはサービスごとに個別のデプロイメントが可能ですが、モジュラーモノリスは一括でデプロイされる。
2. **モジュール間の通信**: 分散モノリスはネットワーク上でプロセス間のAPIを使用しますが、モジュラーモノリスはプロセス内でAPIやイベントを使用します。
3. **モジュールの独立性**: 分散モノリスはサービス間の依存関係が複雑で、独立性が低いのに対し、モジュラーモノリスはモジュール間の境界が明確で、独立性が高い。

これらの違いから、Modular Monolithはモノリスの利点を保ちつつ、モジュールの独立性を高めることができる一方、Distributed Monolithはサービス間の結合が強く、独立デプロイのメリットが現れにくい。

## References

- [Is your microservice a distributed monolith?](https://www.gremlin.com/blog/is-your-microservice-a-distributed-monolith)

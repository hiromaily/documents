# エクストリーム・プログラミング（XP）

エクストリーム・プログラミング（XP）は、アジャイルソフトウェア開発の一手法。XP は、高品質なソフトウェアを迅速に提供することを目的としており、開発チームが効果的に協力し、柔軟で適応可能な方法で作業を進めるためのプラクティスを多く取り入れている。

エクストリーム・プログラミングは、高品質なソフトウェアを迅速に提供するための強力な方法論。しかし、チームやプロジェクトの状況に応じて適切に取り入れることが重要。

## コアバリュー

1. **コミュニケーション**:
   - チームメンバー間の密接なコミュニケーションが重要。情報の共有と協力が効果的な開発につながる。
2. **シンプルさ**:
   - シンプルな設計とコードを書くことを重視し、過剰な機能追加を避ける。
   - [YAGNI](https://ja.wikipedia.org/wiki/YAGNI)
3. **フィードバック**:
   - ユーザーやクライアントからのフィードバックを頻繁に取り入れ、迅速に対応することで、適正な方向性を保つ。
4. **勇気**:
   - 必要に応じて大胆な変更を行う勇気を持つ。改善のための変更を恐れずに実行する。
5. **尊重**:
   - チームメンバー間で互いに尊重し合い、健全な作業環境を築く。

### YAGNI

`You ain't gonna need it`、縮めて `YAGNI` とは、`機能は実際に必要となるまでは追加しないのがよい`とする、エクストリーム・プログラミングにおける原則

- 後で使うだろうという予測の元に作ったものは、実際には10%程度しか使われない。したがって、それに費やした時間の90%は無駄になる
- 余計な機能があると、仕事が遅くなり、リソースを浪費する
- 予期しない変更に対しては、設計を単純にすることが備えとなる。そして、必要以上の機能を追加すると、設計が複雑になってしまう
- 人生の時間は、貴重である。したがって、人間の能力は、ただコードを書くためではなく、現実の問題に集中するために使うべきである
- 結局は、その機能は必要ないかもしれない。もしそうなったら、あなたがその機能を実装するのに費やした時間も、他のみんながそれを読むのに費やした時間も、その機能が占めていたスペースも、すべて無駄になってしまうだろう
- コードをすばやく実装するために最も良い方法は、あまりコードを書かないことである。そして、バグを減らすために最も良い方法も、あまりコードを書かないことである

## コアプラクティス

1. **ペアプログラミング（Pair Programming）**:

   - 二人のプログラマーが一つのコンピュータを使ってコードを書く方法。一方がコードを書き、もう一方がそれをレビューすることで高品質なコードを作成する。

2. **テスト駆動開発（Test-Driven Development, TDD）**:

   - コーディングの前にまずテストを記述する手法。これにより、コードが要求を満たしていることを確認しつつ進めることができる。

3. **リファクタリング（Refactoring）**:

   - 状況に応じてコードをシンプルでわかりやすく、保守性のあるものに改善する。機能追加やバグ修正の際には必ずリファクタリングを行う。

4. **継続的インテグレーション（Continuous Integration, CI）**:

   - コードの変更を頻繁に統合し、自動化されたビルドとテストを通じてバグを早期に検出する。

5. **小さなリリース（Small Releases）**:

   - ソフトウェアを小さな部分に分けて頻繁にリリースする。これにより、フィードバックを迅速に得ることができる。

6. **顧客の常駐（On-site Customer）**:

   - 開発チームに顧客が常駐し、即時のフィードバックや意思決定を行う。

7. **規約作成（Coding Standards）**:
   - 開発チーム全体が従うべきコーディングスタイルや規約を設定する。これにより、コードベースが一貫性を持ちやすくなる。

## メリット

- **アジャイルな対応**: 変更に迅速に対応できる。
- **高いコード品質**: 継続的なテストとフィードバックにより、高品質なコードが維持される。
- **ユーザー中心の開発**: 顧客のニーズに沿った開発が行われる。

## デメリット

- **チームコミュニケーションの重要性**: チームメンバー間のコミュニケーションが不十分だと効果を発揮しにくい。
- **高いリソース消費**: ペアプログラミングなどはリソースを多く消費する可能性がある。
- **顧客のコミットメント**: 顧客が積極的に関与する必要がある。
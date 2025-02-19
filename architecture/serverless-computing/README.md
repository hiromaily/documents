# Serverless Computing

[ReadLater]

Serverless Computing（サーバーレス・コンピューティング）は、クラウド・コンピューティングの一形態で、ユーザーがサーバーの管理やプロビジョニングを意識せずにアプリケーション開発を行える環境を提供する。つまり、従来のようにサーバーの運用やスケーリングを自身で行う必要がないため、`開発者はコーディングやビジネスロジックの実装に専念することができる`。

サーバーレス・コンピューティングは、適切なユースケースで活用すれば、大幅に効率を向上し、コストを削減することができる。特に、変動するトラフィックに対応が必要なサービや迅速なプロトタイピングが求められるプロジェクトに向いている。

[内部Docs: Lambda](../../cloud/aws/services/lambda/README.md)

## 基本的な概念

1. **抽象化されたサーバーの管理**: ユーザーが物理サーバーまたは仮想サーバーのインフラを直接管理することはない。これにより、サーバーのセットアップ、保守、アップデートなどの作業から解放される。

2. **イベント・ドリブン・モデル**: サーバーレス・コンピューティングの場合、多くのサービスはイベントに応じて起動する`イベント・ドリブン・モデル`で動作する。例えば、API のリクエスト、データベースの更新、ファイルのアップロードなどがトリガーになって関数が実行される。

3. **オンデマンドスケーリング**: トラフィックの増減に応じて自動的にスケーリングするため、パフォーマンスの最適化とコスト効率を両立できる。

4. **料金体系**: 通常、`Pay-as-you-go（使った分だけ支払う）`モデルが採用されている。使用したリソース量に基づいて課金されるため、過剰なプロビジョニングによるリソースの無駄遣いが最小限に抑えられる。

## 主なサービスプロバイダー

- **AWS Lambda**: Amazon Web Services によるイベント駆動型の計算サービス。データの変化やユーザーアクションをトリガーとして関数を実行できる。
- **Google Cloud Functions**: Google Cloud Platform の一部であり、サーバーレスな関数の実行環境を提供する。
- **Azure Functions**: Microsoft Azure によるサーバーレス・コンピューティングサービス。
- **Fluid compute by Vercel**: Vercelによるより効率的で高速とされるサービス

- [従来のサーバレスよりさらに高効率で高速な「Fluid Compute」、Vercelが提供開始](https://www.publickey1.jp/blog/25/fluid_computevercel.html)

## 利点

1. **迅速な開発とデプロイ**: サーバーレスは開発とデプロイのプロセスを簡素化し、素早いリリースが可能になる。
2. **コスト効率**: 実行時間や処理件数に応じた料金体系により、必要な分だけ支払い、インフラコストを削減できる。
3. **自動スケーリング**: トラフィックに応じた自動スケーリングが行われるため、パフォーマンスの最適化が容易。
4. **運用管理の軽減**: インフラの運用管理から解放され、開発に注力できる。

## デメリット

1. **制約**: 実行時間(15分)やメモリの制限があり、長時間処理が必要なタスクには不向き。
2. **パフォーマンス問題**: コールドスタートと呼ばれる初回実行の遅延が発生することがある。
3. **依存関係の管理**: 他のサービスとの依存関係が増えると、デバッグや管理が複雑になることがある。

## ユースケース

- **リアルタイムデータ処理**: ログの監視、ストリーミングデータの分析など。
- **API バックエンド**: RESTful API の構築。
- **ETL パイプライン**: データの抽出、変換、ロードを自動化。
- **ファイル処理**: イメージやビデオの自動処理、トランスコーディング。

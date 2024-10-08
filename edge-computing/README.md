# エッジコンピューティング / Edge Computing

**Edge Computing**（エッジコンピューティング）は、`データの処理`を`データが生成される場所の近く`、つまり`エッジ`で行うことを指す。`エッジ`は、通常、データセンターやクラウドのサーバーと区別して使われる言葉で、たとえば、`ネットワークの末端にあるデバイスやローカルサーバーなどが該当`する。

## Edge Computingの利点

1. **低遅延**:
   - データが生成される場所（センサーデバイス、IoTデバイスなど）で直接処理を行うため、データを遠くのクラウドサーバーに送信して戻ってくる時間が減り、低遅延が実現できる。
   - 自動運転車やリアルタイムの分析が必要なアプリケーションにおいて、遅延は致命的となるため、低遅延が非常に重要。

2. **帯域幅の節約**:
   - 大量のデータをクラウドに送信する必要がないため、ネットワーク帯域幅の使用量が減る。これにより、コスト削減が可能。

3. **データプライバシーとセキュリティ**:
   - データがローカルで処理されるため、データが外部に送信されるリスクが減少し、プライバシーとセキュリティが向上する。

4. **リアルタイム処理**:
   - データをリアルタイムで処理できるため、時機を逃さずにアクションを起こすことができる。

### 具体的なアプリケーション例

- **IoTデバイス**:
  - 温度センサー、スマートホームデバイス、ウェアラブルデバイスなどが生成するデータを即座に処理。
  
- **製造業**:
  - 工場内の機械やロボットのセンサーから得られるデータを即座に分析し、機械の故障を予測したり、生産ラインの効率を最適化。

- **自動運転車**:
  - 車載センサーやカメラから得られるリアルタイムデータをその場で処理し、危険の回避や最適なルートの選択を実行。

- **スマートシティ**:
  - 交通センサーやカメラから得られるデータを用いてリアルタイムで交通状況を最適化。

### 技術スタック

- **ハードウェア**:
  - 小型のエッジデバイス（Raspberry Pi、NVIDIA Jetsonなど）
  - エッジサーバー

- **ソフトウェア**:
  - コンテナ（Dockerなど）やオーケストレーションツール（Kubernetes、K3sなど）
  - データ収集・分析ツール（Apache Kafka、Apache Flinkなど）
  
- **通信プロトコル**:
  - `MQTT`、`CoAP`など軽量で低遅延の通信プロトコル

### エコシステムとサービス

- **クラウドプロバイダーのエッジサービス**:
  - AWS IoT Greengrass
  - Azure IoT Edge
  - Google Cloud IoT Edge

- **エッジAI**:
  - NVIDIA Edge AI（NVIDIAが提供するJetsonシリーズとソフトウェアスタック）
  - OpenVINO（IntelのAI推論ツール）

### チャレンジと考慮点

- **分散化の管理**:
  - 多くのエッジデバイスがネットワークに存在すると、それらの管理やアップデートが複雑になる。
  
- **セキュリティの強化**:
  - エッジデバイスが物理的にアクセスしやすい場所に置かれる場合、物理的なセキュリティも考慮が必要。

- **データの一貫性**:
  - 分散された多くのデバイスでデータの一貫性を保つことが課題。

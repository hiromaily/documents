# Grafana k6

オープンソースの負荷テストツールで、グラフィカルなインターフェースを持たず、コマンドラインから実行できる軽量な負荷テストツール。特に API やウェブサービスのテストに適しており、高いパフォーマンスとスケーラビリティを提供する。

k6は、高パフォーマンスかつスケーラブルな負荷テストツールであり、特にAPIやウェブサービスのパフォーマンス評価に向いている。設定が比較的簡単で、他のツールとの統合も容易なため、多くのエンジニアに支持されている。初めて負荷テストを行う場合も、経験豊富なエンジニア向けにも適したツール。

## k6 の主な特徴

1. **スクリプトベース**:

   - JavaScript でテストスクリプトを記述する。これにより、柔軟でプログラム的なテストシナリオの作成が可能。

2. **高パフォーマンス**:

   - Go 言語で実装されているため、低い CPU とメモリのオーバーヘッドで高負荷をシミュレートできる。

3. **シンプルなインターフェース**:

   - コマンドラインから簡単に実行でき、直感的な設定と実行が可能。

4. **スケーラビリティ**:

   - ローカルマシンだけでなく、クラウド環境でも容易にスケールアウトできる。

5. **詳細なレポートとメトリクス**:

   - 豊富なメトリクス収集機能があり、リアルタイムでパフォーマンスを監視できる。

6. **統合性**:
   - 多くの他のツール（Grafana、Prometheus、ElasticSearch など）と統合しやすい。

## k6 の基本的な使い方

1. **スクリプトの作成**:

   - `test.js`という名前のテストスクリプトを作成する。スクリプトは JavaScript で書かれる。

   ```js
   import http from "k6/http";
   import { check, sleep } from "k6";

   export let options = {
     vus: 10, // ユーザー数
     duration: "30s", // 実行時間
   };

   export default function () {
     let res = http.get("https://test.k6.io");
     check(res, { "status was 200": (r) => r.status == 200 });
     sleep(1);
   }
   ```

2. **テストの実行**:
   - コマンドラインからテストを実行する。

   ```sh
   k6 run test.js
   ```

## 追加のオプション

- **並列ユーザー数（Virtual Users, VUs）**の設定:

  ```sh
  k6 run --vus 50 --duration 30s test.js
  ```

- **分散テスト**:
  - k6 はクラウドベースのテスト実行をサポートしており、複数のサーバーから同時に負荷をかけることができる。

## k6 と他のツールとの統合

### Grafana や Prometheus との連携

k6 のテスト結果をリアルタイムで監視するために、Grafana や Prometheus と統合することができる。これにより、より詳細なデータ分析が可能となる。

- k6 から Prometheus にメトリクスを送信するための設定例:

  ```js
  export let options = {
      ext: {
          loadimpact: {
              projectID: <YOUR_PROJECT_ID>,
              name: "My Load Test"
          },
          monitoring: {
              type: 'prometheus',
              address: 'http://<PROMETHEUS_SERVER>:9090/metrics',
          },
      }
  };
  ```

## [xk6](https://github.com/grafana/xk6)

k6の機能を拡張できる

## References

- [Official](https://k6.io/docs/)
- [Official2](https://grafana.com/docs/k6/latest/)
- [github](https://github.com/grafana/k6)

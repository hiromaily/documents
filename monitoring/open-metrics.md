# [OpenMetrics](https://openmetrics.io/)

元々`Prometheus`が利用しているフォーマットで、Prometheus は`Promethues exporter`と呼ばれる監視対象からメトリクスを集約する作りになっている。
Prometheus exporter は実は`単なるHTTPのエンドポイント`であり、そのレスポンスが独自のテキストフォーマットになっている。このフォーマットを標準化しようとして提唱されているのが`OpenMetrics`となる

[Go のアプリケーションを OpenMetrics を使って監視する](https://songmu.jp/riji/entry/2020-05-18-go-openmetrics.html)

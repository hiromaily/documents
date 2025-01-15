# [DatadogのExporter](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/exporter/datadogexporter/README.md) について

`The Datadog Exporter now skips APM stats computation by default. It is recommended to only use the Datadog Connector in order to compute APM stats.`とある。

[Datadog Connector](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/connector/datadogconnector)

しかし、`datadogexporter`は、opentelemetryのInterfaceにはマッチしないので、利用できない。
とはいえ、`"github.com/DataDog/opencensus-go-exporter-datadog"`はdeprecatedされている。

```go
import (
    "github.com/open-telemetry/opentelemetry-collector-contrib/exporter/datadogexporter"
    //datadog "github.com/DataDog/opencensus-go-exporter-datadog"
)
```

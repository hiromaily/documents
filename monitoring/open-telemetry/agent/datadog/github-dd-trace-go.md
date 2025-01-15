# [github: DataDog/dd-trace-go](https://github.com/DataDog/dd-trace-go)

go製のclientパッケージ。内部的に環境変数の`DD_TRACE_AGENT_URL`が利用されている。

```go
func AgentURLFromEnv() *url.URL {
    if agentURL := os.Getenv("DD_TRACE_AGENT_URL"); agentURL != "" {
        u, err := url.Parse(agentURL)
        if err != nil {
            log.Warn("Failed to parse DD_TRACE_AGENT_URL: %v", err)
        } else {
            switch u.Scheme {
            case "unix", "http", "https":
                return u
            default:
                log.Warn("Unsupported protocol %q in Agent URL %q. Must be one of: http, https, unix.", u.Scheme, agentURL)
            }
        }
    }
  ...
}
```

## DATADOG TRACER CONFIGURATION

以下はLambda上でDatadogのtracingを利用した時に、自動的にloggingされたもの

```json
{
    "date": "2025-01-14T08:49:17Z",
    "os_name": "Amazon Linux",
    "os_version": "2023",
    "version": "v1.70.1",
    "lang": "Go",
    "lang_version": "go1.23.4",
    "env": "",
    "service": "communication-hub",
    "agent_url": "http://localhost:8126/v0.4/traces",
    "agent_error": "",
    "debug": false,
    "analytics_enabled": false,
    "sample_rate": "NaN",
    "sample_rate_limit": "disabled",
    "trace_sampling_rules": null,
    "span_sampling_rules": null,
    "sampling_rules_error": "",
    "service_mappings": null,
    "tags": {
        "runtime-id": "dae12789-c8e7-417f-bd73-867896e1d4c3"
    },
    "runtime_metrics_enabled": false,
    "runtime_metrics_v2_enabled": false,
    "health_metrics_enabled": false,
    "profiler_code_hotspots_enabled": true,
    "profiler_endpoints_enabled": true,
    "dd_version": "0.0.1",
    "architecture": "arm64",
    "global_service": "my-service-name",
    "lambda_mode": "true",
    "appsec": false,
    "agent_features": {
        "DropP0s": false,
        "Stats": false,
        "StatsdPort": 0
    },
    "integrations": {
        "AWS SDK": {
            "instrumented": false,
            "available": true,
            "available_version": "v1.50.9"
        },
        "AWS SDK v2": {
            "instrumented": false,
            "available": true,
            "available_version": "v1.32.6"
        },
        "Bun": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "BuntDB": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Cassandra": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Consul": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Elasticsearch v3": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Elasticsearch v5": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Elasticsearch v6": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "FastHTTP": {
            "instrumented": false,
            "available": true,
            "available_version": "v1.51.0"
        },
        "Fiber": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Gin": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Goji": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Google API": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Gorilla Mux": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Gorm": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Gorm (gopkg)": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Gorm v1": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "GraphQL": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "HTTP": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "HTTP Router": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "HTTP Treemux": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "IBM sarama": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Kafka (confluent)": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Kafka (confluent) v2": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Kafka v0": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Kubernetes": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "LevelDB": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Logrus": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Memcache": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "MongoDB": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "MongoDB (mgo)": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Negroni": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Pub/Sub": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Redigo": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Redigo (dep)": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Redis": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Redis v7": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Redis v8": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Redis v9": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "SQL": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "SQLx": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Shopify sarama": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Twirp": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "Vault": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "chi": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "chi v5": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "echo": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "echo v4": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "gRPC": {
            "instrumented": false,
            "available": true,
            "available_version": "v1.67.1"
        },
        "go-pg v10": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "go-restful": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "go-restful v3": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "gqlgen": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "log/slog": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        },
        "miekg/dns": {
            "instrumented": false,
            "available": false,
            "available_version": ""
        }
    },
    "partial_flush_enabled": false,
    "partial_flush_min_spans": 1000,
    "orchestrion": {
        "enabled": false
    },
    "feature_flags": [],
    "propagation_style_inject": "datadog,tracecontext",
    "propagation_style_extract": "datadog,tracecontext"
}
```

# Application Tuning

## Golang

### [http#Client](https://pkg.go.dev/net/http#Client) package

```go
package main

import (
  "fmt"
  "net"
  "net/http"
  "net/http/httptest"
  "time"
)

func main() {
  client := &http.Client{
    // timeout
    Timeout: 5 * time.Second,
    Transport: &http.Transport{
      DialContext: (&net.Dialer{
        Timeout: time.Second,
      }).DialContext,
      TLSHandshakeTimeout:   time.Second,
      ResponseHeaderTimeout: time.Second,
      IdleConnTimeout: time.Second,
      // adjust MaxIdleConnsPerHost
      MaxIdleConns: 100,
      MaxConnsPerHost: 100,
      MaxIdleConnsPerHost: 100,
    },
  }
  ...
}
```

### [httptrace](https://pkg.go.dev/net/http/httptrace) package

```go
import (
  "fmt"
  "log"
  "net/http"
  "net/http/httptrace"
)

func main() {
  req, _ := http.NewRequest("GET", "http://example.com", nil)
  trace := &httptrace.ClientTrace{
    GotConn: func(connInfo httptrace.GotConnInfo) {
      fmt.Printf("Got Conn: %+v\n", connInfo)
    },
    DNSDone: func(dnsInfo httptrace.DNSDoneInfo) {
      fmt.Printf("DNS Info: %+v\n", dnsInfo)
    },
  }
  req = req.WithContext(httptrace.WithClientTrace(req.Context(), trace))
  _, err := http.DefaultTransport.RoundTrip(req)
  if err != nil {
    log.Fatal(err)
  }
}
```

- [Introducing HTTP Tracing](https://go.dev/blog/http-tracing)
- [Medium: HTTP Trace in GoLang (2023)](https://medium.com/@saiteja180/http-trace-in-golang-e37766b15d21)
- [OpenTelemetry の Trace を Go で試してみる](https://christina04.hatenablog.com/entry/opentelemetry-in-go)

## 確認方法

- [httpstat](https://github.com/davecheney/httpstat) ... tool developed by Golang
- [tcpdump](https://www.tohoho-web.com/ex/tcpdump.html) ... パケットキャプチャツール
  - localhost で確認する: `$ sudo tcpdump -i lo0 port 8080 -vv`
  - 任意のアドレスと port を指定: `$ sudo tcpdump port 80 and host 192.168.0.123`

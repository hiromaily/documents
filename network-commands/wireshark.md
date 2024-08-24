# Wireshark

起動してネットワークを選択後、すぐにキャプチャしたいリクエストを実行し、キャプチャを停止させる。  
次に、Filter bar に expression を設定

```
http.host contains "jp.indeed.com" && http.request.uri contains "/jobs?q=Rust"
```

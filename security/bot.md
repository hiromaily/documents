# Bot 対策

リクエストのパターン、ヘッダー、ブラウザの動作や JavaScript の実行などのその他のシグナルを検査するボット検出メカニズムがよく採用されている。

- 期待されるすべての`Response Header`を確認
  - Header の順序とフォーマット
  - Cookie は特に重要
  - UA の検出
- TLS および HTTPS の処理
  - TLS/SSL 接続の確立方法
- HTTP バージョンの違い

## 通信の確認

- [Wireshark](https://www.wireshark.org/)
- tcpdump

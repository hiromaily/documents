# HTTP / Hypertext Transfer Protocol

## HTTP のバージョン

- HTTP/1.0
- HTTP/1.1
- HTTP/2
- HTTP/3 (QUIC)

## 通信の仕組み

- DNS による名前解決を行うため、DNS サーバーに IP を問い合わせる
  - 尚、ブラウザに proxy が設定されている場合は、proxy サーバーが DNS で名前解決を行う
- 次に、IP アドレスに対して、TCP コネクションを確立する
  - まず、PC から Web サーバーに`TCP syn`パケットを送る
  - Web サーバから`TCP syn/ack`パケットを返す
  - PC から`TCP ack`パケットを送る
  - 上記 3 つの step により、コネクション成立となる
  - このやり方は、`3 way ハンドシェイク`と言う
  - なお、HTTPS を使う場合は、TLS ハンドシェイクが必要でオーバーヘッドが大きい

## バージョンごとの通信の違い

### HTTP/1.1

- HTTP リクエストとレスポンスをやり取りするごとに TCP コネクションを切断する
  - つまり、リクエストの度にハンドシェイクが必要になる
- テキスト形式のメッセージをやりとりする
- 1 ドメインあたり概ね 最大 6 TCP コネクションほど(実装依存)

### HTTP/2

- フレームとストリーム(多重化)
  - `1 つの TCP コネクション`上で複数の HTTP リクエストと HTTP レスポンスを多重化することで、複数の HTTP メッセージを並列的にやりとりを行う
  - これにメッセージの上限はない
- ネゴシエーション (ALPN: Application-Layer Protocol Negotiation)
  - HTTP/2 はフレームというメッセージ形式でメッセージを送信するため、 HTTP/1.1 と互換性はない
  - そのため HTTP/2 通信を開始するためには相手と HTTP/2 の使用を合意する必要があり、そのための手法
- コネクションの再利用
  - HTTP/2 では、 極力既存の TCP コネクションを使い回して HTTP リクエストを送信する
  - http で接続を行っている場合は、 ドメイン名の IP アドレスが同じであれば TCP コネクションを再利用できる
  - https で接続を行っている場合は、 http 同様にドメイン名の IP アドレスが同じことに加え、 証明書が有効なことが条件
- ヘッダ圧縮
  - HPACK というヘッダ圧縮方式を策定し、そちらに対応している
- 優先順位
  - クライアントは HTTP リクエストに優先度を指定でき
- サーバプッシュ
  - HTTP リクエストがなくても HTTP レスポンスを送信することができる
- セキュリティの向上

  - HTTP/2 において TLS を使用する場合は以下を守る必要がある
    - TLS 1.2 以上を使用する
    - SNI（Server Name Indication）をサポートする
    - 仕様で指定される暗号スイートを使用する
    - TLS の圧縮機能を無効にする
    - TLS の再ネゴシエーションを使用しない

- HTTP/2 ではバイナリ形式のメッセージをやりとりする

#### ストリーム (仮想的な通信単位)

- HTTP/2 の TCP コネクション上での HTTP リクエストと HTTP レスポンスのやりとりを管理するための概念を`ストリーム`と言う
- 1 対の HTTP リクエストとレスポンスが 1 つの`ストリーム`に属する
- 1 つの TCP コネクションの中で、複数の`ストリーム`が発生することになる
- 一度使用した`ストリーム`は再利用されることなくて、HTTP レスポンスを受信すると使用されなくなる
- ストリームにはストリーム ID と呼ばれる一意の ID がある

#### フレーム

- この仮想的な通信単位であるストリームごとにフレームというメッセージをやりとりすることになる
- 1 つのストリームは複数のフレームの送受信で構成される
- HTTP/2 でやりとりされるフレームは使用用途ごとに 10 種類のフレームタイプがある

## HTTP と HTTPS の違い

- HTTP と HTTPS の違いは通信が暗号化されていないか暗号化されているかの違い
- HTTPS(Hytertext Transfer Protocol Secure)は、HTTP で通信を安全に行うための仕組み
- SSL(Secure Sockets Layer)／TLS(Transport Layer Security)と呼ばれるプロトコルが作り出す、安全な接続を使って、その上で HTTP による通信を行う

## Keep Alive

Idle connection をプールすることによって、クライアントは一回の TCP 接続で複数のコンテンツを要求することにより、通信パフォーマンスを向上させる事が出来る。
内部的には 1 回の接続ごとに接続を閉じることなく、その接続状態を維持したまま複数の resource へのリクエスト送受信を行う。

- HTTP/1.1 からサポート
- `tcpdump`などで挙動の確認ができる

### keep-alive timeout の設定による違い

| Time                                         | Best for                                                                                                        | Pros                                                                                                                         | Cons                                                                                                |
| -------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| Short Keep-Alive Timeout (1-5 seconds)       | High-traffic sites with many short-lived connections, like news sites or social media                           | Frees up server resources quickly, reducing the number of idle connections                                                   | May result in more frequent reconnections, increasing overhead for establishing new TCP connections |
| Medium Keep-Alive Timeout (10-30 seconds)    | General-purpose websites with a mix of static and dynamic content                                               | Balances the need for persistent connections with resource usage, improving user experience without overly taxing the server | May still leave connections open longer than necessary in some high-traffic scenarios               |
| Long Keep-Alive Timeout (60 seconds or more) | Applications with frequent interactions per user session, such as real-time web apps, e-commerce sites, or APIs | Reduces latency for returning visitors, as the connection remains open                                                       | Can consume significant server resources if many connections remain idle for extended periods       |

## References

- [HTTP/2 とは](https://www.nic.ad.jp/ja/newsletter/No68/NL68_0800.pdf)

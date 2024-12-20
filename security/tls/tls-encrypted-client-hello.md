# TLS Encrypted Client Hello / ECH

[Draft: TLS Encrypted Client Hello](https://www.ietf.org/archive/id/draft-ietf-tls-esni-18.html)

TLS Encrypted Client Hello（ECH）は、TLS 1.3の拡張機能で、クライアントがTLSハンドシェイク中のClientHelloメッセージを暗号化するための技術。
クライアントが機密メタデータを含むClientHelloメッセージを暗号化する技術。これにより、プライバシーが強化され、通信の内容が受動的な観察者から保護される。ECHを使用するには、対応するDNS設定と鍵の準備が必要。

## ECHの概要

ECHは、サーバー名表示（SNI）やその他の機密メタデータを含むClientHelloメッセージを暗号化することで、通信のプライバシーを強化する。これにより、サーバー名やその他の機密情報が平文で送信されないため、受動的な観察者が通信の内容を知ることができなくなる。

## ECHの動作

ECHは以下の手順で動作する

1. **クライアント側の処理**:
   - クライアントは二つのClientHelloメッセージを作成する：`ClientHelloOuter`と`ClientHelloInner`。
   - `ClientHelloOuter`には機密ではない情報が含まれ、`ClientHelloInner`には機密情報（SNIなど）が含まれる。
   - `ClientHelloInner`は、サーバーのパブリックキーを使って暗号化され、これを`encrypted_client_hello`拡張として`ClientHelloOuter`に配置する

2. **サーバー側の処理**:
   - サーバーは`ClientHelloOuter`を受信し、ECHの使用を検出する
   - ECHをサポートしている場合は、`ClientHelloInner`を復号する。そうでない場合は、通常のTLSハンドシェイクを続行する

3. **ハンドシェイクの続行**:
   - サーバーがECHをサポートしている場合は、`ClientHelloInner`を使用してハンドシェイクを続行する
   - ECHがサポートされていない場合は、クライアントは再試行するため、最新のECH設定を取得する

## ECHの機能

ECHの主な目的は、同じ匿名性セット内のサーバーへの接続を区別不能にすること。これにより、クライアントが通信先を隠すことができ、プライバシーが強化される。また、ECHは既存のTLS 1.3のセキュリティ特性に影響を与えないように設計されている

ECHを活用するためには、DNSとの接続において`DoT/DoH`と`DNSSEC`に対応する必要がある。これにより、DNSクエリを暗号化し、DNS解決時のフィルタリングを回避できる

## 実装例

wolfSSLの例では、ECHの設定と接続方法が示されている。`wolfSSL_GetEchConfigs`を使用してECHの設定を取得し、`wolfSSL_SetEchConfigs`を使用してそれをSSLオブジェクトに適用する。接続と再接続のプロセスを実行し、ECHの有効性を確認する。

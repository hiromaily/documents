# ポスト量子暗号 Post-quantum cryptography

ポスト量子暗号（Post-Quantum Cryptography, PQC）は、現在主流となっている公開鍵暗号方式（例えばRSAやECDSAなど）が、将来的に量子コンピュータの発展に伴って安全性を失う可能性に備え、新たに提案された暗号方式。量子コンピュータは、現行の多くの公開鍵暗号方式が基づく計算問題（整数因子分解問題や離散対数問題など）を効率的に解くことができるため、これらの暗号方式は脆弱になり得る。
量子コンピュータが現在の公開鍵暗号アルゴリズムへの脅威となっている一方で、現在の多くの共通鍵暗号やハッシュ関数は量子コンピュータからの攻撃に対して比較的安全と考えられている。

ポスト量子暗号の目標は、量子コンピュータによる攻撃にも耐えることができる暗号技術を開発すること。

## 様々な暗号方式

主な取り組み分野としては、以下のような新しい計算問題に基づいた暗号方式が提案されている。

1. **格子暗号（Lattice-based cryptography）：**
   - 格子問題（Lattice problems）に基づく暗号方式。
   - 代表的なものには、NTRU（N-th degree Truncated Polynomial Ring）、LWE（Learning With Errors）問題に基づく方式、Kyberが含まれる。

2. **符号理論ベースの暗号（Code-based cryptography）：**
   - エラー訂正符号に基づく暗号方式。
   - 代表的なものには、McEliece暗号が含まれます。

3. **多変数多項式暗号（Multivariate polynomial cryptography）：**
   - 多変数多項式方程式を基盤とする暗号方式。
   - 代表的なものにHFE（Hidden Field Equations）などが含まれます。

4. **等式暗号（Isogeny-based cryptography）：**
   - 楕円曲線の間の等式に基づく暗号方式。
   - 代表的なものには、SIDH（Supersingular Isogeny Diffie–Hellman）などがあります。

5. **ハッシュベースの署名（Hash-based signatures）：**
   - ハッシュ関数の強いセキュリティ性を利用した署名方式。
   - 代表的なものには、Lamport署名やMerkle署名（XMSS, LMSなど）が含まれます。

## 各暗号方式の実装例

### Kyber

Kyber（カイバー）は、ポスト量子暗号（PQC）の一種であり、特に鍵交換と暗号化に使用される格子ベースの暗号プリミティブ。Kyberは、将来的な量子コンピュータの攻撃に対する耐性を提供することを目指して設計されている。その設計は、強力かつ効率的である

1. **格子暗号ベース**：
   - Kyberは、格子問題（特に、モジュラーラティスの問題）に基づく構造を持っている。格子暗号は強力な数学的難易度に基づいており、量子コンピュータに対しても耐性があると考えられている。

2. **速さと効率**：
   - Kyberは効率的な実装が可能であり、鍵サイズや計算リソースに対する要求が比較的小さいため、実用的な大規模用途にも適している。これにより、既存のインフラストラクチャに統合しやすいメリットがある。

3. **NIST PQC標準化プロセス**：
   - Kyberは、アメリカ国立標準技術研究所（NIST）のポスト量子暗号標準化コンペティションにおいて、鍵交換および暗号化のカテゴリーで最終ラウンドに進出した候補の一つ。このことからも、その高度なセキュリティと実用性が認められている。

4. **セキュリティ保証**：
   - Kyberは漸近的安全性および実践安全性に関する強力な証明を持っており、そのセキュリティは格子問題の難易度に依存している。特に、Smallest Superincreasing Modular Lattice (SIS)やLearning With Errors (LWE)のような問題の解決が困難であることを前提としている。

**Kyberの使用シナリオ**：
具体的なシナリオとして、`ハイブリッドポスト量子暗号TLS鍵交換`にKyberが使われると、以下のように機能する

- **鍵交換のための公私鍵ペア生成**：
  Kyberを使用してサーバーとクライアントがそれぞれpublic privateの鍵ペアを生成する。
- **鍵交換メッセージのやり取り**：
  サーバーはクライアントに対してKyberの公開鍵を送信し、クライアントはそれを使って暗号文を作成し応答する。
- **セッション鍵の生成**：
  サーバーとクライアントは整数演算を行い、結果の共有秘密を生成してセッション鍵として使用する。

## 標準化として採用された実装

1. **ML-KEM (Module-Lattice-Based Key-Encapsulation Mechanism)**: CRYSTALS-Kyberを基にした鍵カプセル化メカニズムで、一般的な暗号化に使用される

2. **ML-DSA (Module-Lattice-Based Digital Signature Algorithm)**: CRYSTALS-Dilithiumを基にした格子ベースのデジタル署名アルゴリズムで、通常のデジタル署名に使用される

3. **SLH-DSA (Stateless Hash-Based Digital Signature Algorithm)**: SPHINCS+を基にしたステートレスハッシュベースのデジタル署名スキームで、ML-DSAのバックアップとして使用される

## NIST標準化プロセス

米国国立標準技術研究所（NIST）は、ポスト量子暗号の標準化プロセスを進めている。このプロセスでは多くの提案が検討され、セキュリティと効率性に基づいて評価される。現在、いくつかの方式が最終ラウンドまで進んでおり、近い将来に標準化されると期待されている。

## ハイブリッドポスト量子暗号TLS鍵交換 / Hybrid Post-Quantum TLS Key Exchange

ハイブリッドポスト量子暗号TLS鍵交換は、現行のTLS（Transport Layer Security）プロトコルにおいて、従来の暗号方式とポスト量子暗号方式を組み合わせてキー交換を行う方式。これは、ポスト量子暗号の研究が進んでいる一方で、その安全性やパフォーマンスに関する完全な信頼性が確立されていない段階において、セキュリティの過渡期をカバーするために利用される。

具体的には、ハイブリッドポスト量子暗号TLS鍵交換では、二つの異なる暗号方式を組み合わせて、以下のように安全性を強化する。

1. **従来の暗号方式**（例：ECDHE（楕円曲線Diffie-Hellman鍵交換）やRSA鍵交換）を使用してキー交換を行う。これにより、現在のコンピュータの性能で破られにくい安全性を持たせる。

2. **ポスト量子暗号方式**（例：NTRU、Kyberなど）を追加で使用してキー交換を行う。将来の量子コンピュータによる攻撃にも耐性を持たせるための準備となる。

このコンビネーションにより、次のメリットが得られる

- **二重のセキュリティ層：** 従来の暗号方式が破られても、ポスト量子暗号の安全性が残り、逆もまた然り。
- **遅延の軽減：** ポスト量子暗号方式が改良され、パフォーマンスが向上するまでの間、従来の効率的な暗号方式と併用することで、性能面での影響を最小限に抑える。

### 一般的なハイブリッドポスト量子暗号TLS鍵交換のプロセス

1. **サーバーとクライアントの鍵交換：**
   - サーバーは従来の暗号方式で生成された公開鍵とポスト量子暗号方式で生成された公開鍵の両方をクライアントに送信。
   - クライアントはサーバーから受け取った公開鍵を用いて、従来の暗号方式とポスト量子暗号方式の両方でキー交換メッセージを生成する。

2. **セッション鍵の生成：**
   - クライアントとサーバーは、それぞれの方式で生成された共有鍵を使い、これらを適切に結合して最終的なセッション鍵を生成する。

3. **暗号通信開始：**
   - 生成されたハイブリッドセッション鍵を使って、後続の通信を暗号化する。

この方式により、移行期のセキュリティを確保しつつ、ポスト量子暗号方式の実用化が進む過程でのリスクを軽減する。ポスト量子時代への完全な移行が実現するまでの過渡期において、重要な役割を果たす技術となる。

### [Google Chromeの耐量子暗号機能をデフォルトで有効化、一部サーバで問題発生](https://news.mynavi.jp/techplus/article/20240501-2937445/)

Chromeバージョン124から「ハイブリッドポスト量子暗号TLS鍵交換(hybrid postquantum TLS key exchange)」をデフォルトで有効にしたとのこと。
2024年現在、一部のWebサイト、サーバ、ファイアーウォールへの接続に問題が発生したと報告されている。原因はサーバ側の不完全なTLS実装にあり、Chromeからの大きなClientHelloメッセージを処理できないためとされる。サーバに原因があるため、問題はサーバ側で修正する必要がある。

暫定対応として、[Chromeの設定](chrome://flags/#enable-tls13-kyber)より機能をOFFにできる。

## Golang 1.23に導入された、post-quantum key exchange mechanism X25519Kyber768Draft00

[Go 1.23 Release Notes#Minor changes to the library](https://tip.golang.org/doc/go1.23#minor_library_changes)

defaultで利用されるため、以下の設定をいれることで、デフォルト設定を変更することができる

```sh
GODEBUG=tlskyber=0
```

### AWSの特定のLambda環境にて、HTTPS通信時にエラー`net/http: TLS handshake timeout`が発生する

- [Go 1.23: Additional key exchange mechanism X25519Kyber768Draft00 causes AWS Network Firewall to drop packets](https://github.com/hashicorp/terraform-provider-aws/issues/39311)
- [[Bug]: AWS STS TLS Timeouts when running terraform init](https://github.com/hashicorp/terraform-provider-aws/issues/39125)

ドメイン ベースのファイアウォールでは、HTTPS 接続で SNI が設定されていないと正しく機能しない、とのこと

#### ドメインベースのファイアウォールにおけるSNIの役割

1. **SNI (Server Name Indication)とは**:
   - SNIはSSL/TLSの拡張仕様で、一つのサーバー（同じグローバルIPアドレス）で複数のドメイン名を使用する場合に、複数のSSL証明書を運用できるようにする。

2. **ドメインベースのファイアウォールとSNI**:
   - ファイアウォールが正しく機能するためには、HTTPS接続においてSNIが設定されている必要がある。SNIはクライアントがSSLハンドシェイクの際に、通信先のドメイン名をサーバーに通知する仕組み。これにより、サーバーは該当のドメインに対応するSSL証明書を返すことができる。

3. **SNIが設定されていない場合の問題**:
   - SNIが設定されていない場合、同一のグローバルIPアドレスを持つサーバーは、異なるドメインに対して同じSSL証明書を返すことになる。これは、複数のドメインを一つのサーバーで運用する名前ベースバーチャルホストにおいて不具合を引き起こす。

したがって、ドメインベースのファイアウォールで正しく機能させるには、HTTPS接続に対してSNIが必要。SNIの導入により、ユーザが取得した独自のドメイン名とSSLサーバ証明書のドメイン名を一致させることができる。

- [AWS post-quantum cryptography migration plan](https://aws.amazon.com/blogs/security/aws-post-quantum-cryptography-migration-plan/)
- [【AWS re:Invent 2024】ポスト量子暗号時代への備え！AWSの取り組みと顧客の一歩](https://blog.serverworks.co.jp/aws-post-quantum-cryptography)

## References

- [Wiki: ポスト量子暗号](https://ja.wikipedia.org/wiki/%E3%83%9D%E3%82%B9%E3%83%88%E9%87%8F%E5%AD%90%E6%9A%97%E5%8F%B7)
- [量子ハッカーから身を守るため「ポスト量子暗号」への移行タイムラインをイギリスNCSCが策定、2035年までに導入するよう大企業に対し要請](https://gigazine.net/news/20250321-pqc-migration-roadmap/)

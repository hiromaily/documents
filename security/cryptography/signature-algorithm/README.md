# デジタル署名アルゴリズム

WIP

デジタル署名アルゴリズムは、メッセージの信憑性、非改ざん性、および送信者の認証を確保するための技術。デジタル署名は、特にインターネットやその他のデジタル通信において、データの整合性と送り手の確認を保証するために広く使用されている。
デジタル署名アルゴリズムは、メッセージの信憑性を保証し、改ざん防止と送り手の確認を行うための非常に重要な技術。RSA、DSA、ECDSA、EdDSA などの主要なアルゴリズムがあり、それぞれの用途や要件に応じて適切なものが選ばれる。デジタル署名の信頼性を保つためには、秘密鍵の適切な管理、高セキュリティのハッシュ関数の選定、および適切な鍵長の採用が重要。

## 基本概念

1. **署名生成 (Signing)**:

   - 送信者は、自分の秘密鍵を使ってメッセージにデジタル署名を生成する。この署名は、メッセージのハッシュ値と送信者の秘密鍵を組み合わせて生成される。

2. **署名検証 (Verification)**:
   - 受信者は、送信者の公開鍵を使って署名を検証する。検証が成功すると、メッセージが改ざんされていないことと、送信者が正しいことを確認することができる。

## 代表的なデジタル署名アルゴリズム

1. **RSA（Rivest-Shamir-Adleman）**:

   - 最も広く使用されているアルゴリズムの一つ。RSA は、その鍵ペアの生成、署名、検証のために異なる数学的処理を用いている。
   - メッセージを署名する際には、まずハッシュ関数を使ってメッセージのハッシュ値を計算し、そのハッシュ値を秘密鍵を使って暗号化する。この暗号化されたハッシュ値がデジタル署名となる。
   - 署名を検証する際には、公開鍵を使って署名を復号し、元のハッシュ値と比較する。
   - 非対称暗号 (公開鍵暗号)

2. **DSA（Digital Signature Algorithm）**:

   - デジタル署名専用のアルゴリズムとして設計され、アメリカ国立標準技術研究所（NIST）によって標準化された。
   - DSA もまずメッセージのハッシュ値を計算し、その後、複数の数学的操作を通じて署名を生成する。この署名は、検証のために送信者の公開鍵とメッセージのハッシュ値と共に送信される。
   - 非対称暗号 (公開鍵暗号)

3. **ECDSA（Elliptic Curve Digital Signature Algorithm）**:

   - 楕円曲線暗号（ECC）に基づいたデジタル署名アルゴリズム。RSA や DSA に比べて、同等のセキュリティレベルをより短い鍵長で提供する。
   - より効率的で軽量なため、特にモバイルデバイスやリソースが限られている環境で広く使用されている。
   - 非対称暗号 (公開鍵暗号)

4. **EdDSA（Edwards-curve Digital Signature Algorithm）**:
   - より新しい楕円曲線ベースの署名アルゴリズムで、高速かつ安全であることが特徴。
   - 代表的な実装は Ed25519 で、Schnorr 署名の変種を採用している。TLS や SSH などのプロトコルで使用されている。

## デジタル署名の生成プロセス

1. **ハッシュ計算**:
   - メッセージのハッシュ値を計算する。安全なハッシュアルゴリズム（例: SHA-256, SHA-3 など）を使う。
2. **ハッシュ値の署名**:
   - 送信者の秘密鍵を用いて、計算されたハッシュ値の署名を生成する。
3. **メッセージと署名の送信**:
   - オリジナルのメッセージとそのデジタル署名が受信者に送信される。

## デジタル署名の検証プロセス

1. **ハッシュ計算**:
   - 受信したメッセージのハッシュ値を計算する。
2. **署名の検証**:
   - 送信者の公開鍵を用いて署名を復号し、それをオリジナルのメッセージのハッシュ値と比較する。
   - 一致すれば、メッセージが改ざんされていないことと、送信者が正しいことが検証される。

## セキュリティ考慮

1. **秘密鍵の保護**:

   - 秘密鍵が漏洩すると、攻撃者が偽の署名を生成できるため、秘密鍵の厳重な保護が必要。

2. **ハッシュ関数の選択**:

   - セキュリティの高いハッシュ関数を選択する必要がある。弱いハッシュ関数を使用すると、衝突攻撃（複数の異なるメッセージが同じハッシュ値を生成する攻撃）に対する脆弱性が生じる。

3. **キーサイズ**:
   - 使用する鍵のサイズは、予想される攻撃に対する強度を考慮して選択する。RSA の場合、2048 ビット以上の鍵長が推奨される。ECC の場合、256 ビット以上の鍵長が一般的。

## 使用例

1. **デジタル証明書**:
   - Web サイトの SSL/TLS 証明書や、電子メールの S/MIME 証明書などがデジタル署名技術を利用している。
2. **ソフトウェアのコード署名**:
   - ソフトウェアやドライバの信頼性を確保するために、デジタル署名が利用される。これにより、ソフトウェアの発行元の認証と、配布中の改ざん防止が可能となる。
3. **電子取引**:
   - 電子契約や電子政府の文書署名など、公式な文書の認証に利用される。

## まとめ

署名生成と検証の仕組み

## デジタル署名

## ECDSA

ECDSA（Elliptic Curve Digital Signature Algorithm）とは楕円曲線 DSA とも呼ばれ、楕円曲線暗号を使用したデジタル署名アルゴリズム

Bitcoin や Ethereum の文脈では特にトランザクションの署名に使われる

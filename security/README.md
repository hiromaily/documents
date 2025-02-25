# Security

- [Network Security](../infra/security.md)

## Trend

- [2025: SMSを使った二要素認証、Googleが廃止へ--なぜ？ 「実は安全ではない」が業界の常識](https://japan.cnet.com/article/35229750/)
  - GoogleはSMSで認証コードを送付する方式を廃止し、パスキーやQRコードに切り替える方針

## References

- [情報処理推進機構: 安全なウェブサイトの作り方](https://www.ipa.go.jp/security/vuln/websecurity.html)
- [OWASP Top Ten](https://owasp.org/www-project-top-ten/)
- [OWASP Top 10:2021](https://owasp.org/Top10/)
  - [github](https://github.com/OWASP/Top10)
- [ハッキング API ―Web API を攻撃から守るためのテスト技法](https://blog.tokumaru.org/2023/03/hacking-api-review.html)

## [Web Application Security, 2nd Edition](https://www.oreilly.com/library/view/web-application-security/9781098143923/)

1. Secure Application Configuration

   - Content Security Policy
     - Implementing CSP
     - CSP Structure
     - Important Directives
     - CSP Sources and Source Lists
     - Strict CSP
     - Example Secure CSP Policy
   - Cross-Origin Resource Sharing
     - Types of CORS Requests
     - Simple CORS Requests
     - Preflighted CORS Requests
     - Implementing CORS
   - Headers
     - Strict Transport Security
     - Cross-Origin-Opener
     - Cross-Origin-Resource-Policy
     - Headers with Security Implications
     - Legacy Security Headers
   - Cookies
     - Creating and Securing Cookies
     - Testing Cookies
   - Framing and Sandboxing
     - Traditional Iframe
     - Web Workers
     - Subresource Integrity
     - Shadow Realms

2. Threat Modeling Applications

   - Designing an Effective Threat Model
   - Threat Modeling by Example
     - Logic Design
     - Technical Design
     - Threat Identification (Threat Actors)
     - Threat Identification (Attack Vectors)
     - Identifying Mitigations
     - Delta Identification

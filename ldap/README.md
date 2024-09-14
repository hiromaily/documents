# LDAP

LDAP（`Lightweight Directory Access Protocol`）は、`ディレクトリサービスにアクセスするためのプロトコル`で、`ユーザー認証`や`情報の検索`などに利用される。LDAP は、軽量かつ効率的なアクセス手段を提供し、特にエンタープライズ環境において ID 管理や認証のために広く利用されている。

LDAP は広く利用されているプロトコルで、ディレクトリサービスにアクセスおよび管理するための強力な手段を提供する。ユーザー認証、リソース管理、組織のディレクトリ構造の管理など、さまざまな用途に対応する。エンタープライズ環境での ID 管理や認証の基盤として非常に重要な役割を果たし、高いスケーラビリティと柔軟性を持つ。

## 概要

- **ディレクトリサービス**:

  - LDAP はディレクトリサービスにアクセスするためのプロトコル。ディレクトリサービスは Tree 構造を持つ`データストア`で、ユーザー、グループ、デバイス、コンピュータ、ネットワークリソースなどの情報を保存する。

- **プロトコルの特徴**:
  - プロトコル: TCP/IP 上で動作し、標準ポートは 389（LDAPS は 636）
  - データ形式: LDAP エントリは属性と値のペアから構成され、ディレクトリ情報ツリー（DIT）として組織される。
  - 照会と操作: クエリ、変更、追加、削除などの操作が可能。

## 基本的なコンポーネント

1. **エントリ（Entry）**:

   - ディレクトリの基本単位で、一つのエントリは一つのオブジェクトを表す。エントリには DN（Distinguished Name）が割り当てられ、この DN がエントリの一意の識別子となる。

2. **ディスティングイッシュドネーム（DN）**:

   - エントリの一意の識別子で、ディレクトリツリーにおけるエントリのパスを示す。例：`uid=jdoe,ou=users,dc=example,dc=com`

3. **属性（Attributes）**:

   - エントリはいくつかの属性で構成される。各属性は名前（例：`cn`）と値（例：`John Doe`）のペア。

4. **スキーマ（Schema）**:
   - ディレクトリ内で使用される属性とエントリのタイプ、およびその構造を定義する。これにより、一貫したデータの管理が可能になる。

## 主な LDAP 操作

1. **バインド（Bind）**:

   - クライアントがディレクトリサーバーに接続し、認証を行う操作。`Simple Bind`（ユーザー名とパスワードを使用）や`SASL Bind`（高度な認証方法）がある。

2. **検索（Search）**:

   - ディレクトリツリーを検索し、特定の条件に一致するエントリを取得する。例：特定の部署の全ユーザーを検索。

3. **追加（Add）**:

   - 新しいエントリをディレクトリに追加する。

4. **削除（Delete）**:

   - エントリをディレクトリから削除する。

5. **変更（Modify）**:

   - 既存のエントリを変更する。特定の属性の追加、削除、変更が可能。

6. **比較（Compare）**:
   - 特定のエントリの属性が与えられた値と一致するかどうかを確認する。

## LDAP のデプロイメント

エンタープライズ環境では、LDAP は ID 管理の中核的な役割を果たす。以下にいくつかの代表的な LDAP デプロイメントの例を示す。

### OpenLDAP

- **概要**:
  - OpenLDAP は、オープンソースのディレクトリサービスで、LDAP プロトコルを実装している。広く利用されており、コミュニティによるサポートも充実している。
- **インストール**:

  ```sh
  sudo apt-get update
  sudo apt-get install slapd ldap-utils
  ```

- **設定**:
  インストール後、`/etc/ldap/ldap.conf`ファイルを編集して基本設定を行う。
- **スキーマの設定**:
  標準スキーマを利用するか、カスタムスキーマを設定。

### Microsoft Active Directory

- **概要**:

  - Active Directory は Microsoft のディレクトリサービスで、LDAP を利用してユーザー認証とリソース管理を行う。多くの企業で利用されており、Windows 環境に最適化されている。

- **機能**:

  - グループポリシー、認証、アクセス制御、証明書管理など、豊富な機能を提供する。

- **統合**:
  - 他の LDAP 対応システムと統合することも可能。

### Apache Directory

- **概要**:

  - Apache Directory Server（ApacheDS）は、フル機能の LDAPv3 ディレクトリサーバーで、Apache Software Foundation が開発している。GUI 管理ツールの Apache Directory Studio も提供されている。

- **インストール**:

  ```h
  sudo apt-get install apacheds
  ```

## セキュリティ

LDAP のセキュリティには特に注意が必要で、以下の点に留意すること：

1. **LDAPS の使用**:

   - 通信の暗号化（TLS/SSL）を使用して、データの盗聴や改竄を防止。

2. **アクセス制御**:

   - 適切なアクセス制御リスト（ACL）を設定し、ユーザーやアプリケーションのアクセス権を制限。

3. **強力な認証**:

   - セキュアな認証方法（例：SASL、Kerberos）の使用。

4. **ログ監視**:
   - ディレクトリサーバーのログを定期的に監視し、不正アクセスや異常を検知。

## Python を使用して LDAP と通信する簡単なスクリプトの例

### Python LDAP クライアント

```python
import ldap

# LDAPサーバーに接続
ldap_server = "ldap://localhost"
conn = ldap.initialize(ldap_server)

# シンプルバインド
user_dn = "cn=admin,dc=example,dc=com"
password = "password"
conn.simple_bind_s(user_dn, password)

# 検索の実行
base_dn = "dc=example,dc=com"
search_filter = "(uid=jdoe)"
result = conn.search_s(base_dn, ldap.SCOPE_SUBTREE, search_filter)

for dn, entry in result:
    print('DN:', dn)
    for attr, values in entry.items():
        print('Attribute:', attr)
        for value in values:
            print('Value:', value)
```

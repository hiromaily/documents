# Nix

Nixは、主に開発者にとって非常に便利なパッケージマネージャーとビルドシステム。その魅力的な特徴は、宣言的な設定と再現性のあるビルドプロセスにある。このツールは、依存関係の管理や、複雑なソフトウェア環境を一貫して再現するために利用される。

## 主な構成要素

1. **Nix（パッケージマネージャー）**: Nixは、パッケージのビルドとインストールを再現性の高い方法で行うことができるパッケージマネージャー。ビルドプロセスやパッケージの依存関係をNix言語で宣言的に記述する。

2. **Nixpkgs（パッケージコレクション）**: Nixpkgsは、Nixで使用できる大規模なパッケージコレクションです。オープンソースコミュニティによって継続的にメンテナンスされている。

3. **NixOS（Linuxディストリビューション）**: NixOSは、Nixパッケージマネージャーを標準として利用するLinuxディストリビューション。システム全体の設定やパッケージ管理も宣言的に記述されるため、非常に安定して運用することができる。

4. **nix.dev**: これはNixの利用をサポートするための情報サイトやドキュメントを提供するリソース。Nixの使い方やベストプラクティスについての情報が載っている。

## Nixの利点

- **再現性**: 環境全体を宣言的に記述するため、同じ設定ファイルで毎回同じ環境を再現可能。
- **原子性とロールバック**: 変更は原子的に適用されるため、インストール途中での障害の影響を防ぎ、簡単に以前の状態にロールバックすることができる。
- **依存関係の分離**: 異なるプロジェクト間で依存関係を完全に分離することができるため、コンフリクトが発生しにくい。

## 対象となるパッケージ

Nixパッケージマネージャーは、以下のような多様な種類のソフトウェアパッケージを管理することができる

1. **プログラミング言語とその関連ツール**: コンパイラ、インタプリタ、パッケージマネージャーなど（例えば、Python、Node.js、Rust、Haskell、GCCなど）。

2. **開発ツール**: IDE、コードエディタ、ビルドツール（Visual Studio Code、JetBrains製品、Make、CMakeなど）。

3. **データベース**: MySQL、PostgreSQL、SQLiteなどのデータベース管理システム。

4. **ウェブサーバ・アプリケーションサーバ**: Apache、Nginx、Tomcatなど。

5. **ライブラリ**: 各種プログラミング言語やフレームワークのためのライブラリ（Boost、OpenSSL、NumPyなど）。

6. **システムツールとユーティリティ**: システム管理やメンテナンスのためのツール（日常的に使用されるtar、grep、htopなど）。

7. **デスクトップアプリケーション**: ウェブブラウザ、オフィスソフトウェア、メディアプレーヤー（Firefox、LibreOffice、VLCなど）。

8. **コンテナおよび仮想化**: Docker、QEMU、VirtualBoxなど。

## パッケージの宣言と管理

Nixでは、各パッケージは```.nix```ファイルで宣言的に管理されry。このファイルには、パッケージのソースや依存関係、ビルド手順が記述されており、自動的に再現可能な方法でビルドおよびインストールされる。

## パッケージコレクション

Nixpkgsというリポジトリには、数千以上のパッケージが収録されている。これを利用することで、既に準備された多くのソフトウェアを簡単にインストールすることが可能。また、ユーザー自身が自身のプロジェクトに必要なパッケージをカスタマイズし、追加することもできる。

## 管理方法

通常のパッケージマネージャー（例えば、aptやyum）のように、```nix-env```というコマンドを使ってパッケージをインストール、アップグレード、削除できる。また、Nixの独自機能として、異なるバージョンのパッケージを同時にインストールすることも可能。

```sh
# パッケージのインストール
nix-env -i <パッケージ名>

# パッケージのアップグレード
nix-env -u <パッケージ名>

# インストール済みパッケージのリスト
nix-env -q
```

## Nixのユニークポイント

Nixの特に強力な機能は再現性。すべての依存関係とそのバージョンが厳密に管理されるため、同じ.nixファイルを使えば、どのシステムでも同じ環境が再現可能。この特徴はCI/CDパイプラインや開発・本番環境の一貫性確保に大きく寄与する。

## References

- [開発マシンの環境セットアップをAnsibleからNixに移行した](https://blog.handlena.me/entry/2025/02/migrate-from-ansible-to-nix/)

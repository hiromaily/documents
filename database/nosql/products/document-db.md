# DocumentDB

Microsoft は 2025 年 1 月 23 日、PostgreSQL をベースとした NoSQL データベース実装「DocumentDB」をオープンソースとして公開した。

## DocumentDB の特徴

1. PostgreSQL エンジンをベースにした NoSQL データベース実装
2. BSON(Binary JSON)形式のデータを扱う「pg_documentdb_core」と、API を提供する「pg_documentdb」の 2 つの主要コンポーネントで構成
3. MIT ライセンスで提供され、開発者は制限なく新しいソリューションに組み込むことが可能
4. CRUD オペレーション、クエリ機能、インデックス管理などの機能を実装
5. SCRAM 認証メカニズムをサポート

## DocumentDB の公開目的と特徴

1. NoSQL の標準策定を目指す
2. NoSQL エンジン間の互換性と相互運用性を高める
3. 開発者のデータベース移行や導入を容易にする

## 利点

1. NoSQL の柔軟性とリレーショナルデータベースの永続性、低レイテンシーの両方を備える
2. グローバル・ディストリビューションを前提に構築されており、リージョンをまたいだ利用が可能
3. 高速な読み込みと書き込みのパフォーマンスを実現
4. 開発者が CAP(Consistency, Availability, Partition-tolerance)のどれを優先するかを選択可能
5. SQL や MongoDB と同じアクセス方法、JavaScript など、さまざまなデータアクセス方法をサポート

DocumentDB は、IoT アプリケーションやグローバルレベルで利用するアプリケーションに特に適している。Microsoft が独自に開発したエンジンとランタイムを持ちながら、MongoDB のオープンなプロトコルもサポートしているため、既存の MongoDB アプリケーションとの互換性も確保されている。

## References

- [Microsoft、PostgreSQL をベースとする NoSQL「DocumentDB」をオープンソースで公開　アーキテクチャと特徴とは](https://atmarkit.itmedia.co.jp/ait/articles/2502/12/news040.html)

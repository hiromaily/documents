# Schema Driven Development

- Schema Driven Development(SDD)は日本語ではスキーマ駆動開発と呼ばれ、Schema First Development としても定義されている。チームにおける Web API 開発フローを改善する開発手法の一つ
- Web API 開発における必要なこと
  - I/F の仕様書を作成
  - API レスポンスの test
  - => これらはバックエンドチームとフロントエンド/アプリチームとの間で発生する
- 典型的な Web API 開発フローの問題は以下の通り
  - 両方のチームが新しいエンドポイントに同意する
  - バックエンドチームは、エンドポイントを実装
  - 実装の前後で、バックエンドチームは新しい API に関するドキュメントを作成
  - フロントエンド/アプリチームは、開発と新しいエンドポイントの使用を開始
  - フロントエンド/アプリチームは問題にぶつかり始め、API の変更に関する提案する
  - 多少の混乱の後、バックエンドチームはエンドポイントを変更する
  - => つまり、コミュニケーションが重要
- スキーマ駆動開発の場合、何より先にスキーマを定義する必要がある
- swagger であれば、定義と同時にドキュメントもできあがる
- バックエンドは開発をしつつ、フロント/アプリチームはドキュメントを元に開発をすすめる

## References

- [Schema-driven development in 2021](https://en.99designs.jp/blog/engineering/schema-driven-development/)
- [SDD — Schema Driven Development](https://medium.com/@hintology/sdd-schema-driven-development-f1d232d73ea6)
- [LayerX インボイスの技術スタック〜分野横断で開発するための Schema Driven Development〜](https://tech.layerx.co.jp/entry/2021/04/06/090000)
- [チームの Web API 開発を最適化する Schema Driven Development の解説＆実装例](https://qiita.com/Seiga/items/a59c800e57e022125e3b)

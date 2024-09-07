# Frontend Architecture

## Architecture

- Model-View-Controller (MVC)
  - データを表現する`Model`、データをユーザーに見せる`View`、ユーザーの入力を処理し、`Model`と`View`間のデータの流れを管理する`Controller`の3つのコンポーネントにアプリケーションを分離する、確立されたアーキテクチャ
- Single-page Application（SPA）
  - SPAは、Webアプリケーションに必要なすべてのコードとデータを前もって読み込み、ユーザーが操作するたびにページの必要な部分のみを更新することで、より応答性の高い、流動的なユーザー体験を提供するように設計されている。
- Micro-Frontends
  - Front-end Applicationをより小さく、独立して展開可能なコンポーネントに分解し、異なるチームで開発・保守できるようにする、比較的新しいアーキテクチャ・パターン
- [Flux](./flux.md)
  - FluxはReactと組み合わせて使われるアプリケーション・アーキテクチャで、コンポーネント間のデータとアクションの一方向の流れを重視するもの
- Component-based architecture
  - Applicationを再利用可能な小さなコンポーネントに分解し、それらを組み合わせて複雑なユーザーインターフェイスを作成するアーキテクチャ
- Elm architecture
  - Elmアーキテクチャは[Elm言語](https://elm-lang.org/)で開発されたアーキテクチャパターンで、Model-View-Update（MVU）というパターンで構成され、コードの再利用性・テストのしやすさに優れた設計パターンとされる。

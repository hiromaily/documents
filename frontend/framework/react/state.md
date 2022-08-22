# State

- [Reactにおける状態管理の動向を追ってみた](https://zenn.dev/yuki_tu/articles/a7b0a1a90c09f4)
- [React ステート管理 比較考察](https://blog.uhy.ooo/entry/2021-07-24/react-state-management/)

- クライアント側に状態を持たせないように設計すべき

- APIで取得した値はすべてキャッシュで管理
- 認証情報などページをまたぐ必要のあるもの、継続してユーザーに知らせ続けるものはグローバルに状態を管理できるライブライを利用
- 見た目の制御もローカルな状態管理である`useState`, `useRef`などもなるべく利用しない

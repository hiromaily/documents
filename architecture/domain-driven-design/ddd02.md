# 実践ドメイン駆動設計から学ぶ DDD の実装入門

DDD はソフトウェア開発手法の１つで、顧客と開発者が業務を戦略的に理解し、共通の言葉を使いながらシステムを発展させる手法。チームの共通言語である`ユビキタス言語`を用いて`ドメインモデル`を構築し、それをコードとして実装する。大規模で密結合なシステムにならないように`ドメイン`と`境界づけられたコンテキスト`でシステムを分割し、`コアドメイン`という最重要領域に集中して開発を行う

`戦略的設計`: チームで使うパターンのことで、ビジネスにおける言語に価値を置き、業務に関わる人の考え方をドメインモデルとして表現する  
`戦術的設計`: テクニカルなパターンのことで、アーキテクチャ、DDD 固有のパターンといった技術的内容が含まれる。

`戦略的設計`を実施せず、エンジニアが取り組みやすい`戦術的設計`にだけ注力すると、`軽量DDD`とよばれる事業価値を発揮できない貧弱な DDD になってしまう

## 1. DDD への誘い ~ドメイン駆動設計のメリットと始め方~

- `ドメインエキスパート`とは、担当業務やシステムについて一番詳しい人を指す。そのため、顧客に限らず、プロマネ、SE やプログラマの可能性もある。
- 単純なマスタメンテナンスや 30 程度のユースケースフローでは DDD を導入するコストのほうが高く付く。
  - 将来的に複雑に成長していくことがわかっているシステムにメリットがある
- DDD の 3 原則
  - コアドメインに集中すること
  - ドメインの実践者とソフトウェアの実践者による創造的な共同作業を通じて、モデルを探求すること
  - 明示的な境界づけられたコンテキストの内部でユビキタス言語を語ること

## 2. ドメイン、サブドメイン、境界づけられたコンテキスト ~DDD で取り組む領域~

- 1 つのコアドメインもしくはサブドメインに 1 つの境界づけられたコンテキストが対応している状態が最適だとされている
- 例えば`アカウント`という言葉は、会計システムや営業管理システムで意味が変わってくる
- つまり言葉が 2 つ以上の意味を持たないように`境界づけられたコンテキスト`が存在する
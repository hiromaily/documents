# SQL Anti パターン

## DB のユニークキー

プライマリキーを UUID にすると新しいデータがインデックス内にランダムに分散されるため、大規模なデータセットから最新のデータを取得したい場合に多数のデータベースインデックスページを走査しなくてはならず、キャッシュヒット率が低下してしまう

- [UUID なのにデータベースのプライマリキーに設定してもパフォーマンスの問題を起こさない「UUIDv7」の標準化作業が進行中](https://gigazine.net/news/20231023-uuid-v7/)
- [Goodbye integers. Hello UUIDv7!](https://buildkite.com/blog/goodbye-integers-hello-uuids)

- [PostgreSQL のプライマリーキーは SERIAL と UUID のどっちが速いのか実験してみた](https://qiita.com/jnchito/items/3ea13928d6aeb732bae2)
  - INSERT においては差はないが、SELECT で顕著なパフォーマンスの差が出る

### [データベースでユニークキーに UUID を使うメリットは何ですか？](https://jp.quora.com/%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9%E3%81%A7%E3%83%A6%E3%83%8B%E3%83%BC%E3%82%AF%E3%82%AD%E3%83%BC%E3%81%ABUUID%E3%82%92%E4%BD%BF%E3%81%86%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88%E3%81%AF%E4%BD%95)

- `プライマリキーには原則としてデータベース側で発行される自動インクリメントの連番を使っておくのが間違いない`
- UUID を使いたくなる理由
  - 大規模な分散システムを設計していて SPOF が許されない
  - ID を乱数化してユーザーから類推しにくくする
- プライマリキーを UUID にする莫大なコストには全く見合わない
  - プライマリキーは連番のままにしておき、`public_id`という別カラムを用意してそこに乱数ベースのデータを入れてユニーク制約をかけておく
- ユーザーに見える UI に出てくる ID は常に乱数ベースの public_id を使い、内部での処理にはすべて連番の ID を使う

## サーティワンフレーバー

enum などによって、限定する値を列定義で指定するアンチパターン

### 問題点と解決方法

- enum のメリット

  - テーブルの join や select の回数が減る

- 問題点
  - enum に設定してある値の一覧を取得する方法が特殊な方法になってしまう
  - 候補の変更が ALTER 文によって列を変更しなくてはいけない
  - 他の DB へ migrate する場合の互換性
  - すでに使われている値の修正が大変
  - 扱う値が将来的にも不変ならよいが、将来的に変更しうる場合には破綻する
- 解法
  - 将来的に変更しうる場合は、参照テーブルを追加し、外部キー制約で限定する

### References

- [SQL アンチパターン感想その二ー ENUM 型を扱う](https://zenn.dev/convers39/articles/0e58e17d0da43f)
- [【MySQL】enum の是非について](https://note.com/standenglish/n/n552052cf4199)
- [ある選択肢のみ許容する column を定義する際の方針](https://scrapbox.io/mrsekut-p/%E3%81%82%E3%82%8B%E9%81%B8%E6%8A%9E%E8%82%A2%E3%81%AE%E3%81%BF%E8%A8%B1%E5%AE%B9%E3%81%99%E3%82%8Bcolumn%E3%82%92%E5%AE%9A%E7%BE%A9%E3%81%99%E3%82%8B%E9%9A%9B%E3%81%AE%E6%96%B9%E9%87%9D)
- [【アンチパターン】データベース物理設計](https://zenn.dev/tanakanata7190/books/55d484e6dc8b09/viewer/6d111a)

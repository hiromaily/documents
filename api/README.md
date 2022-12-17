# API

## 参考
- [REST API設計のパターンと原則](https://note.com/skijima/n/n8c3b18f93c80)
- [API Testing Tools & Approaches to know in 2022](https://aglowiditsolutions.com/blog/api-testing-tools/)
- [Google: RESTful のウェブ API 設計で避けるべき 6 つのよくあるミス](https://cloud.google.com/blog/ja/products/api-management/restful-web-api-design-best-practices/?hl=ja)
## 設計ガイドライン
- [Microsoft REST API Guidelines](https://github.com/microsoft/api-guidelines)
- [Google API design guide](https://cloud.google.com/apis/design)
- [Salesforce APIs](https://developer.salesforce.com/docs/apis)

## [RESTful のウェブ API 設計で避けるべき 6 つのよくあるミス](https://cloud.google.com/blog/ja/products/api-management/restful-web-api-design-best-practices/?hl=ja)

### 1 インサイドアウトで考えるか？アウトサイドインで考えるか？
- 自身の業務をより簡単にし、生産性を上げるようなAPIを構築するためには、そのニーズに合わせてAPIを構築する必要がある
- インサイドアウトではなく、`アウトサイドイン`の考え方が大事
- `インサイドアウト`: 公開する内部システムやサービスに基づいて API を設計すること
- `アウトサイドイン`: 作り上げたいカスタマー エクスペリエンスに基づいて API を設計すること
  - [The API Product Mindset (en)](https://cloud.google.com/files/apigee/apigee-api-product-mindset-ebook.pdf)
- 最初のステップは、ユースケースを知ること
  - 構築しているアプリや課題、どんなものが開発の合理化や簡易化に役立つかを尋ねる
  - 最も重要なユースケースを書き留め、それぞれのケースに必要なデータのみを提供するサンプル API レスポンスを作成する
  - このテストでは、ペイロード間の重複を探し、共通または類似のユースケースで汎用化するように設計を適合させる
  - end-userと直接やり取りできない場合、最善のアプローチは、API を使って何を構築するかを想像してみること
  - 全体像を描いておくことで、将来的に互換性を損なわない変更を簡単に構築できる
![inside-out / outside-in](https://github.com/hiromaily/documents/raw/main/images/1_RESTful_inside_out.jpg "inside-out / outside-in")

### 2 ユーザーにとって複雑すぎる API を作っている
- ユーザーがAPI を利用する目的は、複雑なプログラミングの課題を回避し、得意な分野に注力できるようにすること
- ユーザーのニーズを満たすだけの機能性を有し、複雑な処理を隠蔽したシンプルな API を提供できるかどうか
- API 設計がシンプルであるか確かめるには、システム全体をゼロから構築していると想定してみる

### 3 呼び出しが多すぎる「手間のかかる」API を作成している
- 複数のネットワーク呼び出しは、処理を遅くし接続のオーバーヘッドを増加させるため、API 呼び出しの数を最小限に抑える必要がある
- そのために重要なのは、アウトサイドインの設計、つまり、シンプルにすること
- たとえば、モバイル アプリケーションを構築しているお客様は、バッテリーの消耗を抑えるために、ネットワーク トラフィックを最小限にする必要がある
- 個別のデータドリブンのマイクロサービスの構築か、API 利用の効率化か、どちらかだけを選択するのではなく、両方を提供することを検討してみる
- つまり、特定のデータタイプ用のきめ細かい API と、共通またはユーザー固有のユーザー インターフェースの周辺の `Experience API` , UXを強化するために設計された API
  - [理論的ディスカッション](https://www.googlecloudcommunity.com/gc/Apigee/What-is-an-Experience-API-When-should-you-make-one-Isn-t-it/td-p/21080
  - こうした `Experience API` は、複数の小さなドメインを 1 つのエンドポイントにまとめ、UI構築者が、画面を簡単かつ迅速にレンダリングできるようにする
- もう一つのオプションは、`GraphQL` などを利用して、こうしたカスタマイズを可能にすること

### 4 柔軟性に欠けている
- 上述のステップをすべて行ったとしても、美しく設計されたペイロードの下に収まりきらないエッジケースがある
- たとえば、ユーザーが 1 ページあたりの検索結果に通常よりも多くのデータを求めているかもしれないし、アプリで必要なものよりはるかに多いデータがペイロードに含まれているかもしれない
- 万能のソリューションを作るのは不可能だが、制限だらけの APIというものも避ける必要がある。そこで、エンドポイントをより柔軟にするための 3 つの簡単なオプションが以下となる
  - レスポンス プロパティを除外する: 
    - 並び替えやページネーションにクエリ パラメータを使用するか、これらのタイプの詳細をネイティブで提供する `GraphQL` を使用できる
    - 必要なプロパティだけをリクエストできるようにする
    - `GET /books?fields=title,author,ranking`
  - ページネーションによるソート機能:
    - API レスポンスにおけるオブジェクトの順序を保証したい場合、例えば特定の項目で並び替えたい場合、ページネーションのオプションを組み合わせれば、上位の検索結果のみが必要な場合に、非常に効率的な API を提供できる
    - Spotify APIのsample
    - `GET /v1/artists/xxxxx/albums?album_type=SINGLE&offset=20&limit=10`
  - GraphQL のような成熟したコンポジションを使用する:
    - ユーザーデータのニーズはそれぞれ違うので、on the flyのコンポジットを提供することにより、単一のデータ型やデータ フィールドのプリセットの組み合わせに制限されるのではなく、必要なデータの組み合わせに合わせて構築できる
    - GraphQL を使用すれば、Experence API を構築する必要性を回避することもできますが、それも不可能な場合は、`expand`などのクエリ文字列パラメータ オプションを使用して、より複雑なクエリを作成できる
    - 以下は、プロパティを組み込んだ企業リソースのコレクションを示すレスポンス例
```
"data": [
   {
     "CompanyUid": "27e9cf71-fca4",
     "name": "ABCCo",
     "status": "Active",
     "_embedded": {
       "organization": {
         "CompanyUid": "27e9cf71-fca4",
         "name": "ABCCo",
         "type": "Company",
         "taxId": "0123",
         "city": "Portland",
         "notes": ""
       }
     }
   }
]
```

### 5 人間には読めない設計になっている
- API を設計する際の鉄則は、`とにかくシンプルに`
- API コントラクトが最初のドキュメントになるため、開発者は、ドキュメントを掘り下げる前にペイロード設計を研究する傾向がある
- 調査結果によると、開発者がエディタとクライアントで費やす時間は 51% 以上であるのに対し、リファレンスに費やす時間は多くとも 18% 程度
- `id`という名前は直感的にわかりにくく、ペイロードに数バイト追加するだけで、初期段階での混乱を回避し、API の導入を促進できる

### 6 RESTful のルールを破るタイミングを知る
- 正しい HTTP method、State Code、ステートレス リソースをベースにしたインターフェースの使用など、RESTful の基本に忠実であることが望ましいとはいえ、本来の目的は、ユーザーの業務遂行を支援することなので UXよりも RESTful の設計を優先させると、本来の目的を果たせなくなる
- ユーザーができるだけ早く、簡単に、データを使って成功する支援をすることが目標
- ときには、よりシンプルでエレガントなインターフェースを提供するため、REST の「ルール」を破る必要があるかもしれない
- この場合、特殊な部分や非標準的な部分については、ドキュメントで明確に説明する必要がある

## Rest APIのTestについて
### 種類
- 機能テスト
  - Positive/Negative Testing
- Integrationテスト
  - Reliability Testing
  - Integration Testing
- パフォーマンステスト
  - Soak Testing
  - Load Testing
  - Peak Testing
  - Scalability Testing
  - Spike Testing
  - Stress Testing
- セキュリティーテスト
  - Authentication Testing
  - Fuzz Testing
  - Penetration Testing

## API Tools for CI
- [API testing toolについて調べてみる](https://zenn.dev/katzumi/scraps/4fe5976c0753d5)

### 個人的なニーズは以下
- OpenAPIと連携しているTestツールがあるが、そもそもOpenAPIのデザインが想定と違っているケースも存在するため、Testシナリオは必ずしもOpenAPIに準拠しなくてもよい
- Open sourceで、簡単にInstallできるもの。Node, Python, Java製は避けたい
- ぶっちゃけ、httpie,jqを使ってShell ScriptでTest書くのが最強な気がする。
  - [Httpie Command-line API testing tricks](https://httpie.io/blog/cli-api-tricks)

### Tools
- [Hurl](https://hurl.dev/)
  - [Github](https://github.com/Orange-OpenSource/hurl)
  - Star: 3.2k
  - Rust
  - Docsも充実していて本命感がある
- [zoncoen/scenarigo](https://github.com/zoncoen/scenarigo)
  - Star: 177
  - Golang
  - 頻繁に更新されている
  - YAMLにシナリオを書いて実行できる
  - メルカリでも利用しているらしい
  - [scenarigoでE2Eを実装](https://www.wheatandcat.me/entry/2021/10/31/121549)
- [k1LoW/runn](https://github.com/k1LoW/runn)
  - Star: 89
  - Golang
  - 頻繁に更新されている
  - YAMLにシナリオを書いて実行できる
- [keploy](https://github.com/keploy/keploy)
  - Testing for Developers. Toolkit that creates test-cases and data mocks from API calls, DB queries, etc.
  - Star: 1.1k
  - Golang
  - 頻繁に更新されている
- [taverntesting/tavern](https://github.com/taverntesting/tavern)
  - A command-line tool and Python library and Pytest plugin for automated testing of RESTful APIs, with a simple, concise and flexible YAML-based syntax
  - Star: 898
  - Python
  - 頻繁に更新されている
  - YAMLにシナリオを書いて実行できる
- [restcli/restcli](https://github.com/restcli/restcli)
  - Star: 249
  - Kotlin
  - 2021/12でReleaseが止まっている
  - JetBrain依存か？

### Not Free??
- [Postman + Newman](https://learning.postman.com/docs/running-collections/using-newman-cli/command-line-integration-with-newman/)
  - [PostmanとNewmanを組み合わせて、CI/CDに組み込むREST APIの自動テストを作ろう！](https://qiita.com/developer-kikikaikai/items/74cedc67643ca93d2e0b)
- [Katalon](https://katalon.com/)
- [TestGrid](https://www.testgrid.io/)
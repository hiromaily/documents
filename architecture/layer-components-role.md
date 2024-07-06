# Layer components の役割

一般的な MVC パターンが Clean Architecture ではどのように変換されるのか

```txt
// 構造体例
[Service] Instance
    |- [Usecase] as Interface
           |- [Repository] as Interface
```

- Web 開発において、一番外側の Framework こそ pluggable な設計にすべき、Framework の変更によって多くのロジックに修正が必要になるべきではない
- Framework 依存の処理
  - main における、server 初期化処理
  - router の設定
  - handler (framework によって利用されるパラメータが異なるため)
- handler より先は Framework 依存にはならない

  - つまり Usecase の I/F は Framework 依存にはならない

- Repository
  - DB の実装をもったり、In memory の実装を持ったり抽象化されるべきレイヤー
- Service
  - 必要な Usecase を持つ
- Controller
  - handler にあたるが、Framework に依存しない I/F を持つ Usecase に合わせた入力値の変換処理が含まれる
  - また framework に適した出力の責務も持つ
  - 以上のことから Controller もまた Framework 依存のレイヤーとなる
- Data レイヤー
  - DTO (DataAccessObject)
    - 外部から取得したデータをそのまま保持しておくためのオブジェクトで、repository の実装によって異なる
  - Model
    - repository を扱う Usecase 層が使うための、repository の実装に依存しない共通 object にあたる
  - DAO (DataTransferObjec)
    - Model をアプリケーションのレスポンスとして返す際に扱いやすい形に詰め替えたオブジェクトのなるため、Framework 依存となる

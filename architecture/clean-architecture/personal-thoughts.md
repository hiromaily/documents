# Clean Architectureについて考察

- Clean Architecture の中核は`Entities (Domain)`層ではあるが、`Application Business Rules (Use Cases)`層を中心に各レイヤーとの関係を俯瞰したほうがわかりやすい
- そのため、`Application Business Rules (Use Cases)`層のオブジェクトの構造と依存関係の構築手法が重要であると考える
- `Application Business Rules (Use Cases)`層の構造体がもつメンバーはそれぞれが`Interface Adapter`の抽象に依存するが、`Interface Adapter`層の不要な`Device`層(logger やクラウドサービスへのエンドポイント)に直接依存するケースもあり得る
- `Application Business Rules (Use Cases)`層構築については`関心の分離`の観点から`システムを使うこと`と、`構築すること`を分離する
- 依存関係は `DI(Dependency injection)` によって、環境変数や Config ファイルの値から適切なコンポーネント切り替える。
- Web フレームワークへの依存をいかに plugable にするか？という点については、可読性を優先するという観点でその必要性がないシステム（もしくはトレードオフ）もあるように思う。
  - この場合、Handler の各エンドポイントをユースケースとして見立てることになる。
- 例えば、Database の場合、使用する Database のデータを変換するための専用の Adapter が存在するケースがほとんど
- `Interface Adapter`と`Framework/Device`の間に Interface は不要なケースも存在するが、Interface が存在しないと`依存性のルール`を満たすことができない。これを満たすためだけに対となる`Interface Adapter`と`Framework/Device`の間に Interface を用意するのは不毛と感じる。
- 周りを見ていると Clean Architecture を難しく考えすぎる節があるが、そこに DDD(domain-driven design)の思想を持ち込むが故に思える。Clean Architecture をシンプルに考えるとレイヤー構造と、具象ではなく抽象への依存が重要な要素であり、それに付随して依存の方向性と、抽象への依存の先にある具象とそれをユースケースに渡す Adapter Interface 層の責務の分担を抑えればよい。
- 抽象への依存の目的は plugable なコンポーネントによる変更の容易性であり、それを実現するためのオブジェクト生成のコードが重要になる。デザインパターンにおける Creational Patterns や DI との相性がいい

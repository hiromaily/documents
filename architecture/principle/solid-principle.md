# SOLID principle

## References

- [SOLID: The First 5 Principles of Object Oriented Design](https://www.digitalocean.com/community/conceptual_articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design)
- [The S.O.L.I.D Principles in Pictures](https://medium.com/backticks-tildes/the-s-o-l-i-d-principles-in-pictures-b34ce2f1e898)
- [SOLID principle in GO](https://medium.com/@s8sg/solid-principle-in-go-e1a624290346)
- [SOLID Go Design](https://dave.cheney.net/2016/08/20/solid-go-design)
- [SOLID 原則について簡単に書く](https://qiita.com/yui_mop/items/93fef037a787318e7067)
- [単一責任の原則（Single responsibility principle）について、もう一度考える](https://www.ogis-ri.co.jp/otc/hiroba/others/OOcolumn/single-responsibility-principle.html)

## SOLID 原則

1. Single Responsibility Principle (単一責任の原則)
   - Class を変更する理由は 1 つでなければならない
2. Open/Closed Principle (オープン/クローズドの原則)
   - Class は拡張に対して開かれて、修正に対して閉じられていなければならない
3. Liskov Substitution Principle (リスコフの置換原則)
   - 派生型は基本型と置換可能でなければならない
4. Interface Segregation Principle (インターフェース分離の原則)
   - クライアントが利用しないメソッドへの依存を強制してはならない
5. Dependency Inversion Principle (依存性逆転の原則)
   - 上位のモジュールは下位のモジュールに依存してはならない。どちらのモジュールも「抽象」に依存すべきである

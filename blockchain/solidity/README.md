# Solidity

## References

- [Solidity docs](https://docs.soliditylang.org/)
- [Solidity 日本語](https://solidity-ja.readthedocs.io/ja/latest/)
- [Solidity 日本語(古い)](https://solidity-jp.readthedocs.io/ja/latest/)

## 書籍まとめ

### Solidity と Ethereum による実践スマートコントラクト開発

- [book](https://www.oreilly.co.jp/books/9784873119342/)

- private の状態変数や、パラメータの名前の先頭に`_`をつけるのが一般的なプラクティス
  うべき
- mapping の for ループを使って key と value を抽出する機能は存在しない

- function では複数の戻り値を定義できる。この時、タプルが使われる。呼び出した test コードは配列として値に index でアクセスできる。以下のやり方でも可能。

```
const {value, dates} = await fundraiser.myDoanations();
```

- ABI の制限により、外部関数または public 関数から構造体の変数を返すことはできない
- データの保管場所として
  - memory キーワード: この値がコントラクトの永続ストレージに配置されているものを一切参照しないことを意味する
  - calldata キーワード: 関数が external として宣言されていて、パラメータのデータ型が mapping, stuct, string, array といった参照型である場合に限られる
- 状態変数の配列から値を取り出すとき、function 内部でもその戻り値の変数を storage として定義すれば、参照することになる。
- 状態変数はコントラクトの中で定義されているすべての関数からアクセスできる
- 状態変数の可視性修飾子(State Variable Visibility)は`internal`がデフォルトとなる
- 状態変数を public にすると、ストレージ変数と同じ名前の public ゲッター関数が自動的に生成される

- address 型には 2 種類あり、`address`と`address payable`があり、後者は transfer, send メソッドが使え、この型の変数はイーサを受け取ることができる
- Truffle で test を書く時、solidity の function を呼び出すときに、from プロパティを持つオブジェクトを設定可能だが、実行するアカウントの情報に加えて、value(ウェイ単位)の設定も可能。

```
await fundraiser.donate({from: accounts[0], value})
---------------
function donate() public payable {
  Donation memory donation = Donation({
    value: msg.value,
    date: block.timetamp
  });
  _donations[msg.sender].push(donation);
}
```

- イベントはイーサリアムのログに書き込みを行う手段で、新しいエントリに対するサブスクライブまたは監視ができるように設定されている。ログはブロックチェーンの一部であるため、ログへの書き込みは view や pure 関数では許可されない。
- イベント定義時に、パラメータに indexed を付けるとイベントを絞り込みやすくなる
- fallback 関数は名前を持たない関数であり、以下の振る舞いをする
  - コントラクトが通常のトランザクションを通じてイーサを受け取ったとき
  - コントラクトが定義済みのどの関数とも一致しないシグネチャを持つ関数で呼び出されたとき
- fallback 関数はパラメータなしの external 関数として宣言する

```
# 0.6.0より古い場合
function () external payable {
  ...
}
# 0.6.0以上 シグネチャが一致しない場合
fallback () external {
  ...
}
# 0.6.0以上 イーサを受け取る場合
receive () external payable {
  ...
}
```

- コントラクトまたは EOA にイーサを送信すると、それらのアドレスの残高を自動的に増やすことになる
- 時間をチェックするコードを書く時、完全な等価性を比較するのではなく、常にブロックの大小の比較を行
- 入金と出金アクションは分けておくのがベストプラクティス
- Factory パターンによって、コントラクト作成のためのコントラクトが用意されるのが一般的？
  - コントラクトからコントラクトの新しいインスタンスを作成すると、新しいインスタンスのアドレスが返される
- OpenZeppelin のコントラクトをベースとして作業を始める
- 所有権の概念を実装するコントラクト`Ownable`が OpenZeppelin に実装されている
- 整数のオーバーフロー問題を解決するために、`SafeMath`が OpenZeppelin に実装されている
- Truffle で書く test は、Mocha がベースとなっている
- React Truffle Box という React Box のラッパー機能を使うと UI 開発が楽

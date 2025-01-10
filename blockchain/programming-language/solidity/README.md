# Solidity

## References

- [Solidity docs](https://docs.soliditylang.org/)
- [Solidity 日本語](https://solidity-ja.readthedocs.io/ja/latest/)
- [Solidity 日本語(古い)](https://solidity-jp.readthedocs.io/ja/latest/)
- [Solidityの基本構文 0.8.7](https://note.com/npaka/n/n4fb510d2b3b4)
- [Solidity-quick-guide (日本語)](https://www.finddevguides.com/Solidity-quick-guide)

## 基本

### 変数

- private の状態変数や、パラメータの名前の先頭に`_`をつけるのが一般的なプラクティス
  うべき

### For Loop

- mapping の for ループを使って key と value を抽出する機能は存在しない

### function

- function では複数の戻り値を定義できる。この時、タプルが使われる。呼び出した test コードは配列として値に index でアクセスできる。以下のやり方でも可能。

```sol
const {value, dates} = await fundraiser.myDoanations();
```

- ABI の制限により、外部関数または public 関数から構造体の変数を返すことはできない
- データの保管場所として
  - memory キーワード: この値がコントラクトの永続ストレージに配置されているものを一切参照しないことを意味する
  - calldata キーワード: 関数が external として宣言されていて、パラメータのデータ型が mapping, struct, string, array といった参照型である場合に限られる
- コントラクトまたは EOA にイーサを送信すると、それらのアドレスの残高を自動的に増やすことになる
- function における、オーバーロード、オーバーライドが利用可能

#### Method ID

コントラクトから他のコントラクトの関数を実行する際に、Method IDをFunction Selectorに渡して実行する。関数名と引数の型の文字列を`keccak256`でハッシュ化し、頭の4byteを取ったものがMethod IDとなる

```sol
bytes4(keccak256("setNum(uint256)") = 0xcd16ecbf
```

#### fallback 関数

- fallback 関数は名前を持たない関数であり、以下の振る舞いをする
  - コントラクトが通常のトランザクションを通じてEtherを受け取ったとき
  - コントラクトが定義済みのどの関数とも一致しないシグネチャを持つ関数で呼び出されたとき
- fallback 関数はパラメータなしの external 関数として宣言する

```sol
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

#### functionへの追加情報

- Truffle で test を書く時、solidity の function を呼び出すときに、from プロパティを持つオブジェクトを設定可能だが、実行するアカウントの情報に加えて、value(ウェイ単位)の設定も可能。

```js
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

### 状態変数

- 状態変数の配列から値を取り出すとき、function 内部でもその戻り値の変数を storage として定義すれば、参照することになる。
- 状態変数はコントラクトの中で定義されているすべての関数からアクセスできる
- 状態変数の可視性修飾子(State Variable Visibility)は`internal`がデフォルトとなる
- 状態変数を public にすると、ストレージ変数と同じ名前の public ゲッター関数が自動的に生成される

### address型

- address 型には 2 種類あり、`address`と`address payable`があり、後者は transfer, send メソッドが使え、この型の変数はイーサを受け取ることができる
- [address型のメンバー](https://solidity-ja.readthedocs.io/ja/latest/units-and-global-variables.html#address-related)
  - `<address>.balance (uint256)`
  - `<address payable>.transfer(uint256 amount)`
  - `<address payable>.send(uint256 amount) returns (bool)`
  - `<address>.call(bytes memory) returns (bool, bytes memory)`
  - `<address>.delegatecall(bytes memory) returns (bool, bytes memory)`
  - `<address>.staticcall(bytes memory) returns (bool, bytes memory)`
- `call`, `delegatecall`, `staticcall`はABIに準拠していないコントラクトとのインターフェースや、エンコーディングをより直接的に制御するために用意されている関数
  - このとき、構造化データのエンコードに`abi.encode`、`abi.encodePacked`、`abi.encodeWithSelector`、`abi.encodeWithSignature`関数を使用する

### Event

- イベントはイーサリアムのログに書き込みを行う手段で、新しいエントリに対するサブスクライブまたは監視ができるように設定されている。ログはブロックチェーンの一部であるため、ログへの書き込みは view や pure 関数では許可されない。
- イベント定義時に、パラメータに indexed を付けるとイベントを絞り込みやすくなる

### 書き方のベストプラクティス

- 時間をチェックするコードを書く時、完全な等価性を比較するのではなく、常にブロックの大小の比較を行う
- 入金と出金アクションは分けておくのがベストプラクティス
- Factory パターンによって、コントラクト作成のためのコントラクトが用意されるのが一般的？
  - コントラクトからコントラクトの新しいインスタンスを作成すると、新しいインスタンスのアドレスが返される
- OpenZeppelin のコントラクトをベースとして作業を始める
- 所有権の概念を実装するコントラクト`Ownable`が OpenZeppelin に実装されている
- 整数のオーバーフロー問題を解決するために、`SafeMath`が OpenZeppelin に実装されている
- React Truffle Box という React Box のラッパー機能を使うと UI 開発が楽

### コントラクタ

[./contract.md](Contract)

- コントラクタの宣言がない場合、コンパイラがデフォルトコントラクタを作成する
- コントラクタはコントラクトのデプロイ時に１度だけ実行される
- 状態変数を初期化するためにコントラクタは存在し、それ以外で書く必要はない
- 抽象コントラクトという関数定義のみ、もしくは関数定義以外の実装を持つコントラクトがある。これはインスタンスを作成できないが、継承して利用する。継承したコントラクトはそれを実装する必要がある。

### インターフェース

- インターフェースは関数定義のみしかできない。状態変数を含めること、インターフェイスから他のコントラクトを継承することはできないが、他のインターフェースを継承することはできる。

```sol
interface IHelloWorld {
  function GetValue() public view returns (uint);
  function SetValue(uint _value) public;
}

contract HelloWorld is IHelloWorld {
  ...
}

contract client {
  IHelloWorld myObj;

  function client(){
    myObj - new HelloWorld();
  }
}
```

### Test

- Truffle で書く test は、Mocha がベースとなっている
- コントラクトのインスタンス化には 2 通りあり、既に Deploy されているコントラクトアドレスを利用して、インスタンス化する方法もあり、これは参照にあたる。

```js
# 新たにインスタンスを生成
HelloWorld myObj = new HelloWorld();
# アドレスからコントラクトを参照
HelloWorld myObj = HelloWorld(contractAddress);
```

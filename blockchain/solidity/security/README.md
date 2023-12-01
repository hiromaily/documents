# [Ethereum Smart Contract Security Best Practices](https://consensys.github.io/smart-contract-best-practices/)

- こちらはアクティブに更新されていないとのこと
  - [Smart Contract Security Field Guide](https://scsfg.io/)を参照のこと
- 中級の Solidity プログラマー向けにセキュリティに関する基本的な知識を提供するもの

## [General Philosophy](https://consensys.github.io/smart-contract-best-practices/general-philosophy/)

- [The Smart Contract Security Field Guide for Developers](https://scsfg.io/developers/)を参照とのこと

スマート・コントラクトのプログラミングには、これまでとは異なるエンジニアリングの考え方が必要。失敗のコストは高く、変更は難しく、ある意味ではウェブやモバイルの開発よりも、ハードウェアのプログラミングや金融サービスのプログラミングに似ている。そのため、既知の脆弱性を防御するだけでは不十分で、その代わりに、新しい開発哲学を学ぶ必要がある

### 失敗に備える

自明でない契約にはエラーがつきものだ。したがって、あなたのコードは、バグや脆弱性に優雅に対応できなければならない。

- 物事がうまくいかないときに Contract を一時停止する（circuit breaker）
- リスクのある金額を管理する（rate limiting, maximum usage）
- バグフィックスや改良のための効果的なアップグレードパスを持つ

### 最新情報

新しいセキュリティの動向を把握する

- 新しいバグが発見され次第、Contract をチェックする
- ツールやライブラリはできるだけ早く最新バージョンにアップグレードする
- 有用と思われる新しいセキュリティ技術を採用する

### シンプルに

複雑さはエラーの可能性を高める。

- Contract ロジックがシンプルであること
- コードをモジュール化して、コントラクトと関数を小さく保つ
- 可能な限り、すでに書かれているツールやコードを使う（例：乱数発生器を自作しない）
- 可能な限り、パフォーマンスよりも透明性を優先する
- システムの分散化が必要な部分にのみブロックチェーンを使用する

### 初公開: Rooling out

本番リリースの前にバグを発見するのは、常に良いこと

- Contract を徹底的にテストし、新しい攻撃ベクトルが発見されるたびにテストを追加する
- アルファ版のテストネットリリースからバグ報奨金を提供する
- 段階的に展開し、各段階で Usage(使用量)とテストを増やす

### ブロックチェーンの特性

あなたのプログラミング経験の多くはイーサリアムのプログラミングに関連するだろうが、注意すべき落とし穴もある。

- 悪意のあるコードを実行し、制御フローを変更する可能性のある外部コントラクト呼び出しには細心の注意を払うこと。
- パブリック関数は公開され、悪意を持ってどのような順序でも呼び出される可能性があることを理解する
  - スマート・コントラクトの private data も、誰でも見ることができる。
- gas cost と block gas の制限を念頭に置く
- ブロックチェーン上のタイムスタンプは不正確であり、マイナーは数秒の差で取引の実行時刻に影響を与える可能性があることに注意する
- ブロックチェーン上ではランダム性は自明ではなく、乱数生成のほとんどのアプローチはブロックチェーン上でゲーム可能である。

### 単純さと複雑さ

スマートコントラクトシステムの構造とセキュリティを評価する際に考慮すべき複数の基本的なトレードオフがある。スマート・コントラクト・システムの一般的な推奨事項は、これらの基本的なトレードオフの適切なバランスを特定すること

ソフトウェア工学のバイアスに立った理想的なスマートコントラクトシステムは、モジュール化されており、コードを複製する代わりに再利用し、アップグレード可能なコンポーネントをサポートしている。特に複雑なスマートコントラクトシステムの場合、セキュアアーキテクチャのバイアスから見た理想的なスマートコントラクトシステムは、この考え方を共有するかもしれない。

しかし、セキュリティとソフトウェア工学のベストプラクティスが一致しない重要な例外も存在する。いずれの場合も、適切なバランスは、以下のような Contract システムの次元に沿った特性の最適な組み合わせを特定することによって得られる：

- 堅牢性とアップグレード可能性 (Rigid versus Upgradeable)
- モノリシックとモジュラー (Monolithic versus Modular)
- 複製と再利用 (Duplication versus Reuse)

#### Rigid versus Upgradeable

このリソースを含む複数のリソースは、Killable（殺害可能）、Upgradeable（アップグレード可能）、Modifiable（変更可能）といったパターンのような可鍛性(Malleability)の特性を強調しているが、可鍛性(Malleability)とセキュリティの間には基本的なトレードオフがある。

可鍛性パターンは定義上、複雑さと潜在的な攻撃面を追加する。スマート・コントラクト・システムが、あらかじめ定義された限られた期間、非常に限定された機能セットを実行するような場合、例えば、ガバナンスのない有限時間枠のトークンセール・コントラクト・システムなどでは、複雑さよりも単純さの方が特に効果的。

#### Monolithic versus Modular

モノリシックな自己完結型のコントラクトは、すべての知識をローカルで識別可能かつ読み取り可能な状態に保つ。一枚岩として存在するスマート・コントラクト・システムが高く評価されることは少ないが、例えばコード・レビューの効率を最適化する場合など、データとフローの極端な局所性を求める議論もある。

ここで検討した他のトレードオフと同様に、セキュリティのベストプラクティスは、単純な短期契約の場合はソフトウエアエンジニアリングのベストプラクティスから遠ざかり、より複雑な永久 Contract システムの場合はソフトウエアエンジニアリングのベストプラクティスに向かう傾向がある。

#### Duplication versus Reuse

ソフトウェアエンジニアリングの観点からスマートコントラクトシステムは、合理的な再利用を最大化したいと考える。Solidity でコントラクト コードを再利用する方法はたくさんある。一般的に、コードの再利用を達成するための最も安全な方法は、自分が所有している実績のある以前にデプロイされたコントラクトを使用すること。

複製は、自己所有の以前に展開されたコントラクトが利用できない場合に、頻繁に頼られる。OpenZeppelin の Solidity ライブラリのような取り組みは、安全なコードが重複することなく再利用できるようなパターンを提供しようとするもの。コントラクトのセキュリティ分析には、対象となるスマートコントラクトシステムのリスクに見合った信頼レベルを以前に確立していない再利用コードを含める必要がある。

## [開発に関する提言](https://consensys.github.io/smart-contract-best-practices/development-recommendations/)

### 一般 / 開発中に留意すべき指針

#### External Calls

##### 1. External Calls を実行するときは注意する

信頼されていないコントラクトへの呼び出しは、いくつかの予期せぬリスクやエラーを 引き起こす可能性がある。External Calls は、そのコントラクトや、そのコントラクトが依存する他のコントラクトで、悪意あるコードを実行する可能性がある。したがって、すべての外部呼出しは、潜在的なセキュ リティリスクとして扱われるべきである。External Calls を削除することが不可能な場合、あるいは削除することが望ましくない場合は、 このセクションの残りの部分にある推奨事項を使用して、危険を最小化すること。

##### 2. 信頼できない Contract をマークする

外部コントラクトと相互作用する場合、変数、メソッド、コントラクト・インターフェースを、それらとの相互作用が安全でない可能性があることを明確にする方法で命名すること。これは、外部コントラクトを呼び出す独自の関数にも当てはまる。

```sol
// bad
Bank.withdraw(100); // Unclear whether trusted or untrusted

function makeWithdrawal(uint amount) { // Isn't clear that this function is potentially unsafe
    Bank.withdraw(amount);
}

// good
UntrustedBank.withdraw(100); // untrusted external call
TrustedBank.withdraw(100); // external but trusted bank contract maintained by XYZ Corp

function makeUntrustedWithdrawal(uint amount) {
    UntrustedBank.withdraw(amount);
}
```

##### 3. External Calls 後の状態変化を避ける

raw call（`someAddress.call()`）であれ、コントラクト呼び出し（`ExternalContract.someMethod()`）であれ、悪意のあるコードが実行される可能性があることを想定すること。ExternalContract が悪意のあるものでなくても、それが呼び出すコントラクトによって悪意のあるコードが実行される可能性があります。

特に危険なのは、悪意のあるコードが制御フローを乗っ取り、[リエントランシーによる脆弱性](https://consensys.github.io/smart-contract-best-practices/attacks/reentrancy/)を引き起こすことである

信頼できない外部コントラクトをコールする場合は、コール後のステート変更を避ける。 このパターンは、[checks-effects-interactions パターン](https://docs.soliditylang.org/en/develop/security-considerations.html#use-the-checks-effects-interactions-pattern)としても知られることがある。

Smart Contract Weakness Classification [SWC-107](https://swcregistry.io/docs/SWC-107/):Reentrancy を参照

##### 4. transfer()や send()は使わないこと

`.transfer()`と`.send()`は、受信者に正確に 2,300 ガスを転送する。このハードコード化されたガス支給の目的は再起不能の脆弱性を防ぐことであったが、これはガス代が一定であるという仮定の下でしか意味をなさない。最近、[EIP 1884](https://eips.ethereum.org/EIPS/eip-1884) がイスタンブールのハードフォークに含まれた。EIP 1884 に含まれる変更の 1 つは、`SLOAD` operation のガスコストの増加であり、コントラクトのフォールバック機能が 2300 ガスコスト以上になる原因となっている。

`.transfer()`と`.send()`の使用を止め、代わりに`.call()`を使用することを推奨する。

`.call()`はリエントランシー攻撃を軽減する効果はないので、他の予防策を講じる必要があることに注意。リエントランシー攻撃を防ぐには、[checks-effects-interactions パターン](https://docs.soliditylang.org/en/develop/security-considerations.html#use-the-checks-effects-interactions-pattern)を使うことを推奨する。

```sol
// bad
contract Vulnerable {
    function withdraw(uint256 amount) external {
        // This forwards 2300 gas, which may not be enough if the recipient
        // is a contract and gas costs change.
        msg.sender.transfer(amount);
    }
}

// good
contract Fixed {
    function withdraw(uint256 amount) external {
        // This forwards all available gas. Be sure to check the return value!
        (bool success, ) = msg.sender.call.value(amount)("");
        require(success, "Transfer failed.");
    }
}
```

##### 5. external calls のエラー処理

Solidity には、raw address で動作する低レベルの呼び出しメソッド、`address.call()`、`address.callcode()`、`address.delegatecall()`、および `address.send()`がある。これらの低レベルメソッドは例外をスローしないが、呼び出しで例外が発生した場合は false を返す。一方、コントラクト呼び出し（例えば、ExternalContract.doSomething()）は、自動的にスローを伝播します（例えば、ExternalContract.doSomething()は、doSomething()がスローした場合にもスローします）。

低レベルの呼び出しメソッドを使用する場合は、戻り値をチェックすることによって、呼び出しが失敗する可能性に対処するようにしてください。

SWC-104 参照

##### 6. 外部コールのプッシュより プルを好む

外部呼は、偶発的または故意に失敗する可能性がある。このような失敗による損害を最小にするには、各外部呼を、呼の受信者が 開始できる独自のトランザクションに分離した方がよいことが多い。これは特に決済に関連しており、ユーザーに資金を自動的にプッシュする よりも、ユーザーに資金を引き出してもらう方がよい。(複数のエーテル送金を 1 つのトランザクションにまとめるのは避けよう。

SWC-128 を参照

##### 7. 信頼されていないコードにコールを委譲しないでください

delegatecall 関数は、あたかも呼び出し元のコントラクトに属しているかのように、他のコントラクトから関数を呼び出すために使用される。そのため、呼び出し側は、呼び出し元のアドレスの状態を変更する可能性がある。以下の例は、delegatecall を使用すると、コントラクトが破壊され、そのバランスが失われる可能性があることを示しています。

Worker.doWork()が、デプロイされた Destructor コントラクトのアドレスを引数として呼び出された場合、Worker コントラクトは自己破壊する。実行は信頼できるコントラクトにのみ委譲し、ユーザーが提供したアドレスには決して委譲しないでください。

Warning

コントラクトが残高ゼロで作成されることを想定してはならない。 攻撃者はコントラクトが作成される前にそのアドレスに Ether を送ることができるため、コントラクトは初期状態に残高がゼロであると仮定すべきではない。詳細は issue 61 を参照のこと。

SWC-112 を参照

#### Force-feeding Ether

#### Public on-chain Data

#### Unreliable Participants

#### Negation of Signed Integers

### 注意事項 / 一般的な攻撃を防ぐ、あるいは最悪のケースで過剰な被害を避ける原則

### Solidity 固有の tips / Solidity でスマートコントラクトを構築する際に役立つヒント

### Token 固有の tips / トークンを扱う際、または実装する際に尊重すべき推奨事項

### 文書化 / スマートコントラクトとそれを取り巻くプロセスを適切に文書化する方法についてのガイドライン

### 非推奨 / 過去には該当していたが、現在では合理的に除外できる脆弱性

## Security Attacks

- [Index](https://consensys.github.io/smart-contract-best-practices/attacks/)
  - [Reentrancy](https://consensys.github.io/smart-contract-best-practices/attacks/reentrancy/)
  - [Oracle Manipulation](https://consensys.github.io/smart-contract-best-practices/attacks/oracle-manipulation/)
  - [Frontrunning](https://consensys.github.io/smart-contract-best-practices/attacks/frontrunning/)
  - [Timestamp Dependence](https://consensys.github.io/smart-contract-best-practices/attacks/timestamp-dependence/)
  - [Insecure Arithmetic](https://consensys.github.io/smart-contract-best-practices/attacks/insecure-arithmetic/)
  - [Denial of Service](https://consensys.github.io/smart-contract-best-practices/attacks/denial-of-service/)
  - [Griefing](https://consensys.github.io/smart-contract-best-practices/attacks/griefing/)
  - [Force Feeding](https://consensys.github.io/smart-contract-best-practices/attacks/force-feeding/)
  - [Deprecated/Historical](https://consensys.github.io/smart-contract-best-practices/attacks/deprecated/)
  - [More](https://consensys.github.io/smart-contract-best-practices/attacks/more/)

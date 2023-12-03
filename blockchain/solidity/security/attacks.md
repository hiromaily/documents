# [Ethereum Smart Contract Security Best Practices: Attacks](https://consensys.github.io/smart-contract-best-practices/attacks/)

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

## [Reentrancy](https://scsfg.io/hackers/reentrancy/)

直訳すると、「再侵入」

外部コントラクトを呼び出す際の最も大きな脅威の一つは、コール側のスマート・コントラクトが操作の流れを掌握できることだ。これは、呼び出されたコントラクトが、呼び出した関数が予期していなかったスマート・コントラクト・システムの変更を実行する可能性があることを意味する。この操作は多くの場合、制御フローをリダイレクトすることで実現し、事実上、コール側をコール側に変える。このサイクルが繰り返されることで、スマート・コントラクトは何度もシステムに侵入することができる。この悪名高い脆弱性はリエントランシーと呼ばれ、様々な形を取ることができる。  
このセクションでは、リエントランシーのタイプを明らかにし、Solidity コード内のそのような脆弱性を特定するためのガイダンスを提供することを目的としている。

### Single-Function Reentrancy

この脆弱性が発見され、悪用された最初のケースは、単一の関数コンテキスト内でのリエントランシーであった。このようなシナリオでは、関数内の external call がその関数を再度トリガーし、半完了した実行が新たに複数回開始され、状態変化のカスケードが発生する。

単一関数のリエントランシー問題から得られる主な教訓は、external call の後に発生する状態変更とチェックが脆弱性を可能にするということだ。  
悪名高い DAO ハックにヒントを得た例を考えてみよう

```sol
contract Vulnerable {
  mapping (address => uint) private balances;

  function withdraw() public {
    uint amount = balances[msg.sender];
    (bool success, ) = msg.sender.call.value(amount)("");
    require(success);
    balances[msg.sender] = 0;
  }
}
```

この例では、external call は ETH 値を msg.sender に送金することを目的としている。ユーザーの残高は external call の後でのみゼロに更新されることに注意する。したがって、msg.sender が別のスマートコントラクトである場合、そのフォールバック関数を通じて、引き出し関数を呼び出すことができる。

ユーザー残高マッピングは呼び出しの後まで更新されないので、withdraw の再呼び出しは指定された残高を繰り返し引き出すことができ、最終的にスマートコントラクトの総資金を枯渇させる。最後のステップでは、攻撃者は単にターゲットとなるスマートコントラクトの全体的な ETH 残高をチェックし、コントラクトが保持する以上の ETH を引き出そうとしないことを確認する必要がある。さらに攻撃者は、繰り返される呼び出しの間にガス欠にならないように、実行深度とその累積ガスコストを考慮する必要がある。

初期コード例のリエントランシー脆弱性は、ユーザー残高が更新されるまで外部呼び出しを延期することで修正できる。  
呼び出し後のコードには、値の転送が失敗した場合に戻すためのチェックも含まれています：

```sol
contract Vulnerable {
  mapping (address => uint) private balances;

  function withdraw() public {
    uint amount = balances[msg.sender];
    balances[msg.sender] = 0; // 最初に0にしておく
    (bool success, ) = msg.sender.call.value(amount)("");
    require(success);
  }
}
```

しかし、この解決策にはまだ潜在的な問題がある。別の関数が withdraw を呼び出すと、同じ攻撃を受ける可能性がある。したがって、信頼されていないコントラクトを呼び出す関数は、信頼されていないものとして扱われるべきである。以下、この問題に対する潜在的な解決策を探る。

### Cross-Function Reentrancy

単一関数のリエントランシー（再入可能性）に対する修正は、そのコンテキスト内ではセキュリティー脆弱性を効果的に軽減するが、より複雑なシナリオでは、この悪用はまだ実行可能である。例えば、別の関数が`withdraw()`を呼び出す場合、リエントランシーが潜在的な脅威となる可能性がある。これは`Cross-Function Reentrancy`と呼ばれ、複数の function が同じ状態を共有する場合に発生する。

```sol
contract Vulnerable {
  mapping (address => uint) private balances;

  function transfer(address to, uint amount) public {
    if (balances[msg.sender] >= amount) {
      balances[to] += amount;
      balances[msg.sender] -= amount;
    }
  }

  function withdraw() public {
    uint amount = balances[msg.sender];
    (bool success, ) = msg.sender.call.value(amount)("");
    require(success);
    balances[msg.sender] = 0;
  }
}
```

この例では、攻撃者は最初に引き出し関数を呼び出し、値の転送のために呼び出され たら、今度は転送関数を呼び出して契約に再参加することができます。攻撃者が transfer 関数で再入力した時点では、まだ引き出しの呼び出しが終了していないため、msg.sender の残高マッピングはゼロに設定されていません。その結果、攻撃者は引き出し額に加えて資金を送金することができます。

攻撃者はその後、不正に管理された残高を送金機能から自分の管理するアドレスに送金することで、すでに引き出し額を受け取っているにもかかわらず、そのアドレスで処理を繰り返すことができる。この種の脆弱性は、2016 年の DAO ハッキングの際にも悪用された。

単一関数のリエントランシーの例と同様に、ここでの改善策も、関連するすべての状態変化が発生するまで外部呼び出しを延期することである。このことは、リエントランシー脆弱性を防ぐための慎重なプログラミングの重要性を再度強調している。

### Cross-contract Reentrancy

先に説明した悪用は、単一のコントラクト内で共有されたステートと関数に限定されるものではな いことを強調しておく必要がある。例えば、バランシング・マッピングが public に設定されていたり、ビュー関数を通じて間接的または直接的に公開されていたりし、別のコントラクトがそのステートに依存している場合でも、エクスプロイトが成功する可能性があります。これは、複雑なビジネス・ロジックが支配する、高度にモジュール化されたスマート・コントラクト・システムで特に顕著になります。このような状況では、クロスコントラクトのリエントランシーは目立ちにくく、したがってはるかに危険です。

### Read-only Reentrancy

読み取り専用リエントランシーは、クロス・コントラクト・リエントランシー攻撃の特定の例である。このタイプの脆弱性は、スマート・コントラクトの動作が他のコントラクトの状態に依存する場合に発生する。リエントランシーを探す攻撃者は通常、状態を変更する関数に注目します。とはいえ、コントラクト間のリエントランシーのコンテキストでは、ビューが古い状態情報をもたらす可能性がある。このような状況は、サードパーティのインフラを悪用することにつながる可能性がある。

以下の例では、利用者に入出金を許可する銀行契約が示されている：

```sol

```

銀行契約は、OpenZeppelin の ReentrancyGuard を使用することで、リエントランシー問題から自分自身を保護します。さらに、サードパーティのスマートコントラクトが存在し、銀行の公開残高マッピングを独自のビジネスロジックに使用しています：

```sol

```

銀行の引き出し機能は再連続性から保護されている。しかし、このガードは契約自体にのみ適用され、他のシステムには適用されない。withdraw の外部呼び出しの実行フローは攻撃者に乗っ取られる可能性があり、攻撃者は他のプロジェクトとやりとりしながら、誤解を招くような残高を提示するスマート・コントラクトを作ることができる。

この場合、BankConsumer はそのようなプロジェクトであり、単に説明のためにビュー関数を公開しているに過ぎない。このようなビュー関数は、例えば株式の割り当てや、ユーザーが所有する株式より多くの株式を清算することを防ぐチェックのために、内部的に他の場所で利用することができる。銀行契約によって公開された古い残高は、悪意のある受信関数を設計することによって悪用することができる：

```sol

```

アタッカー契約はチェックポイント・イベントを記録し、BankConsumer 契約に表示される残高が古いことを示します。Remix でシステムがセットアップされ、攻撃機能が実行されると、以下のイベントが Attacker コントラクトによって記録されます：

```sol

```

2 つ目のチェックポイント・イベントは、資金が攻撃者に送金されたにもかかわらず、Bank コントラクトが受信機能の間、攻撃者コントラクトのアドレスに対して 1ETH の残高を提示したままであることを示しています。この古い情報は、BankConsumer のような Bank コントラクト上に構築されたサードパーティのインフラを欺くために操作することができます。

### Protection Shortcomings

上記で示したように、リエントランシーは、単一の機能に影響を与えたり、複数の機能にまたがったり、あるいは異なるスマートコントラクトにまたがることさえあり、スマートコントラクトシステムを効果的に破ります。従って、単一の機能に限定されたリエントランシーに対する保護策は、十分な保護を提供するには不十分である。

例えば、OpenZeppelin の ReentrancyGuard のようなソリューションだ。これらのソリューションは、組み込まれたコントラクト内に状態を保存するため、コントラクト間のリエントランシーを防ぐことができない。checks-effects-interactions パターンは、より一般的に順守されるべきである。この原則が綿密に適用されれば、外部呼び出しの後に状態変更が発生しないため、リエントランシーの脆弱性を根絶することができる。

追加の関数呼び出しも精査されなければならないことを考慮することは極めて重要である。次の例はこの点を強調している：

```sol

```

この場合、たとえ withdrawBonus が外部の契約と直接関わっていなくても、withdraw 内の呼び出しは、reentrancy 攻撃を受けやすくするのに十分である。したがって、withdraw は内部呼び出しのコンテキストでも信頼され ないとみなされなければならない。checks-effects-interactions パターンを再び適用すると、上記のコードをより堅牢にしたものは次のようになる：

```sol

```

一般的により適用しやすい保護へのもうひとつのアプローチは、ミューテックスを使用することである。このテクニックは「ロック」状態をもたらし、ロックの所有者だけがそれを変更できるようにします。OpenZeppelin の ReentrancyGuard は、これを利用して、個々のコントラクトのリエントランシー保護に普遍的なソリューションを提供します：

```sol

```

このパターンは、モディファイアとして採用できるため、効果的で便利である。しかし、同じシステム内の複数の契約を含むシナリオをカバーするには不十分である。

# [Ethereum Smart Contract Security Best Practices: 開発に関する提言](https://consensys.github.io/smart-contract-best-practices/development-recommendations/)

## 一般 / 開発中に留意すべき指針

### External Calls

#### 1. External Calls を実行するときは注意する

信頼されていないコントラクトへの呼び出しは、いくつかの予期せぬリスクやエラーを 引き起こす可能性がある。External Calls は、そのコントラクトや、そのコントラクトが依存する他のコントラクトで、悪意あるコードを実行する可能性がある。したがって、すべての外部呼出しは、潜在的なセキュ リティリスクとして扱われるべきである。External Calls を削除することが不可能な場合、あるいは削除することが望ましくない場合は、 このセクションの残りの部分にある推奨事項を使用して、危険を最小化すること。

#### 2. 信頼できない Contract をマークする

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

#### 3. External Calls 後の状態変化を避ける

raw call（`someAddress.call()`）であれ、コントラクト呼び出し（`ExternalContract.someMethod()`）であれ、悪意のあるコードが実行される可能性があることを想定すること。ExternalContract が悪意のあるものでなくても、それが呼び出すコントラクトによって悪意のあるコードが実行される可能性があります。

特に危険なのは、悪意のあるコードが制御フローを乗っ取り、[リエントランシーによる脆弱性](https://consensys.github.io/smart-contract-best-practices/attacks/reentrancy/)を引き起こすことである

信頼できない外部コントラクトをコールする場合は、コール後のステート変更を避ける。 このパターンは、[checks-effects-interactions パターン](https://docs.soliditylang.org/en/develop/security-considerations.html#use-the-checks-effects-interactions-pattern)としても知られることがある。

Smart Contract Weakness Classification [SWC-107](https://swcregistry.io/docs/SWC-107/):Reentrancy を参照

#### 4. transfer()や send()は使わないこと

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

#### 5. external calls のエラー処理

Solidity には、raw address で動作する低レベルの呼び出しメソッド、`address.call()`、`address.callcode()`、`address.delegatecall()`、および `address.send()`がある。これらの低レベルメソッドは例外をスローしないが、呼び出しで例外が発生した場合は false を返す。一方、コントラクト呼び出し（例えば、ExternalContract.doSomething()）は、自動的にスローを伝播する（例えば、ExternalContract.doSomething()は、doSomething()がスローした場合にもスローする）

低レベルの呼び出しメソッドを使用する場合は、戻り値をチェックすることによって、呼び出しが失敗する可能性に対処するようにすること。

```sol
// bad
someAddress.send(55);
someAddress.call.value(55)(""); // this is doubly dangerous, as it will forward all remaining gas and doesn't check for result
someAddress.call.value(100)(bytes4(sha3("deposit()"))); // if deposit throws an exception, the raw call() will only return false and transaction will NOT be reverted

// good
(bool success, ) = someAddress.call.value(55)("");
if(!success) {
    // handle failure code
}

ExternalContract(someAddress).deposit.value(100)();
```

Smart Contract Weakness Classification [SWC-104](https://swcregistry.io/docs/SWC-104/):Unchecked Call Return Value を参照

#### 6. 外部コールの push より pull を好む

External calls は、偶発的または故意に失敗する可能性がある。このような失敗による損害を最小にするには、各 External calls を、呼び出しの受信者が 開始できる独自のトランザクションに分離した方がよいことが多い。これは特に決済に関連しており、ユーザーに資金を自動的に push するよりも、ユーザーに資金を引き出してもらう方がよい。これにより gas limit に関連する問題を軽減できる可能性もある。複数の Ether 送金を 1 つのトランザクションにまとめるのは避ける。

```sol
// bad
contract auction {
    address highestBidder;
    uint highestBid;

    function bid() payable {
        require(msg.value >= highestBid);

        if (highestBidder != address(0)) {
            (bool success, ) = highestBidder.call.value(highestBid)("");
            require(success); // if this call consistently fails, no one else can bid
        }

       highestBidder = msg.sender;
       highestBid = msg.value;
    }
}

// good
contract auction {
    address highestBidder;
    uint highestBid;
    mapping(address => uint) refunds;

    function bid() payable external {
        require(msg.value >= highestBid);

        if (highestBidder != address(0)) {
            refunds[highestBidder] += highestBid; // record the refund that this user can claim
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    function withdrawRefund() external {
        uint refund = refunds[msg.sender];
        refunds[msg.sender] = 0;
        (bool success, ) = msg.sender.call.value(refund)("");
        require(success);
    }
}
```

Smart Contract Weakness Classification [SWC-128](https://swcregistry.io/docs/SWC-128/):DoS With Block Gas Limit を参照

#### 7. 信頼されていないコードに delegatecall は使わない

`delegatecall` 関数は、あたかも呼び出し元のコントラクトに属しているかのように、他のコントラクトから関数を呼び出すために使用される。そのため、呼び出し側は、呼び出し元のアドレスの状態を変更する可能性がある。以下の例は、delegatecall を使用すると、コントラクトが破壊され、そのバランスが失われる可能性があることを示している。

```sol
contract Destructor
{
    function doWork() external
    {
        selfdestruct(0);
    }
}

contract Worker
{
    function doWork(address _internalWorker) public
    {
        // unsafe
        _internalWorker.delegatecall(bytes4(keccak256("doWork()")));
    }
}
```

Worker.doWork()が、デプロイされた Destructor コントラクトのアドレスを引数として呼び出された場合、Worker コントラクトは self-destruct する。実行は信頼できるコントラクトにのみ委譲し、ユーザーが提供したアドレスには決して委譲しないこと。

##### Warning

コントラクトが残高ゼロで作成されることを想定してはならない。 攻撃者はコントラクトが作成される前にそのアドレスに Ether を送ることができるため、コントラクトは初期状態に残高がゼロであると仮定すべきではない。詳細は [issue 61](https://github.com/ConsenSys/smart-contract-best-practices/issues/61) を参照のこと。

Smart Contract Weakness Classification [SWC-112](https://swcregistry.io/docs/SWC-112/):Delegatecall to Untrusted Callee を参照

### Force-feeding Ether

### Public on-chain Data

### Unreliable Participants

### Negation of Signed Integers

## 注意事項 / 一般的な攻撃を防ぐ、あるいは最悪のケースで過剰な被害を避ける原則

## Solidity 固有の tips / Solidity でスマートコントラクトを構築する際に役立つヒント

## Token 固有の tips / トークンを扱う際、または実装する際に尊重すべき推奨事項

## 文書化 / スマートコントラクトとそれを取り巻くプロセスを適切に文書化する方法についてのガイドライン

## 非推奨 / 過去には該当していたが、現在では合理的に除外できる脆弱性

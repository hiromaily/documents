# Lambda の二重起動防止

ある Lambda 関数が実行中の場合に、同じ関数の再実行を制御するには、いくつかの方法があります。一般的なアプローチとしては、以下の方法が考えられる

1. **Concurrency Control (並行実行制御) を使用する**:
   - Lambda 関数の最大実行数を制限する。
2. **DynamoDB を使用した分散ロックの実装**:
   - DynamoDB を使用して、関数の実行状況を追跡し、実行中であれば再実行を制御する。

## 1. Concurrency Control を使用する方法

これは最も簡単な方法で、AWS Lambda の同時実行数を管理する機能を使用する

1. AWS マネジメントコンソールで、目的の Lambda 関数を選択。
2. 「設定」タブで、「並行実行」セクションを選ぶ。
3. 「予約済み非同期実行数」を、同時実行させたくない数（1 など）に設定する。

この設定により、関数が 1 つ以上のインスタンスで実行中の場合、新しいリクエストはキューに入れられる。関数が非実行状態になるまで、新しいリクエストは保留される。
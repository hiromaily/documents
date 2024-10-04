# Mutex

Mutex（ミューテックス）は、`Mutual Exclusion（相互排他）`の略で、並列処理（スレッドやプロセスの並行実行）において、共有リソースへの同時アクセスを防ぐための同期プリミティブ。
基本的な考え方として、複数のスレッドが同時に共有リソース（例えばデータ構造やファイルなど）を変更しようとすると、競合状態やデータの不整合が発生することがある。Mutex はこの問題を解決するために使用される。

## 動作の基本概念

1. **ロック（Lock）**:
   スレッドが共有リソースを使用する前に、Mutex を「ロック」する。ロックを取得したスレッドのみがそのリソースにアクセスできる。

2. **アンロック（Unlock）**:
   スレッドがリソースの使用を終えたら、Mutex を「アンロック」する。アンロックすると、他のスレッドがその Mutex をロックできるようになる。

## 使用方法

典型的な使用方法は以下の通り

- **ロックの取得**: あるスレッドがリソースを使用する前に、Mutex をロックする。もし他のスレッドがすでにロックを保持している場合、現在のスレッドはロックが解放されるまで待機する。
- **クリティカルセクション**: ロックを取得した状態で共有リソースに対する操作を行う。
- **ロックの解放**: クリティカルセクションの操作が完了したら、Mutex をアンロックする。

具体的には以下のようなコードになる（C 言語の場合）：

```c
#include <pthread.h>
#include <stdio.h>

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
int shared_resource = 0;

void* task(void* arg) {
    pthread_mutex_lock(&mutex);             // Mutexをロック
    // 以下がクリティカルセクション
    shared_resource++;
    printf("Shared Resource: %d\n", shared_resource);
    pthread_mutex_unlock(&mutex);           // Mutexをアンロック
    return NULL;
}

int main() {
    pthread_t threads[10];

    // スレッドの作成
    for (int i = 0; i < 10; ++i) {
        pthread_create(&threads[i], NULL, task, NULL);
    }

    // スレッドの終了待ち
    for (int i = 0; i < 10; ++i) {
        pthread_join(threads[i], NULL);
    }

    pthread_mutex_destroy(&mutex);
    return 0;
}
```

## 注意点

- **デッドロック**: 複数のスレッドが相互にロックを待つ状態になると、進展しなくなる「デッドロック」状態になることがある。デッドロックを避けるための工夫が必要。
- **競合の発生頻度**: Mutex を頻繁にロック・アンロックすることでパフォーマンスに影響が出ることがある。過剰なロックは避け、効率的な設計を心掛けることが重要。

## References

- [The Fastest Mutexes](https://justine.lol/mutex/)

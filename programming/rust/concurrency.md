# 並行性 Concurrency

M:N のグリーンスレッドモデルは、スレッドを管理するのにより大きな言語ランタイムが必要となるため、Rust の標準ライブラリは、`1:1スレッドの実装のみ`を提供しているが、パフォーマンスと引き換えに`M:Nスレッドの実装`をしたクレートもある。

## `thread::spawn`で新規スレッドを生成する

- 新しいスレッドは、実行が終わったかどうかにかかわらず、メインスレッドが終了したら停止する
- スレッドの実行順に保証もなく、立ち上げたスレッドが全て実行されるとは限らない

```rs
use std::thread;
use std::time::Duration;

fn main() {
    //新しいスレッド
    thread::spawn(|| {
        for i in 1..10 {
            // やあ！立ち上げたスレッドから数字{}だよ！
            println!("hi number {} from the spawned thread!", i);
            thread::sleep(Duration::from_millis(1));
        }
    });

    // mainスレッド
    for i in 1..5 {
        // メインスレッドから数字{}だよ！
        println!("hi number {} from the main thread!", i);
        thread::sleep(Duration::from_millis(1));
    }
}
```

## join ハンドルで全スレッドの終了を待つ

```rs
use std::thread;
use std::time::Duration;

fn main() {
    // thread::spawnの戻り値である、JoinHandle型の値を取得
    // JoinHandleは、そのjoinメソッドを呼び出したときにスレッドの終了を待つ所有された値
    let handle = thread::spawn(|| {
        for i in 1..10 {
            println!("hi number {} from the spawned thread!", i);
            thread::sleep(Duration::from_millis(1));
        }
    });

    for i in 1..5 {
        println!("hi number {} from the main thread!", i);
        thread::sleep(Duration::from_millis(1));
    }

    // スレッドの終了を待つ。つまりこのコードでブロックされる。
    handle.join().unwrap();
}
```

## スレッドで`moveクロージャ`を使用する

`moveクロージャ`は、あるスレッドのデータを別のスレッドで使用できるようになるため、`thread::spawn`とともによく使用される。
`moveクロージャ`がない場合、main スレッド側に定義した変数に新しく立てたスレッドからアクセスを試みる場合、立ち上げたスレッドがどのくらいの期間走るのかわからないのでエラーを起こす。

```rs
use std::thread;

fn main() {
    let v = vec![1, 2, 3];

    let handle = thread::spawn(|| {
        // こちらがベクタ: {:?}
        println!("Here's a vector: {:?}", v);
    });

    handle.join().unwrap();
}

// エラー内容
error[E0373]: closure may outlive the current function, but it borrows `v`,
which is owned by the current function
(エラー: クロージャは現在の関数よりも長生きするかもしれませんが、現在の関数が所有している
`v`を借用しています)
 --> src/main.rs:6:32
  |
6 |     let handle = thread::spawn(|| {
  |                                ^^ may outlive borrowed value `v`
7 |         println!("Here's a vector: {:?}", v);
  |                                           - `v` is borrowed here
  |
help: to force the closure to take ownership of `v` (and any other referenced
variables), use the `move` keyword
(助言: `v`(や他の参照されている変数)の所有権をクロージャに奪わせるには、`move`キーワードを使用してください)
  |
6 |     let handle = thread::spawn(move || {
  |
```

そのため、以下のようなコードが求められる

```rs
use std::thread;

fn main() {
    let v = vec![1, 2, 3];

    let handle = thread::spawn(move || {
        println!("Here's a vector: {:?}", v);
    });

    handle.join().unwrap();
}
```

## メッセージ受け渡しを使ってスレッド間でデータを転送する

1 つの手段が`チャンネル`で、 Rust の標準ライブラリが実装を提供しているプログラミング概念であり、転送機と受信機で 2 分割できる。転送機と受信機のどちらかがドロップされると、 チャンネルは閉じられたことになる。

`mpsc`は `multiple producer, single consumer`の略で、1 つのチャンネルが値を生成する複数の送信側と、 その値を消費するたった 1 つの受信側を持つことができるということを意味

```rs
use std::thread;
use std::sync::mpsc; // mpscは `multiple producer, single consumer`

fn main() {
    // 新しいチャンネルを生成, 1つ目の要素は、送信側、2つ目の要素は受信側
    // txとrxという略称は、多くの分野で伝統的に転送機と受信機にそれぞれ使用されている
    let (tx, rx) = mpsc::channel();

    // producer
    thread::spawn(move || {
        let val = String::from("hi");
        tx.send(val).unwrap(); // 値を送信する場所がなければ、送信処理はエラーを返す
        // valの所有権は移っているので、ここからは使えない
    });

    // consumer
    // メインスレッドの実行をブロックし、 値がチャンネルを流れてくるまで待機
    let received = rx.recv().unwrap(); // チャンネルの送信側が閉じたら、recvはエラーを返す
    println!("Got: {}", received);
}
```

複数のメッセージを扱う

```rs
use std::thread;
use std::sync::mpsc;
use std::time::Duration;

fn main() {
    let (tx, rx) = mpsc::channel();

    thread::spawn(move || {
        // スレッドからやあ(hi from the thread)
        let vals = vec![
            String::from("hi"),
            String::from("from"),
            String::from("the"),
            String::from("thread"),
        ];

        for val in vals {
            tx.send(val).unwrap();
            thread::sleep(Duration::from_secs(1));
        }
    });

    for received in rx { // rxをイテレータとして扱う
        println!("Got: {}", received);
    }
}
```

## 転送機をクローンして複数の生成器を作成する

全ての値を同じ受信機に送信する複数のスレッドを生成

```rs
use std::thread;
use std::sync::mpsc;
use std::time::Duration;

fn main() {
// --snip--

let (tx, rx) = mpsc::channel();

// スレッド２
let tx2 = mpsc::Sender::clone(&tx);
thread::spawn(move || {
    let vals = vec![
        String::from("hi"),
        String::from("from"),
        String::from("the"),
        String::from("thread"),
    ];

    for val in vals {
        tx2.send(val).unwrap();
        thread::sleep(Duration::from_secs(1));
    }
});

// スレッド１
thread::spawn(move || {
    // 君のためにもっとメッセージを(more messages for you)
    let vals = vec![
        String::from("more"),
        String::from("messages"),
        String::from("for"),
        String::from("you"),
    ];

    for val in vals {
        tx.send(val).unwrap();
        thread::sleep(Duration::from_secs(1));
    }
});

// receiver
for received in rx {
    println!("Got: {}", received);
}

// --snip--
}
```

## References

- [The Rust Programming Language 日本語版: 恐れるな！並行性](https://doc.rust-jp.rs/book-ja/ch16-00-concurrency.html)

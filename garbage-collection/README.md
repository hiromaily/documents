# Garbage Collection ガベージコレクション

ガベージコレクション（Garbage Collection、GC）は、コンピュータプログラムにおいて不要になったメモリ領域を自動的に回収する仕組みのこと。これにより、メモリ管理が容易になり、プログラムが使用しているメモリの効率を向上させることができる。ガベージコレクションは一般に高レベル言語（例えば Java、Python、JavaScript、C#、Ruby など）で使用されるが、Go などでも広く利用されている。
言語やランタイム環境によっては、ガベージコレクションの具体的な実装や最適化オプションが異なるため、特定の環境での詳細はその言語またはランタイムのドキュメントを参照するとよい。

## ガベージコレクションの基本的な概念

1. **不要なオブジェクトの識別**
   ガベージコレクションシステムは、プログラムがもはや使用していないオブジェクトを識別する。このために使用される主な方法には、リファレンスカウントやトレーシングガーベジコレクションが含まれる。

2. **メモリの回収**
   使われていないオブジェクトが識別されると、メモリが解放される。これにより、新しいオブジェクトのためのメモリ領域が確保される。

## ガベージコレクションの方式

1. **リファレンスカウント（Reference Counting）**
   各オブジェクトに参照カウントを持たせ、そのカウントが 0 になるときにメモリを解放する方式。シンプルですが、循環参照問題（オブジェクトが互いに参照し合っている場合、どちらも解放されない）が発生する可能性がある。

2. **マーク＆スイープ（Mark and Sweep）**
   トレースアルゴリズムのひとつ。全てのオブジェクトをマークしてから、再びトラバース(横断することや横切ること)し、使用されていないオブジェクトを「スイープ（掃除）」する。循環参照問題は解決できるが、実行時のパフォーマンスに一定のコストがかかる。

3. **コピー型ガベージコレクション（Copying Garbage Collection）**
   メモリを複数の領域（通常は 2 つ）に分割し、使用中のオブジェクトを一つの領域から他の領域へコピーする。これにより断片化を防ぐが、メモリ消費が増える可能性がある。

4. **ジェネレーショナルガベージコレクション（Generational Garbage Collection）**
   オブジェクトの寿命に基づいてメモリを複数の「世代（generation）」に分割し、若い世代のオブジェクトの回収を頻繁に行い、古い世代のオブジェクトに関しては回収の頻度を下げる方式。これにより、パフォーマンスが向上する。

## ガベージコレクションの利点と欠点

**利点：**

- プログラマが手動でメモリ管理を行う必要がないため、コードが簡潔になり、メモリリークやダングリングポインタなどのバグを減少させる。
- メモリの効率的な使用が期待できる。

**欠点：**

- ガベージコレクタが実行される際に一時的なパフォーマンスの低下が生じる可能性がある。
- リアルタイムシステムや非常に高性能を要求されるシステムでは、必ずしも最適な解決策ではないことがある。

## GCが存在しない言語

ガベージコレクションが存在しない、すなわちメモリ管理を手動で行う必要があるプログラミング言語

1. **C言語**
   C言語ではメモリ管理をプログラマが明示的に行う必要がある。動的メモリ確保には `malloc()` や `calloc()` のような関数を使用し、不要になったメモリは `free()` 関数を使って解放する。ガベージコレクションは存在しない。

2. **C++**
   C++もまた、C言語と同様に手動でメモリ管理を行うことが求められる。動的メモリの確保には `new` キーワードを使用し、不要になったオブジェクトは `delete` キーワードで解放する。ただし、C++ではスマートポインタ（`std::unique_ptr`, `std::shared_ptr`など）など、メモリ管理を部分的に自動化するためのライブラリやツールも提供されている。

3. **Rust**
   Rustは所有権（ownership）と借用（borrowing）という概念を用いてメモリ管理を行う。Rustはコンパイル時にメモリの安全性を保証するため、ガベージコレクションは不要。Rustでは所有権が自動的に管理され、スコープを抜けたときにメモリが解放される。

4. **Assembly（アセンブリ言語）**
   アセンブリ言語は非常に低レベルなプログラミング言語であり、メモリ管理を完全に手動で行う必要がある。メモリ管理のためにはシステムコールなどを使用する。
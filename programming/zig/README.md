# Zig

Zigは、現代のシステムプログラミングのための革新的かつ高性能なプログラミング言語で、次世代のシステムプログラミング言語と言われることがある。Zigは、他の多くのシステム言語における設計上の課題を解決しつつ、より効率的で予測可能なコードを作成するためのツールを提供する。

Zigは、そのシンプルさ、高パフォーマンス、厳格なエラーハンドリングを通じて、システムプログラミングに新しいアプローチを提供する。現代のシステム開発において、安全で効率的なコードを書くための強力なツールとなる。

## 特徴と設計理念

Zigの設計は以下の重要な理念に基づいている。

1. **シンプルさ**:
    - 直感的で理解しやすい構文。
    - より少ない規則と一貫した言語設計を重視。

2. **規約の厳格性**:
    - 未初期化変数の禁止。
    - 例外の代わりにエラーコードを使用。
    - 安全性と予測可能な動作のためのコンパイル時の検査。

3. **高パフォーマンス**:
    - 高度な最適化と低オーバーヘッドの実現。
    - 「C」を置き換えることができるパフォーマンス。

4. **エラーハンドリング**:
    - エラーリターントレースをサポート。
    - エラーハンドリングの際の低いオーバーヘッド。

5. **無依存性**:
    - GC（ガベージコレクション）や特定のランタイムに依存しない設計。
    - アロケータをプログラム可能なパターンとして扱う。

## 基本構文

### Hello World

最初のZigプログラムは、他の言語と同様に「Hello, World!」の出力から始める。

```zig
const std = @import("std");

pub fn main() !void {
    const stdout = try std.io.getStdOut().writer();
    try stdout.print("Hello, World!\n", .{});
}
```

- `@import("std")`は、Zigの標準ライブラリをインポートする。
- `pub fn main() !void` は、公開されたエントリーポイント。
- `try` は、エラーを自動で返すために用いる。

### データ型と変数

Zigは、いくつかの基本データ型をサポートし、それぞれの変数は型を明示的に宣言する必要がある。

```zig
const num: i32 = 10;
const decimal: f64 = 4.5;
const isTrue: bool = true;
```

整数型や浮動小数点型、ブール値などが含まれる。

### 関数

シンプルな関数の定義と呼び出し:

```zig
fn add(x: i32, y: i32) i32 {
    return x + y;
}

const result = add(5, 3); // result は 8になる
```

### 制御構文

Zigは通常の制御構文（条件文、ループ）も一通りサポートしている。

- **条件文**

```zig
if (num > 5) {
    // 処理
} else {
    // それ以外の処理
}
```

- **ループ**

```zig
var i: usize = 0;
while (i < 10) {
    // 処理
    i += 1;
}

for (i, 0..10) |i| {
    // 処理
}
```

### エラーハンドリング

Zigのエラーハンドリングは独特で、`try`キーワードを使ってエラーを簡潔にコントロールできる。

```zig
fn mightFail() !void {
    return error.SomeError;
}

pub fn main() void {
    const result = mightFail();
    if (result) |value| {
        // 成功時の処理
    } else |err| {
        // エラー発生時の処理
    }
}
```

### メモリ管理

Zigは、メモリ管理において明示的な管理を要求する。標準ライブラリで提供されるアロケータを使用してメモリを管理する。

```zig
const std = @import("std");
const allocator = std.heap.page_allocator;

var buffer = try allocator.alloc(u8, 1024);
// メモリ利用
allocator.free(buffer);
```

## コンパイルと実行

Zigのコンパイルは非常に簡単で、コマンドラインから直接コンパイルできる。

```bash
zig build-exe main.zig
./main
```

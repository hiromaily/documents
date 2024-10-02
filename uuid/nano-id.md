# NanoID

NanoID は、短くてユニークな識別子（ID）を生成するためのライブラリおよびアルゴリズム。非常に高いユニーク性と柔軟性を持ち、さまざまなプログラミング言語で利用可能なため、多種多様な用途に適している。UUID や ULID と比較しても、特に ID の短さや暗号学的な強度を求める場合に優れた選択肢となる。

## NanoID の特長

NanoID は、他の識別子生成方法（例えば、UUID や ULID）と比較して、以下のような特長がある

1. **短い**：NanoID は一般的に 21 文字の英数字で構成されますが、文字数は任意に変更可能。
2. **ユニーク性**：暗号学的に強力な乱数生成アルゴリズムを使用しているため、高いユニーク性が保証される。
3. **可読性**：使用する文字セットをカスタマイズすることで、人間にとって読みやすく、覚えやすい ID を生成できる。
4. **ランダム性**：NanoID は暗号学的に安全な乱数生成を行うため、他の方法に比べて予測不可能性が高い。
5. **軽量**：ライブラリ自体が非常に軽量で、さまざまなプログラミング言語で利用可能。

## NanoID の構造

デフォルト設定では、NanoID はランダムに選ばれた 21 文字の英数字から構成される。デフォルトの文字セットは以下の 32 種類

```txt
0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz-
```

ただし、必要に応じてカスタム文字セットや異なる長さの ID を生成することができる。

## NanoID の生成方法

NanoID は、暗号学的に安全な乱数生成アルゴリズムを使用して次のように生成される

1. **ランダムバイトの生成**：
   - システムに依存した暗号学的に安全な乱数生成器（CRNG）を使用して必要なランダムバイトを生成する
2. **ランダムバイトのエンコーディング**：
   - 生成されたバイトを対応する文字セットにマッピングして、最終的な ID を生成する

## 使用例

以下の例は JavaScript で NanoID を使用してユニークな識別子を生成する方法

```js
// NanoIDのインストール
// npm install nanoid

const { nanoid } = require("nanoid");

// デフォルトの21文字のNanoIDを生成
const id = nanoid();
console.log(id); // 例えば、'V1StGXR8_Z5jdHi6B-myT'

// カスタム長さのNanoIDを生成
const longId = nanoid(30);
console.log(longId); // 例えば、'V1StGXR8_Z5jdHi6B-myTV1StGXR8_Z5'

// カスタム文字セットのNanoIDを生成
const { customAlphabet } = require("nanoid");
const nanoidCustom = customAlphabet("0123456789ABCDEF", 10);
console.log(nanoidCustom()); // 例えば、'4C1D9A2E3B'
```

## 利用例

NanoID は以下のようなシナリオでよく使用される

- REST API のエンドポイントでのリソース識別子
- トランザクション ID
- クッキーやセッション ID
- カスタム短縮 URL の生成
- 分散システムでの一意識別子

## パフォーマンスとユニーク性

NanoID は暗号学的に安全な乱数生成を行うため、非常に高いユニーク性を持つ。また、生成速度も高速で、特に短い ID を必要とするシナリオで効果的

## References

- [Generating 10 Million Unique IDs: Which Is Faster, UUID, ULID, or NanoID?](https://prabeshthapa.medium.com/optimizing-your-system-with-the-right-unique-id-uuid-ulid-or-nanoid-78bf8b7bf200)

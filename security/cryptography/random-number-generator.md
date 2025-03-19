# 擬似乱数生成器 / Random Number Generator

WIP

[内部Docs: 乱数生成](../../algorithm/random-number.md)

## 疑似乱数生成器（Pseudo-Random Number Generator, PRNG）の種類

疑似乱数生成器（Pseudo-Random Number Generator, PRNG）は、あるアルゴリズムに基づいて予測可能だが見かけ上ランダムな数列を生成するもの。用途によって選ばれるべきPRNGが異なるため、用途に応じて適切な乱数生成器を選択することが重要。

以下にいくつかの代表的なPRNGの種類を挙げる。

1. **PCG-DXSM**:
    - 高速かつ統計的にランダム性が保証された擬似乱数生成器を導入。
    - `math/rand/v2`で導入
2. **ChaCha8**:
    - 暗号学的に強固な乱数生成器であり、従来の乱数生成器よりもセキュリティ面で優れている。グローバル乱数生成器として採用されている。
    - `math/rand/v2`で導入
3. **線形合同法（Linear Congruential Generator, LCG）**
    - 数式：\( X_{n+1} = (aX_n + c) \mod m \)
    - 非常にシンプルな方法ですが、欠点として周期が短い場合や値の分布が不均一になることがある。

4. **メルセンヌ・ツイスタ（Mersenne Twister）**
    - 高速かつ長い周期を持つ（約 \(2^{19937} - 1\)）。
    - 多くのプログラミング言語（例えばPythonの標準ライブラリ）で採用されている。

5. **中間平方法（Middle Square Method）**
    - 乱数を得るために中間の平方値を計算する方法。
    - 収束や周期性が問題となることがあるため、実用性は限定的。

6. **Xorshift**
    - ビット操作（XOR, シフト）を用いる軽量な乱数生成器。
    - 高速であるが、それでも注意が必要な場合がある。

7. **Linearly Recurrent Shift Register (LFSR)**
    - シフトレジスタを用いる方法。
    - ハードウェアで実装されやすいため、デジタル回路でよく利用される。

8. **線形帰還シフトレジスタ (Linear Feedback Shift Register, LFSR)**
    - 特定の位置のビットからフィードバックを受けて新しいビットを生成する方式。
    - 限定的な周期を持つが、高速で実装が容易。

9.  **ISAAC**（Indirection, Shift, Accumulate, Add, and XOR）
10. **Xoroshiro**
11. **SplitMix64**

## References

- [「真の乱数」を生成するためにCloudflareが波マシンを設置](https://gigazine.net/news/20250319-chaos-in-cloudflare-lisbon-wave/)

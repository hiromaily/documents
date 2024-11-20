# 対称鍵暗号アルゴリズム / AES (Advanced Encryption Standard)

AES（Advanced Encryption Standard）は、データの暗号化に広く使用されている対称鍵暗号アルゴリズム

## AES の歴史と背景

AES は、1977 年にアメリカ国立標準技術研究所（NIST）が標準化した DES（Data Encryption Standard）の後継として 1997 年に公募された。2001 年にベルギーの Joan Daemen と Vincent Rijmen によって開発された「Rijndael」が AES として選定され、FIPS 197 として標準化された。

## AES の特徴

1. **鍵長**:

   - AES は 3 つの鍵長（128, 192, 256 ビット）をサポートしている。これにより、様々なセキュリティレベルとパフォーマンス要求に応じることができる。

2. **対称鍵暗号**:

   - 同じ鍵を使ってデータを暗号化および復号する方式。これにより、鍵を安全に共有する必要がある。

3. **ブロック暗号**:
   - 固定長のデータブロック（AES では 128 ビット）を暗号化する。長いメッセージの場合は、ブロックモードを使用して連続的に暗号化処理を行う。

## AES の内部構造とアルゴリズム

AES は複数の処理ラウンドで成り立っている。ラウンド数は鍵の長さに応じて異なる（128 ビット鍵で 10 ラウンド、192 ビット鍵で 12 ラウンド、256 ビット鍵で 14 ラウンド）。
以下に AES の主要な処理ステップを説明する：

1. **初期鍵追加**（AddRoundKey）:

   - 最初のステップでは、平文ブロックに対して初期ラウンド鍵を XOR 演算する。

2. **ラウンド処理**:

   - 各ラウンドは以下の 4 つのサブステップで構成される。
     - **SubBytes**: 非線形なバイト代わり（Substitution）。S-box と呼ばれる固定ルックアップテーブルを通じて各バイトを置き換える。
     - **ShiftRows**: 行シフト（Permutation）。ステートの各行を左に回転させる。
     - **MixColumns**: 列混合（Mixing）。各列に対して特定の行列と乗算し、新しい列を作る。
     - **AddRoundKey**: ラウンド鍵をステートに XOR。

3. **最終ラウンド**:
   - 最終ラウンドでは、MixColumns ステップをスキップし、残りのステップだけを行う。

## AES の利点

1. **セキュリティの高い設計**:

   - AES は広範な解析と評価を経て、非常に強力なセキュリティを提供することが立証されている。攻撃に対して強固であり、現代のコンピューティングパワーでは実質的に解読不可能。

2. **高速処理**:

   - ソフトウェアとハードウェアの両方で非常に高速に実行することが可能であり、さまざまなプラットフォームで効率的に動作する。

3. **柔軟性**:
   - 各種の鍵長とブロックモードをサポートしているため、さまざまなアプリケーションとセキュリティ要件に適応することができる。

## AES の使用例

AES は広範な用途に利用されている。以下にいくつかの代表的な例を示す。

1. **データ保護**:

   - データベースの暗号化、ファイルシステムの暗号化、バックアップデータの保護など、静的データの保護に使用される。

2. **通信の保護**:

   - HTTPS、TLS/SSL、VPN など、ネットワーク通信の保護に使用される。

3. **ハードウェアの保護**:
   - AES はハードディスクのフルディスク暗号化、セキュアブート、DRM（デジタル著作権管理）など、ハードウェアレベルでのデータ保護に利用される。

## ブロック暗号の運用モード

暗号アルゴリズム（特にブロック暗号）にはいくつかの運用モードがあり、それぞれ異なる特性と適用シナリオを持っている。以下に代表的なブロック暗号モードを比較する。

### 1. GCM（Galois/Counter Mode）モード

**特徴**:

- セキュリティーが最も強力
- 認証付き暗号。
- CTR モードをベースに、Galois Hash を使用してメッセージ認証コード（MAC）を生成。

**利点**:

- 並列処理が可能。
- 高速で、データ完全性を保証。

**欠点**:

- 実装においてやや複雑（特に認証部分）。
- 暗号化時に算出されるnonce値を符号化の際にも必要となる

**使用例**:

- セキュリティとデータ完全性が重要な通信（例：TLS/SSL）。

### 2. CTR（Counter）モード

**特徴**:

- 高速
- それぞれのブロックはカウンター値の暗号化結果と平文を XOR。
- カウンタベースのため、並列計算が可能。

**利点**:

- 高速（並列処理可能）。
- 任意長のデータ処理に向く。

**欠点**:

- カウンタの再利用でセキュリティ低下。

**使用例**:

- 高速なストリーム暗号が必要な場合

### 3. OFB（Output Feedback）モード

**特徴**:

- ストリーム暗号として動作するが、各ブロックは事前計算されたキーストリームと XOR される。
- 次のキーストリームは前のキーストリームの暗号化結果を基に生成される。

**利点**:

- 誤り伝播がない。
- 事前計算可能（暗号文のみの再利用も可能）。

**欠点**:

- IV が重要（同じ IV の再利用でセキュリティ低下）。

**使用例**:

- ストリームの暗号化

### 4. CBC（Cipher Block Chaining）モード (古典的なデータ暗号化)

**特徴**:

- 各ブロックは前の暗号ブロックと XOR された後に暗号化される。
- 初期化ベクトル（IV）が必要。

**利点**:

- 同一平文ブロックが異なる暗号ブロックになる。
- パターンは隠される。

**欠点**:

- 暗号化プロセスは直列的（並列処理が難しい）。
- 復号は並列処理が可能。

**使用例**:

- 古典的なデータ暗号化

### 5. CFB（Cipher Feedback）モード

**特徴**:

- 速度が遅い
- ストリーム暗号として動作する。
- 各平文ブロックは前の暗号ブロック（暗号化されたフィードバック）と XOR された後暗号化される。

**利点**:

- 誤り伝播が限定的（異なる長さも持てる）。
- ストリーム暗号のような性質。

**欠点**:

- 速度が遅い（連続的操作が必要）。

**使用例**:

- ストリームデータのリアルタイム暗号化

### 6. ECB（Electronic Codebook）モード (使用すべきではない)

**特徴**:

- 各ブロックを独立して暗号化。
- 平文の同じブロックは同じ暗号文ブロックに暗号化される。

**利点**:

- 実装が簡単。
- 並列処理が可能。

**欠点**:

- 同一パターンが維持されるため、解析されやすい（例えば、画像データの暗号化には不適）。

**使用例**:

- セキュリティが重要でない場合

### 比較

- **セキュリティ面**: ECB は最も弱、GCM は最も強力（認証付き暗号）。
- **並列処理**: CTR と GCM は並列処理に強い。CBC は暗号化で直列処理が必要。
- **誤り伝播**: CFB は狭い誤り伝播、CBC は広い誤り伝播。
- **用途**: EVP や CFB はリアルタイムストリーム、CBC や GCM は文書などのデータ保護に適している。

暗号化モードの選択は、具体的な使用シナリオと要件（例えば、データの機密性、完全性、パフォーマンス要件など）に依ります。例えば、GCM は TLS などのプロトコルで広く採用されていますが、シンプルなセキュリティ用途には CTR や CBC が用いられることも多いです。

## Go 言語を使った AES の実装例

以下のコードサンプルは、Go で AES-256 を使った暗号化と復号の実装例。AES-GCM モードを利用して、高速で安全な暗号化を行っている。

```go
package main

import (
    "crypto/aes"
    "crypto/cipher"
    "crypto/rand"
    "encoding/hex"
    "fmt"
    "io"
)

// encrypt encrypts plaintext using a given key with AES-GCM.
func encrypt(plaintext, key []byte) (ciphertext, nonce []byte, err error) {
    block, err := aes.NewCipher(key)
    if err != nil {
        return nil, nil, err
    }

    aesGCM, err := cipher.NewGCM(block)
    if err != nil {
        return nil, nil, err
    }

    nonce = make([]byte, aesGCM.NonceSize())
    if _, err = io.ReadFull(rand.Reader, nonce); err != nil {
        return nil, nil, err
    }

    ciphertext = aesGCM.Seal(nil, nonce, plaintext, nil)
    return ciphertext, nonce, nil
}

// decrypt decrypts ciphertext using a given key and nonce with AES-GCM.
func decrypt(ciphertext, nonce, key []byte) (plaintext []byte, err error) {
    block, err := aes.NewCipher(key)
    if err != nil {
        return nil, err
    }

    aesGCM, err := cipher.NewGCM(block)
    if err != nil {
        return nil, err
    }

    plaintext, err = aesGCM.Open(nil, nonce, ciphertext, nil)
    if err != nil {
        return nil, err
    }

    return plaintext, nil
}

func main() {
    key := []byte("thisis32bitlongpassphraseimusing!") // 32 bytes key for AES-256
    plaintext := []byte("Hello, World!")

    ciphertext, nonce, err := encrypt(plaintext, key)
    if err != nil {
        fmt.Println("Error encrypting:", err)
        return
    }

    fmt.Printf("Ciphertext: %s\n", hex.EncodeToString(ciphertext))
    fmt.Printf("Nonce: %s\n", hex.EncodeToString(nonce))

    // Decrypt the message
    decryptedPlaintext, err := decrypt(ciphertext, nonce, key)
    if err != nil {
        fmt.Println("Error decrypting:", err)
        return
    }

    fmt.Printf("Decrypted: %s\n", string(decryptedPlaintext))
}
```

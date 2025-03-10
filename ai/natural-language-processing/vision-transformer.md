# Vision Transformer（ViT）

Vision Transformer（ViT）は、自然言語処理（NLP）での成功を収めた`Transformerアーキテクチャ`を画像認識タスクに応用したモデル。具体的には、Transformerの自己注意メカニズムを用いて画像データから特徴を抽出し、画像分類を行う。ViTは、Google Researchによって提案され、2020年に発表された。

## Transformerとは

Transformerは、Seq2Seq問題に対処するために設計され、特にNLPで広く利用されている。
主なコンポーネントは以下の通り

1. **自己注意機構（Self-Attention Mechanism）**:
    - 各単語が他の単語に対してどれだけ重要かを評価する。
    - クエリ（Query）、キー（Key）、バリュー（Value）というベクトルを用いる。

2. **エンコーダとデコーダ（Encoder-Decoder Architecture）**:
    - エンコード処理で入力データを高次元ベクトルに変換し、デコード処理でそのベクトルから出力を生成する。

3. **マルチヘッド注意機構（Multi-Head Attention Mechanism）**:
    - 自己注意機構を並列に実行し、異なる部分空間での情報を捕える。

## ViTのアーキテクチャ

ViTは、画像をパッチ（小さな部分画像）に分割し、それぞれのパッチをグリッドに並べて1次元のシーケンスデータとして扱う。
以下がViTの主な要素

1. **画像パッチ分割（Image Patch Partitioning）**:
    - 入力画像（例えば224x224ピクセル）を固定サイズのパッチ（例えば16x16ピクセル）に分割。
    - ここで、各パッチは16x16x3のベクトルになります（RGBの3チャネル）。

2. **線形埋め込み（Linear Embedding）**:
    - 各パッチを固定サイズのベクトル（例えば768次元）に埋め込み。
    - これにより、パッチが一連のベクトルとして扱われるようになる。

3. **位置符号化（Position Embedding）**:
    - パッチの位置情報を追加するために、位置エンコーディングを使う。これは、Transformerがシーケンシャルなデータを扱う前提で設計されているため。

4. **Transformerエンコーダ（Transformer Encoder）**:
    - ViTの主な計算部分であり、NLPのTransformerと同様に自己注意機構とフィードフォワードネットワークで構成される。
    - 通常、複数のエンコーダ層がスタックされる（例えば12層、16層、24層など）。

5. **分類ヘッド（Classification Head）**:
    - エンコーダの出力を用いて最終的なクラス予測を行う。通常、[CLS]トークンが使われ、その出力が最終的な分類ヘッドに渡される。

## ViTの学習

ViTは、通常の学習プロセスとして大量のデータセットを使用する。以下がその一般的な手順

1. **前処理**:
    - 画像データをパッチに分割し、線形埋め込みと位置符号化を行う。

2. **モデルの訓練**:
    - 過去のラベル付きデータに基づいてモデルを訓練する。クロスエントロピー損失関数やその他の損失関数を使用する。

3. **ハイパーパラメータのチューニング**:
    - トレーニングデータと検証データで性能を評価し、モデルのハイパーパラメータ（例えば、層の数、埋め込みの次元数、学習率など）を調整する。

## ViTの特徴と利点

1. **スケーラビリティ**:
    - ViTは大量のデータに適しており、モデルサイズを大きくすることで性能が向上する。

2. **柔軟性**:
    - 画像だけでなく、他の形式のデータにも適用可能（e.g. Video, Text）

3. **性能**:
    - 十分に大きなデータセットで訓練された場合、従来の`CNN`を凌ぐ性能を発揮する。特にImageNetのような大規模データセットで顕著。

## 課題と制約

1. **データの必要性**:
    - ViTは大量のデータを必要とし、中小規模のデータセットでの性能は限定的。

2. **計算資源**:
    - 訓練に計算リソースが多く必要となる。特に、自己注意機構は計算量がO(n^2)に依存し、大規模な画像では計算が重くなる。

## まとめ

Vision Transformer（ViT）は、Transformerアーキテクチャを画像認識に応用したもので、画像を固定サイズのパッチに分割して処理する。ViTは大規模データセットで強力な性能を発揮し、従来のCNNを補完するか、置き換えることが可能。ただし、訓練には大量のデータと計算リソースが必要。今後の研究や技術の進展によって、ViTはさらに進化する可能性がある。

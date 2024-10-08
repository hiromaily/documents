# 圧縮フォーマット

各圧縮形式にはそれぞれの利点と適用シナリオがあり、選択する際には、圧縮率、圧縮速度、対応プラットフォーム、セキュリティ機能（例えば暗号化やパスワード保護）などを考慮することが重要。

## ZIP

- **アルゴリズム**: 主に DEFLATE を使用。DEFLATE は LZ77 とハフマン符号化を組み合わせたもの。
- **特徴**:
  - 非可逆圧縮をサポート。
  - 広く利用されており、ほとんどのオペレーティングシステムやアーカイブソフトウェアでサポートされている。
  - パスワード保護や暗号化オプションがある。

## RAR

- **アルゴリズム**: 主に LZSS と予測符号化を使用。
- **特徴**:
  - 高い圧縮率と効率的なファイル復元力。
  - マルチボリュームアーカイブやパスワード保護、復元レコードによるデータの修復機能が強力。
  - パスワード保護や暗号化オプションもあり。

## 7z (7-Zip)

- **アルゴリズム**: LZMA（Lempel-Ziv-Markov chain algorithm）を使用。LZMA は非常に高い圧縮率と速度を持つ。
- **特徴**:
  - 非常に高い圧縮率。通常 ZIP や RAR よりも高圧縮率を実現。
  - 暗号化（AES-256）や固体圧縮、マルチボリュームアーカイブなど機能が豊富。

## TAR (Tarball)

- **アルゴリズム**: 圧縮自体のアルゴリズムは使用せず、複数のファイルを 1 つにまとめるための形式。圧縮は通常 gzip や bzip2 と組み合わせて行う。
- **特徴**:
  - UNIX 環境で広く使用。
  - シンプルな構造で、gzip や bzip2 と組み合わせて高圧縮率を実現。

## GZ (gzip)

- **アルゴリズム**: DEFLATE を使用。
- **特徴**:
  - 単一ファイルの圧縮に主に使われる。
  - TAR と併用して使われることが多い（.tar.gz、.tgz）。

## BZ2 (bzip2)

- **アルゴリズム**: バロース・ウィーラー変換（BWT）とランレングス符号化（RLE）、ハフマン符号化を組み合わせたもの。
- **特徴**:
  - gzip よりも高圧縮率を実現するが、圧縮と解凍がやや遅い。
  - TAR と併用して使われることが多い（.tar.bz2）。

## XZ

- **アルゴリズム**: LZMA2 アルゴリズムを使用。
- **特徴**:
  - 7z と同様に非常に高い圧縮率を持つ。
  - 高速かつ効率的なデータ圧縮。
  - TAR と併用して使われることが多い（.tar.xz）。

## その他の形式

- **ARJ**: 古いアーカイブ形式で、DOS 時代に広く使用された。
- **LZH**: 日本国内で一時的に広く使われた形式。Lempel-Ziv-Huffman の略。
- **CAB**: Microsoft のインストーラパッケージ形式に使用。

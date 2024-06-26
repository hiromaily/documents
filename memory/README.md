# Memory

## ヒープとスタック

プログラムが実行される際、メモリは主に以下の領域に分かれる

- ヒープ領域
- スタック領域
- 静的領域
- テキスト領域

### スタック領域

- 関数呼び出しやローカル変数の割り当てに使われる
- プログラム実行時のメモリの管理方法
  - 関数の呼び出し時に自動的に割り当てられ、関数の終了とともに自動的に解放される
- データ構造
  - 後入れ先出し（LIFO）のデータ構造
  - 確保したのとは逆の順番で解放するのがスタック領域の特徴

### ヒープ領域

- プログラム実行中に必要なサイズのメモリを動的に確保・解放するのに利用される
- プログラム実行時のメモリの管理方法
  - プログラマが明示的にメモリの確保（malloc など）と解放（free など）を行う必要がある
  - これにより、動的なメモリ管理が可能になる
- データ構造
  - ヒープ領域には順序がない
  - どのような順序で確保・解放するかは、ソフトウェア側で自由に決められるため、柔軟性が高い

### 比較

- ヒープへのデータアクセスは、スタックのデータへのアクセスよりも低速

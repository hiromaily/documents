# FlatBuffers

[Official](https://flatbuffers.dev/)

FlatBuffers は、Google によって開発された高パフォーマンスのバイナリシリアライゼーションライブラリ。データを効率的にシリアライズおよびデシリアライズ（エンコードおよびデコード）するためのフォーマットおよびツールセットを提供する。特に、低レイテンシが求められるゲーム開発やリアルタイムアプリケーション向けに設計されている。
FlatBuffers は、そのユニークな特性から、特にパフォーマンスが重要視されるリアルタイムアプリケーションにおいて強力なツールとなる。

## 特徴

- **高速なアクセス**: サイズが固定のテーブルを使用しているため、パース時にメモリアロケーションを必要とせず、非常に高速にデータにアクセスすることができます。
- **スキーマ駆動**: スキーマ定義ファイル（`.fbs`ファイル）を使って、データの形式を予め定義します。これにより、データフォーマットの変更がしやすくなります。
- **ランタイム最適化**: ランタイムで特別なデコード処理が不要で、そのままメモリ内のデータを使えます。これはパフォーマンスの大幅な向上に寄与します。
- **互換性**: 多くのプログラミング言語（C++, C#, C, Go, Java, JavaScript, TypeScript, PHP, Python, Dart, Rust など）をサポートしています。

## 使用方法

### スキーマ定義

まず、データ構造をスキーマファイル（`.fbs`ファイル）で定義します。例：

```flatbuffers
table Monster {
  hp:int;
  mana:int;
  name:string;
}
root_type Monster;
```

### スキーマのコンパイル

`flatc`というコンパイラを使用して、スキーマ定義から対応する言語のバインディングを生成します。例えば、Python のコード生成は以下のようにします：

```
flatc --python monster.fbs
```

### コードでの使用

生成されたバインディングを使用して、データのシリアライズとデシリアライズを行います。例（Python の場合）：

データのシリアライズ：

```python
import FlatBuffers

# FlatBuffersのビルダーを作成
builder = flatbuffers.Builder(0)

# 名前の文字列を追加
name = builder.CreateString("Orc")

# モンスターのデータを追加
Monster.MonsterStart(builder)
Monster.MonsterAddHp(builder, 300)
Monster.MonsterAddMana(builder, 150)
Monster.MonsterAddName(builder, name)
monster = Monster.MonsterEnd(builder)

# ビルドを完了
builder.Finish(monster)

# シリアライズされたバイト配列を取得
buf = builder.Output()
```

データのデシリアライズ：

```python
# バイト配列からバッファーを作成
buf = bytearray(builder.Output())
monster = Monster.Monster.GetRootAsMonster(buf, 0)

# データにアクセス
print(monster.Hp())      # 300
print(monster.Mana())    # 150
print(monster.Name())    # Orc
```

## 用途

FlatBuffers は、高速なデータ転送やゲームの状態の管理、ネットワークのプロトコル、ファイルフォーマット、メッセージングシステムなど、リアルタイム性が重視される多くの分野で利用されています。また、gRPC 等の通信プロトコルの基盤としても用いられることがあります。

## 利点と欠点

### 利点

1. **高パフォーマンスと省メモリ**: シリアライズとデシリアライズが非常に高速で、メモリの使用量も抑えることができます。
2. **ランタイムの最適化**: データにアクセスする際に追加のデコード処理が不要です。
3. **拡張性**: スキーマのバージョン管理が簡単に行えます。

### 欠点

1. **複雑さ**: 初期設定やスキーマの管理が少し複雑です。
2. **非テキスト性**: バイナリ形式のため、デバッグや手動編集が難しいです。

# Sucrase

Sucraseは、JavaScript・TypeScriptのトランスパイラであり、開発中のトランスパイリングを高速化するために設計されており、BabelやTypeScriptコンパイラ（tsc）の代替として使用することができる。特にホットリロードやウォッチモードでの高速トランスパイルに強みを持つ。

## 主な特徴

1. **高速性**:
   - Sucraseはトランスパイリングに特化しており、他のトランスパイラ（例：BabelやTypeScriptコンパイラ）に比べて非常に高速。

2. **シンプルな設定**:
   - 設定が非常にシンプルで、迅速にセットアップできる。

3. **限定的なトランスパイル機能**:
   - Sucraseは、開発中のトランスパイルに焦点を当てているため、プロダクションビルドには向いていない。特定のケースでは、完全なトランスパイル機能が求められるため、BabelやTypeScriptコンパイラが推奨される。

4. **プラグイン不要**:
   - 一部の機能（たとえばTypeScriptの完全サポート）にフォーカスしないことで、シンプルなアーキテクチャを維持している。

## 基本的な使い方

### 1. インストール

```sh
npm install --save-dev sucrase
```

### 2. CLIの使用例

ファイルやディレクトリをトランスパイルするためのコマンド

```sh
sucrase ./src -d ./dist --transforms typescript,jsx
```

### 3. スクリプトの設定例

`package.json`のscriptsセクションにスクリプトを追加して、簡単に実行できる

```json
{
  "scripts": {
    "build": "sucrase ./src -d ./dist --transforms typescript,jsx"
  }
}
```

### 4. 開発中のホットリロード

例えば、Node.jsアプリケーションで使用する場合には以下のような設定が考えられる

```sh
npx sucrase-node src/index.ts
```

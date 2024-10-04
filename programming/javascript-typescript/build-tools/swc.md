# SWC

SWC (Speedy Web Compiler) は、高速なJavaScript と TypeScript のコンパイラであり、トランスパイラとしてよく利用される。
SWCはRustで実装されており、その高速性と効率性が大きな特徴。SWCはJavaScriptとTypeScriptのコードを非常に高速にコンパイルおよびトランスパイルするために設計されており、例えばBabelやTerserの代替として使用される。

SWCはその高速性と効率性から、特に大規模なプロジェクトやTypeScriptプロジェクトにおいて非常に有用。Babelなどの既存のツールと比較しても、非常に迅速なトランスパイルとミニファイを提供する。他のビルドツールと比較しても、特に高速なビルドを重視する場合にはSWCを選択する価値がある。

## 主な特徴

1. **高速なパフォーマンス**:
   - SWCはRustで書かれているため、非常に高速。大規模なコードベースでも高速なコンパイル時間を実現する。

2. **JavaScriptとTypeScriptのサポート**:
   - 最新のJavaScript（ECMAScript）の標準に対応しており、TypeScriptのコンパイルもサポートしている。

3. **トランスパイルおよびミニファイ**:
   - 一部のビルドツールでは、トランスパイリングとミニファイの両方を行うためにSWCを利用している。

4. **設定のシンプルさ**:
   - SWCの設定はシンプルで、`.swcrc`ファイルで管理できる。

5. **プラグインシステム**:
   - 拡張可能なプラグインシステムが提供されており、スコープを広げることができる。

## 基本的な使い方

### 1. インストール

まず、SWCのCLIをインストール

```sh
npm install -g @swc/cli @swc/core
```

### 2. 必要な設定ファイル

プロジェクトディレクトリに`.swcrc`という設定ファイルを作成

```json
{
  "jsc": {
    "parser": {
      "syntax": "typescript",
      "tsx": true
    },
    "transform": {
      "react": {
        "pragma": "React.createElement",
        "pragmaFrag": "React.Fragment",
        "throwIfNamespace": true,
        "development": false,
        "useBuiltIns": true
      }
    }
  },
  "module": {
    "type": "commonjs"
  }
}
```

### 3. トランスパイリングの実行

以下のコマンドでTypeScriptファイルをトランスパイルする

```sh
swc src -d dist
```

### 4. JavaScriptファイルのミニファイ

```sh
swc src/index.js -o dist/index.min.js --minify
```

## 使用ケース

1. **高速なトランスパイリングが求められる場合**:
   - 特に大規模プロジェクトやTypeScriptプロジェクトでのトランスパイリング速度を重視する場合。

2. **BabelやTerserの代替**:
   - BabelやTerserの代替として、より高速なトランスパイリングやミニファイを求める場合。

3. **シンプルな設定**:
   - 簡単な設定で高速なコンパイルを実現したい場合。

## まとめ

- [SWC](https://swc.rs/)は、Rust-based Compiler+Bundlerで、Babelより桁違いに高速。
- Super-fast Web Compileの略
- `esbuild`との比較が多いがあまり性能差はないように見える。[benchmark](https://swc.rs/docs/benchmarks)
- Babelよりはるかに高速とされている

## References

- [Official](https://swc.rs/)
- [github](https://github.com/swc-project/swc)
  - Star: 27.6k

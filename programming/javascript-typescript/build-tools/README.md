# Build Tools

Typescriptで書かれたファイルは`compile`, `bundle`, `minify` されなくてはならない

- General Build Tools
  - Vite
  - [Rome](https://rome.tools/)
- Bundlers
  - Browserify
- Compilers/Transpilers
  - SWC (Bundlerとしても使える)
  - Babel (JavaScript transpile)
  - SASS/LESS/Stylus (CSS preprocessors)

## ビルドプロセス

ビルドプロセスには、ソースコードを実行可能な形式に変換するためのさまざまなステップが含まれる。

1. **コードのトランスパイル**:
   - TypeScriptや最新のJavaScript（ES6+）を古いブラウザでも対応できるJavaScriptに変換する。（例えば、`TypeScriptコンパイラ`や`Babel`など）

2. **コードのモジュールバンドリング**:
   - 複数のモジュールや依存関係を一つのファイルまたはいくつかのファイルにまとめる。`Webpack`や`Rollup`がこのステップを担当

3. **デッドコードの除去**:
   - 使用されていないコード（デッドコード）を検出して削除する。これにより、出力ファイルのサイズを小さく保つことができる。

4. **ミニフィケーション（Minification）**:
   - JavaScriptやCSSコードを最適化し、ファイルサイズを小さくするために不必要な空白やコメントを削除し、変数名を短縮する。例えば、`Terser`や`UglifyJS`がこの処理を行う。

5. **ソースマッピング**:
   - デバッグを容易にするために、圧縮されたコードと元のコードとの対応関係を示すソースマップを生成する。これにより、ブラウザのデバッガで圧縮前のコードを表示できる。

6. **リソースバンドリング**:
   - 画像、フォント、CSSなどの静的リソースをバンドルに含めるか、適切なディレクトリにコピーする。たとえば、`Webpack`のfile-loaderやurl-loaderを使用する。

7. **環境依存の設定**:
   - 開発環境、ステージング環境、本番環境など、異なる環境ごとに異なる設定や変数を使用する場合、これらの設定を適用する。多くの場合、`dotenv`や`cross-env`などのツールを使用する。

8. **コードのリンティングとフォーマッティング**:
   - コードスタイルを統一し、品質を確保するために、リントツール（ESLintなど）やフォーマッタ（Prettierなど）を使う。ビルドプロセスの一部として自動化することが多い。

9. **テストの実行**:
   - ユニットテスト、統合テストなどを実行して、コードが期待通りに動作するか確認する。JestやMochaなどのテストフレームワークが使わる。

10. **ホットモジュールリプレースメント（HMR）**:
    - 開発中に、再ビルドせずにコードの一部を更新する機能。これにより、開発効率が向上する。Webpack Dev ServerやViteがこの機能を提供する。

11. **ビルド用のフォルダに出力**:
    - すべてのコードとアセットを最終的な出力フォルダ（例: distやbuildフォルダ）に配置する。

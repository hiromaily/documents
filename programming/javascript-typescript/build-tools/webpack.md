# Turbopack / Webpack

## Webpackの基本機能

1. **モジュールバンドリング**:
   - Webpackは多くのJavaScriptモジュール（および他の資産）を一つのバンドルにまとめることができる。このモジュールには、自前のJavaScriptコードだけでなく、Node.jsのパッケージも含まれる。

2. **エントリーポイント**:
   - `entry`プロパティでアプリケーションのエントリポイントを指定する。これはWebpackが依存関係グラフを作成する起点となる。

3. **出力**:
   - `output`プロパティでバンドルされたファイルの出力先と名前を指定する。

4. **ローダー**:
   - Webpackはローダーを使用して、JavaScript以外のファイル（例：TypeScript、CSS、画像など）を処理する。ローダーは特定のファイルタイプを変換する関数。

5. **プラグイン**:
   - プラグインは、バンドルプロセスを拡張するために使用される。例えば、圧縮、HTMLテンプレートの生成、環境変数の注入などができる。

6. **ホットモジュールリプレースメント (HMR)**:
   - コードの一部が変更されたときに、ページ全体を再読み込みすることなく、更新されたモジュールだけを実行中のアプリケーションに適用する機能。

## Webpackの特徴と利点

1. **柔軟性**:
   - 多くのプラグインとローダーが用意されており、非常に柔軟に設定が変更可能。

2. **エコシステムの広さ**:
   - 豊富なコミュニティとエコシステムがあり、さまざまな用途に対応したプラグインやローダーが存在する。

3. **ホットモジュールリプレースメント（HMR）**:
   - 開発体験の向上に非常に役立つ機能。

## 比較されるTools

- Vite
- esbuild
- Turbopack (後継)
# tsconfig.json

TSConfig.jsonは、TypeScriptコンパイラー（tsc）の動作を設定するための構成ファイルで、プロジェクトのディレクトリに配置される。これにより、コードベース全体にわたって一貫したコンパイル設定を適用することができる。

## 主な設定オプション

### `compilerOptions`

TypeScriptコンパイラーに関する設定を行うセクション

```json
"compilerOptions": {
  "target": "es6",                 // コンパイル後のJavaScriptのバージョン（es5, es6, es2015+など）
  "module": "commonjs",            // 使用するモジュールシステム（commonjs, esnext, amdなど）
  "strict": true,                  // 厳格な型チェックモードを有効にする
  "strictNullChecks": true,        // nullおよびundefinedを型システムで区別する
  "outDir": "./dist",              // コンパイル後の出力ディレクトリ
  "rootDir": "./src",              // それぞれのファイルの基点となるディレクトリ
  "baseUrl": "./",                 // モジュール解決の基点となるディレクトリ
  "paths": {                       // モジュールのエイリアスを設定
    "@src/*": ["src/*"]
  },
  "esModuleInterop": true,         // CommonJSとES Moduleの相互運用性を有効にする
  "forceConsistentCasingInFileNames": true, // ファイル名の大文字小文字の一貫性を強制
  "skipLibCheck": true,            // 型チェック中に定義ファイル（*.d.ts）のチェックをスキップ
  "resolveJsonModule": true,       // JSONファイルをインポート可能にする
  "isolatedModules": true          // 各ファイルを単独のモジュールとして扱う
}
```

### `include`

コンパイル対象のファイルやディレクトリを指定する

```json
"include": [
  "src/**/*.ts"
]
```

### `exclude`

コンパイル対象から除外するファイルやディレクトリを指定する

```json
"exclude": [
  "node_modules",
  "dist"
]
```

### `extends`

他のTSConfigファイルから設定を継承する

```json
"extends": "./base.tsconfig.json"
```

### `files`

特定のファイルをコンパイル対象として直指定する

```json
"files": [
  "src/main.ts"
]
```

### プロジェクト参照（Project References）

最大規模のプロジェクトにおいて依存関係を明示的に管理するための設定

```json
{
  "compilerOptions": {
    "composite": true,
    "declaration": true,
    "declarationMap": true
  },
  "references": [
    { "path": "./project1" },
    { "path": "./project2" }
  ]
}
```

### `typeRoots` と `types`

特定の型定義ファイル（@typesパッケージなど）の検索パスや使用する型定義を制限する

```json
"compilerOptions": {
  "typeRoots": [
    "./typings",
    "./node_modules/@types"
  ],
  "types": [
    "node",
    "jest" 
  ]
}
```

### `useUnknownInCatchVariables`

`try/catch`ブロックの`catch`変数がデフォルトで`unknown`になる（TypeScript 4.5+）

```json
"compilerOptions": {
  "useUnknownInCatchVariables": true
}
```

## References

- [tsconfig.json の最近の新機能　ファイルパス編](https://speakerdeck.com/uhyo/tsconfig-dot-jsonnozui-jin-noxin-ji-neng-huairupasubian)

# Custom Plugin for ESLint

- [Create Plugins](https://eslint.org/docs/latest/extend/plugins)
  - [Custom Rules](https://eslint.org/docs/latest/extend/custom-rules)
- [eslint plugin tutorial](https://github.com/Quramy/eslint-plugin-tutorial)
- [Beginner’s Guide to Custom ESLint Plugins](https://medium.com/@brandongregoryscott/beginners-guide-to-custom-eslint-plugins-77aca43f05c6)
- [【実装編】手を動かしながら学ぶ ESLint ルールの作り方](https://zenn.dev/kazuwombat/articles/2a870356528783)

## Glossary

- Plugin
  - ESLint の基本機能を拡張したパッケージで、多くの場合 1 つ以上のカスタムルールを含む
- Rule
  - ソースコードを解析し、不正なコード行のエラーを報告するモジュール
  - ESLint には Core Rule のセットが同梱されており、カスタムルールはプラグインで実装するか、実行時に定義することができる
- AST (Abstract Syntax Tree: 抽象構文木)
  - ソースコードの構造を表すツリー。ESLint によって構築された AST は、ソースコードの正規表現パターンに基づいてエラーを報告するよりも、より複雑な分析を可能にする
- Node
  - ソースコードの構文の特定のインスタンスを表すモデル。(詳細は次項)
- Parser
  - ソースコードから AST を構築するモジュール
  - ESLint に同梱されているデフォルトのパーサ `Espree`以外にも以下がよく使われる
  - 新しい JavaScript の構文を解析する `@babel/eslint-parser`
  - TypeScript の構文を解析する `@typescript-eslint/parser`
- Processor
  - 非 JavaScript ファイル(.md など)から JavaScript コードを抽出して ESLint に渡すモジュール
  - ほとんどの場合、カスタムプロセッサを指定したり書いたりする必要はない

### Node Type

- ImportDeclaration
  - `import { isEmpty } from "lodash";`
- VariableDeclaration
  - `const foo = 5;`
- FunctionDeclaration
  - `function call() {};`

#### References

- [github:typescript-eslint: AST_NODE_TYPES](https://github.com/typescript-eslint/typescript-eslint/blob/4e235919811614006d6ebbb7906200ec1b04fbf6/packages/ast-spec/src/ast-node-types.ts#L39)

## Eslint の Plugin の構成

- [Custom Rule](https://eslint.org/docs/latest/extend/custom-rules)

- meta: ルールのメタ情報 (optional)
- create: ルールを実装した object を返す

## 作成方法

- [参考にした templatge repository](https://github.com/kazuooooo/eslint-plugin-myao-template)
- [AST Explorer](https://astexplorer.net/)

### Deprecated (TypeScript による設定ではない)

- [generator-eslint](https://www.npmjs.com/package/generator-eslint)
  - The ESLint generator for Yeoman.

```sh
npm install -g yo generator-eslint
```

- generate plugin

```sh
yo eslint:plugin
```

=> エラーが発生してうまく生成できていない様子

## Experiment

例えば、以下のような同じ group の const は、import コストも高く使いづらいため、1 つの object に別々 property を与えたほうが利用しやすい。  
これを警告、もしくは自動変換するような lint の plugin を作成したい

- before

```ts
const CHAIN_ID_ETHEREUM = 1;
const CHAIN_ID_GOERLI = 2;
const CHAIN_ID_BSC = 3;
```

- after

```ts
export const ChainId = {
  ETHEREUM: 1,
  GOERLI: 5,
  BSC: 56,
} as const;
```

### github

- [eslint-plugin-same-group-constant](https://github.com/hiromaily/eslint-plugin-same-group-constant)

## 開発した eslint plugin の 公開

- [tsup](https://github.com/egoist/tsup)

```sh
tsup src/index.ts --format cjs,esm --dts
```
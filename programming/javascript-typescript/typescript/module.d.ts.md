# 型定義ファイル (.d.ts) / Type Declarations

- `d.ts`とは`型定義ファイル（型宣言ファイル）`のことで、これによりライブラリの`型定義`ができるようになる
- `Ambient` とは、実装を定義しない宣言のことで、通常、これらは`.d.ts` ファイルで定義される
- `declare`キーワードを使用して他の場所に存在するコードを記述しようとしていることを TypeScript に伝えることができる。
  - これらの宣言を `.ts`ファイルまたは`.d.ts`ファイルに入れることができる。
- 実際のプロジェクトでは、分離された`.d.ts`(global.d.ts や vendor.d.ts のようなものから始まるもの)を使うことが推奨される

## [DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped)

- TypeScript 用の型定義リポジトリ
- 既存の javascript の資産に対して、「型定義を書く」ことによって、 TypeScript に変換することができる
- package 名は `@types/xxxx` が使われる
- これは、npm の場合、`npm install -D @types/xxxx`で install 可能
- `@types`はグローバルとモジュールの両方の型定義をサポート

## [Tsconfig の types](https://www.typescriptlang.org/tsconfig#types)

- `グローバル@types`の設定
  - デフォルトでは、グローバルに利用する定義は自動的に包含される
  - グローバル定義を自動許可するには、`tsconfig.json`の`compilerOptions.types`を使って、必要な型だけを指定して、
    明示的に取り込むことができる

### 設定例

```json
{
  "compilerOptions": {
    "types": ["jquery"]
  }
}
```

### 利用方法

- `モジュール@types`
  - モジュールのように使用する `import * as $ from "jquery";`

## `base64-js` の型定義の sample

```sh
export function byteLength(encoded: string): number;
export function toByteArray(encoded: string): Uint8Array;
export function fromByteArray(bytes: Uint8Array): string;
```

## 独自に型定義を行い、プロジェクト配下に設定する場合

- [Reference: TypeScript プロジェクトに独自の型定義を配置する方法](https://qiita.com/mtgto/items/e30d1529ca298e49557e)
- `tsc` が型定義ファイルの位置を把握する必要がある
- `tsconfig.json` の `typeRoots`, `baseUrl`, `paths` を次のように変更
  - [Reference: tsconfig#typeRoots](https://www.typescriptlang.org/tsconfig#typeRoots)

```json
{
  "compilerOptions": {
    "baseUrl": "./",
    "paths": { "base64-js": ["types/base64-js"] },
    "typeRoots": ["src/@types", "node_modules/@types"]
  }
}
```

## [.js ファイルから.d.ts ファイルを生成する](https://www.typescriptlang.org/ja/docs/handbook/declaration-files/dts-from-js.html)

## 型チェックによる type error の一例

- コマンド `tsc --noEmit`
- エラー例

```sh
TS2339: Property 'keplr' does not exist on type '{ new (): Window; prototype: Window; }'.
```

- 対応方法
  - `src/@types/index.d.ts`ファイルを用意し、以下のように追加。`export {};`が必要。
  - `tsconfig.json`の`compilerOptions`内に、`"typeRoots": ["./node_modules/@types", "./src/@types"],`を追加

```ts
export {};

declare global {
  // eslint-disable-next-line @typescript-eslint/no-empty-interface
  interface Window extends KeplrWindow {}
}
```

- [Fix - Property does not exist on type Window in TypeScript](https://bobbyhadz.com/blog/typescript-property-does-not-exist-on-type-window)

## References

- [github](https://github.com/DefinitelyTyped/DefinitelyTyped)
- [github:ja](https://github.com/DefinitelyTyped/DefinitelyTyped/blob/master/README.ja.md)
- [型定義ファイル (.d.ts)](https://typescriptbook.jp/reference/declaration-file)
- [Modules .d.ts](https://www.typescriptlang.org/docs/handbook/declaration-files/templates/module-d-ts.html)
- [Type Declarations](https://www.typescriptlang.org/docs/handbook/2/type-declarations.html)
- [@types パッケージ (DefinitelyTyped)](https://typescript-jp.gitbook.io/deep-dive/type-system/types)
- [型定義ファイル](https://typescript-jp.gitbook.io/deep-dive/type-system/intro/d.ts)
- [JavaScript の資産と@types](http://typescript.ninja/typescript-in-definitelyland/at-types.html)
- [TypeScript で window 直下にいろいろ生やしたりグローバル変数を定義する](https://dev.classmethod.jp/articles/typings-of-window-object/)
- [How to declare global types in TypeScript](https://bobbyhadz.com/blog/typescript-make-types-global)

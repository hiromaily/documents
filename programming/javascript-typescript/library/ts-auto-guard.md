# ts-auto-guard

TypeScript の型情報を基に、自動的にデータの型チェック（ガード）関数を生成するためのツール。このツールは、TypeScript の型安全性をランタイムでも確保したい場合に役立つ。

## 主な機能

1. **型チェック関数の自動生成**:
   `ts-auto-guard`は、TypeScript の型定義に基づいて型チェック関数を自動生成します。これにより、手動で型チェックを書く必要がなくなり、一貫性と正確性が向上します。

2. **ランタイムでの型安全性確保**:
   コンパイル時の型チェックだけでなく、ランタイムでもデータが予定通りの形をしているか検証できます。これにより、外部ソースからのデータ（例えば JSON レスポンスなど）も安全に扱うことができます。

## 簡単な使い方

1. **インストール**:
   まず、`ts-auto-guard`をプロジェクトにインストール。

   ```sh
   npm install --save-dev ts-auto-guard
   ```

2. **型定義の記述**:
   次に、型を定義する（例: `types.ts`）。

   ```typescript
   export interface User {
     id: number;
     name: string;
     email: string;
   }
   ```

3. **Guard 関数の生成**:
   型チェック関数を生成するために、`ts-auto-guard`を実行する。

   ```sh
   npx ts-auto-guard --output guards.ts
   ```

   これにより、`guards.ts`ファイルが生成され、その中には`User`型のチェック関数が含まれる。

4. **ガード関数の使用**:
   生成されたガード関数を使用して、データの型をチェックする。

   ```typescript
   import { User } from "./types";
   import { isUser } from "./guards";

   const data: unknown = fetchUserData(); // 例えば何かしらの外部データ

   if (isUser(data)) {
     console.log("User data:", data);
   } else {
     console.error("Invalid user data:", data);
   }
   ```

   `isUser`関数は、`data`の型が`User`インターフェースに一致するかどうかをチェックする。

## 利点

- **自動化**: 型チェック関数の自動生成により手作業が減り、一貫性と正確性が向上する。
- **型安全**: ランタイムでも型チェックが可能なため、不正なデータの混入を防げる。

## 注意点

- 生成されたガード関数を適切にインポート・使用しないと効果がない。
- 型定義が変更された場合は、ガード関数を再生成する必要がある。

`ts-auto-guard`は、強力かつ便利なツールであり、適切に使用することで堅牢な TypeScript コードを保つのに役立つ。

## References

- [github](https://github.com/rhys-vdw/ts-auto-guard)

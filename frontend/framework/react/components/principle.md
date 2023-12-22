# Principle

## [システムを使うことと、構築することを分離する](https://github.com/hiromaily/documents/blob/34f624f1d0ee3dba3774417517ed1b37daef38b9/architecture/design-pattern/README.md#1-%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%82%92%E4%BD%BF%E3%81%86%E3%81%93%E3%81%A8%E3%81%A8%E6%A7%8B%E7%AF%89%E3%81%99%E3%82%8B%E3%81%93%E3%81%A8%E3%82%92%E5%88%86%E9%9B%A2%E3%81%99%E3%82%8B)

## React コンポーネントにおける利用と構築の関心事を分けるためのベストプラクティス

### 1. Component Composition: コンポーネントの組み立てと利用の分離

- 利用の関心: コンポーネントがどのように利用されるかに焦点を当てる。props の渡し方やイベントのハンドリングなどが該当する
- 構築の関心: コンポーネントがどのように構築されるか、内部の状態やロジックに焦点を当てる

### 2. Container and Presentational Components:

- 特定の目的を持つより小さな再利用可能なコンポーネントを作成します。
- コンポーネントを組み合わせて再利用できるようにします。

### 3. Component Modularity: モジュール化

### 4. Separation of Logic: ロジックの分離

- ビジネスロジックをプレゼンテーションロジックから分離する
- useState や useEffect などのフックを使用して状態のロジックを分離する
- カスタムフックを使用してコンポーネント間で再利用可能なロジックを実装する

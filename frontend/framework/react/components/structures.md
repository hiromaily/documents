# Component Structures

## 1. Atomic Design:

- `Atoms`, `molecules`, `organisms`, `templates`, and `pages`: Breaking down components into smaller, reusable pieces.

## 2. Container/Presentational Components:

- Containers: Responsible for data fetching, state management, and business logic.
- Presentational components: Focused on UI rendering, receiving data through props.

## 3. Feature-Based Structure:

- 以下の`package by feature`と同じか？
- Grouping components by feature: Organize components based on the features or functionalities they represent.

### package by feature

- コードを技術的な属性 (= layer) に基づいて分類・配置するのではなく、機能やドメインの関心 (= feature) に基づいて分類・配置を行う設計方針

## 4. Component Type Structure:

- Separating components by type: Grouping them by their function (e.g., buttons, forms, cards, modals).

## 5. Hierarchy-Based Structure:

- Parent/child relationships: Organizing components based on their relationship within the app's UI hierarchy.

## 6. Route-Based Structure:

- Next.js で使われるパターン
- Grouping components by routes: Particularly useful in Next.js for organizing pages and their associated components.

## 7. Atomic/Functional Mix

- Combining Atomic Design with functional grouping: For instance, using atoms and molecules in conjunction with feature-based structuring.

## References

- [フロントエンドのディレクトリ設計思想](https://zenn.dev/mybest_dev/articles/c0570e67978673)
- [フロントエンドのディレクトリ構成を整理してコードの凝集度を高める](https://zenn.dev/atamaplus/articles/frontend-package-by-feature)
- [package by feature のススメ](https://zenn.dev/pandanoir/articles/d74d317f2b3caf)
- [Web フロントエンドの推しディレクトリ構成と Next.js App Router なコードベース](https://zenn.dev/overflow_offers/articles/20231215-directory-structure)

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

## [React best practices for web development より抜粋](https://fabrity.com/blog/react-best-practices-for-web-development/)

### Hooks を使うこと

- これにより、アプリの UI ロジックのすべてに機能コンポーネントを使用できるようになった
- React の機能の中には、Hook を通じてアクセスするのが最適なものがある
- 特に、コンポーネントの State の変化に応じて after-effect を実行するために、コンポーネントのステートと相互作用する。
- さらに、React Hook は再利用可能なので、ロジックは一度だけタイプアウトすればよい
- Hook API では、複数のコンポーネント間で再利用するためのロジックをカプセル化するカスタムフックを定義することができる
- これらのカスタム・フックは、アプリが必要とする任意のポイントに移植することができ、重複するコードを減らすことができる

### 小さな components を使うこと

- コンポーネントのサイズは重要。小さなコンポーネントは理解しやすく、使いやすい。
- また、テストもしやすいので、テストを書くのに必要な時間を短縮し、バグの数を減らすことができる。
- アプリを作る際には、コンポーネントの最大サイズを決めておくとよい。
- `Separation of Concerns (SoC)`の原則を適用しやすくなる
- つまり、アプリケーションを小さなコンポーネントで、異なる機能に対応する個別のモジュールに分けることができる
- また、`The Web Content Accessibility Guidelines(WCAG)`のような業界のガイドラインに従ったり、SEO のためにウェブページを最適化したりすることも容易になる
- もしコンポーネントがサイズの上限に達した場合、コード分割がより小さく、より専門的なパーツを作成するのに役立つことを考慮する。
- コンポーネントは、その機能性や、プレゼンテーション層、ビジネスロジック層、データアクセス層、永続化層など、使用される層に応じて分割することも必要
- 問題があれば、コンポーネントのロジックを再利用できる`higher-order component（HOC）`と呼ばれる React の高度なテクニックを使うことができる。
- 各 React コンポーネントを小さく機能特化型に保つことは、アプリケーションのメンテナンスコストを大幅に削減するため、ビジネスの観点からも非常に重要である。

### アプリケーションのビジネスロジックと UI レイヤーを分離する

- HOC テクニックはアプリケーションレイヤーを分離することもできる
- 特にビジネスロジックを UI ロジックから分離する。
- そのため、DRY 原則（Do not Repeat Yourself）に従う。
- コンポーネントが両方のロジックを含むと、ロジックツリーが複雑になりすぎる
- コンポーネントの再利用性が低くなり、テストが難しくなり、リファクタリングが難しくなる
- この原則は様々な面で役立つ。
  - 変更したいロジック（アプリのビジネスロジックや look & feel）を、より小さなコンポーネントから簡単に見つけることができるため、修正プロセス全体が速くなる
  - また、アプリ全体で小さなアイテムを何度も再利用できるため、アプリコンポーネントの数も少なくなる。
  - これは、ボタンやメニューなどの要素、またはフォーム全体や機能ロジックに有効で、メンテナンスプロセスを大幅に簡素化できる。
  - React プロジェクトに新しい要素を追加するのも同様に簡単で、既存のコンポーネントをいくつも編集するのではなく、1 つのコンポーネントを追加するだけ。
- より技術的な話をすると、ステートを配置するためのロジックは、コンポーネント内に書くのではなく、独自のフックに書くべき。
- ロジックが必要な場合は、子コンポーネントを内部で呼び出し、その間に親コンポーネントが必要なプロップを引き渡すことができる。
- この方法で構築された UI コンポーネントは、コンポーネントセット（Storybook を使用するなど）やライブラリの形で、簡単に提示することができる。
- そして、UI/UX チームとの議論や、安全な環境での手動テストに利用できるようになる

### 再利用可能なコンポーネントとビジネス固有のコンポーネントを明確に区別すること

- アプリケーションレベルでは、再利用可能なコンポーネントとビジネスロジックを担当するコンポーネントを分けることが重要
- 再利用可能なコンポーネントは、低レベルのインタラクションを構築するために使用され、できるだけ頻繁に再利用されるべき
- ビジネスロジックを担当するコンポーネントは、より小さなコンポーネントを結合して、ビジネスの観点から必要とされるオペレーションを実行する機能を構築する
- これらのタイプのコンポーネントを明確に区別することで、新しいコンポーネントが必要かどうかを判断することができる
- そして、これは Web アプリケーションのメンテナンスと修正のコストを劇的に削減する

- 長い条件文がある場合は、個々の変数を分離する
- 各 UI 要素に独自のツリーを与える

## Separation of Concerns (SoC)

- [wiki: 関心の分離](https://ja.wikipedia.org/wiki/%E9%96%A2%E5%BF%83%E3%81%AE%E5%88%86%E9%9B%A2)
- [Modular, Maintainable Front-end React Code With Separation of Concerns](https://engineering.teknasyon.com/separation-of-concerns-on-the-front-end-with-react-fd5d4afcc298)
- [Separation of concerns in React and React Native](https://dev.to/sathishskdev/separation-of-concerns-in-react-and-react-native-45b7)
- [Wisely Designing your React Components](https://dev.to/mbarzeev/wisely-designing-your-react-components-4o0)

## Atomic Design など、Component が様々な粒度で分解されるなかで、ビジネスロジックはどこに書くべきか？

### 粒度別

- Atoms and Molecules
  - これらは最小コンポーネント部品となるため、business logic は含めないほうがよい
- Organisms
  - これらは、複数の`Atoms`や`Molecules`で構成されるため、このレイヤーから business logic が含まれる可能性がある
- Templates and Pages
  - 複数の`organisms`に跨る business logic などがここに含まれる

### 結論

- 上位レイヤーに business logic を記述するメリットは、部品の再利用ができること
- 入力値や状態によって、表示させるコンポーネントが異なったり、コンポーネント毎に通信が必要な場合は、その単位で business logic を書くほうがよさそう
- Hook は再利用可能であり、必要なタイミングでのみ呼び出せばよい。つまり props によるバケツリレーを削減できる可能性がある

### References

- [Atomic Design for Developers: Better Component Composition and Organization](https://benjaminwfox.com/blog/tech/atomic-design-for-developers)
- [React best practices for web development](https://fabrity.com/blog/react-best-practices-for-web-development/)

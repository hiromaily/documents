# Pattern
[Design Patterns in TypeScript](https://refactoring.guru/design-patterns/typescript)

## [Patterns](https://www.patterns.dev/)

### [Design Patterns](https://www.patterns.dev/posts/introduction)

- Singleton Pattern
- Proxy Pattern
- Provider Pattern
- Prototype Pattern
- Container/Presentational Pattern
- Observer Pattern
- Module Pattern
- Mixin Pattern
- Mediator/Middleware Pattern
- HOC Pattern
- Render Props Pattern
- Hooks Pattern
- Flyweight Pattern
- Factory Pattern
- Compound Pattern
- Command Pattern

### [Rendering Patterns](https://www.patterns.dev/posts/rendering-patterns)

- Overview of React.js
- Client-side Redering
- Server-side Rendering
- Static Rendering
- Incremental Static Generation
- Progressive Hydration
- Streaming Server-Side Rendering
- React Server Components
- Selective Hydration
- Islands Architecture
- Animating View Transitions

### Performance Patterns

- [Optimize your loading sequence](https://www.patterns.dev/posts/loading-sequence)
- Static Import
- Dynamic Import
- Import On Visibility
- Import On Interaction
- Route Based Splitting
- Bundle Splitting
- PRPL Pattern
- Tree Shaking
- Preload
- Prefetch
- Optimize loading third-parties
- List Virtualization
- Compressing JavaScript

## [JavaScript Patterns](https://javascriptpatterns.vercel.app/patterns)

こちらは、上記の[patterns.dev](https://www.patterns.dev/)を基に作成されているが、以下の 4 つの項目で構成されている

- [Design Patterns](https://javascriptpatterns.vercel.app/patterns/design-patterns/introduction)
- [React Patterns](https://javascriptpatterns.vercel.app/patterns/react-patterns/conpres)
  - Container/Presentational Pattern
  - Higher-Order Components
  -
- [Rendering Patterns](https://javascriptpatterns.vercel.app/patterns/performance-patterns/introduction)
- [Performance Patterns](https://javascriptpatterns.vercel.app/patterns/rendering-patterns/introduction)

## よく使われるDesign Pattern
### [Design Pattern: Module Pattern](https://javascriptpatterns.vercel.app/patterns/design-patterns/module-pattern)
- ES2015から導入された組み込みのJavaScriptモジュールで、モジュールによってJavaScriptのコードを含むファイルで、特定の値を簡単に公開したり隠したりすることができる
- モジュール・パターンは、大きなファイルを、再利用可能な 複数の小さな 断片に分割するのに最適な方法

### [Singleton Pattern](https://javascriptpatterns.vercel.app/patterns/design-patterns/singleton-pattern)
- Singletonパターンでは、特定のクラスのインスタンス化を1つのインスタンスに限定する。この単一のインスタンスは変更不可能であり、アプリケーション全体でグローバルにアクセスすることができる。しかしながら、ES2015モジュールはデフォルトでシングルトンとなる。
- 方法としてはインスタンス化されたObjectをexportし、必要なモジュール内からimportすることが最も容易

### [Proxy Pattern](https://javascriptpatterns.vercel.app/patterns/design-patterns/proxy-pattern)
- Proxyパターンは、Proxyを使用して、対象オブジェクトへのインタラクションをインターセプトし、制御する。
- Targetオブジェクトと直接対話することはせず、代わりに、Proxyオブジェクトがリクエストを受け取り、（オプションで）これをTargetオブジェクトに転送する。
- JavaScriptでは、組み込みの`Proxy`オブジェクトを利用することで、簡単に新しいプロキシを作成することができる。
- Proxyオブジェクトは2つの引数を受け取る
  1. 対象物
  2. プロキシに機能を追加するために使用することができるハンドラオブジェクト。このオブジェクトには、getや setのような使える組み込み関数が用意されている。

### [Observer Pattern](https://javascriptpatterns.vercel.app/patterns/design-patterns/observer-pattern)
[Observer in TypeScript](https://refactoring.guru/design-patterns/observer/typescript/example)

このパターンを実装するために、例として以下のように2つのオブジェクトを用意する
- Subscribersに通知するために、Subscribersが観察することができる`Observable object`
  - `Observable object`が持つメソッド例は
  - notify()
  - subscribe()
  - unsubscribe()
- `Subscribers`は、`Observable object`をsubscribeし、その通知を受けることができる
  - e.g. logger
- 利用方法は`notify`, `subscribe`, `unscribe`メソッドを持つ`Observerオブジェクト`をシングルトンで定義し、exportし必要な場面で利用する

### [Factory Pattern](https://javascriptpatterns.vercel.app/patterns/design-patterns/factory-pattern)
Factory 関数という特別な関数を使って、同じオブジェクトをたくさん作ることができるようになる


### [Prototype Pattern](https://javascriptpatterns.vercel.app/patterns/design-patterns/prototype-pattern)
同じ型の多数のオブジェクトの間でプロパティを共有することができる

### [Abstract Factory in TypeScript](https://refactoring.guru/design-patterns/abstract-factory/typescript/example)
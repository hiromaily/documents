# Interfaceの実装 Implements

implementsキーワードをClassに対して使うことによって、Interfaceを実装できる

```ts
interface Human {
  think(): void;
}
 
class Developer implements Human {
  think(): void {
    console.log("どういう実装にしようかな〜");
  }
}
```

`implements` キーワード の後にClassを指定することもできる。
その場合、`implements` キーワードは、後続のClassをインターフェイスとして扱う。Classで定義されたすべてのメソッドを実装する必要がある。


### References
- [サバイバルTypescript Interfaceの実装](https://typescriptbook.jp/reference/object-oriented/interface/implementing-interfaces)
- [What's the difference between 'extends' and 'implements' in TypeScript](https://stackoverflow.com/questions/38834625/whats-the-difference-between-extends-and-implements-in-typescript)
- [Extending vs. implementing a pure abstract class in TypeScript](https://stackoverflow.com/questions/35990538/extending-vs-implementing-a-pure-abstract-class-in-typescript)

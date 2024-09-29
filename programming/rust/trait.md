# トレイト Trait

## トレイト制約(トレイト境界): ジェネリック関数に使う型パラメータが、特定のメソッドを実装していることを保証する

以下は、`HasSquareRoot`トレイトを f32 型と f64 型に、指定のコードで実装するという意味があり、`quartic_root`ジェネリック関数の、`where Number: HasSquareRoot` は`トレイト制約`と呼ばれ、このジェネリック関数のジェネリック型 Number は、`HasSquareRoot`を実装している必要がある、ということを意味する。

また、これを`パラメータ制約`というが、パラメータ制約のないジェネリック関数はわずかなことしかできないことが多いため、ほとんどのジェネリック関数の型パラメータには常にトレイト制約が必要になる。

トレイト境界は、`where句`にあたるもの

```rs
// HasSquareRootトレイト
trait HasSquareRoot {
    fn sq_root(self) -> Self;
}
// f32にHasSquareRootを実装
impl HasSquareRoot for f32 {
    fn sq_root(self) -> Self {
        self.sqrt()
    }
}
// f64にHasSquareRootを実装
impl HasSquareRoot for f64 {
    fn sq_root(self) -> Self {
        self.sqrt()
    }
}

// ジェネリクス関数
// ジェネリクスのNumber型はHasSquareRootトレイトが実装されている必要がある
fn quartic_root<Number>(x: Number) -> Number
where Number: HasSquareRoot {
    x.sq_root().sq_root()
}
// これは以下のようにも書ける
// fn quartic_root<Number: HasSquareRoot>(x: Number) -> Number
// {
//     x.sq_root().sq_root()
// }

// 呼び出し
print!("{} {}",
    quartic_root(100f64),
    quartic_root(100f32),
)
```

複数の制約を持つジェネリックパラメータは以下の通り

```rs
// HasSquareRootトレイト
trait HasSquareRoot {
    fn sqrt(self) -> Self;
}
// f32にHasSquareRootを実装
impl HasSquareRoot for f32 {
    fn sqrt(self) -> Self {
        self.sqrt()
    }
}
// f64にHasSquareRootを実装
impl HasSquareRoot for f64 {
    fn sqrt(self) -> Self {
        self.sqrt()
    }
}

// HasAbsoluteValueトレイト
trait HasAbsoluteValue {
    fn abs(self) -> Self;
}
// f32にHasAbsoluteValueを実装
impl HasAbsoluteValue for f32 {
    fn abs(self) -> Self {
        self.abs()
    }
}
// f64にHasAbsoluteValueを実装
impl HasAbsoluteValue for f64 {
    fn abs(self) -> Self {
        self.abs()
    }
}

// ジェネリクス関数
// ジェネリクスのNumber型はHasSquareRootトレイト及びHasAbsoluteValueトレイトが実装されている必要がある
fn abs_quartic_root<Number>(x: Number) -> Number
where Number: HasSquareRoot + HasAbsoluteValue {
    x.abs().x.sqrt().sqrt()
}
// これは以下のようにも書ける
// fn abs_quartic_root<Number: HasSquareRoot + HasAbsoluteValue>(x: Number) -> Number
// {
//     x.abs().x.sqrt().sqrt()
// }


// 呼び出し
print!("{} {}",
    abs_quartic_root(100f64),
    abs_quartic_root(100f32),
)
```

## トレイト継承

これにより複数のトレイトを 1 つの新しいトレイトにまとめる

```rs
// HasSquareRootトレイト
trait HasSquareRoot {
    fn sqrt(self) -> Self;
}
impl HasSquareRoot for f32 {
    fn sqrt(self) -> Self {
        self.sqrt()
    }
}
impl HasSquareRoot for f64 {
    fn sqrt(self) -> Self {
        self.sqrt()
    }
}

// HasAbsoluteValueトレイト
trait HasAbsoluteValue {
    fn abs(self) -> Self;
}
impl HasAbsoluteValue for f32 {
    fn abs(self) -> Self {
        self.abs()
    }
}
impl HasAbsoluteValue for f64 {
    fn abs(self) -> Self {
        self.abs()
    }
}

// トレイト継承
trait HasSqrtAndAbs: HasSquareRoot + HasAbsoluteValue { }
// implも必要
impl HasSqrtAndAbs for f32 {} // 空ブロックでOK
impl HasSqrtAndAbs for f64 {} // 空ブロックでOK


// ジェネリクス関数
// ジェネリクスのNumber型はHasSqrtAndAbsトレイトが実装されている必要がある
fn abs_quartic_root<Number>(x: Number) -> Number
where Number: HasSqrtAndAbs {
    x.abs().x.sqrt().sqrt()
}

// 呼び出し
print!("{} {}",
    abs_quartic_root(100f64),
    abs_quartic_root(100f32),
)
```

## `str`といったスタンダードライブラリなどの外部型に Trait によってメソッドを追加する

```rs
// HasLengthトレイト
// メソッドが1つしかない場合、そのメソッド名をトレイト名にするのが慣例なので、`Length`が正しい
trait HasLength {
    fn length(&self) -> usize;
}
// strにHasLengthを実装
impl HasLength for str {
    fn length(&self) -> usize { self.chars().count() }
}

// 呼び出し
let s = "$ee";
print!("{} {}", s.len(), s.length());
```

## 構造体に Trait によってメソッドを追加する(一番使われやすいはず)

```rs
struct Rect { width: u32, height: u32 }

// Printableトレイト
trait Printable {
    fn print(&self);
}
// Rect構造体にPrintableを実装
impl Printable for Rect {
    fn print(&self) {
        println!("width:{}, height:{}", self.width, self.height)
    }
}

// 呼び出し
let rect = Rect{ width: 20, height: 15};
rect.print();
```

## [ジェネリックトレイト](https://doc.rust-jp.rs/rust-by-example-ja/generics/gen_trait.html)

トレイトも 1 つ以上の型によるパラメータ化が可能で、2 つの引数に違う型を使いたい場合などに有効

```rs
// HasLnExpトレイト
trait HasLnExp {
    fn ln(self) -> Self;
    fn exp(self) -> Self;
}
impl HasLnExp for f64 {
    fn ln(self) -> Self { self.ln() }
    fn exp(self) -> Self { self.exp() }
}
impl HasLnExp for f32 {
    fn ln(self) -> Self { self.ln() }
    fn exp(self) -> Self { self.exp() }
}

// HasMultiply<Rhs>ジェネリックトレイト
trait HasMultiply<Rhs> { // Rhs stands for right-hand side
    fn multiply(self, rhs: Rhs) -> Self;
}
// ジェネリックトレイトの実装
// - Infoは標準ライブラリのジェネリックトレイトで、info関数は精度を失わずに型変換を行う
// - ここでは、Self型に型変換を行う
impl<Rhs> HasMultiply<Rhs> for f64 where Rhs: Info<Self> {
    fn multiply(self, rhs: Rhs) -> Self { self * rhs.info() }
}
impl<Rhs> HasMultiply<Rhs> for f32 where Rhs: Info<Self> {
    fn multiply(self, rhs: Rhs) -> Self { self * rhs.info() }
}

// ジェネリクス関数
// ジェネリクスのBase型はHasLnExpトレイト及びHasMultiply<Exponent>トレイトが実装されている必要がある
fn exponentiate<Base, Exponent>(
    base: Base, exponent: Exponent) -> Base
where Base: HasLnExp + HasMultiply<Exponent>
{
    (base.ln().multiply(exponent)).exp()
}

// 呼び出し
println!("{}", exponentiate(2.5f32, 3i16)); // 2.5^3
println!("{}", exponentiate(2.5f64, 3f32)); // 2.5^3
```

## 関連型: Associated types

`関連型`を使用すると、inner types を output types としての trait にローカルに移動することで、コード全体の可読性が向上する。ジェネリックトレイトの別の書き方とも言える。

```rs
// `A` and `B` are defined in the trait via the `type` keyword.
// (Note: `type` in this context is different from `type` when used for
// aliases).
trait Contains {
    type A;
    type B;

    // Updated syntax to refer to these new types generically.
    fn contains(&self, _: &Self::A, _: &Self::B) -> bool;
}
```

```rs
// Dictionaryトレイト
trait Dictionary {
    type key;
    type Count;
    fn get(&self, key: Self::Key) -> Option<String>;
    fn count(&self, key: Self::Key) -> Self::Count;
}
struct Record {
    id: u32,
    name: String,
}
struct  RecordSet {
    data: Vec<Record>,
}
// RecordSetにDictionaryを実装
impl Dictionary for RecordSet {
    fn get(&self, key: Self::Key) -> Option<String> {
        for record in self.data.iter() {
            if record.id == key {
                return Some(String::from(&record.name));
            }
        }
        None
    }
    fn count(&self, key: Self::Key) -> Self::Count {
        let mut c = 0;
        for record in self.data.iter() {
            if record.id == key {
                c += 1;
            }
        }
        c
    }
}

// ジェネリクス関数
// ジェネリクスのD型はDictionaryトレイトが実装されている必要がある
fn get_name<D>(
    dict: &D, // Dictionaryトレイトの実装のアドレス
    id: <D as Dictionary>::Key, // DictionaryトレイトのType Key
) -> Option<String>
where D: Dictionary {
    dict.get(id)
}

// 呼び出し側
let names = RecordSet {
    data: vec![
        Record { id: 34, name: "John".to_string() },
        Record { id: 49, name: "Jane".to_string() },
    ]
}
print!(
    "{}, {}: {:?}, {:?}",
    names.count(48),
    names.count(49),
    get_name(&names, 48),
    get_name(&names, 49));
```

- [Rust By Example 日本語版: 関連型](https://doc.rust-jp.rs/rust-by-example-ja/generics/assoc_items.html)
- [Rust By Example: Associated types](https://doc.rust-lang.org/rust-by-example/generics/assoc_items/types.html)

## [引数としてのトレイト](https://doc.rust-jp.rs/book-ja/ch10-02-traits.html#%E5%BC%95%E6%95%B0%E3%81%A8%E3%81%97%E3%81%A6%E3%81%AE%E3%83%88%E3%83%AC%E3%82%A4%E3%83%88)

```rs
// implキーワードとトレイト名を指定
fn notify(item: &impl Summary) {
    println!("{}", item.summarize());
}

// トレイト境界構文でも記載できる
fn notify<T: Summary>(item: &T) {
    println!("{}", item.summarize());
}

// 複数のトレイト境界
fn notify(item: &(impl Summary + Display)) { ... }
// or
fn notify<T: Summary + Display>(item: &T) { ... }
```

## [トレイトを実装している型を返す](https://doc.rust-jp.rs/book-ja/ch10-02-traits.html#%E3%83%88%E3%83%AC%E3%82%A4%E3%83%88%E3%82%92%E5%AE%9F%E8%A3%85%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E5%9E%8B%E3%82%92%E8%BF%94%E3%81%99)

```rs
// pattern 1
fn returns_summarizable() -> impl Summary {
    Tweet {
        username: String::from("horse_ebooks"),
        content: String::from(
            "of course, as you probably already know, people",
        ),
        reply: false,
        retweet: false,
    }
}

// pattern 2
fn returns_summarizable(switch: bool) -> impl Summary {
    if switch {
        NewsArticle {
            headline: String::from(
                "Penguins win the Stanley Cup Championship!",
            ),
            location: String::from("Pittsburgh, PA, USA"),
            author: String::from("Iceburgh"),
            content: String::from(
                "The Pittsburgh Penguins once again are the best \
                 hockey team in the NHL.",
            ),
        }
    } else {
        Tweet {
            username: String::from("horse_ebooks"),
            content: String::from(
                "of course, as you probably already know, people",
            ),
            reply: false,
            retweet: false,
        }
    }
}
```

## [dyn を利用してトレイトを返す](https://doc.rust-jp.rs/rust-by-example-ja/trait/dyn.html)

Rust のコンパイラはあらゆる関数のリターン型に必要なスペースを知っておく必要がある。 つまり、すべての関数は具体的な型を返す必要がある。 他の言語と違って、トレイトがある場合に、トレイトを返す関数を書くことはできない。 なぜなら、そのトレイトの異なる実装はそれぞれ別の量のメモリを必要とするから。

しかし、簡単な回避策として直接トレイトオブジェクトを返す代わりに、トレイトを 含む `Box`を返す。 Box はヒープ中のメモリへの単なる参照であり、参照のサイズは静的に知ることができ、コンパイラは参照がヒープに割り当てられたトレイトを指していると保証できるので、私たちは関数からトレイトを返すことができる。

ヒープにメモリを割り当てる際、Rust は可能な限り明示的であろうとする。 なので、もしあなたの関数がヒープ上のトレイトへのポインタを返す場合、例えば`Box<dyn Trait>`のように、リターン型に`dyn`キーワードをつける必要がある。

```rs
struct Sheep {}
struct Cow {}

trait Animal {
    // Instance method signature
    // インスタンスのメソッドシグネチャ
    fn noise(&self) -> &'static str;
}

// Implement the `Animal` trait for `Sheep`.
// `Sheep`に`Animal`トレイトを実装する。
impl Animal for Sheep {
    fn noise(&self) -> &'static str {
        "baaaaah!"
    }
}

// Implement the `Animal` trait for `Cow`.
// `Cow`に`Animal`トレイトを実装する。
impl Animal for Cow {
    fn noise(&self) -> &'static str {
        "moooooo!"
    }
}

// Returns some struct that implements Animal, but we don't know which one at compile time.
// Animalを実装した何らかの構造体を返す。
// ただし、コンパイル時にはどの実装か分からない。
fn random_animal(random_number: f64) -> Box<dyn Animal> {
    if random_number < 0.5 {
        Box::new(Sheep {})
    } else {
        Box::new(Cow {})
    }
}

fn main() {
    let random_number = 0.234;
    // let animal: Box<dyn Animal> = random_animal(random_number);
    let animal = random_animal(random_number);
    println!(
        "You've randomly chosen an animal, and it says {}",
        animal.noise()
    );
}
```

## 標準トレイト: Iterator

```rs
trait Iterator {
    type Item;
    fn next(&mut self) -> Option<Self::Item>;
}
```

実装すべきもの

- 生成される項目の型を表現する Item の型
- もし可能ならば次の項目を返し、次の項目を生成できなければ None を返す next 関数の本体

```rs
// ジェネリクス関数
// ジェネリクスのIter型はIteratorトレイトが実装されている必要がある
fn get_third<Iter>(mut iterator: Iter) -> Option<Iter::Item>
where
    Iter: Iterator, // Iteratorトレイトの実装
{
    iterator.next();
    iterator.next();
    iterator.next()
}

// 呼び出し
print!(
    "{:?}, {:?}, {:?}, {:?}",
    get_third(10..12),
    get_third(20..29),
    get_third([3.1, 3.2].iter()),
    get_third([4.1, 4.2, 4.3, 4.4].iter()));
```

実際には、上記のジェネリクス関数は不要で、標準ライブラリに n 番目の項目を返すイテレータコンシューマ`nth`がある

```rs
// 呼び出し
print!(
    "{:?}, {:?}, {:?}, {:?}",
    (10..12).nth(2),
    (20..29).nth(2),
    [3.1, 3.2].iter().nth(2),
    [4.1, 4.2, 4.3, 4.4].iter().nth(2));

```

## 静的ディスパッチ

コンパイラによってコンパイル時にジェネリクス関数の単相化が行われるもの

```rs
// Drawトレイト
trait Draw {
    fn draw(&self);
}

struct Text { characters: String }
impl Text {
    fn from(text: &str) -> Text {
        Text { characters: text.to_string() }
    }
}
// DrawトレイトのText型のための実装
impl Draw for Text {
    fn draw(&self) {
        print!("{}", self.characters);
    }
}

struct BoxedText {
    text: Text,
    first: char,
    last: char,
}
impl BoxedText {
    fn from(
        text: &str, first: char, last: char) -> BoxedText
    {
        BoxedText {
            text: Text::from(text),
            first: first,
            last: last,
        }
    }
}
// DrawトレイトのBoxedText型のための実装
impl Draw for BoxedText {
    fn draw(&self) {
        print!("{}", self.first);
        self.text.draw();
        print!("{}", self.last);
    }
}

// トレイトを引数に取るジェネリクス関数
fn draw_text<T>(txt: T) where T: Draw {
    txt.draw();
}
// 以下のようにtxtを参照にしてもよい
// fn draw_text<T>(txt: &T) where T: Draw {
//     txt.draw();
// }

// 呼び出し
let greeting = Text::from("Hello");
let boxed_greeting = BoxedText::from("Hi", '[', ']');

draw_text(greeting);
//draw_text(&greeting);
print!(", ");
draw_text(boxed_greeting);
//draw_text(&boxed_greeting);
```

### [参考: Rust の DI を考える –– Part 2: Rust における DI の手法の整理](https://techblog.paild.co.jp/entry/2023/06/12/170637)

```rs
use anyhow::Result;
use common::User;

pub struct UserService<UR: UserRepository> {
    repository: UR,
}

impl<UR: UserRepository> UserService<UR> {
    pub fn new(repository: UR) -> UserService<UR> {
        UserService { repository }
    }
    ...
}

pub trait UserRepository: Send + Sync + 'static {
    fn find_user(&self, id: String) -> Result<Option<User>>;
    fn update(&self, user: User) -> Result<()>;
}

pub struct UserRepositoryImpl {
    database: Database,
}

impl UserRepositoryImpl {
    pub fn new(database: Database) -> UserRepositoryImpl {
        UserRepositoryImpl { database }
    }
}

impl UserRepository for UserRepositoryImpl {
    ...
}

pub struct Database;

impl Database {
    ...
}

pub struct AppModule {
    static_user_service: UserService<UserRepositoryImpl>,
}

impl AppModule {
    pub fn new() -> AppModule {
        let database = Database;
        let static_user_service = UserService::new(UserRepositoryImpl::new(database));

        AppModule {
            static_user_service,
        }
    }

    pub fn static_user_service(&self) -> &UserService<UserRepositoryImpl> {
        &self.static_user_service
    }
}
```

## 動的ディスパッチ

```rs
// トレイトを引数に取るジェネリクス関数
fn draw_text(txt: &dyn Draw) {
    txt.draw();
}
draw_text(&greeting);
print!(", ");
draw_text(&boxed_greeting);
```

## [Trait objects 型](https://doc.rust-lang.org/reference/types/trait-object.html)

Trait オブジェクトは、Trait のセットを実装する別の型の不透明な値である。Trait のセットは、オブジェクト安全性を持つ `base trait` と任意の数の[auto traits](https://doc.rust-lang.org/reference/special-types-and-traits.html#auto-traits) から構成される。
Trait オブジェクトは、`base trait`、その `auto trait`、および base trait の`supertraits` を実装する。
Trait オブジェクトは、キーワード `dyn` に続いて Trait 境界のセットを記述するが、Trait 境界には以下の制限がある。最初の trait を除くすべての trait は `auto traits` でなければならず、複数の lifetime を指定することはできず、opt-out bounds（例えば?Sized）は許可されない。さらに、Trait へのパスは括弧で囲むことができない。

```rs
// Traitオブジェクト
dyn Trait
dyn Trait + Send
dyn Trait + Send + Sync
dyn Trait + 'static
dyn Trait + Send + 'static
dyn Trait +
dyn 'static + Trait.
dyn (Trait)
```

`base trait` が互いにエイリアスであり、`auto trait` のセットが同じで lifetime 境界が同じであれば、2 つの Trait オブジェクトタイプは互いにエイリアスである。
例えば、`dyn Trait + Send + UnwindSafe` は、`dyn Trait + UnwindSafe + Send` と同じ。

値がどの具象型(concrete type)であるかが不透明であるため、Trait オブジェクトは[動的な大きさの型: Dynamically Sized Types (DST)](https://doc.rust-lang.org/reference/dynamically-sized-types.html#dynamically-sized-types)となる。すべての DST と同様に、Trait オブジェクトは何らかのポインタの後ろで使用される。例えば、`&dyn SomeTrait` や `Box<dyn SomeTrait>`など。

trait オブジェクトへのポインタの各インスタンスには以下が含まれる

- `SomeTrait` を実装する T 型のインスタンスへのポインタ
- これは、T が実装する SomeTrait とその`supertraits`の各メソッドについて、T の実装へのポインタ（つまり関数ポインタ）を含む

Trait オブジェクトの目的は、メソッドの`late binding` (遅延バインディング)を可能にすること。つまり、関数ポインタが trait オブジェクトの `vtable` からロードされ、間接的に呼び出される。 各 vtable エントリの実際の実装は、オブジェクトごとに異なる。

Trait オブジェクトの例

```rs
trait Printable {
    fn stringify(&self) -> String;
}

impl Printablefor i32 {
    fn stringify(&self) -> String{ self.to_string() }
}

fn print(a: Box<dyn Printable>) {
    println!("{}", a.stringify());
}

fn main() {
    print(Box::new(10) as Box<dyn Printable>);
}
```

### Trait オブジェクトの lifetimes 境界

trait オブジェクトは参照を含むことができるので、それらの参照の lifetime を trait オブジェクトの一部として表現する必要がある。このライフタイムは `Trait + 'a.`と記述する。このライフタイムは、通常、賢明な選択で推論できる[デフォルト](https://doc.rust-lang.org/reference/lifetime-elision.html#default-trait-object-lifetimes)がある。

## [Auto traits](https://doc.rust-lang.org/reference/special-types-and-traits.html#auto-traits)

`Send`、`Sync`、`Unpin`、`UnwindSafe`、`RefUnwindSafe` の各 trait が`auto traits`。
`auto traits` には特別なプロパティがある。

与えられた型に対する`auto traits`について、明示的な実装や否定的な実装が書かれていない場合、コンパイラは以下の規則に従って自動的に実装する

- `&T`, `&mut T`, `*const T`, `*mut T`, `[T; n]`, および`[T]`は、T が trait を実装していれば、それに従う。
- 関数項目型と関数ポインタは自動的にこの trait を実装する。
- 構造体、列挙型、共用体、およびタプルは、そのフィールドのすべてがその trait を実装していれば、その trait を実装する。
- クロージャは、そのキャプチャのすべての型がその trait を実装していれば、その trait を実装する。T を共有参照でキャプチャし、U を値でキャプチャするクロージャは、&T と U の両方が実装しているすべての`auto traits`を実装している。

ジェネリック型（上記の組み込み型は T を超えるジェネリック型としてカウントされる）については、ジェネリック実装が利用可能な場合、コンパイラは、必要な Trait 境界を満たさないことを除いて、その実装を使用できる型に対して自動的に実装することはない。例えば、標準ライブラリは T が Sync であるすべての&T に対して Send を実装する。これは、T が Send であり Sync でない場合、コンパイラは&T に対して Send を実装しないことを意味する。

標準ライブラリのドキュメントでは、`impl !AutoTrait for T` として示され、自動実装をオーバーライドする。例えば、*mut T は Send の否定的な実装を持つので、T が Send であっても*mut T は Send ではない。現在のところ、否定的な実装を追加で指定する安定した方法はない。

`auto traits`は、通常は 1 つの trait しか許されないが、どの trait オブジェクトにも追加バインドとして追加できる。例えば、`Box<dyn Debug + Send + UnwindSafe>`は有効な型である。

## [Sized trait](https://doc.rust-lang.org/reference/special-types-and-traits.html#sized)

Sized trait は、この型のサイズがコンパイル時に既知であることを示す。Sized trait は、この型が動的にサイズ指定される型ではないことを示す。Sized trait は、実装項目ではなく、常にコンパイラによって自動的に実装される。

## Supertraits スーパートレイト

Rust には`継承`はないが、あるトレイトを別のトレイトの上位集合として定義できる

```rs
trait Person {
    fn name(&self) -> String;
}

// PersonはStudentのスーパートレイト
// Studentを実装するにはPersonも実装する必要がある
trait Student: Person {
    fn university(&self) -> String;
}
```

### References for Supertraits

- [Rust By Example 日本語版: スーパートレイト](https://doc.rust-jp.rs/rust-by-example-ja/trait/supertraits.html)
- [The Rust Reference: Supertraits](https://doc.rust-lang.org/reference/items/traits.html#supertraits)

## object-safety オブジェクト安全性

- トレイトオブジェクトには、オブジェクト安全なトレイトしか作成できない
- トレイトは、トレイト内で定義されているメソッド全てに以下の特性があれば、オブジェクト安全になる：
  - 戻り値の型が Self でないこと
    - [例外] 標準ライブラリの `Clone トレイト`はメソッドがオブジェクト安全でない
  - ジェネリックな型引数がないこと

標準ライブラリの Clone トレイトはメソッドがオブジェクト安全でない

```rs
pub trait Clone {
    fn clone(&self) -> Self;
}
```

### [The Rust Reference: Traits Object Safety](https://doc.rust-lang.org/reference/items/traits.html#object-safety)

オブジェクトセーフな traits は、trait オブジェクトの基本 trait になることができる。
trait がオブジェクトセーフであるのは、次の特性を備えている場合。

- すべての`supertraits`はオブジェクトセーフである必要がある (つまり、Clone を継承した trait はオブジェクトセーフではなくなる)
- `Sized` は`supertraits`であってはならない。つまり、`Self: Sized` を必要としてはならない
- 関連する定数があってはならない
- ジェネリックに関連する型があってはならない
- 関連するすべての関数は、トレイト オブジェクトからディスパッチ可能であるか、明示的にディスパッチ不可である必要がある
  - ディスパッチ可能な関数は
    - 型パラメータを持たないこと (ただし、lifetime パラメータは許可される)
    - レシーバーの型以外では Self を使用しないメソッドであること
    - 次のいずれかの型のレシーバーを持つこと:
      - &Self (i.e. &self)
      - &mut Self (i.e &mut self)
      - `Box<Self>`
      - `Rc<Self>`
      - `Arc<Self>`
      - `Pin<P>` where P is one of the types above
    - 不透明な戻り型を持たないこと
      - `async fn` (隠された Future 型を持つ) ではないこと [重要]
      - 戻り値に `impl Trait` 型を持たないこと (`fn example(&self) -> impl Trait`)
    - `where Self: Sized` 境界を持たないこと (Self のレシーバー タイプ (self) はこれを意味する)
  - 明示的にディスパッチ不可能な関数には以下が必要
    - self: Sized 境界がある (Self のレシーバー タイプ (つまり self) はこれを意味する)

### References for object-safety

- [トレイトオブジェクトには、オブジェクト安全性が必要](https://doc.rust-jp.rs/book-ja/ch17-02-trait-objects.html#%E3%83%88%E3%83%AC%E3%82%A4%E3%83%88%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%81%AB%E3%81%AF%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E5%AE%89%E5%85%A8%E6%80%A7%E3%81%8C%E5%BF%85%E8%A6%81)
- [The Rust Reference: Traits Object Safety](https://doc.rust-lang.org/reference/items/traits.html#object-safety)
- [rfcs: 255 object-safety](https://github.com/rust-lang/rfcs/blob/master/text/0255-object-safety.md)

#### async function を Trait で利用したい場合

[async-trait](https://crates.io/crates/async-trait) を使う

```rs
use async_trait::async_trait;

// Define the trait with async functions using the async-trait attribute
#[async_trait]
trait MyTrait {
    async fn my_async_function(&self);
}

// Implement the trait for a struct
struct MyStruct;

#[async_trait]
impl MyTrait for MyStruct {
    async fn my_async_function(&self) {
        // Your async code here
        println!("Hello from async function!");
    }
}

// Usage example
#[tokio::main]
async fn main() {
    let my_struct = MyStruct;
    my_struct.my_async_function().await;
}
```

## References

- [The Rust Programming Language 日本語版: トレイト(trait)](https://doc.rust-jp.rs/book-ja/ch10-02-traits.html)
  - [The Rust Programming Language 日本語版: 引数としてのトレイト](https://doc.rust-jp.rs/book-ja/ch10-02-traits.html#%E5%BC%95%E6%95%B0%E3%81%A8%E3%81%97%E3%81%A6%E3%81%AE%E3%83%88%E3%83%AC%E3%82%A4%E3%83%88)
- [The Rust Programming Language 日本語版: トレイトオブジェクトで異なる型の値を許容する](https://doc.rust-jp.rs/book-ja/ch17-02-trait-objects.html)
- [The Rust Programming Language 日本語版: 高度なトレイト](https://doc.rust-jp.rs/book-ja/ch19-03-advanced-traits.html)
- [Rust By Example 日本語版: トレイト](https://doc.rust-jp.rs/rust-by-example-ja/trait.html)
- [Rust での 抽象化 3 パターンについて](https://zenn.dev/j5ik2o/articles/045737392958a3)

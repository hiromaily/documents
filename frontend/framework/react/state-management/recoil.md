# Recoil
- Reduxの問題点
  - Reduxは状態管理を行なっているストアがひとつであるがゆえに、アプリケーション上のデータを常に上書きします。たとえばストアの状態を空オブジェクトのみで更新してしまうと、アプリケーション上のデータはすべて消えてしまう
- Context APIの制約
  - Context APIで管理されているReactコンポーネントの状態を変更するためには祖先コンポーネントまで辿ってツリーを更新しなくてはいけない
- Recoilとは？
  - Context APIが抱えるこれらの制約・問題を解決するためにFacebookによって提唱された実験的な状態管理ライブラリ
  - 「Atom」「Selector」と呼ばれる単位を使用してアプリケーションデータを管理し、各Atomには一意のキーとそれが管理するデータの一部が含まれている
  - 各Selectorは複数のAtomにもとづく派生状態の一部で、Atom・他のSelectorを受け取る純粋な関数として定義する
  - これらの単位をHooks APIで操作しながら状態管理を行うのがRecoil


recoilより、[Jotai](./jotai.md)のほうがよさそう

## References
- [recoil](https://recoiljs.org/)
- [github](https://github.com/facebookexperimental/Recoil)
- [Docs](https://recoiljs.org/docs/introduction/installation)
- [Reactの新しい状態管理ライブラリ「Recoil」とは？ Reduxとの違いを解説](https://ics.media/entry/210224/)


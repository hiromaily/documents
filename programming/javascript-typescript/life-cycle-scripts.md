# Life Cycle Scripts

- [npm: Life Cycle Scripts](https://docs.npmjs.com/cli/v10/using-npm/scripts#life-cycle-scripts)

npm による `scripts`フィールドの中に、特定の状況でのみ起こる特別なライフサイクルスクリプトが存在する

- prepare
  - パッケージがパックされる前、つまり `npm publish` と `npm pack` の間に実行される
  - 引数なしでローカルの`npm install`で実行される
- prepublishOnly
  - `npm publish` でのみ、パッケージが準備されパックされる前に実行される
- prepack
  - tarball がパックされる前に実行される
- postpack
  - tarball が生成された後、最終目的地に移動される前に実行される
- dependencies
  - `node_modules`ディレクトリに変更があった場合、変更された操作の後に実行される
  - グローバルモードでは実行されない
- preinstall
  - `npm install`の前に実行
- postinstall
  - `npm install`の後に実行
- preuninstall
  - `npm uninstall`の前に実行

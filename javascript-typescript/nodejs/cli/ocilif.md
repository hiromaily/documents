# oclif

## References

- [Official](https://oclif.io/)
- [github](https://github.com/oclif/oclif)

## CLI 生成

```
# 実行時のNode version: v18.11.0
# CLI! Version: 3.6.3

npx oclif generate mynewcli
> ? npm package name (mynewcli)
> ? command bin name the CLI will export
> ? description (oclif example Hello World CLI)
> ? author (HirokiYasui @hiromaily)
> ? license (MIT)
> ? Who is the GitHub owner of repository (https://github.com/OWNER/repo)
> ? What is the GitHub name of repository (https://github.com/owner/REPO)
> ? Select a package manager
```

これにより、指定した名前のディレクトリができあがる

## 利用できるコマンド

package.json より

```
  "scripts": {
    "build": "shx rm -rf dist && tsc -b",
    "lint": "eslint . --ext .ts --config .eslintrc",
    "postpack": "shx rm -f oclif.manifest.json",
    "posttest": "yarn lint",
    "prepack": "yarn build && oclif manifest && oclif readme",
    "test": "mocha --forbid-only \"test/**/*.test.ts\"",
    "version": "oclif readme && git add README.md"
  },
```

## bin ディレクトリ

開発中に CLI をテストするために実行できるいくつかの node スクリプトがあり、これらのスクリプトは、`dist`ディレクトリにあるビルドされたファイルからコマンドを実行する

```sh
# コマンド未指定時は、helpとなる
./bin/run

# コマンド指定の例
./bin/run hello world
./bin/dev hello John
```

## 独自コマンドの作成

1. 既に`npx oclif generate <dir-name>`で作成済みのディレクトリ内で実行する

```sh
npx oclif generate command <command-name>

>create src/commands/hogehoge.ts
>create test/commands/hogehoge.test.ts
```

2. 生成された src/commands 内のファイルを修正する
3. `npm run build` でビルド
4. 実行して確認

```sh
./bin/run <command-name>
# e.g.
./bin/run hogehoge --name Mike
```

## リリース方法

[Release](https://oclif.io/docs/releasing)

- `npm`によるものと、`tarballs`によるものがある

### npm

- `npm publish`コマンドによって release できる

### スタンドアロン tarballs

- CLI の root dir から `oclif pack tarballs`を実行する。これは node バイナリも含んでいるので、node のインストールは不要
- 公開するには、
  - `./dist`からファイルをコピーするか
  - `oclif upload tarballs`を使用して S3 にファイルをコピーする

### Brew

- Formula を作成する

## prompt (応答型で入力を受け付けるコマンド)

- [https://oclif.io/docs/prompting](https://oclif.io/docs/prompting)

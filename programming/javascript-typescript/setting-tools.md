# npm エコシステム内でよく使われるツールや設定

## .vscode directory

- vscode workspace settings

## .editorconfig

- [EditorConfig](https://editorconfig.org/)
  - EditorConfig helps maintain consistent coding styles for multiple developers working on the same project across various editors and IDEs

## .node-version

- .node-version is a file read by various tools on an individual basis for specifying the target node version.

## tsconfig

- tsconfig.base.json
- tsconfig.eslint.json

## .npmrc

- npm 用の設定ファイルで、private package を読み込む場合などによく使われる

## yarn

- .yarn directory
- .yarnrc.yml
  - yarn settings

## ESLint

- .eslintignore
- .eslintrc.js
- eslint.config.js

## prettie

- .prettierignore
- .prettierrc.json

## jest

- jest.config.js

## .husky directory

- [husky](https://github.com/typicode/husky)
  - git hook

## .cspell.json

- [CSpell](https://cspell.org/)
  - The CSpell mono-repo, a spell checker for code.
  - [e.g. configuration](https://github.com/typescript-eslint/typescript-eslint/blob/main/.cspell.json)

## .c8rc

- [c8](https://github.com/bcoe/c8)
  - output coverage reports using Node.js' built in coverage

## .codecov.yml

- [Codecov](https://about.codecov.io/)
  - Code Coverage

## .codeclimate.yml

- [Code Climate](https://docs.codeclimate.com/)
  - Code Climate helps your team ship better code, faster, by incorporating fully-configurable static analysis and test coverage data into your development workflow

## .lintstagedrc

- [lint-staged](https://github.com/okonet/lint-staged)
  - git stage されているファイルに対して linter を走らせるライブラリ

## [markdownlint](https://github.com/DavidAnson/markdownlint)

- Node.js style checker and lint tool for Markdown/CommonMark files
- .markdownlint.json
- .markdownlintignore

## [Nx](https://github.com/nrwl/nx)

- モノレポをベースとした build system
- .nxignore
- nx.json

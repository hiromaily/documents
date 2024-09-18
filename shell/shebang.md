# シェバン (shebang)

- `#!` から始まる 1 行目のこと。起動してスクリプトを読み込むインタプリタを指定する
  - e.g. `#!/bin/bash`, `#!/bin/sh`
- シェバンの参照先は、実行可能バイナリでなければならない
- env を用いたトリックは PATH 環境変数に依存する
  - e.g. `#!/usr/bin/env python3`
  - `env`コマンドは環境変数を設定してコマンドを実行するときに使うコマンド

## `#!/usr/bin/env python` の意味

### `#!/usr/bin/python`

`/usr/bin/python script.py` が実行される

### `#!/usr/bin/env python`

システムによっては、Python のインストールパスが異なる場合があるため、この記述によって、env コマンドの効果で、PATH 環境変数の通っている場所から、Python インタープリタを探索して実行することになる。これにより、pyenv で指定した環境から読み込むことができるようになる。ただし、alias で、`alias python=/usr/bin/python3`としていても、python によって python3 が読まれるということはない。

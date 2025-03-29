# Useful functionalities

## Go 1.25

**その他**:

- [Goodbye core types - Hello Go as we know and love it!](https://go.dev/blog/coretypes)

## Go 1.24

[Go 1.24 Release Notes](https://tip.golang.org/doc/go1.24), [Blog: Go 1.24 is released!](https://go.dev/blog/go1.24)

1. **言語レベルの更新**:

   - **ジェネリック型エイリアスのサポート**：Go 1.24 は、ジェネリック型エイリアスを完全にサポートしている。これにより、型エイリアスをパラメータ化することができるようになり、コードの柔軟性と再利用性が向上する。

2. **Cgo の改善**:

   - **新しい C 関数注釈**:`#cgo noescape`と`#cgo nocallback`が追加されている。これにより、C 関数の実行時パフォーマンスが向上する。また、C 関数の互換性チェックが厳格化され、異なるファイルに互換性のない宣言がある場合にエラーを検出し報告する。

3. **標準ライブラリの改善**:

   - **空のディレクトリの処理**：`archive`パッケージは、空のディレクトリを書き込む際に自動的にディレクトリヘッダを追加する。
   - **イテレータ関連の関数**:`bytes`と`strings`パッケージに、文字列とバイトスライスの操作を容易にするための複数のイテレータ関連の関数が追加された。
   - **暗号関連の機能**:`crypto`パッケージ内のサブパッケージが強化され、メソッドと機能が調整・強化されている。これにより、セキュリティとパフォーマンスが向上する。
   - **オブジェクトのシリアル化**:`encoding`パッケージに`TextAppender`と`BinaryAppender`インターフェイスが追加され、オブジェクトのシリアル化プロセスが最適化された。
   - **HTTP/2 サポートの拡大**:`net/http`パッケージは HTTP/2 に対するサポートを拡大し、開発者により強力な HTTP サーバーとクライアント開発機能を提供する。

4. **テスト関連の機能**:

   - **testing/synctest パッケージ**：並行コードのテストに特化した強力なサポートを提供する。これには、ゴルーチンのグループを起動するための`synctest.Run`関数と、現在の「バブル」内のすべてのゴルーチンがブロック状態に入るのを待つための`synctest.Wait`関数が含まれる。

5. **その他の機能と改善**:
   - **認証**:`GOAUTH`環境変数が追加され、プライベートモジュール取得の認証要件を満たすためのより柔軟な認証方法が提供された。
   - **バージョン情報**:`go build`コマンドは、バージョン管理システムのタグおよび/またはコミット情報に基づいて、コンパイルされたバイナリファイルのメインモジュールバージョンを設定する。
   - **ツールチェーンの改善**:`toolchaintrace=1`を使用すると、`go`コマンドのツールチェーン選択プロセスを追跡することができる。
   - **WebAssembly サポート**:`go:wasmexport`ディレクティブが追加され、Go プログラムから WebAssembly ホストへの関数のエクスポートが可能になった。また、`go:wasmimport`関数の型に使用できる型が増えた。

- [Coming in Go 1.24: testing/synctest experiment for time and concurrency testing](https://danp.net/posts/synctest-experiment/)

## Go 1.23

[Go 1.23 Release Notes](https://tip.golang.org/doc/go1.23), [Blog: Go 1.23 is released!](https://go.dev/blog/go1.23)

1. **range over func の正式導入**:

   - バージョン 1.23 で正式に導入された`range over func`機能により、Go 1.23 で for-range 構文を用いてシンプルな形でイテレータ処理の実装が可能になった.

2. **iter パッケージの追加**:

   - iter パッケージが新たに追加され、イテレータに関する実装や定義が含まれるようになった。これにより、イテレータ操作がより簡素化され、効率よく行えるようになった。

3. **slices パッケージの強化**:

   - slices パッケージには、イテレータの操作を行うための新しい関数が追加された。これにより、スライスを操作する際に、これまでと比べより簡潔な方法が利用可能になった。

4. **time パッケージの更新**:

   - time.Timer と time.Ticker の実装に大きな変更が加えられた。特に、参照されなくなったタイマーやティッカーが Stop メソッドが呼び出されていなくても即座にガベージコレクションの対象になるようになった。

5. **コンパイラの最適化**:

   - コンパイラでは、プロファイルガイド最適化（PGO）のオーバーヘッドが大幅に削減された。以前は、PGO を有効化するとビルド時間が 100%以上増加することがあったが、Go 1.23 ではオーバーヘッドが数パーセントに抑えられている。

6. **ツールチェーンの変更**:

   - 環境変数`GOROOT_FINAL`の設定はもはや効果を持たなくなった。ツールチェーンを`$GOROOT/bin/go`以外の場所にインストールするディストリビューションは、バイナリを移動またはコピーするのではなく、シンボリックリンクを使用することが推奨されている。さらに、`go env -changed`フラグが追加され、現在の環境設定の中でデフォルト値から変更されているもののみを表示するようになった。

7. **unique パッケージの追加**:

   - unique パッケージが新たに追加され、スライスの重複要素を除去するための機能が提供された。

8. **crypto/tls パッケージの TLS client が Encrypted Client Hello をサポートする**

   - [参考: 内部 Docs: TLS Encrypted Client Hello / ECH](../../security/tls/tls-encrypted-client-hello.md)
   - [参考: 内部 Docs: ポスト量子暗号](../../security/cryptography/public-key-cryptography/post-quantum-cryptography.md#golang-123に導入されたpost-quantum-key-exchange-mechanism-x25519kyber768draft00)

   ```sh
   GODEBUG=tlskyber=0
   ```

## Go 1.22

[Go 1.22 Release Notes](https://tip.golang.org/doc/go1.22), [Blog: Go 1.22 is released!](https://go.dev/blog/go1.22)

**Go 1.22 の主な変更点**

1. **for ループの仕様変更**:

   - **ループ変数のスコープの変更**: ループの各反復ごとに新しい変数が作成されるようになり、偶発的な共有バグを回避する
   - **整数の範囲指定をサポート**: `for`ループが整数を範囲として使用できるようになった。例えば、`for v := range 3`という形式で使用可能。

2. **range-over-function iterators のプレビュー**:

   - Go 1.22 には、将来の Go バージョンで検討されている言語変更「関数イテレータの範囲指定」のプレビューが含まれている
   - この機能を有効にするには、`GOEXPERIMENT=rangefunc`を指定してビルドする

3. **パッケージの追加と更新**:

   - **net/http**パッケージに新しい機能が追加。例えば、`http.ServeMux`でメソッドとマスクを指定する機能が追加された。

4. **パフォーマンスの向上**:

   - PGO（Profile-Guided Optimization）を有効にすると、ほとんどのプログラムのパフォーマンスが 2%～ 14%向上する。

5. **Windows でのビルドオプションの追加**:

   - `-buildmode=c-archive`や`-buildmode=c-shared`を使用することで、Event Logging Windows (ETW) API を使用できる。

6. **ライブラリの変更**:

   - **math/rand/v2**パッケージが標準ライブラリに追加された。これは、より一貫性のある API を提供し、より高速なアルゴリズムを使用して擬似乱数を生成する

7. **その他の変更**:
   - **io/unsafe**パッケージが追加され、ポインタとメモリを操作する機能が提供される
   - **net/http**パッケージでアイドル接続を閉じる機能が追加。

## Go 1.21

[Go 1.21 Release Notes](https://tip.golang.org/doc/go1.21), [Blog: Go 1.21 is released!](https://go.dev/blog/go1.21)

- ジェネリクスのためのパッケージ `slices`,`maps`の追加
- 組み込み関数 `min`, `max`, `clear` の追加
- コアライブラリの追加
  - `slog`パッケージ
  - `slices`, `maps`, `cmp` パッケージ

### [slog](https://pkg.go.dev/log/slog@master)

- インタフェースではなく実装
- structured + leveled logging 可能
- ネストした structure も可能
- slog.SetDefault を呼ぶと標準の log パッケージの出力も slog になる
- テキスト形式のほか、JSON 形式の出力も手軽にできる
- API トークンなどをログに出さないよう型ベースで設定できる

## Go 1.20

[Go 1.20 Release Notes](https://tip.golang.org/doc/go1.20)

- [PGO: Profile-guided optimization](https://go.dev/doc/pgo)
  - まだ preview 段階
  - ビルド時にプロファイルを提供することにより、コンパイラは一般的なアプリケーションを約 3 ～ 4%高速化することができる
- 標準ライブラリの追加
  - [crypto/ecdh](https://pkg.go.dev/crypto/ecdh)パッケージ
  - [errors.Join](https://pkg.go.dev/errors#Join)関数: エラータイプに`Unwrap() []error`メソッドが実装されている場合、再度取得することができるエラーのリストをラップしたエラーを返す
- パフォーマンスの向上

## Go 1.19

[Go 1.19 Release Notes](https://tip.golang.org/doc/go1.19)

- 変更のほとんどは、tool chain, runtime, ライブラリの実装となる
- 目立った修正は見られない

## Go 1.18

[Go 1.18 Release Notes](https://tip.golang.org/doc/go1.18)

- Generics
- Fuzzing tools

### Fuzzing (Since Go1.18)

- [Fuzzing is Beta Ready](https://blog.golang.org/fuzz-beta)
- [Design Draft: First Class Fuzzing](https://go.googlesource.com/proposal/+/master/design/draft-fuzzing.md)
- [Go 言語でファジング](https://deeeet.com/writing/2015/12/21/go-fuzz/)
- [dvyukov/go-fuzz](https://github.com/dvyukov/go-fuzz)
- [Go 製のネットワーククライアントに対する継続的 Fuzzing](https://speakerdeck.com/mururu/fuzzing-for-network-client-in-go)

## Go 1.17

[Go 1.17 Release Notes](https://golang.org/doc/go1.17)
目立った修正は見当たらない

## Go 1.16

[Go 1.16 Release Notes](https://golang.org/doc/go1.16)

- Module-aware mode is enabled by default. `GO111MODULE` environment variable now defaults to `on`.
- Build commands like go build and go test no longer modify go.mod and go.sum by default.
- go install now accepts arguments with version suffixes (for example, go install example.com/cmd@v1.0.0). This causes go install to build and install packages in module-aware mode, ignoring the go.mod file in the current directory or any parent directory.

### Embedding Files

- The go command now supports including static files and file trees as part of the final executable, using the new `//go:embed` directive.
- [Package embed](https://golang.org/pkg/embed/)
- [Go 1.16 からリリースされた go:embed とは](https://future-architect.github.io/articles/20210208/)

## deprecated

- The `-i` flag accepted by go build, go install, and go test is now deprecated.

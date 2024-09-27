# emscripten

Emscriptenは、LLVMを基盤としたコンパイラテクノロジーで、CおよびC++のコードをWebAssembly (WASM) または該当しない一部のケースでは`asm.js`にコンパイルすることができる。これにより、ネイティブアプリケーションのコードをブラウザ上で実行するための環境を提供する。

[LLVM内部Docs](../compiler/llvm.md)

## Emscriptenの特徴と利点

- **クロスプラットフォーム**: Emscriptenを使用することで、既存のC/C++コードベースを変更することなく、ブラウザで動作させることが可能です。
- **高速**: LLVMを使用して最適化されているため、生成されたWASMやasm.jsコードは高速に実行されます。
- **ブラウザ互換性**: Emscriptenが生成するコードは、主要なモダンブラウザで動作します。
- **JavaScriptインターオペラビリティ**: EmscriptenはJavaScriptとの相互運用性が高く、JavaScriptからC/C++コードを呼び出したり、その逆も可能です。

## Emscripten SDK (emsdk)

Emscripten SDK（通称emsdk）は、Emscriptenツールチェーンを簡単にダウンロード、インストール、構成するためのものです。

## インストールとセットアップ

以下に、Emscripten SDKを使った基本的なセットアップ手順を示します。

1. **emsdkのインストール**

    ```sh
    brew install emscripten
    
    or

    git clone https://github.com/emscripten-core/emsdk.git
    cd emsdk
    ./emsdk install latest
    ./emsdk activate latest
    source ./emsdk_env.sh
    ```

    `source ./emsdk_env.sh`を毎回シェルを開く度に実行する必要があります。これを自動化するために、`~/.bashrc`や`~/.zshrc`などのシェル設定ファイルに追加できます。

    ```sh
    echo 'source /path/to/emsdk/emsdk_env.sh' >> ~/.bashrc
    ```

2. **確認**

    正しくインストールされていることを確認するには、以下のコマンドを実行します。

    ```sh
    emcc --version
    ```

    このコマンドがEmscriptenのバージョン情報を表示すれば、インストールは成功しています。

## 基本的な使用例

1. **C/C++ライブラリのリンク**

    Emscriptenを使用して、C/C++に依存するRustプロジェクトをビルドする。Rustのクロスコンパイル機能を使用して、emscriptenターゲットに向けてビルドすることができる。

    ```sh
    cargo build --target wasm32-unknown-emscripten

    cargo build --target wasm32-unknown-emscripten --release
    ```

## References

- [emscripten](https://emscripten.org/)
- [hello-rust-sdl2-wasm](https://github.com/awwsmm/hello-rust-sdl2-wasm)
- [Hello, Rust: emscripten](https://www.hellorust.com/setup/emscripten/)
- [wasm-and-rust](https://github.com/raphamorim/wasm-and-rust)

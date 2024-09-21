# Rust Wasm with OpenCV

## [opencv-rust](https://github.com/twistedfall/opencv-rust)

[crates.io: opencv](https://crates.io/crates/opencv)

[Install](https://github.com/twistedfall/opencv-rust/blob/master/INSTALL.md)

```sh
brew install opencv

export DYLD_FALLBACK_LIBRARY_PATH="$(xcode-select --print-path)/Toolchains/XcodeDefault.xctoolchain/usr/lib/"
export LDFLAGS=-L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib  
```

cargo.toml

```toml
opencv = { version = "0.93", features = ["clang-runtime"] }
```

build

```sh
wasm-pack build --out-dir public/pkg-bundler --target bundler
```

### ビルド時にOpenCV起因のエラーが発生する

これは、Docker化したことで解決したが、別のエラーに遭遇した

```sh
   Compiling opencv v0.93.0
error: failed to run custom build command for `opencv v0.93.0`

Caused by:
  process didn't exit successfully: `{project}/wasm-ar-rust/target/release/build/opencv-beb3e85138c4bcc7/build-script-build` (exit status: 1)
  --- stdout
...
 === Detected probe priority boost based on environment vars: pkg_config: false, cmake: false, vcpkg: false
  === Probing the OpenCV library in the following order: environment, pkg_config, cmake, vcpkg_cmake, vcpkg
  === Can't probe using: environment, continuing with other methods because: Some environment variables are missing
  === Probing OpenCV library using pkg_config
  === Can't probe using: pkg_config, continuing with other methods because: pkg-config has not been configured to support cross-compilation.

  Install a sysroot for the target platform and configure it via
  PKG_CONFIG_SYSROOT_DIR and PKG_CONFIG_PATH, or install a
  cross-compiling wrapper for pkg-config and set it via
  PKG_CONFIG environment variable., pkg-config has not been configured to support cross-compilation.

  Install a sysroot for the target platform and configure it via
  PKG_CONFIG_SYSROOT_DIR and PKG_CONFIG_PATH, or install a
  cross-compiling wrapper for pkg-config and set it via
  PKG_CONFIG environment variable.
  === Probing OpenCV library using cmake
  === cmake ninja probe command: cd "{project}/wasm-ar-rust/target/wasm32-unknown-unknown/release/build/opencv-7451a8a87ac6ce86/out/cmake_probe_build" && "cmake" "-S" "{HOME}/.local/share/cargo/registry/src/index.crates.io-6f17d22bba15001f/opencv-0.93.0/cmake" "-DOCVRS_PACKAGE_NAME=OpenCV" "-DCMAKE_BUILD_TYPE=Release" "-G" "Ninja"
  === Probing with cmake ninja generator failed, will try Makefile generator, error: No such file or directory (os error 2)
  === cmake makefiles probe command: cd "{project}/wasm-ar-rust/target/wasm32-unknown-unknown/release/build/opencv-7451a8a87ac6ce86/out/cmake_probe_build" && "cmake" "-S" "{HOME}/.local/share/cargo/registry/src/index.crates.io-6f17d22bba15001f/opencv-0.93.0/cmake" "-DOCVRS_PACKAGE_NAME=OpenCV" "-DCMAKE_BUILD_TYPE=Release" "-G" "Unix Makefiles"
  === Probing with cmake Makefile generator failed, will try deprecated find_package, error: No such file or directory (os error 2)
  === cmake find-package compile probe command: cd "{project}/wasm-ar-rust/target/wasm32-unknown-unknown/release/build/opencv-7451a8a87ac6ce86/out/cmake_probe_build" && "cmake" "-S" "{HOME}/.local/share/cargo/registry/src/index.crates.io-6f17d22bba15001f/opencv-0.93.0/cmake" "-DOCVRS_PACKAGE_NAME=OpenCV" "-DCMAKE_BUILD_TYPE=Release" "--find-package" "-DCOMPILER_ID=GNU" "-DLANGUAGE=CXX" "-DMODE=COMPILE" "-DNAME=OpenCV"
  === Can't probe using: cmake, continuing with other methods because: No such file or directory (os error 2)
  === Probing OpenCV library using vcpkg_cmake
  === Can't probe using: vcpkg_cmake, continuing with other methods because: Could not find Vcpkg tree: No vcpkg installation found. Set the VCPKG_ROOT environment variable or run 'vcpkg integrate install'
  === Probing OpenCV library using vcpkg
  === Can't probe using: vcpkg, continuing with other methods because: the vcpkg-rs Vcpkg build helper can only find libraries built for the MSVC ABI., the vcpkg-rs Vcpkg build helper can only find libraries built for the MSVC ABI.
  Error: "Failed to find installed OpenCV package using probes: environment, pkg_config, cmake, vcpkg_cmake, vcpkg, refer to https://github.com/twistedfall/opencv-rust#getting-opencv for help"
warning: build failed, waiting for other jobs to finish...
Error: Compiling your crate to WebAssembly failed
Caused by: Compiling your crate to WebAssembly failed
Caused by: failed to execute `cargo build`: exited with exit status: 101
  full command: cd "{project}/wasm-ar-rust/crates/ar-wasm" && "cargo" "build" "--lib" "--release" "--target" "wasm32-unknown-unknown"

```

- [opencv-rust: Crosscompilation](https://github.com/twistedfall/opencv-rust/blob/master/INSTALL.md#crosscompilation)
  - Dockerfileが存在しているが、用途がことなる
- [Cross-compilation issues](https://github.com/twistedfall/opencv-rust/issues/504)
- [Add support for WASM targe](https://github.com/twistedfall/opencv-rust/issues/124)
- [Problem building project : opencv version not recognized](https://github.com/twistedfall/opencv-rust/issues/368)
  - `OPENCV_INCLUDE_PATHS="/path/to/include/opencv4"`を設定すればいいらしい
  - `OPENCV_INCLUDE_PATHS=/opt/homebrew/Cellar/opencv/4.10.0_6/include`を設定したが動かず
- [How to cross compile a rust project with opencv package for armv7](https://stackoverflow.com/questions/73433948/how-to-cross-compile-a-rust-project-with-opencv-package-for-armv7)

## 必要なtool?

- pkg-config
- [emscripten-core/emsdk](https://github.com/emscripten-core/emsdk)

## 代替え案

- [ブラウザ上のカメラでかざし画像を識別するWasmライブラリ(pHash)](https://i-407.com/blog/m9/)
- [OpenCV.jsとは？JavaScript版OpenCVの概要とその特徴](https://www.issoh.co.jp/tech/details/3608/#OpenCVjs-2)
- [wasm-ar](https://github.com/EdwardLu2018/wasm-ar/tree/master)
  - pythonだが、ARのアプリの例として
- [Rust+WebAssemblyを使ったWebアプリでの高速画像処理入門](https://techblog.adacotech.co.jp/entry/introduction_rust_and_wasm)

## References

- [WebAssemblyハンズオン ～React+Rustで顔モザイクツールをつくる～](https://devlog.neton.co.jp/develop/react/wasm-handson/)
  - OpenCVは使ってないので、Cのコードは含んでいない様子
- [Rust WebAssembly でリアルタイムで顔にモザイク処理](https://qiita.com/benki/items/5281141bd9b2cf320db3)
  - rustfaceを使っているが、OpenCVは使っていない
- [C/C++を呼び出しているRustのWASM化](https://future-architect.github.io/articles/20230605a/)
  - よくまとまっている。`emscripten`を使うことでうまくいったとのこと
  - `wasm-packはC/C++を呼んでいる場合は使えない` らしい
- [C言語へのFFIを含むRustをWASM化するのは難しすぎる](https://zenn.dev/newgyu/articles/4240df5d2a7d55)
- [C言語へのFFIを含むRustコードをWASMにする（CMakeを添えて）](https://zenn.dev/newgyu/articles/8bff73505c7b35)
- [github: opencv-wasm](https://github.com/omkar-mohanty/opencv-wasm)
- [Rust の wasm-pack のつまりどころ](https://takeg.hatenadiary.jp/entry/2022/01/30/175514)
- [How you can link a Rust library with C/C++ and wasm-bindgen for the wasm32-unknown-unknown target?](https://stackoverflow.com/questions/78556000/how-you-can-link-a-rust-library-with-c-c-and-wasm-bindgen-for-the-wasm32-unkno)
  - [`wasm-c-abi flag`](https://github.com/rust-lang/rust/pull/117919)によって、ビルドができるようになるらしい
  - [wasm-c-abi](https://doc.rust-lang.org/nightly/unstable-book/compiler-flags/wasm-c-abi.html)

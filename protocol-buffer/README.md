# Protocol Buffer

- [Protocol Buffers](https://protobuf.dev/)
- [Protocol Buffer Basics: Go](https://protobuf.dev/getting-started/gotutorial/)
- [Go Generated Code](https://protobuf.dev/reference/go/go-generated/)

- [github.com/golang/protobuf.. this is newer](https://github.com/protocolbuffers/protobuf-go)
  - [github.com/golang/protobuf.. this is old](https://github.com/golang/protobuf)

## Install

protobuf compiler is called `protoc`. but there are some compilers.

### 1. using homebrew on MacOS

```
brew install protoc
```

## `protoc` command (as of Jan 2022)

```
$ protoc --help
Usage: protoc [OPTION] PROTO_FILES
Parse PROTO_FILES and generate output based on the options given:
  -IPATH, --proto_path=PATH   Specify the directory in which to search for
                              imports.  May be specified multiple times;
                              directories will be searched in order.  If not
                              given, the current working directory is used.
                              If not found in any of the these directories,
                              the --descriptor_set_in descriptors will be
                              checked for required proto file.
  --version                   Show version info and exit.
  -h, --help                  Show this text and exit.
  --encode=MESSAGE_TYPE       Read a text-format message of the given type
                              from standard input and write it in binary
                              to standard output.  The message type must
                              be defined in PROTO_FILES or their imports.
  --deterministic_output      When using --encode, ensure map fields are
                              deterministically ordered. Note that this order
                              is not canonical, and changes across builds or
                              releases of protoc.
  --decode=MESSAGE_TYPE       Read a binary message of the given type from
                              standard input and write it in text format
                              to standard output.  The message type must
                              be defined in PROTO_FILES or their imports.
  --decode_raw                Read an arbitrary protocol message from
                              standard input and write the raw tag/value
                              pairs in text format to standard output.  No
                              PROTO_FILES should be given when using this
                              flag.
  --descriptor_set_in=FILES   Specifies a delimited list of FILES
                              each containing a FileDescriptorSet (a
                              protocol buffer defined in descriptor.proto).
                              The FileDescriptor for each of the PROTO_FILES
                              provided will be loaded from these
                              FileDescriptorSets. If a FileDescriptor
                              appears multiple times, the first occurrence
                              will be used.
  -oFILE,                     Writes a FileDescriptorSet (a protocol buffer,
    --descriptor_set_out=FILE defined in descriptor.proto) containing all of
                              the input files to FILE.
  --include_imports           When using --descriptor_set_out, also include
                              all dependencies of the input files in the
                              set, so that the set is self-contained.
  --include_source_info       When using --descriptor_set_out, do not strip
                              SourceCodeInfo from the FileDescriptorProto.
                              This results in vastly larger descriptors that
                              include information about the original
                              location of each decl in the source file as
                              well as surrounding comments.
  --dependency_out=FILE       Write a dependency output file in the format
                              expected by make. This writes the transitive
                              set of input file paths to FILE
  --error_format=FORMAT       Set the format in which to print errors.
                              FORMAT may be 'gcc' (the default) or 'msvs'
                              (Microsoft Visual Studio format).
  --fatal_warnings            Make warnings be fatal (similar to -Werr in
                              gcc). This flag will make protoc return
                              with a non-zero exit code if any warnings
                              are generated.
  --print_free_field_numbers  Print the free field numbers of the messages
                              defined in the given proto files. Groups share
                              the same field number space with the parent
                              message. Extension ranges are counted as
                              occupied fields numbers.
  --plugin=EXECUTABLE         Specifies a plugin executable to use.
                              Normally, protoc searches the PATH for
                              plugins, but you may specify additional
                              executables not in the path using this flag.
                              Additionally, EXECUTABLE may be of the form
                              NAME=PATH, in which case the given plugin name
                              is mapped to the given executable even if
                              the executable's own name differs.
  --cpp_out=OUT_DIR           Generate C++ header and source.
  --csharp_out=OUT_DIR        Generate C# source file.
  --java_out=OUT_DIR          Generate Java source file.
  --js_out=OUT_DIR            Generate JavaScript source.
  --kotlin_out=OUT_DIR        Generate Kotlin file.
  --objc_out=OUT_DIR          Generate Objective-C header and source.
  --php_out=OUT_DIR           Generate PHP source file.
  --python_out=OUT_DIR        Generate Python source file.
  --ruby_out=OUT_DIR          Generate Ruby source file.
  @<filename>                 Read options and filenames from file. If a
                              relative file path is specified, the file
                              will be searched in the working directory.
                              The --proto_path option will not affect how
                              this argument file is searched. Content of
                              the file will be expanded in the position of
                              @<filename> as in the argument list. Note
                              that shell expansion is not applied to the
                              content of the file (i.e., you cannot use
                              quotes, wildcards, escapes, commands, etc.).
                              Each line corresponds to a single argument,
                              even if it contains spaces.
```

## Compile options

### Plugin の指定方法について

- 複数の plugin を利用することが可能
- 引数を渡すことができる

```
--xxx_out=arg1=aaaaaa,arg2,arg3=cccccc:OUT_DIR \
```

- `--xxx_out` ... プラグイン+出力先の指定。`proto-gen-xxx`というプラグイン名であることが多い
  - `--go_out` ... go としての出力先 [plugin: google.golang.org/protobuf/cmd/protoc-gen-go)
  - `--js_out` ... js としての出力先
  - `--ts_out` ... ts としての出力先
  - `--ts_proto_out` ... ts としての出力先
  - `--grpc_out` ... grpc 用のファイルとしての出力先 (このやり方は古い)
  - `--go-grpc_out` ... grpc 用、かつ go として出力先 [plugin: https://github.com/grpc/grpc-go/tree/master/cmd/protoc-gen-go-grpc]
- `--plugin` ... 使用するプラグインの実行可能ファイルを指定する。形式は、--plugin=Name=Path となる。

### proto ファイル内の`import` path へのパスを指定する

- compile 時に`--proto_path` もしくは`-I`をつけることによって、proto ファイル内から参照する import パスを設定することができる

```
syntax = "proto3";

package path;

import 'device.proto';
```

- `--proto_path` (= -I)
  - `.proto` ファイルから import するファイルの PATH
  - さらに、コンパイルするための proto のパスも定義する必要がある

#### `-I`の書き方

- `-I.`
- `-I./proto`
- `-I=./proto`
- `-I${GOPATH}/src`
- `-I.:./proto:${GOPATH}/src` これによって複数指定ができる
- 以下のように複数指定することも可能

```
-I${somewhere}/abcde/proto \
-I${GOPATH}/src/github.com/gogo/protobuf
```

### option 指定後の最後の行

- compile する proto ファイルのパス
  - `proto/**/*.proto` のような書き方で複数ディレクトリを指定することも可能？？

#### ディレクトリが複数ある場合の bash script の書き方

```
proto_dirs=$(find $PROTO_DIR -path -prune -o -name '*.proto' -print0 | xargs -0 -n1 dirname | sort | uniq)
for dir in $proto_dirs; do
  $PROTOC \
  --plugin="$(yarn bin protoc-gen-ts_proto)" \
  --ts_proto_out="$OUT_DIR" \
  --proto_path="$PROTO_DIR" \
  --proto_path="$THIRD_PARTY_PROTO_DIR" \
  --ts_proto_opt="esModuleInterop=true,forceLong=long,useOptionals=true,outputTypeRegistry=true" \
  $(find "${dir}" -maxdepth 1 -name '*.proto')
done
```

## proto ファイルのフォーマットについて

- `clang-format` を使う
  - [.proto ファイルの整形に clang-format を使う](https://christina04.hatenablog.com/entry/protobuf-formatter)
- [buf](https://github.com/bufbuild/buf)を使う
  - [Docs](./buf.md)

## Proto ファイルの linter について

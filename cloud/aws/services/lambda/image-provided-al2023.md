# Lambda の OS 専用ランタイム

`provided.al2023`ベースランタイムは `AL2023 の最小コンテナイメージに基づいており`、AL2023 ベースの Lambda マネージドランタイムとコンテナベースイメージを提供する。package manager すら install されていない。

## `provided.al2023` および `provided.al2` ランタイムの利点

- arm64 アーキテクチャのサポート (AWS Graviton2 プロセッサー)
- バイナリの小型化
- 若干の呼び出し時間短縮化など

## Dockerfile: [provided.al2023/Dockerfile.provided.al2023](https://github.com/aws/aws-lambda-base-images/blob/provided.al2023/Dockerfile.provided.al2023)

```Dockerfile
FROM scratch
ADD x86_64/0ca391d81c067de7780380c3432241dae95d6b7206f54fcff382da4441f44d2f.tar.xz /
ADD x86_64/41bd69298790635913afaf03b4ed358b68fdb1a16307b0fef634d7d671c6a816.tar.xz /
ADD x86_64/5d2ebdeb7c1b4a119e143bc4511152f945d8e5c003f4db0af0496e04aface18e.tar.xz /
ADD x86_64/5fb2b0c09baa8e02cbc31c60ea19d4d546aa475fa27020977678599077f63ea6.tar.xz /

ENV LANG=en_US.UTF-8
ENV TZ=:/etc/localtime
ENV PATH=/var/lang/bin:/usr/local/bin:/usr/bin/:/bin:/opt/bin
ENV LD_LIBRARY_PATH=/var/lang/lib:/lib64:/usr/lib64:/var/runtime:/var/runtime/lib:/var/task:/var/task/lib:/opt/lib
ENV LAMBDA_TASK_ROOT=/var/task
ENV LAMBDA_RUNTIME_DIR=/var/runtime

WORKDIR /var/task

ENTRYPOINT ["/lambda-entrypoint.sh"]
```

## provided:al2023 Image を使った Dockerfile の例

```Dockerfile
FROM golang:1.20 as build

WORKDIR /helloworld
COPY go.mod go.sum ./
COPY main.go .
RUN go build -tags lambda.norpc -o main main.go

# Copy artifacts to a clean image
FROM public.ecr.aws/lambda/provided:al2023
COPY --from=build /helloworld/main ./main
ENTRYPOINT [ "./main" ]
```

## [AL2 と AL2023 の比較](https://docs.aws.amazon.com/ja_jp/linux/al2023/ug/compare-with-al2.html)

- AL2023 は起動時間を最適化して、インスタンス起動からのワークロードの実行までの時間を短縮する
- AL2023 は RPM ベース
- AL2023 のデフォルトのソフトウェアパッケージ管理ツールは `DNF`

## References

- [Lambda の OS 専用ランタイムを使用する状況](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/runtimes-provided.html)
- [AWS Lambda で AL2023 を使用する](https://docs.aws.amazon.com/ja_jp/linux/al2023/ug/lambda.html)
- [AL2023 Minimal container image](https://docs.aws.amazon.com/linux/al2023/ug/minimal-container.html)
- [コンテナ (AL2023) で AWS Lambda を構築するのに必要な事項のメモ](https://zenn.dev/hassaku63/scraps/58de9fc1d8a338)

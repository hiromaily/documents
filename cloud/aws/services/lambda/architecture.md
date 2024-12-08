# Lambdaの命令セットArchitecture

コンテナ内でビルドするときは、`arm64`を指定する必要がある

```Dockerfile
FROM base AS build-app
ARG COMMIT_ID
ENV ARCH="arm64"
RUN --mount=type=cache,target=/go/pkg/mod/ \
    --mount=type=bind,target=. \
    GOOS=linux GOARCH=${ARCH} CGO_ENABLED=0 \
    go build -trimpath -ldflags="-s -w -X main.CommitID=${COMMIT_ID}" -o /bin/app ./cmd/app/
```

[Lambda 関数の命令セットアーキテクチャの選択と設定](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/foundation-arch.html)

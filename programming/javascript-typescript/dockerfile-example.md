# Docker for npm project

## 原則

変更が入りやすいものほど、後ろに設定する

### 方法 1

問題点: COPY 対象`src`ディレクトリ 内に変更が入ったらキャッシュが無効化され、 `npm install` が実行されてしまう

```dockerfile
FROM node:22 AS builder

WORKDIR /workspace

# ハッシュ値がなるべく変わりにくいように，ビルドに関係するファイルだけをコピー
COPY package.json package-lock.json ./
COPY public public
COPY src src

RUN npm install
RUN npm run build

FROM nginx:stable

COPY --from=builder /workspace/build /usr/share/nginx/html
```

### 方法 2

`RUN npm install`を先に実行することで、`src`ディレクトリに修正入っても `npm install` は実行されないが、わずかに `package.json` が修正されても `npm install` がすべて実行されてしまう

```dockerfile
FROM node:22 AS builder

WORKDIR /workspace

# ハッシュ値がなるべく変わりにくいように，ビルドに関係するファイルだけをコピー
COPY package.json package-lock.json ./
RUN npm install

COPY public public
COPY src src

RUN npm run build

FROM nginx:stable

COPY --from=builder /workspace/build /usr/share/nginx/html
```

### 方法 3 [最適解]

`--mount=type=cache` を使う

```dockerfile
# syntax=docker/dockerfile:1

FROM node:22 AS builder

WORKDIR /workspace

COPY package.json package-lock.json ./
# /root/.npm をキャッシュ
RUN --mount=type=cache,target=/root/.npm npm install
# dev環境であれば以下でもよい
# RUN \
#   --mount=type=cache,target=/root/.npm \
#   --mount=type=cache,target=/workspace/node_modules \
#   npm install


COPY public public
COPY src src
RUN npm run build

FROM nginx:stable

COPY --from=builder /workspace/build /usr/share/nginx/html
```

### キャッシュディレクトリ

- npm: /root/.npm
- yarn: /usr/local/share/.cache/yarn/v6
- pnpm: /root/.pnpm-store

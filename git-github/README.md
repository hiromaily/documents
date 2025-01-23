# Git

- [Dangit, Git!?!](https://dangitgit.com/ja)
- WIP: [GitHub コマテク集](https://techblog.openwork.co.jp/entry/github-tips)

## Github の検索

- [grep.app](https://grep.app/)

## 新しい branch の作成方法

```sh
# 古い方法
git checkout -b ${new-branch} origin/main

# 新しい方法
git switch -c ${new-branch} origin/main
```

## 新しい branch の変更方法

```sh
# 古い方法
git checkout ${branch-name}

# 新しい方法
git switch ${branch-name}
```

## git add した後に変更点を見る

```sh
git diff --cached
 or
git diff --staged
```

## 特定のファイルの変更履歴を辿る

```sh
# ファイルの変更箇所といつ・誰が変更したかを表示
git blame ${file-name}
```

## 月間のコミット数のランキング

```sh
git log --since="2024-09-01" --until="2024-09-30" --format='%aN' | sort | uniq -c | sort -nr
```

結果

```sh
  69 HirokiYasui
  56 FooBar
```

## 現在のブランチがどのリモートブランチに追跡されているかを確認する

```sh
git branch -vv

# 追跡ブランチを`origin/develop`に変更する例
git branch -u origin/develop

# 追跡ブランチがまだ作成されていない場合
git push -u origin feature-branch
```

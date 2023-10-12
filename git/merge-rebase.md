# Merge and Rebase

マージ時にコンフリクトしたときに、どちらかで上書きしたい場合、自分が修正しているブランチが`branch-my-development`で、`origin/main`で rebase もしくは merge したいとする。この時、rebase と merge で、theirs/ours の指すブランチが逆になるので注意が必要

```sh
$ git merge -Xtheirs origin/main  # <- ours: branch-my-development, theirs: origin/main
$ git rebase -Xtheirs origin/main # <- ours: origin/main, theirs: branch-my-development
```

# chezmoi

[chezmoi](https://github.com/twpayne/chezmoi)

プロジェクト内の`.bashrc`といったdotファイル を管理するためのツール。複数のマシンやデバイス間で、dotfilesを一貫して安全に管理できる。

```sh
# Install
sh -c "$(curl -fsLS get.chezmoi.io)"

# 初期化
chezmoi init

# dotfilesの追加
chezmoi add ~/.bashrc

# 変更の確認
chezmoi diff

# 変更の適用
chezmoi apply
```

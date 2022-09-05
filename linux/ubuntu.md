# Ubuntu

- [Upgrading from Ubuntu 20.04? Look Out for These Features in 22.04](https://www.omgubuntu.co.uk/2022/04/ubuntu-22-04-lts-20-key-changes)

## Shortcut
- アプリケーション+検索window ... Windowボタン
- Windowサイズを全画面にしたり、右/左半分に変更する ... Windowボタン+十字キー
- ワークスペース切り替え ... Ctrl+Alt と　矢印キー

## 日本語入力
- `Budgie Control Center`の`Keyboard`の設定内、`Input Source Switching`の項を確認
- `Keyboard Shortcuts`で変更が可能。`Super` + `Space`が一般的

### 日本語が入力できない問題への対処
- 以下を実行し、input-sourceの確認
```bash
gsettings get org.gnome.desktop.input-sources sources
# [('ibus', 'mozc-jp'), ('xkb', 'us'), ]
```

- `IBus  is  an  Intelligent Input Bus. It is a new input framework for Linux OS`　
- `ibus-setup`コマンドで、設定ファイルが表示される。
  - `Keyboard Shortcuts`-`Next input method:` で、shortcutの追加が必要
  - Restartしたら切り替えが動作するようになった


## Ubuntu Workspace
- ワークスペース切り替え ... `Ctrl`+`Alt` と `矢印キー`

## Gestures
- [mouse](https://help.ubuntu.com/stable/ubuntu-help/mouse.html.en)
- [touchscreen-gestures](https://help.ubuntu.com/stable/ubuntu-help/touchscreen-gestures.html.en)
- `Ubuntu Budgie Desktop`の場合は選択できない？？

## Install theme
- `Ubuntu Budgie Desktop`の場合、`Budgie Themes & Layouts`から選択が可能
- [gnome-look.org](https://www.gnome-look.org/browse?cat=135&ord=rating)

```
sudo apt install [package name]-theme
```

## tilix
[home](https://gnunn1.github.io/tilix-web/manual/)

### Change Shortcuts
- `Preference` > `Shortcuts`にて、真っ先に`Copy`, `Paste`の設定を変更しておく

- `Alt`+`T` ... Open a new session
- `Alt`+`D` ... Add terminal right
- `Alt`+`Shift`+`D` ... Add terminal down
- `Alt`+`right`/`left` ... Switch session in same window
- `Alt`+`Shift`+`right`/`left` ... Switch session of next window
- `Alt`+`K` ... Reset and clear the terminal


## Ubuntuのboot USBをMacで作成する
- OS imageをダウンロード
- USBメモリを`FAT32`にフォーマット
- [etcher](https://www.balena.io/etcher/)をインストール

## Clean install from USB
- OS 起動前での BIOS へのアクセスにはキーボード上の`F2`を押下したまま、`電源ボタン`を押し、`F2` キーは押したまま


## Install Install Budgie Desktop 
```
sudo apt update && sudo apt upgrade -y
sudo apt install ubuntu-budgie-desktop
# default display manager => lightdm
```
- Then Log Out 
- Switch to Budgie Desktop at Login in Ubuntu from right bottom corner

## Upgrade version from 20.04 to 22.04
```
sudo apt update 
sudo apt upgrade
sudo apt dist-upgrade
sudo apt autoremove
sudo apt install update-manager-core
sudo do-release-upgrade 
```

# Ubuntu

- [Upgrading from Ubuntu 20.04? Look Out for These Features in 22.04](https://www.omgubuntu.co.uk/2022/04/ubuntu-22-04-lts-20-key-changes)

## Shortcut
- アプリケーション+検索window ... Windowボタン
- Windowサイズを全画面にしたり、右/左半分に変更する ... Windowボタン+十字キー
- ワークスペース切り替え ... Ctrl+Alt と　矢印キー

## tilix
[home](https://gnunn1.github.io/tilix-web/manual/)

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

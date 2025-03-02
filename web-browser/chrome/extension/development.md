# Extensionの開発

開発者は自身の拡張機能を作成することができる。基本的な開発ステップは以下の通り：

1. **マニフェストファイル（manifest.json）**: 拡張機能の設定や権限を指定するためのファイル。
2. **HTML、CSS、JavaScript**: インターフェイスや機能を実装する。
3. **[Chrome API](https://developer.chrome.com/docs/extensions/reference/api?hl=ja)**: Googleが提供する特定のAPIを使用すると、拡張機能はより強力な機能を実現できる。
4. **パッケージングとアップロード**: 開発が完了したら、拡張機能をパッケージ化してChromeウェブストアにアップロードする。
5. **公式の審査**: 審査を経て Chrome Web Store で公開することができ、広くユーザーに利用してもらうことが可能。

以下は簡単な`manifest.json`の例：

```json
{
  "manifest_version": 3,
  "name": "My Extension",
  "version": "1.0",
  "description": "A simple Chrome extension example.",
  "permissions": ["activeTab"],
  "action": {
    "default_popup": "popup.html",
    "default_icon": {
      "16": "icon_16.png",
      "48": "icon_48.png",
      "128": "icon_128.png"
    }
  }
}
```

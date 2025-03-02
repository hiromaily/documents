# Google Chrome の拡張機能（Chrome Extension）

Google Chrome の拡張機能（Chrome Extension）は、Google Chrome ブラウザの機能を拡張または変更する小さなソフトウェアプログラム。これらの拡張機能は、ユーザーエクスペリエンスを向上させるために設計されており、新しい機能の追加、既存機能の改良、またはウェブサイトの動作を調整するために使用される。

## 主な特徴

1. **機能追加**: 特定のタスクを効率化するための新しいツールや機能を提供する。

   - 例: パスワードマネージャー、翻訳ツール、広告ブロッカー

2. **デザインの変更**: ウェブページの外観やレイアウトをカスタマイズすることができる。

   - 例: ダークモードテーマを追加する拡張機能、フォントサイズの調整

3. **効率化**: ブラウザの動作やインターフェイスをカスタマイズして、操作を効率化する。

   - 例: タブ管理ツール、キーボードショートカットの追加

4. **セキュリティとプライバシー**: セキュリティを向上させたり、プライバシーを保護する機能も提供される。
   - 例: トラッカーのブロック、フィッシング対策

## 具体的に何ができるか？

### 1. UI のカスタマイズ

- **ツールバーアイコン**: ブラウザツールバーにカスタムアイコンを追加し、そこからアクションをトリガーできる。
- **ポップアップウィンドウ**: ツールバーアイコンをクリックすると開くポップアップウィンドウを作成し、そこにカスタム UI を表示できる。
- **コンテキストメニュー**: 右クリックメニューにカスタム項目を追加し、専用のアクションを実行できる。

### 2. コンテンツの制御/変更

- **コンテンツスクリプト**: 特定のウェブページにスクリプトを挿入して、その内容や動作を変更できる。例えば、特定のキーワードをハイライトしたり、ページのレイアウトを変更したりすることができる。
- **ページのスタイル変更**: 特定のウェブページの CSS を変更して、見た目をカスタマイズできる。

### 3. ブラウザの動作制御

- **タブ管理**: タブの作成、削除、更新、リロード、並び替えなどを行うことができる。
- **ウェブリクエストの操作**: 特定の条件に基づいてウェブリクエストをブロックしたり、リダイレクトしたり、ヘッダーを操作したりできる。

### 4. データの保存および同期

- **ローカルストレージ**: ブラウザを閉じても保持されるローカルストレージにデータを保存できる。
- **クラウド同期**: Chrome ブラウザにログインしているデバイス間で設定やデータを同期させることができる。

### 5. ネットワーク通信

- **バックグラウンド通信**: サーバーとの非同期通信を実行し、バックグラウンドでデータの取得や送信を行える。
- **通知表示**: ユーザーに通知を表示して、重要な情報を即座に伝えることができる。

### 6. ブラウザ設定のカスタマイズ

- **プロキシ設定の管理**: 拡張機能からプロキシ設定を動的に変更したり管理したりできる。
- **ブラウザの動作や設定の変更**: デフォルトの検索エンジン、ホームページ、タブの動作などをカスタマイズできる。

### 7. セキュリティ/プライバシーの強化

- **広告ブロック**: ページ上の広告を検出し、表示をブロックする。
- **トラッキング防止**: トラッキングスクリプトやクッキーをブロックすることによって、ユーザーのプライバシーを保護する。

### 8. デベロッパーツールの拡張

- **デベロッパーツールパネル**: Chrome のデベロッパーツールにカスタムタブやパネルを追加して、特定のデバッグ作業を支援するツールを提供できる。

### 9. 専門的な作業効率化

- **フォーム自動補完**: よく使うフォームの入力を自動化する。
- **スクリーンショット**: 特定のウェブページのスクリーンショットをキャプチャし、編集や保存する。

これらの機能は、拡張機能の`manifest.json`ファイルに必要な権限を宣言することによって利用できるようになる。例えば、ブラウザのタブを管理するには`tabs`権限が必要。

## どのタイミングで実行される？

### 1. 拡張機能アイコンのクリックをトリガーにする場合

拡張機能のアイコンがクリックされたときにスクリプトを実行する方法。
この場合、`background` スクリプトや`service worker`を使ってイベントリスナーを設定する。

**`manifest.json`**:

```json
{
  "manifest_version": 3,
  "name": "Extension Click Example",
  "version": "1.0",
  "permissions": ["activeTab", "scripting"],
  "background": {
    "service_worker": "background.js"
  },
  "action": {
    "default_popup": "popup.html",
    "default_icon": {
      "16": "icon.png",
      "48": "icon.png",
      "128": "icon.png"
    }
  },
  "icons": {
    "16": "icon.png",
    "48": "icon.png",
    "128": "icon.png"
  }
}
```

**`background.js`**:

```js
chrome.action.onClicked.addListener((tab) => {
  chrome.scripting.executeScript({
    target: {tabId: tab.id},
    function: changePageContent
  });
});

function changePageContent() {
  document.body.style.backgroundColor = 'yellow';
}
```

### 2. 特定のページが表示されたときにスクリプトを実行する場合

特定のURLマッチングに基づいてスクリプトを自動的に挿入して実行する方法。この場合、`content_scripts`の`matches`オプションを使う。

**`manifest.json`**:

```json
{
  "manifest_version": 3,
  "name": "Page Specific Script Example",
  "version": "1.0",
  "permissions": ["activeTab"],
  "content_scripts": [
    {
      "matches": ["https://example.com/*"],
      "js": ["content.js"],
      "run_at": "document_idle"
    }
  ],
  "icons": {
    "16": "icon.png",
    "48": "icon.png",
    "128": "icon.png"
  }
}
```

**`content.js`**:

```js
document.addEventListener("DOMContentLoaded", () => {
  // Example.comのページが表示されたときに実行されるコード
  console.log("This is example.com");
  document.body.style.backgroundColor = 'lightblue';
});
```

### 3. コンテキストメニューを作成し、特定のページ要素の操作をトリガーにする場合

ウェブページ上で特定の要素を右クリックしたときにメニュー項目を追加し、それを通じてスクリプトを実行する方法。

**`manifest.json`**:

```json
{
  "manifest_version": 3,
  "name": "Context Menu Example",
  "version": "1.0",
  "permissions": ["contextMenus", "scripting", "activeTab"],
  "background": {
    "service_worker": "background.js"
  },
  "icons": {
    "16": "icon.png",
    "48": "icon.png",
    "128": "icon.png"
  }
}
```

**`background.js`**:

```js
// メニュー項目を追加
chrome.runtime.onInstalled.addListener(() => {
  chrome.contextMenus.create({
    id: "changeColor",
    title: "Change background color to Blue",
    contexts: ["all"]
  });
});

// コンテキストメニュー項目がクリックされたときのイベントハンドラ
chrome.contextMenus.onClicked.addListener((info, tab) => {
  if (info.menuItemId === "changeColor") {
    chrome.scripting.executeScript({
      target: {tabId: tab.id},
      function: changePageColor
    });
  }
});

function changePageColor() {
  document.body.style.backgroundColor = 'blue';
}
```

### 4. タブ更新やページナビゲーションをトリガーにする場合

特定のタブでページがロード完了したときにスクリプトを実行する方法。

**`manifest.json`**:

```json
{
  "manifest_version": 3,
  "name": "Tabs Update Example",
  "version": "1.0",
  "permissions": ["tabs", "scripting", "activeTab"],
  "background": {
    "service_worker": "background.js"
  },
  "icons": {
    "16": "icon.png",
    "48": "icon.png",
    "128": "icon.png"
  }
}
```

**`background.js`**:

```js
chrome.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
  if (changeInfo.status === 'complete' && tab.url.includes("https://example.com")) {
    chrome.scripting.executeScript({
      target: {tabId: tabId},
      function: initializeScript
    });
  }
});

function initializeScript() {
  console.log("Example.com page has been fully loaded.");
  document.body.style.backgroundColor = 'green';
}
```

## Ad blocker の実装方法

## セキュリティとプライバシーの考慮

拡張機能をインストールする際は、信頼性を確認することが重要。特に、過剰な権限を要求する拡張機能には注意が必要。ユーザーのデータを保護するために、拡張機能の開発者はセキュリティガイドラインに従い、透明性を維持する必要がある。

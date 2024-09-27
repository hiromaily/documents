# File System API

`File System API`は、ウェブアプリケーションがローカルファイルシステムに直接アクセスするためのインターフェースを提供する。これにより、ユーザーはファイルの読み書き、選択、および保存をウェブアプリケーションと同じように行うことができる。このAPIは、特にデスクトップアプリケーションのような機能を提供したいウェブアプリケーションにとって非常に有用。

## 主な機能

1. **ファイルの読み取り**: ユーザーが選択したファイルの内容を読み取ることができる
2. **ファイルの書き込み**: ユーザーが選択したファイルにデータを書き込むことができる
3. **ファイルの保存**: 新しいファイルの作成と保存が可能
4. **ディレクトリの操作**: ディレクトリを選択し、その中のファイルを操作することも可能（前提としてユーザーの許可が必要）。

## File System APIの代表的な操作例

### 1.ファイルを開いて読み取る

まず、ユーザーがファイルを選択して、その内容を読み取る方法

```html
<input type="file" id="fileInput" />

<script>
document.getElementById('fileInput').addEventListener('change', async (event) => {
    const file = event.target.files[0];
    const content = await file.text();
    console.log('ファイル内容:', content);
});
</script>
```

### 2.ファイルの保存

次に、ユーザーが新しいファイルを作成し、その内容を保存する方法

```html
<button id="saveFileButton">ファイルを保存</button>

<script>
document.getElementById('saveFileButton').addEventListener('click', async () => {
    try {
        const handle = await window.showSaveFilePicker({
            types: [{
                description: 'Text Files',
                accept: { 'text/plain': ['.txt'] },
            }],
        });
        const writable = await handle.createWritable();
        await writable.write('Hello, World!');
        await writable.close();
        console.log('ファイルが保存されました');
    } catch (error) {
        console.error('ファイル保存中にエラーが発生しました:', error);
    }
});
</script>
```

### 3.ファイルに書き込む

既存のファイルを選択して、その内容を書き換える方法

```html
<button id="writeFileButton">ファイルに書き込む</button>

<script>
document.getElementById('writeFileButton').addEventListener('click', async () => {
    try {
        const [fileHandle] = await window.showOpenFilePicker();
        const writable = await fileHandle.createWritable();
        await writable.write('新しい内容');
        await writable.close();
        console.log('ファイルが書き換えられました');
    } catch (error) {
        console.error('ファイル書き込み中にエラーが発生しました:', error);
    }
});
</script>
```

### 4.ディレクトリの操作

ユーザーがディレクトリを選択し、その中のファイルを操作する方法

```html
<button id="directoryPickerButton">ディレクトリを選択</button>

<script>
document.getElementById('directoryPickerButton').addEventListener('click', async () => {
    try {
        const directoryHandle = await window.showDirectoryPicker();
        for await (const entry of directoryHandle.values()) {
            console.log('ディレクトリエントリ:', entry.name);
        }
    } catch (error) {
        console.error('ディレクトリ選択中にエラーが発生しました:', error);
    }
});
</script>
```

## セキュリティとプライバシー

File System Access APIは、セキュリティとプライバシーに配慮して設計されているが、以下の点に注意が必要

1. **ユーザーの明示的な許可**:
   - ファイルまたはディレクトリへのアクセスは、常にユーザーの明示的な許可が必要。ユーザーがアクセスを許可した範囲内で操作が実行される。

2. **スコープの制限**:
   - アプリケーションはユーザーが明示的に選択したファイルやディレクトリに対してのみアクセス可能。他のファイルやディレクトリにアクセスすることはできない。

3. **パーミッションの持続性**:
   - パーミッションは永続的ではなく、ブラウザセッションが終了するまで維持されるか、ブラウザの設定で管理される。

## ブラウザサポート

PCのChrome, Edge, Operaくらいしかサポートしていない

[Can I use](https://caniuse.com/native-filesystem-api)

# HTMLVideoElement

`HTMLVideoElement`は、HTML5におけるビデオ再生のための要素であり、主に`<video>`タグを介して操作される。この要素はウェブページでビデオを表示および操作するための多くのプロパティやメソッド、イベントを提供する。

## 主なプロパティ

- **height**: ビデオの高さを取得または設定する。デフォルト値はなし（ブラウザのデフォルト）。
- **width**: ビデオの幅を取得または設定する。デフォルト値はなし（ブラウザのデフォルト）。
- **videoHeight**: ビデオのネイティブな高さ（ピクセル単位）を取得（読み取り専用）。
  - Macbook Proでも640pxだった
- **videoWidth**: ビデオのネイティブな幅（ピクセル単位）を取得（読み取り専用）。
  - Macbook Proでも480pxだった
- **poster**: ビデオのサムネイルイメージ（ポスターフレーム）を指定。ビデオが再生されていないときに表示される画像。
- **srcObject**: ビデオのソースとして直接MediaStreamを指定できる。

## 主なメソッド

- **play()**: ビデオの再生を開始。
- **pause()**: ビデオの再生を一時停止。
- **load()**: ビデオのロードを強制開始。
- **canPlayType(type)**: 指定されたMIMEタイプのビデオを再生できるかどうかを確認。返り値は`"probably"`、`"maybe"`、または空文字列。

## 主なイベント

- **play**: 再生が開始されたときに発生。
- **pause**: 再生が一時停止されたときに発生。
- **ended**: ビデオの再生が終了したときに発生。
- **loadeddata**: ビデオのデータが完全に読み込まれたときに発生。
- **timeupdate**: 再生位置（currentTime）が更新されたときに定期的に発生。
- **error**: ビデオの再生中にエラーが発生したときに発生。

### 使用例

```html
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>HTMLVideoElementの使用例</title>
</head>
<body>
    <!-- ビデオ要素 -->
    <video id="myVideo" width="640" height="480" controls poster="thumbnail.jpg">
        <source src="your-video-file.mp4" type="video/mp4">
        お使いのブラウザは、ビデオタグをサポートしていません。
    </video>
    
    <button onclick="playVideo()">再生</button>
    <button onclick="pauseVideo()">一時停止</button>
    
    <script>
        const video = document.getElementById('myVideo');
        
        function playVideo() {
            video.play();
        }
        
        function pauseVideo() {
            video.pause();
        }

        // イベントリスナーの例
        video.addEventListener('play', () => {
            console.log('ビデオが再生されました');
        });

        video.addEventListener('pause', () => {
            console.log('ビデオが一時停止されました');
        });
    </script>
</body>
</html>
```

この例では、`<video>`タグを使用してビデオを表示し、JavaScriptを使ってビデオの再生と一時停止の機能を追加している。また、ビデオの再生と一時停止イベントにリスナーを追加して、コンソールにメッセージを出力している。

## References

- [MDN: HTMLVideoElement](https://developer.mozilla.org/en-US/docs/Web/API/HTMLVideoElement)
- [Can I use](https://caniuse.com/mdn-api_htmlvideoelement)

# WASM と合わせて使うと効果的な Web APIs

WebAssembly（WASM）と共に使用すると効果的な Web APIs はいくつかある。WebAssembly は、パフォーマンスが重視される計算や処理を高速化するために使用されるバイナリ形式のコードを実行するための技術で、JavaScript と連携して動作する。

WASM と組み合わせて使用すると特に効果的な Web APIs とその例

## 1. **Canvas API**

Canvas API は、2D および 3D グラフィックスを描画するためのインターフェースを提供する。WebAssembly を使って高速な描画アルゴリズムを実装し、Canvas API を通じてレンダリングを行うことで、パフォーマンスの向上が期待できる。

**例: WebAssembly による画像処理と Canvas への描画**

```html
<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8" />
    <title>WASMとCanvas APIの例</title>
  </head>
  <body>
    <canvas id="myCanvas" width="400" height="400"></canvas>
    <script>
      (async () => {
        const response = await fetch("image_processing.wasm");
        const bytes = await response.arrayBuffer();
        const { instance } = await WebAssembly.instantiate(bytes);

        const canvas = document.getElementById("myCanvas");
        const ctx = canvas.getContext("2d");
        const imageData = ctx.createImageData(canvas.width, canvas.height);

        // 偽の画像処理の結果
        instance.exports.processImage(imageData.data, imageData.data.length);

        ctx.putImageData(imageData, 0, 0);
      })();
    </script>
  </body>
</html>
```

## 2. **Web Audio API**

Web Audio API は、サウンドの生成、処理、再生を行うためのインターフェースを提供する。音声信号処理やエフェクトの適用など、高度なオーディオ処理を WebAssembly で行い、その結果を Web Audio API で再生することで、より効率的な音声処理が可能になる。

**例: WebAssembly による音声信号処理と Web Audio API の活用**

```js
(async () => {
    const response = await fetch('audio_processing.wasm');
    const bytes = await response.arrayBuffer();
    const { instance } = await WebAssembly.instantiate(bytes);

    const audioContext = new (window.AudioContext || window.webkitAudioContext)();
    const audioBuffer = // 取得したいオーディオデータ;
    const source = audioContext.createBufferSource();
    source.buffer = audioBuffer;
    source.connect(audioContext.destination);

    // WebAssemblyによるオーディオ処理 (例: ノイズリダクション)
    // 偽のバッファ操作例
    const processedBuffer = instance.exports.processAudio(audioBuffer.getChannelData(0));
    source.buffer.copyToChannel(processedBuffer, 0);

    source.start(0);
})();
```

## 3. **WebGL API**

WebGL API は、ブラウザ内で 3D グラフィックスをレンダリングするためのインターフェースを提供する。WebAssembly を使用して複雑なシェーダーや物理演算を実装し、その結果を WebGL で描画することで、高度なグラフィック機能と高いパフォーマンスが実現できる。

**例: WebAssembly による物理演算と WebGL による 3D レンダリング**

```js
(async () => {
  const response = await fetch("physics.wasm");
  const bytes = await response.arrayBuffer();
  const { instance } = await WebAssembly.instantiate(bytes);

  const canvas = document.getElementById("myCanvas");
  const gl = canvas.getContext("webgl");

  // WebGL初期設定...
  // Shaderプログラムの作成、バッファの設定など...

  function render() {
    // WebAssemblyによる物理演算...
    instance.exports.updatePhysics();

    // WebGLによる描画更新...
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

    // 描画コード...

    requestAnimationFrame(render);
  }

  render();
})();
```

## まとめ

WebAssembly と組み合わせて使用すると、計算や処理が重たいタスクを高速化できるため、以下の API が特に効果的

- **Canvas API**：画像処理やグラフィックスの描画を最適化。
- **Web Audio API**：音声信号処理を効率化。
- **WebGL API**：3D グラフィックスのレンダリングと物理演算を高速化。

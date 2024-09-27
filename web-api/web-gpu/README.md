# WebGPU

WebGPUは、Webブラウザ上で高度なグラフィックスや並列計算を実行するための新しいAPI。WebGPUは、既存の`WebGL`と比較して、`より高性能でモダンなグラフィックスおよび計算機能を提供する`。そして、Direct3D 12、Metal、Vulkanといった最新のネイティブグラフィックスAPIに基づいて作られている。

WebGPUはまだ開発途中であり、仕様や各種実装が進行中。

## **主要な特徴と機能：**

1. **モダンな設計：**
   WebGPUは最新のグラフィックスAPIをベースにしているため、より効率的でパワフルなグラフィックス処理と計算が可能。WebGLが依存するOpenGLよりも新しい技術コンセプトを取り入れている。

2. **パフォーマンス：**
   WebGPUは、低オーバーヘッドと直接的なハードウェアアクセスを提供し、WebGLよりも高いパフォーマンスを実現する。これにより、ゲーム、シミュレーション、機械学習などの計算集約型アプリケーションに適している。

3. **計算シェーダー：**
   WebGPUは計算シェーダーをサポートしており、GPUを利用した並列計算が可能。これにより、データ処理や機械学習アルゴリズムなどを非常に効率的に実行できる。

4. **統一されたプラットフォーム：**
   WebGPUは、Windows、macOS、Linux、そしてモバイルプラットフォームなど、複数のオペレーティングシステム上で動作する。

5. **安全性：**
   WebGPUはセキュリティを重視して設計されており、ブラウザから直接ハードウェアへの安全なアクセスを提供する。

## **基本的な構成要素：**

1. **デバイス（GPUDevice）:**
   WebGPUアプリケーションは、GPU環境に接続するためにデバイスを作成する。デバイスはリソースの管理やコマンドの送信を行う。

2. **シェーダー（Shader）:**
   WebGPUシェーダーは、SPIR-VやWGSL（WebGPU Shader Language）などの中間言語で記述される。これにより、GPU上で実行される処理を定義する。

3. **パイプライン（Pipeline）:**
   パイプラインは、シェーダーステージや固定機能ステージなどの設定をまとめたもの。これにより、一連のグラフィックスや計算処理の設定を一括管理できる。

4. **バッファ（Buffer）やテクスチャ（Texture）：**
   データを格納するための主要なリソースタイプ。バッファは通常、頂点データやインデックスデータを含み、テクスチャは画像データを格納する。

5. **コマンドエンコーダー（Command Encoder）：**
   コマンドエンコーダーは、GPUに対する一連のコマンドを記録するためのもので、これを使用して描画や計算を指示する。

## **使用例：**

以下の例では、WebGPUデバイスを初期化し、簡単なレンダーを行う方法を示す。
このコードは、非常にシンプルなWebGPUアプリケーションの雛形。ブラウザでWebGPUがサポートされているか確認し、アダプタとデバイスを取得し、基本的なレンダリングパイプラインとコマンドを作成して、三角形を画面に描画する。

```js
async function initWebGPU() {
    // ブラウザがWebGPUをサポートしているか確認
    if (!navigator.gpu) {
        console.error("WebGPU is not supported in this browser.");
        return;
    }

    // アダプタを取得
    const adapter = await navigator.gpu.requestAdapter();
    if (!adapter) {
        console.error("Failed to get GPU adapter.");
        return;
    }

    // デバイスを取得
    const device = await adapter.requestDevice();

    // スワップチェーンのコンフィグレーション
    const canvas = document.getElementById('webgpuCanvas');
    const context = canvas.getContext('gpupresent');
    const swapChainFormat = "bgra8unorm";

    const swapChain = context.configureSwapChain({
        device: device,
        format: swapChainFormat,
        usage: GPUTextureUsage.OUTPUT_ATTACHMENT
    });

    // パイプラインを作成
    const pipeline = device.createRenderPipeline({
        vertexStage: {
            module: device.createShaderModule({
                code: vertexShaderCode,    // 頂点シェーダーコード
            }),
            entryPoint: "main",
        },
        fragmentStage: {
            module: device.createShaderModule({
                code: fragmentShaderCode,  // フラグメントシェーダーコード
            }),
            entryPoint: "main",
        },
        primitiveTopology: "triangle-list",
        colorStates: [{
            format: swapChainFormat,
        }],
    });

    // コマンドをエンコード
    const commandEncoder = device.createCommandEncoder();
    const textureView = swapChain.getCurrentTexture().createView();
    const renderPassDescriptor = {
        colorAttachments: [{
            attachment: textureView,
            loadValue: [0, 0, 0, 1], // 背景色
        }],
    };

    const passEncoder = commandEncoder.beginRenderPass(renderPassDescriptor);
    passEncoder.setPipeline(pipeline);
    passEncoder.draw(3, 1, 0, 0); // 三角形を描画
    passEncoder.endPass();

    // コマンドをサブミット
    const commandBuffer = commandEncoder.finish();
    device.queue.submit([commandBuffer]);
}

initWebGPU();
```

## 対応デバイス

- [Can I use WebGPU](https://caniuse.com/webgpu)
- [Android版のChrome 121、高速なグラフィクス描画やGPUプログラミングを可能にする「WebGPU」が標準で利用可能に](https://www.publickey1.jp/blog/24/androidchrome_121gpuwebgpu.html)

iOSは`2024/9`現在未対応だが、`Can be enabled in Safari with the WebGPU feature flag.` とある。

## References

- [WebGPU API](https://developer.mozilla.org/ja/docs/Web/API/WebGPU_API)
- [WebGPUがついに利用可能にWebGL以上の高速な描画と、計算処理への可能性](https://ics.media/entry/230426/)
- [Web AI を高速化するための WebAssembly と WebGPU の機能強化、パート 2](https://developer.chrome.com/blog/io24-webassembly-webgpu-2?hl=ja)

# WebGL

WebGL (Web Graphics Library) は、ウェブブラウザー上でインタラクティブな3Dおよび2Dグラフィックスを表示するためのJavaScript API。WebGLは、OpenGL ES 2.0に基づいており、ハードウェアアクセラレーションを利用して高性能なレンダリングを可能にする。

WebGLは、ウェブブラウザ上でリッチなインタラクティブグラフィックスを実現する非常に強力なツールで、従来の2Dグラフィックスに比べ、3Dグラフィックスを含む複雑な描画が可能であり、ゲーム、データビジュアライゼーション、シミュレーションなどさまざまな分野で広く利用されている。

## 1. WebGLの基本

- **JavaScript API**:
  WebGLはJavaScriptの一部として提供され、HTML5 Canvasエレメント内でグラフィックスを描画する。

- **ハードウェアアクセラレーション**:
  GPU（Graphics Processing Unit）を使用して高速で効率的なレンダリングを実現する。

- **クロスプラットフォーム**:
  主要なウェブブラウザ（Chrome, Firefox, Safari, Edgeなど）でサポートされており、OSに依存しない。

## 2. WebGLのアーキテクチャ

WebGLは以下のようなアーキテクチャで構成されている:

- **コンテキスト取得**:
  Canvasエレメントから`WebGLRenderingContext`を取得し、これを通じてWebGLの関数やメソッドを呼び出す。

  ```js
  var canvas = document.getElementById('canvas');
  var gl = canvas.getContext('webgl') || canvas.getContext('experimental-webgl');
  ```

- **シェーダー**:
  GPU上で動作する小さなプログラム。WebGLでは頂点シェーダーとフラグメントシェーダーの2種類がある。これらはGLSL（OpenGL Shading Language）で記述する。

  ```glsl
  // 頂点シェーダー
  attribute vec4 a_position;
  void main() {
      gl_Position = a_position;
  }

  // フラグメントシェーダー
  void main() {
      gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0); // 赤色
  }
  ```

- **プログラムオブジェクト**:
  シェーダーをコンパイルしリンクしてプログラムオブジェクトを作成することで、GPUでシェーダーを実行させる。
  
  ```js
  // シェーダーの作成とコンパイル
  var vertexShaderSource = /* シェーダーソースコード */;
  var vertexShader = gl.createShader(gl.VERTEX_SHADER);
  gl.shaderSource(vertexShader, vertexShaderSource);
  gl.compileShader(vertexShader);

  var fragmentShaderSource = /* フラグメントシェーダーのソースコード */;
  var fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
  gl.shaderSource(fragmentShader, fragmentShaderSource);
  gl.compileShader(fragmentShader);

  // プログラムオブジェクトの作成とリンク
  var program = gl.createProgram();
  gl.attachShader(program, vertexShader);
  gl.attachShader(program, fragmentShader);
  gl.linkProgram(program);
  gl.useProgram(program);
  ```

## 3. 基本的なレンダリングプロセス

- **バッファの設定とデータの転送**:
  頂点データやインデックスデータをGPUに転送するためのバッファを設定する。
  
  ```js
  var positions = new Float32Array([0, 0, 0, 1, 1, 0, 1, 1]);
  var positionBuffer = gl.createBuffer();
  gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
  gl.bufferData(gl.ARRAY_BUFFER, positions, gl.STATIC_DRAW);
  ```

- **頂点属性の設定**:
  シェーダー内で使用する頂点属性を設定する。
  
  ```js
  var positionLocation = gl.getAttribLocation(program, "a_position");
  gl.enableVertexAttribArray(positionLocation);
  gl.vertexAttribPointer(positionLocation, 2, gl.FLOAT, false, 0, 0);
  ```

- **描画**:
  WebGLの`drawArrays`や`drawElements`関数を使用してレンダリングを行う。

  ```js
  gl.drawArrays(gl.TRIANGLES, 0, 3);
  ```

## 4. 高度な機能

- **テクスチャ**:
  画像や他のデータをテクスチャとして読み込み、シェーダー内で使用することができる。

- **フレームバッファ**:
  画面に直接描画する代わりに、オフスクリーンのフレームバッファに描画し、後でそのデータを利用することができる。

- **深度テスト、ブレンド、ステンシルテスト**:
  高品質なレンダリングを実現するためのさまざまなテストやブレンドモードの設定が可能。

## 5. ライブラリとツール

WebGLをより簡単に扱うためのライブラリやツールも数多く存在する。たとえば:

- **Three.js**: 使いやすい高レベルライブラリで、3Dグラフィックスの作成を簡単にする。
- **Babylon.js**: ゲームエンジンとしても使える強力な3Dライブラリ。

## 対応デバイス

[Can I use WebGL](https://caniuse.com/webgl)を見る限りモバイル含め全てのデバイスで利用可能

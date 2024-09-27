# 3D データ

3D データは、物体やシーンの 3 次元形状や質感を表現するために使われるデジタル情報で、多くの形式や種類がある。

## 主要な 3D データの種類と形式

1. **メッシュデータ**

   - **ポリゴンメッシュ**：頂点、エッジ、フェイスで構成されるデータ。頂点が位置情報を持ち、エッジで頂点が繋がり、フェイスで形状を形成する。代表的な形式には OBJ、STL、PLY などがある。
   - **サブディビジョンサーフェス**：ポリゴンメッシュをスムースにする技術で、より詳細なモデリングに使われる。

2. **点群データ**

   - **ポイントクラウド**：3D スキャナなどから取得される、座標点の集まり。各点が三次元空間内の位置を示す。代表的な形式には PTS、XYZ、LAS などがある。

3. **ボリュームデータ**

   - **ボクセルデータ**：三次元空間を均一なグリッド（ボクセル）で表現。医療用途やシミュレーションに使われることが多い。ファイル形式例としては DICOM などがある。

4. **NURBS（Non-Uniform Rational B-Splines）**

   - **NURBS サーフェス**：数式で定義される滑らかな表面。CAD や精密モデリングに利用されることが多い。

5. **CAD データ**

   - **設計図データ**：高精度な設計を行うための 3D データ。固有の形式としては STEP、IGES、Parasolid などがある。

6. **テクスチャ/マテリアルデータ**

   - **テクスチャマッピング**：メッシュの表面に貼り付ける 2D 画像データ。
   - **マテリアルプロパティ**：表面の反射・屈折・散乱・光沢感などを定義する情報。通常は MTL、MF などのファイルで提供される。

7. **アニメーションデータ**

   - **スケルトン/リグデータ**：3D モデルの動きを制御するための骨格情報。
   - **キーフレームアニメーション**：時間とともに変化するモデルの状態を記録するためのデータ。

8. **環境データ**
   - **HDRI（High Dynamic Range Imaging）**：高ダイナミックレンジの環境マップで、リアリスティックな照明情報を提供する。

これらの 3D データは、多岐にわたる産業と応用分野で利用されており、それぞれが特定のニーズや用途に応じた利点と弱点を持っている

## Rust で取り扱えるデータ形式

1. **OBJ (Wavefront OBJ)**

   - 特徴: シンプルなテキスト形式。本当に基本的な 3D データの表現に向いています。
   - 使い方: モデルのインポート/エクスポートに向いています。

2. **GLTF/GLB**

   - 特徴: 3D モデルの高効率、バイナリ形式(GLB)とテキスト形式(GLTF)の両方があり、アニメーション、テクスチャ、マテリアルなど広範囲な情報をサポート。
   - 使い方: 特にゲームやリアルタイムレンダリングでのモデル表現に良い選択。

3. **STL**
   - 特徴: 3D プリンティング向けの形式。比較的シンプル。
   - 使い方: 3D プリンティング用途に最適。

## Rust のライブラリ

1. **`wavefront_obj`** ライブラリ

   - 使い方: Wavefront OBJ 形式のパーシングに利用。

2. **`gltf`** ライブラリ

   - 使い方: glTF 形式のファイルを読み書きするためのライブラリ。

3. **`nalgebra`** ライブラリ

   - 使い方: 線形代数の演算をサポート。ベクトル、行列、クォータニオンなどを取り扱う。

4. **`ncollide`**（衝突検出と物理計算）

   - 使い方: 物理シミュレーションや衝突検出に利用。

5. **`winit`** + **`wgpu`** ライブラリ

   - 使い方: レンダリングのために使う。`winit`はウィンドウ管理とイベントシステム、`wgpu`はグラフィック API の抽象化ライブラリ。

6. **`kiss3d`** ライブラリ
   - 使い方: 3dをシンプルなコードで実装するためのライブラリ

## Rust サンプルコード

1. 必要な依存ライブラリを`Cargo.toml`に追加

   ```toml
   [dependencies]
   nalgebra = "0.33"
   winit = "0.30"
   wgpu = "22.1"
   wavefront_obj = "10.0"
   ```

2. 基本的な 3D レンダリングのセットアップを行う。

   ```rs
   // src/main.rs
   use winit::event_loop::EventLoop;
   use winit::window::WindowBuilder;

   fn main() {
       let event_loop = EventLoop::new();
       let window = WindowBuilder::new().build(&event_loop).unwrap();

       // Initialize wgpu and other rendering set ups
       // Load and parse 3D models using wavefront_obj or gltf crates

       event_loop.run(move |event, _, control_flow| {
           // Handle events and render loop
       });
   }
   ```

## JavaScript で取り扱えるデータ形式

1. **OBJ (Wavefront OBJ)**

   - 特徴: テキストフォーマットであり、比較的シンプルでわかりやすい形式。
   - 使い方: モデルのインポート/エクスポートに適している。

2. **GLTF/GLB**

   - 特徴: 現代的な 3D アセットフォーマットで、バイナリ(GLB)およびテキスト(GLTF)の両方をサポート。アニメーション、テクスチャ、マテリアルなどの複雑なデータも保持できる。
   - 使い方: ゲームやリアルタイムレンダリングで広く使用される。

3. **STL**
   - 特徴: 主に 3D プリンティング用に使われるシンプルな形式。
   - 使い方: 3D プリンティングや基本的な形状検討に適している。

## JavaScript のライブラリ

1. **Three.js**

   - 特徴: WebGL の抽象化ライブラリで、3D グラフィックスのレンダリングを容易にします。豊富な機能とコミュニティサポートがある。
   - リンク: [Three.js](https://threejs.org/)

2. **Babylon.js**

   - 特徴: 強力な 3D エンジンで、物理シミュレーションや VR サポートもある。
   - リンク: [Babylon.js](https://www.babylonjs.com/)

3. **THREE.GLTFLoader**

   - 特徴: Three.js と共に使用される GLTF ファイルの読み込み用ローダー。
   - リンク: [GLTFLoader](https://threejs.org/docs/#examples/en/loaders/GLTFLoader)

4. **THREE.OBJLoader**
   - 特徴: Three.js と共に使用される OBJ ファイルの読み込み用ローダー。
   - リンク: [OBJLoader](https://threejs.org/docs/#examples/en/loaders/OBJLoader)

## Javascript サンプルコード

1. 必要なライブラリをインストールするか、Three.js の CDN を利用する。

   ```html
   <!DOCTYPE html>
   <html lang="en">
     <head>
       <meta charset="UTF-8" />
       <meta name="viewport" content="width=device-width, initial-scale=1.0" />
       <title>Three.js GLTF Example</title>
       <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/build/three.min.js"></script>
       <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/loaders/GLTFLoader.js"></script>
     </head>
     <body>
       <script>
         // シーンの作成
         const scene = new THREE.Scene();
         const camera = new THREE.PerspectiveCamera(
           75,
           window.innerWidth / window.innerHeight,
           0.1,
           1000
         );
         const renderer = new THREE.WebGLRenderer();
         renderer.setSize(window.innerWidth, window.innerHeight);
         document.body.appendChild(renderer.domElement);

         // 光源の設定
         const light = new THREE.DirectionalLight(0xffffff, 1);
         light.position.set(1, 1, 1).normalize();
         scene.add(light);

         // GLTFLoaderを使用してモデルをロード
         const loader = new THREE.GLTFLoader();
         loader.load(
           "path/to/your/model.gltf", // GLTFファイルへのパス
           function (gltf) {
             scene.add(gltf.scene);
           },
           undefined,
           function (error) {
             console.error(error);
           }
         );

         camera.position.z = 5;

         // レンダリングループ
         function animate() {
           requestAnimationFrame(animate);
           renderer.render(scene, camera);
         }

         animate();
       </script>
     </body>
   </html>
   ```

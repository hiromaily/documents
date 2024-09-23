# WASM with WebGPU

## 特徴

- WebGPU APIは非同期であるため、非同期処理が必要
- WebGPUを初期化し、ディスパッチコマンドを発行し、結果を取得する一連の流れが必要

## 必要なパッケージ

- [wgpu](https://crates.io/crates/wgpu)
  - Rusty WebGPU API wrapper
- [futures](https://crates.io/crates/futures)
  - adding the foundations for asynchronous programming
- [winit](https://crates.io/crates/winit)
  - Cross-platform window creation and management

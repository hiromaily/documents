# SynthID

SynthID は Google が開発した AI ツールで、SynthID は現在、Google の AI 開発プラットフォーム「Vertex AI」内の画像生成モデル「Imagen」に搭載されている。この技術は、AI が生成したコンテンツと人間が作成したコンテンツを区別するのに役立ち、フェイク情報の拡散防止に貢献することが期待されている。

また、Google は SynthID のソースコードを GitHub で公開しており、開発者がこの技術を自由に利用し、改良できるようになっている

## SynthID の主な機能

1. AI 生成コンテンツの識別：画像、音声、テキストなどの AI 生成コンテンツに電子透かしを埋め込む
2. 不可視の電子透かし：人間の目には見えない形で、画像のピクセルに直接電子透かしを埋め込む
3. 耐編集性：トリミングやリサイズなどの編集を行っても、電子透かしは残り続ける
4. 検出機能：画像を分析し、AI で生成されたかどうかを評価できる

## References

- [DeepMind: SynthID](https://deepmind.google/technologies/synthid/)

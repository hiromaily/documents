# Web Vitals

Web Vitalsは、Googleが提供する一連の指標で、`ウェブページのユーザーエクスペリエンス（UX）を評価するために使用される`。これらの指標は特にページの読み込み速度、インタラクティブ性、および視覚的な安定性に焦点を当てている。Web Vitalsの主な目標は、ウェブサイトがユーザーにとって快適で使いやすいことを確認し、それを通じて検索ランキングを向上させること。

## Core Web Vitalsとして知られる最も重要な3つの指標

1. **Largest Contentful Paint (LCP)**:
   - **目的**: ページのメインコンテンツの読み込み速度を測定。
   - **理想的な値**: 2.5秒以内。

2. **First Input Delay (FID)**:
   - **目的**: ページが最初にユーザーからの入力（クリック、タップ、キーボード入力など）に反応するまでの時間を測定。
   - **理想的な値**: 100ミリ秒以内。

3. **Cumulative Layout Shift (CLS)**:
   - **目的**: ページの視覚的な安定性を測定。ページが予期せずレイアウトを変えないかどうかを見る。
   - **理想的な値**: 0.1未満。

これらの指標は、ウェブページの全体的な使いやすさやパフォーマンスに大きな影響を及ぼし、Googleの検索エンジンランキングにも反映されることがある。そのため、Web Vitalsを正確に理解し、最適化することは、ウェブマスターやデベロッパー、SEO専門家にとって非常に重要。

## その他の重要な指標

- **First Contentful Paint (FCP)**: 最初のコンテンツが表示されるまでの時間。
- **Time to Interactive (TTI)**: ページが完全にインタラクティブになるまでの時間。
- **Total Blocking Time (TBT)**: ページの応答性に影響を与える長時間のブロッキング時間を測定。

Web VitalsはGoogle Search ConsoleやGoogle Analyticsといったツールを通じてモニタリングすることができる。また、LighthouseやPageSpeed Insightsなどのツールで詳細なレポートを作成することが可能。

## References

- [Web Vitals](https://web.dev/vitals/)  
- [Largest Contentful Paint (LCP)](https://web.dev/lcp/)
  - [Optimize Largest Contentful Paint](https://web.dev/optimize-lcp/)
- [First Input Delay (FID)](https://web.dev/fid/)
  - [Optimize First Input Delay](https://web.dev/optimize-fid/)
- [Cumulative Layout Shift (CLS)](https://web.dev/cls/)
  - [Optimize Cumulative Layout Shift](https://web.dev/optimize-cls/)

# Golden Test

Golden Test は、主に FlutterによるモバイルのUI のリグレッションテストに用いられる手法で、アプリケーションのウィジェットやスクリーンショットの外観を検証するために使用される。

## Golden Test の概要

- **目的**: UI の視覚的な一貫性と正確性を確認するために使用される
- **方法**: アプリケーションのビジュアルアスペクトが望ましい状態にあるときに生成される画像ファイル（Golden ファイル）を用いる。新しいテスト結果とこれらの保存済みの画像とを比較することで、ピクセル単位での変更を検出する

## Golden Test の特徴

- **精度**: ピクセル単位での差分の検出が可能なため、目視で確認するよりも正確かつ効率的に UI のテストを行うことができる。
- **運用**: 基準となる Golden Image を作成・更新し、意図しない変更が含まれていないかをチェックする。
- **利点**: UI の品質担保、ビジュアルリグレッションの検出、効率的な UI の確認が可能。

## 実装例

以下は、Golden Test を実装するためのコードの例。

```dart
testGoldens(
  'Weather Screen Test',
  (tester) async {
    final builder = DeviceBuilder()
      // デバイスの種類を指定
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
      ])
      // テストするシナリオを追加
      ..addScenario(
        widget: testableWidget(
          child: const WeatherScreen(),
        ),
      );

    // addScenarioで指定したWidgetをレンダリング
    await tester.pumpDeviceBuilder(builder);

    // レンダリングされたWidgetのスクリーンショットを作成し、比較
    await screenMatchesGolden(tester, 'weather_screen_test');
  },
);
```

この例では、`DeviceBuilder`を使用して異なるデバイスサイズで Widget をテストし、生成されたスクリーンショットを基準の Golden Image と比較している。

## References

- [Golden Test を導入して UI 開発の不安を解消する](https://zenn.dev/taisei_dev/articles/f88b46aad05dba)

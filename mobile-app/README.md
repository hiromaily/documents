# Mobile App
ここでは、クロスプラットフォームフレームワークに焦点を当てる

- [Flutter](https://flutter.dev/)
- [React Native](https://reactnative.dev/)
- Kotlin/Native
- Swift for Android

## [Flutter](https://flutter.dev/) 
- フラターという発音だが、日本人はフラッター？とかいうのが辛い
- Language: Dart
- Platform: Android, iOS
- IDE: Android Studio, IntelliJ, VSCode
- Nativeに近いパフォーマンスを発揮可能で、React Nativeよりもパフォーマンスは高い
- APIsとUIについても、組み込みのライブラリがあるため、優れている

### References
- [Flutterで始めるアプリ開発](https://www.flutter-study.dev/)

### [Install](https://docs.flutter.dev/get-started/install)
- zipファイルをdownloadし、展開後、PATHを通す
- install後は、`flutter doctor`コマンドで、実行環境の状態を調べ、足りないtoolをinstallする
- iOS setup
- Set up the iOS simulator

### アプリケーションの作成と起動
```sh
flutter create flutter_sample_app
cd flutter_sample_app
flutter run
```
- `flutter run`実行前に、`iOS Simulator`を使う場合は事前に立ち上げておかねばならない


## [React Native](https://reactnative.dev/)
- Language: JavaScript
- Platform: Android, iOS, Web Apps

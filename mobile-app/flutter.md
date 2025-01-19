# Flutter

Flutter は Google が開発したオープンソースの UI フレームワークであり、1 つのコードベースから iOS と Android を含む複数のプラットフォーム向けにアプリケーションを構築することができる。
Flutter は現代のクロスプラットフォームアプリケーション開発に極めて適しており、多くの開発者が注目している。

## 主要なポイント

### 1. **技術的な概要**

- **言語**: Dart というプログラミング言語を使用する。これは Google が開発した言語で、シンプルで学びやすく、高パフォーマンスを提供する。
- **アーキテクチャ**: Flutter は自前のレンダリングエンジンを使用して、iOS と Android で一貫性のある UI を提供する。Flutter のアプリケーションはネイティブコードとしてコンパイルされるため、パフォーマンスが高い。

### 2. **主要な特徴**

- **ホットリロード**:
  - コードの変更をリアルタイムでアプリ上に反映できるため、開発サイクルが非常に効率的になる。
- **ウィジェットベースのアーキテクチャ**:
  - Flutter の UI はウィジェットという小さな部品で構成されており、これらの部品を組み合わせることで複雑なユーザーインターフェースを作成できる。
- **豊富な標準ウィジェット**:
  - Material Design（Google のデザイン言語）と Cupertino（iOS のデザイン言語）の両方に完全対応したウィジェットが提供されている。
- **クロスプラットフォーム対応**:
  - iOS と Android に加え、Web、Windows、macOS、Linux など多様なプラットフォームに対応したアプリを構築できる。

### 3. **開発環境**

- **Flutter SDK**:
  - Flutter のツールチェーンとライブラリのセットが含まれます。これには Dart SDK も含まれている。
- **IDE サポート**:
  - Visual Studio Code や IntelliJ IDEA、Android Studio などの人気のある IDE で開発が可能。これらの IDE には Flutter のプラグインが用意されており、開発をサポートする。
- **CLI ツール**:
  - `flutter`コマンドラインツールを使用して、プロジェクトの作成、ビルド、テスト、デプロイなどの操作が行える。

### 4. **エコシステムとコミュニティ**

- **パッケージ管理**:
  - pub.dev という公式パッケージリポジトリで、多くのサードパーティ製のライブラリやパッケージを利用することができる。
- **コミュニティ**:
  - 広大なコミュニティが存在し、フォーラムやブログ、YouTube チャンネル、GitHub リポジトリなど、豊富なリソースがある。

### 5. **パフォーマンス**

- **ネイティブレベルのパフォーマンス**:
  - Flutter は Dart コードをネイティブコードにコンパイルするため、パフォーマンスが非常に高い。特に UI のレンダリング速度が速く、スムーズなアニメーションが実現できる。
- **オフスクリーンレンダリング**:
  - 画面外の部分を先に描画しておくことで、スクロールやトランジションなどの操作をスムーズに行える。

### 6. **実例と採用事例**

- Flutter は Google 自身の製品（例：Google Ads）だけでなく、Alibaba、eBay などの大手企業でも採用されている。

### 7. **将来性**

- Google は Flutter の発展に積極的であり、バージョンアップや新機能の追加が頻繁に行われている。また、Flutter は Fuchsia という Google の次世代 OS の主要な開発ツールとしても位置づけられている。

## [Flutter](https://flutter.dev/)の特徴

- フラターという発音だが、日本人はフラッター？とかいうのが辛い
- Language: Dart
- Platform: Android, iOS
- IDE: Android Studio, IntelliJ, VSCode
- Native に近いパフォーマンスを発揮可能で、React Native よりもパフォーマンスは高い
- APIs と UI についても、組み込みのライブラリがあるため、優れている

## [Install](https://docs.flutter.dev/get-started/install)方法

- zip ファイルを download し、展開後、PATH を通す
- install 後は、`flutter doctor`コマンドで、実行環境の状態を調べ、足りない tool を install する
- iOS setup
- Set up the iOS simulator

## アプリケーションの作成と起動

```sh
flutter create flutter_sample_app
cd flutter_sample_app
# `flutter run`実行前に、`iOS Simulator`を使う場合は事前に立ち上げておかねばならない
flutter run
```

## GUIでFlutterアプリが作成できるサービス

[flutterstudio.app](https://flutterstudio.app/)

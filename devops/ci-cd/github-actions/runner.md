# Runner

GitHub Actionsで利用可能なrunnerには主に2種類ある

1. GitHub ホステッドランナー:
   - GitHubが提供・管理する仮想マシン環境。
   - 以下のオペレーティングシステムで利用可能:
     - Ubuntu Linux
     - Windows
     - macOS
   - 標準的なツール、パッケージ、設定が事前にインストールされている。
   - メンテナンスとアップグレードは自動的に行われる。
   - Runnerのサイズ
     - 標準的なランナー: 一般的な用途に適したスペックの仮想マシン。
     - より大きなランナー: GitHub TeamまたはGitHub Enterprise Cloudプランで利用可能で、より多くのコアやGPUプロセッサを搭載したマシン。

2. セルフホステッドランナー:
   - ユーザーが自身で用意・管理するマシン。
   - 特殊な要件がある場合や大規模な利用を想定している場合に適している。

## 利用できるRunner

申し訳ありません。ご質問の意図を正しく理解できていませんでした。GitHub Actionsで利用可能な具体的なランナーについて説明します。

GitHub Actionsで利用可能な主なランナーは以下の通りです:

1. Ubuntu Linux:
   - `ubuntu-latest` (現在は `ubuntu-22.04` を指す)
   - `ubuntu-22.04`
   - `ubuntu-20.04`

2. Windows:
   - `windows-latest` (現在は `windows-2022` を指す)
   - `windows-2022`
   - `windows-2019`

3. macOS:
   - `macos-latest` (現在は `macos-12` を指す)
   - `macos-12` (Monterey)
   - `macos-11` (Big Sur)

4. より大きなランナー (GitHub TeamまたはEnterprise Cloudプラン向け):
   - `ubuntu-latest-4-cores`
   - `ubuntu-latest-8-cores`
   - `ubuntu-latest-16-cores`
   - `windows-latest-4-cores`
   - `windows-latest-8-cores`
   - `windows-latest-16-cores`

5. セルフホステッドランナー:
   - `self-hosted`
   - カスタムラベルを付けたセルフホステッドランナー (例: `[self-hosted, linux, x64, gpu]`)

これらのランナーは、ワークフローファイル内で `runs-on` キーワードを使用して指定する。

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
```

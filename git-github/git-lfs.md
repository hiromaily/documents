# Git LFS（Large File Storage）

Git LFS（Large File Storage）は、Git リポジトリで大きなファイル（例：バイナリファイルやメディアファイル）を効率的に管理するための拡張機能。通常、Git はソースコードなどのテキストファイルを扱うのに優れているが、大きなバイナリファイルをそのまま Git リポジトリに含めると、リポジトリのサイズが急激に増大し、クローンやフェッチの速度が低下する可能性がある。

## Git LFS の仕組み

1. **大きなファイルのポインタ管理**：Git LFS では、大きなファイルそのものではなく、そのポインタ（メタデータ）だけがリポジトリにコミットされる。このポインタには、LFS で管理される大きなファイルの実際の位置などの情報が含まれる。

2. **実ファイルの外部ストレージ**：大きなファイル自体は、リモート LFS ストレージに保存される。LFS ストレージは、通常の Git リモートとは異なる専用のストレージ。

3. **スムーズなファイルチェックアウト**：ファイルが必要な時に、ポインタを元にして LFS ストレージから実際のファイルをダウンロードし、ワーキングディレクトリに配置する。このため、Git の操作は通常の速度を維持しつつ、必要な大きなファイルも取り扱うことができる。

## Git LFS の利用

Git LFS は、バイナリファイルを多く扱うプロジェクトや、大きなファイルの頻繁な更新が発生するプロジェクトにおいて非常に有用

1. **インストール**：マシンに Git LFS をインストールします。

   ```sh
   git lfs install
   ```

2. **追跡設定**：LFS で管理するファイルタイプを指定。

   ```sh
   git lfs track "*.psd"
   ```

3. **コミット&プッシュ**：通常の Git 操作と同様に、ファイルの追加・コミット・プッシュを行う。

   ```sh
   git add .gitattributes
   git add largefile.psd
   git commit -m "Add large PSD file"
   git push origin main
   ```

## `brew`でinstall後に表示されるlog

```sh
==> git-lfs
Update your git config to finish installation:

  # Update global git config
  $ git lfs install

  # Update system git config
  $ git lfs install --system
```

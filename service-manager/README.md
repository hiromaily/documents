# Service manager

Linux のサービスマネージャーは、システムの起動、停止、再起動、およびステータスの確認など、サービスやデーモンを管理するためのツール。主なサービスマネージャーとして、`systemd`、`SysVinit`、`upstart`があるが、現在最も広く使われているのは `systemd` 。

## systemd (systemctl)

`systemd` は、ほとんどの現代的な Linux ディストリビューションで使用されているサービスマネージャー。`journalctl`を利用したログ管理、デバイス管理、タイマー、依存関係の管理など、さまざまな機能を提供する。

### systemd の基本コマンド

- **サービスの起動**:

  ```sh
  sudo systemctl start <サービス名>
  ```

- **サービスの停止**:

  ```sh
  sudo systemctl stop <サービス名>
  ```

- **サービスの再起動**:

  ```sh
  sudo systemctl restart <サービス名>
  ```

- **サービスのステータス確認**:

  ```sh
  sudo systemctl status <サービス名>
  ```

- **サービスの自動起動を有効化**:

  ```sh
  sudo systemctl enable <サービス名>
  ```

- **サービスの自動起動を無効化**:

  ```sh
  sudo systemctl disable <サービス名>
  ```

### systemd の例

Apache HTTP サーバー (`httpd` または `apache2`) のステータスを確認する場合：

```sh
sudo systemctl status httpd
```

## SysVinit

`SysVinit` は古くから使われているサービスマネージャーであり、設定ファイルやスクリプトを使用してサービスを管理する。現在では`systemd`に置き換えられていることが多いですが、古いシステムではまだ使用されている。

### SysVinit の基本コマンド

- **サービスの起動**:

  ```sh
  sudo service <サービス名> start
  ```

- **サービスの停止**:

  ```sh
  sudo service <サービス名> stop
  ```

- **サービスの再起動**:

  ```sh
  sudo service <サービス名> restart
  ```

- **サービスのステータス確認**:

  ```sh
  sudo service <サービス名> status
  ```

### SysVinit の例

MySQL サービスを再起動する場合：

```sh
sudo service mysql restart
```

## init.d

`init.d` は主に古い`SysVinit`システムに関連しており、`/etc/init.d/` ディレクトリに配置されたスクリプトを用いてサービスを管理する。これらのスクリプトは、基本的にシェルスクリプトであり、`start`、`stop`、`restart`、`status` などの引数を受け取る。`init.d` は従来の`SysVinit`システムの一部。

### `init.d`の使用例

各サービスには対応するスクリプトが`/etc/init.d/`に存在し、これを手動で実行することでサービスの制御を行う。

- **サービスの起動**:

  ```sh
  sudo /etc/init.d/servicename start
  ```

- **サービスの停止**:

  ```sh
  sudo /etc/init.d/servicename stop
  ```

- **サービスの再起動**:

  ```sh
  sudo /etc.init.d/servicename restart
  ```

- **サービスのステータス確認**:

  ```sh
  sudo /etc/init.d/servicename status
  ```

## Upstart

`Upstart` は、イベントベースのサービスマネージャーであり、サービスやデーモンを管理するための新しいアプローチを提供している。特に Ubuntu 9.10 から 14.10 にかけてのバージョンで使用されていたが、現在では`systemd`に取って代わられている。

### Upstart の基本コマンド

- **サービスの起動**:

  ```sh
  sudo start <サービス名>
  ```

- **サービスの停止**:

  ```sh
  sudo stop <サービス名>
  ```

- **サービスの再起動**:

  ```sh
  sudo restart <サービス名>
  ```

- **サービスのステータス確認**:

  ```sh
  sudo status <サービス名>
  ```

### Upstart の例

Network Manager サービスのステータスを確認する場合：

```sh
sudo status network-manager
```

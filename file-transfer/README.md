# ファイル転送

## プロトコル

1. **SCP (Secure Copy Protocol)**:
   - SSHを利用して安全にファイルを転送します。コマンドラインを使うことが多い。
   - よく利用される

2. **SFTP (SSH File Transfer Protocol)**:
   - セキュアなFTPの一種で、SSH（Secure Shell）プロトコルを利用してデータを暗号化する。
   - よく利用される

3. **FTPS (FTP Secure/FTP-SSL)**:
   - FTPにTLS/SSL暗号化を追加したもので、セキュアなデータ転送が可能。

4. **HTTP/HTTPS (Hypertext Transfer Protocol/HTTP Secure)**:
   - Webブラウザを通じてファイルを転送する際に使われる。HTTPSではデータが暗号化される。

5. **TFTP (Trivial File Transfer Protocol)**:
   - 非常にシンプルでセキュリティ機能がほとんどないため、小規模なファイル転送に適している。主にネットワークデバイスの初期構成などで使用される。

6. **WebDAV (Web Distributed Authoring and Versioning)**:
   - HTTPを基にしたプロトコルで、Webサーバー上のファイルを管理できる。さまざまなアクセス制御やバージョン管理をサポートしている。

7. **rsync**:
   - ローカルおよびリモート間で効率的にデータを同期するためのツールで、SSHと組み合わせて使用することでセキュアな転送が可能。

8. **NFS (Network File System)**:
   - ネットワーク上でファイルシステムを共有するためのプロトコル。ファイルの読み書きが透過的に行える。

# Socket ソケット

ソケット（Socket）とは、ネットワークプログラミングで非常に重要な概念であり、異なるデバイス間、または同一デバイス内のプロセス間で通信を行うためのインターフェースの一種

## ソケットの基本概念

1. **通信エンドポイント**: ソケットは通信のエンドポイントとして機能する。通信するために、少なくとも二つのエンドポイント（例えば、クライアント側とサーバー側）が必要。

2. **IP アドレスとポート番号**: 各ソケットは IP アドレスとポート番号によって一意に特定される。IP アドレスはホストデバイスの位置を特定し、ポート番号はそのデバイス上の特定の通信サービスを示す。

3. **プロトコル**: 通常、ソケットは`TCP`または`UDP`というトランスポート層プロトコルを利用する。TCP ソケットは信頼性のある通信を提供し、データが失われたり順序が入れ替わったりしないよう保証する。一方、UDP ソケットは信頼性を保証しないが、より高速な通信が可能。

## ソケットの操作

以下のような基本的な操作がソケットプログラミングで行われる

1. **ソケットの作成**: `socket()`関数を使って、ソケットを作成します。

   ```c
   int sockfd = socket(AF_INET, SOCK_STREAM, 0);  // TCPソケットの例
   ```

2. **ソケットのバインド**: サーバー側で、`bind()`関数を使ってソケットに IP アドレスとポート番号を結び付ける。

   ```c
   struct sockaddr_in addr;
   addr.sin_family = AF_INET;
   addr.sin_port = htons(8080);
   addr.sin_addr.s_addr = INADDR_ANY;
   bind(sockfd, (struct sockaddr*)&addr, sizeof(addr));
   ```

3. **リスニングと受け入れ**: サーバー側で、`listen()`関数を使って接続を待ち、`accept()`関数で新しい接続を受け入れる。

   ```c
   listen(sockfd, 5);
   int new_socket = accept(sockfd, (struct sockaddr*)&addr, &addrlen);
   ```

4. **接続の確立**: クライアント側で、`connect()`関数を使ってサーバー側ソケットに接続する。

   ```c
   connect(sockfd, (struct sockaddr*)&addr, sizeof(addr));
   ```

5. **データの送受信**: `send()`や`recv()`関数を使ってデータを送受信する。

   ```c
   send(new_socket, "Hello, World", strlen("Hello, World"), 0);
   recv(sockfd, buffer, sizeof(buffer), 0);
   ```

6. **ソケットの閉じる**: 通信に使ったソケットを閉じるために`close()`関数を使う。

   ```c
   close(sockfd);
   ```

## References

- [調べなきゃ寝れない！と調べたら余計に寝れなくなったソケットの話](https://qiita.com/kuni-nakaji/items/d11219e4ad7c74ece748)
- [socat を使うと各種ソケットの操作が捗りまくる件](https://momijiame.tumblr.com/post/48934531325/socat-%E3%82%92%E4%BD%BF%E3%81%86%E3%81%A8%E5%90%84%E7%A8%AE%E3%82%BD%E3%82%B1%E3%83%83%E3%83%88%E3%81%AE%E6%93%8D%E4%BD%9C%E3%81%8C%E6%8D%97%E3%82%8A%E3%81%BE%E3%81%8F%E3%82%8B%E4%BB%B6)

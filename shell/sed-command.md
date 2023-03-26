# sed command
ChatGPTに聞くとうまく教えてくれる。

- ファイル内に以下のような文字列があり、右辺の値を`22.8.2`に変更したい
```txt
QUORUM_VERSION=22.7.5
```
```sh
sed -i 's/QUORUM_VERSION=[0-9]\+\.[0-9]\+\.[0-9]\+/QUORUM_VERSION=22.8.2/g' file.txt
```

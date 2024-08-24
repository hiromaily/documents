# Network command on Linux

- [10 Useful Linux Networking Commands](https://geekflare.com/linux-networking-commands/)
- [20 Linux Commands for System Administrator](https://geekflare.com/linux-commands-for-system-admin/)

## 1. ifconfig

TCP/IP を使用するネットワークのネットワーク・インターフェース・パラメーターを構成または表示する

- `ifconfig` utility is used to configure network interface parameters.
- Mostly we use this command `to check the IP address assigned to the system`.

```sh
$ sudo apt install net-tools
```

```sh
$ ifconfig -a
docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:68:c4:12:4e  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 11548  bytes 1017855 (1.0 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 11548  bytes 1017855 (1.0 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlp2s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.xxx.xxx  netmask 255.255.255.0  broadcast 192.168.10.255
        inet6 240b:10:2a00:7000:25be:6653 1  r753.tokynt01.ap.so-net.ne.jp (120.74.156.138)  3.522 ms  4.761 ms  4.744 ms
```

## 2. ss

ソケットの状態表示をするコマンド

- `ss` is used to dump socket statistics. It allows showing information similar to netstat.
- It can display more TCP and state informations than other tools.

- `-a` : -all, display all sockets
- `-n` : -numeric, don't resolve service names
- `-t` : -tcp, display only TCP sockets
- `-u` : -udp, display only UDP sockets
- `-p` : -processes, show process using socket

```sh
$ ss -antup | grep parity

udp  UNCONN     0       0                                         0.0.0.0:30303                        0.0.0.0:*         users:(("parity",pid=25166,fd=58))
tcp  LISTEN     0       128                                     127.0.0.1:18546                        0.0.0.0:*         users:(("parity",pid=25166,fd=119))
tcp  LISTEN     0       128                                       0.0.0.0:30303                        0.0.0.0:*         users:(("parity",pid=25166,fd=57))
tcp  LISTEN     0       128                                     127.0.0.1:8546                         0.0.0.0:*         users:(("parity",pid=25166,fd=111))
tcp  ESTAB      0       1120                               192.168.10.104:51106                  18.222.233.28:30303     users:(("parity",pid=25166,fd=338))
tcp  ESTAB      0       0                                  192.168.10.104:48640                   54.36.123.48:30305     users:(("parity",pid=25166,fd=384))
tcp  ESTAB      0       0                                  192.168.10.104:33504                 35.187.218.232:30303     users:(("parity",pid=25166,fd=393))
tcp  ESTAB      0       0                                  192.168.10.104:36544                138.201.121.137:30305     users:(("parity",pid=25166,fd=347))
tcp  ESTAB      0       0                                  192.168.10.104:41958                  159.69.123.83:30313     users:(("parity",pid=25166,fd=323))
tcp  ESTAB      0       0                                  192.168.10.104:41070                     3.94.31.11:30303     users:(("parity",pid=25166,fd=336))
tcp  ESTAB      0       0                                  192.168.10.104:49322                   51.255.77.89:30302     users:(("parity",pid=25166,fd=142))
tcp  ESTAB      0       0                                  192.168.10.104:35058                 202.231.206.54:30303     users:(("parity",pid=25166,fd=221))
tcp  ESTAB      0       0                                  192.168.10.104:57678                  144.217.68.43:30303     users:(("parity",pid=25166,fd=289))
tcp  ESTAB      0       0                                  192.168.10.104:60018                   51.255.77.90:30302     users:(("parity",pid=25166,fd=145))
tcp  ESTAB      0       0                                  192.168.10.104:40080                  13.251.47.174:30303     users:(("parity",pid=25166,fd=385))
tcp  ESTAB      0       0                                  192.168.10.104:57694                     3.95.65.94:30303     users:(("parity",pid=25166,fd=313))
tcp  ESTAB      0       0                                  192.168.10.104:49632                  34.229.85.249:30303     users:(("parity",pid=25166,fd=351))
tcp  ESTAB      0       0                                  192.168.10.104:60600                 195.201.87.168:20303     users:(("parity",pid=25166,fd=396))
tcp  ESTAB      0       0                                  192.168.10.104:58936                 96.126.114.115:30303     users:(("parity",pid=25166,fd=134))
tcp  ESTAB      0       0                                  192.168.10.104:33774                  112.169.69.30:30303     users:(("parity",pid=25166,fd=412))
tcp  ESTAB      0       307                                192.168.10.104:34250                 178.128.42.228:30303     users:(("parity",pid=25166,fd=357))
tcp  ESTAB      0       0                                  192.168.10.104:53798                   213.32.25.40:30302     users:(("parity",pid=25166,fd=146))
tcp  ESTAB      0       0                                  192.168.10.104:54120                  52.176.100.77:30303     users:(("parity",pid=25166,fd=369))
tcp  ESTAB      0       0                                  192.168.10.104:49720                  13.230.95.188:30303     users:(("parity",pid=25166,fd=232))
tcp  ESTAB      0       0                                  192.168.10.104:43390                   100.26.0.163:30303     users:(("parity",pid=25166,fd=284))
tcp  ESTAB      0       0                                  192.168.10.104:52104                  95.216.151.26:30303     users:(("parity",pid=25166,fd=397))
tcp  ESTAB      0       0                                  192.168.10.104:37788                  47.244.140.38:30303     users:(("parity",pid=25166,fd=332))
tcp  ESTAB      0       0                                  192.168.10.104:53316                 206.189.138.85:30303     users:(("parity",pid=25166,fd=230))
tcp  ESTAB      0       3452                               192.168.10.104:40016                  13.76.152.128:30303     users:(("parity",pid=25166,fd=292))
tcp  ESTAB      0       0                                  192.168.10.104:47022                  115.22.91.165:30303     users:(("parity",pid=25166,fd=249))
```

## 3. netstat (deprecated)

TCP/IP 通信の状態を調べる
非推奨のため、代わりに`ip`や`ss`コマンドを利用する。

- Netstat command allows you a simple way to review each of your network connections and open sockets.
- netstat with head output is very helpful while performing web server troubleshooting.

```sh
$ netstat -n
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 192.168.10.104:51472    139.59.69.168:30303     TIME_WAIT
tcp        0      0 192.168.10.104:56438    45.76.95.0:30303        TIME_WAIT
tcp        0      1 192.168.10.104:33810    159.65.34.74:30303      SYN_SENT
tcp        0      0 192.168.10.104:34590    47.92.1.152:30303       TIME_WAIT
tcp        0      0 192.168.10.104:57170    192.99.244.228:30140    TIME_WAIT
tcp        0      0 192.168.10.104:38748    27.115.41.206:30303     TIME_WAIT
tcp        0      0 192.168.10.104:41874    13.66.246.94:30303      TIME_WAIT
tcp        0      1 192.168.10.104:52136    139.59.69.168:30303     SYN_SENT
tcp        0      0 192.168.10.104:59878    149.28.201.235:30303    TIME_WAIT
tcp        0      0 192.168.10.104:57784    150.109.13.11:30303     TIME_WAIT
tcp        0      0 192.168.10.104:34390    47.99.136.157:30312     TIME_WAIT
tcp        0      0 192.168.10.104:35882    51.255.86.95:30303      TIME_WAIT
tcp        0      0 192.168.10.104:38136    185.202.172.191:30303   TIME_WAIT
tcp        0    307 192.168.10.104:39732    104.248.139.245:30303   ESTABLISHED
tcp        0      0 192.168.10.104:52828    51.77.140.200:30305     TIME_WAIT
...
...
...
```

- `-t` = tcp
- `-u` = udp
- `-l` = listening
- `-p` = program
- `-n` = numeric

```sh
$ netstat -tulpn | grep 'parity'

(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
tcp        0      0 127.0.0.1:18546         0.0.0.0:*               LISTEN      25166/parity
tcp        0      0 0.0.0.0:30303           0.0.0.0:*               LISTEN      25166/parity
tcp        0      0 127.0.0.1:8546          0.0.0.0:*               LISTEN      25166/parity
udp        0      0 0.0.0.0:30303           0.0.0.0:*                           25166/parity
```

- show open ports

```sh
$ netstat -nap
```

## 4. lsof

プロセスが開いているファイルを表示するコマンドで、サーバーで特定のポート番号を待ち受けているかどうかなどに使われる

- list open files
- Lsof lists on its standard output file information about files opened by processes for the following UNIX dialects.
- An open file may be a regular file, a directory, a block special file, a character special file, an executing text reference, a library, a stream or a network file (Internet socket, NFS file or UNIX domain socket.)
- A specific file or all the files in a file system may be selected by path.

- `-i` :

```sh
$ lsof -i

COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
chrome   3703   hy   78u  IPv4 625262      0t0  TCP hy-UX430UAR:38322->tk-in-f188.1e100.net:5228 (ESTABLISHED)
chrome   3703   hy  151u  IPv4 270569      0t0  UDP 224.0.0.251:mdns
chrome   3703   hy  156u  IPv6 892160      0t0  UDP hy-UX430UAR:34307->nrt12s01-in-x0e.1e100.net:443
chrome   3703   hy  168u  IPv4  45985      0t0  UDP 224.0.0.251:mdns
chrome   3703   hy  208u  IPv4 878451      0t0  TCP hy-UX430UAR:40834->151.101.72.133:443 (ESTABLISHED)
chrome   3703   hy  256u  IPv4 883212      0t0  TCP hy-UX430UAR:40840->151.101.72.133:443 (ESTABLISHED)
chrome   3703   hy  284u  IPv4 878454      0t0  TCP hy-UX430UAR:40842->151.101.72.133:443 (ESTABLISHED)
chrome   3703   hy  289u  IPv4 885137      0t0  TCP hy-UX430UAR:48782->185.199.109.154:443 (ESTABLISHED)
chrome   3703   hy  353u  IPv4 886005      0t0  TCP hy-UX430UAR:45716->lb-192-30-253-125-iad.github.com:https (ESTABLISHED)
chrome   3703   hy  361u  IPv4 871325      0t0  TCP hy-UX430UAR:50928->ec2-52-89-52-224.us-west-2.compute.amazonaws.com:https (ESTABLISHED)
slack   24150   hy   72u  IPv4 708373      0t0  TCP hy-UX430UAR:41802->ec2-18-182-92-196.ap-northeast-1.compute.amazonaws.com:https (ESTABLISHED)
slack   24150   hy   73u  IPv4 708366      0t0  TCP hy-UX430UAR:46962->ec2-52-196-199-255.ap-northeast-1.compute.amazonaws.com:https (ESTABLISHED)
slack   24150   hy   94u  IPv4 892101      0t0  TCP hy-UX430UAR:51482->server-99-84-134-165.nrt57.r.cloudfront.net:https (ESTABLISHED)
slack   24150   hy  100u  IPv4 564042      0t0  TCP hy-UX430UAR:51108->server-13-33-208-245.nrt57.r.cloudfront.net:https (ESTABLISHED)
slack   24150   hy  113u  IPv4 665242      0t0  TCP hy-UX430UAR:49252->ec2-18-182-92-196.ap-northeast-1.compute.amazonaws.com:https (ESTABLISHED)
parity  25166   hy   57u  IPv4 785980      0t0  TCP *:30303 (LISTEN)
parity  25166   hy   58u  IPv4 784198      0t0  UDP *:30303
parity  25166   hy  111u  IPv4 785984      0t0  TCP localhost:8546 (LISTEN)
parity  25166   hy  119u  IPv4 783131      0t0  TCP localhost:18546 (LISTEN)
parity  25166   hy  134u  IPv4 852368      0t0  TCP hy-UX430UAR:58936->li339-115.members.linode.com:30303 (ESTABLISHED)
parity  25166   hy  142u  IPv4 786007      0t0  TCP hy-UX430UAR:49322->cluster07-enode02.gra1.ovh.fr.nodes.jnode.network:30302 (ESTABLISHED)
parity  25166   hy  145u  IPv4 786010      0t0  TCP hy-UX430UAR:60018->cluster07-enode01.gra1.ovh.fr.nodes.jnode.network:30302 (ESTABLISHED)
parity  25166   hy  146u  IPv4 786011      0t0  TCP hy-UX430UAR:53798->cluster07-enode03.gra1.ovh.fr.nodes.jnode.network:30302 (ESTABLISHED)
parity  25166   hy  221u  IPv4 814494      0t0  TCP hy-UX430UAR:35058->202.231.206.54:30303 (ESTABLISHED)
parity  25166   hy  230u  IPv4 811988      0t0  TCP hy-UX430UAR:53316->206.189.138.85:30303 (ESTABLISHED)
parity  25166   hy  232u  IPv4 788260      0t0  TCP hy-UX430UAR:49720->ec2-13-230-95-188.ap-northeast-1.compute.amazonaws.com:30303 (ESTABLISHED)
parity  25166   hy  249u  IPv4 784961      0t0  TCP hy-UX430UAR:47022->115.22.91.165:30303 (ESTABLISHED)
parity  25166   hy  289u  IPv4 805846      0t0  TCP hy-UX430UAR:57678->dev.eth.share.green:30303 (ESTABLISHED)
parity  25166   hy  292u  IPv4 840948      0t0  TCP hy-UX430UAR:40016->13.76.152.128:30303 (ESTABLISHED)
parity  25166   hy  313u  IPv4 807352      0t0  TCP hy-UX430UAR:57694->ec2-3-95-65-94.compute-1.amazonaws.com:30303 (ESTABLISHED)
parity  25166   hy  315u  IPv4 887177      0t0  TCP hy-UX430UAR:59920->2.228.189.35.bc.googleusercontent.com:30303 (ESTABLISHED)
parity  25166   hy  323u  IPv4 837276      0t0  TCP hy-UX430UAR:41958->static.83.123.69.159.clients.your-server.de:30313 (ESTABLISHED)
parity  25166   hy  332u  IPv4 857086      0t0  TCP hy-UX430UAR:37788->47.244.140.38:30303 (ESTABLISHED)
parity  25166   hy  336u  IPv4 806732      0t0  TCP hy-UX430UAR:41070->ec2-3-94-31-11.compute-1.amazonaws.com:30303 (ESTABLISHED)
parity  25166   hy  338u  IPv4 808396      0t0  TCP hy-UX430UAR:51106->ec2-18-222-233-28.us-east-2.compute.amazonaws.com:30303 (ESTABLISHED)
parity  25166   hy  347u  IPv4 811945      0t0  TCP hy-UX430UAR:36544->n1.b.eth.myapp.ws:30305 (ESTABLISHED)
parity  25166   hy  351u  IPv4 806861      0t0  TCP hy-UX430UAR:49632->ec2-34-229-85-249.compute-1.amazonaws.com:30303 (ESTABLISHED)
parity  25166   hy  369u  IPv4 789976      0t0  TCP hy-UX430UAR:54120->52.176.100.77:30303 (ESTABLISHED)
parity  25166   hy  384u  IPv4 808493      0t0  TCP hy-UX430UAR:48640->smtp.funpay.today:30305 (ESTABLISHED)
parity  25166   hy  385u  IPv4 870831      0t0  TCP hy-UX430UAR:40080->ec2-13-251-47-174.ap-southeast-1.compute.amazonaws.com:30303 (ESTABLISHED)
parity  25166   hy  393u  IPv4 843914      0t0  TCP hy-UX430UAR:33504->232.218.187.35.bc.googleusercontent.com:30303 (ESTABLISHED)
parity  25166   hy  396u  IPv4 843682      0t0  TCP hy-UX430UAR:60600->static.168.87.201.195.clients.your-server.de:20303 (ESTABLISHED)
parity  25166   hy  397u  IPv4 849620      0t0  TCP hy-UX430UAR:52104->static.26.151.216.95.clients.your-server.de:30303 (ESTABLISHED)
parity  25166   hy  412u  IPv4 857935      0t0  TCP hy-UX430UAR:33774->112.169.69.30:30303 (ESTABLISHED)
```

## 5. traceroute

特定のあて先までの経路を調べる時に使うコマンド

- traceroute print the route packets take to network host.
- Destination host or IP is mandatory parameter to use this utility

```sh
$ sudo apt install tracetoute
```

```sh
$ traceroute google.com
 1  r753.tokynt01.ap.so-net.ne.jp (120.74.156.138)  3.522 ms  4.761 ms  4.744 ms
 2  maru-03Gi3-11.net.so-net.ne.jp (120.74.156.137)  3.829 ms  4.180 ms  4.198 ms
 3  note-gw18ET8.net.so-net.ne.jp (202.213.193.93)  6.001 ms  5.019 ms  5.970 ms
 4  202.213.193.88 (202.213.193.88)  10.797 ms  10.517 ms  10.548 ms
 5  72.14.243.129 (72.14.243.129)  5.186 ms  6.274 ms  6.262 ms
 6  108.170.242.97 (108.170.242.97)  5.843 ms 108.170.242.129 (108.170.242.129)  6.807 ms  7.216 ms
 7  72.14.234.199 (72.14.234.199)  6.265 ms  5.064 ms  6.245 ms
 8  nrt12s17-in-f14.1e100.net (172.217.26.46)  6.029 ms  6.013 ms  6.004 ms
```

## 6. dig

ネームサーバに対して問い合わせを行い、その応答結果を表示するコマンド

- dig (Domain Information Groper) is a flexible tool for interrogating DNS name servers.
- It performs DNS lookups and displays the answers that are returned from the name servers.

```sh
$ dig google.com

; <<>> DiG 9.11.3-1ubuntu1.3-Ubuntu <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 11395
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;google.com.			IN	A

;; ANSWER SECTION:
google.com.		120	IN	A	172.217.31.142

;; Query time: 4 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Mon Feb 11 20:04:16 JST 2019
;; MSG SIZE  rcvd: 55

```

## 7. nslookup

IP アドレスからドメイン名を確認すること、ドメイン名から IP アドレスを確認することができるコマンド

- nslookup is a program to query Internet domain name servers.

```sh
$ nslookup google.com

Address:	127.0.0.53#53

Non-authoritative answer:
Name:	google.com
Address: 172.217.26.46
Name:	google.com
Address: 2404:6800:400a:80b::200e
```

## 8. nmap

対象として指定したホストに対してポート番号を変えながら IP パケットを送信し、その反応を調べることでどのポートが外部からアクセス可能なのかを調査する行為を`ポートスキャン`といい、そのためのコマンド

- nmap is a one of the powerful commands, which checks the opened port on the server.

```sh
$ nmap $server_name
```

## 9. Enable/Disable Network Interface

Network Interface の ON/OFF の仕方

- To enable eth0

```sh
$ ifup eth0
```

- To disable eth0

```sh
$ ifdown eth0
```

## 10. w

システムに現在誰がログインしており、何を実行しているのかを表示するコマンド

- `w` prints a summary of the current activity on the system, including what each user is doing, and their processes.
- Also list the logged in users and system load average for the past 1, 5, and 15 minutes.

```sh
$ w

 20:31:28 up 2 days, 21:51,  1 user,  load average: 4.08, 4.47, 4.31
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
hy       :0       :0               Fri22   ?xdm?   1:49m  0.01s /usr/lib/gdm3/gdm-x-session --run-script env GNOME_SHELL_SESSION_MODE=ubuntu gnome-session --session=ubuntu

```

## 11. telnet

ネットワーク経由でリモートのマシンへ`Telnetプロトコル`でログインするコマンドだが、現在は`ssh`がよく使われる

- telnet connect destination host:port via a telnet protocol if connection establishes means connectivity between two hosts is working fine.

```sh
$ telnet xxx.xxx.xxx 443
```

## 12. htop

プロセスのメモリ使用率や CPU 使用率など現在のシステム状況を表示するコマンド

- This is htop, an interactive process viewer for Unix systems. It is a text-mode application (for console or X terminals) and requires ncurses.
- [htop](https://hisham.hm/htop/)

```sh
sudo apt install htop
```

## 13. tcpdump

ネットワーク通信の生のデータをキャプチャし、その結果を出力するコマンド

`https://example.com/xxxx`へのリクエストをキャプチャしたい場合

```sh
sudo tcpdump -i en0 -A -s 0 host example.com and port 443
```

ただし、https の場合は暗号化されていて表示できないため、一旦`pcap`ファイル保存する

```sh
sudo tcpdump -i en0 -s 0 -w output.pcap host jp.indeed.com
```

wireshark で開く

```
wireshark output.pcap
```

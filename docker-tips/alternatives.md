# Alternatives

Docker Desktopの代替えとなるもの

- [5 Docker Desktop Alternatives](https://hackernoon.com/5-docker-desktop-alternatives)

## [OrbStack](https://orbstack.dev/)
- [github](https://github.com/orbstack/orbstack): Star 1.8k
- [Docker Desktop for Mac代替のOrbStackがすごい](https://ik.am/entries/746)

macOS上でDockerコンテナとLinuxマシンを高速、軽量、かつシンプルに実行する方法で、超強力なWSLとDocker Desktopの代替品であり、すべてが1つの使いやすいアプリにまとめられている。

## [Podman](https://podman.io/)
- [github](https://github.com/containers/podman): Star 18.2k

Podman（the POD MANager）は、コンテナやイメージ、それらのコンテナにマウントされたボリューム、コンテナのグループから作られるpodを管理するためのツール。PodmanはLinux上でコンテナを実行するが、Podmanで管理された仮想マシンを使ってMacやWindowsシステムでも使用することができる。

## [colima](https://github.com/abiosoft/colima)
- [github](https://github.com/abiosoft/colima): Star 12.1k

LinuxとmacOSでのみ利用可能なColimaは、macOS上でLinux VMを有効にするためにLimaを使用している。Docker、Containerd、Kubernetesのランタイムをサポートしており、いずれの場合もColimaと並行してそのランタイムをインストールする必要がある。

## [Rancher desktop](https://rancherdesktop.io/)
- [github](https://github.com/rancher-sandbox/rancher-desktop/): Star 4.8k

Rancher Desktopは、デスクトップ上でコンテナ管理とKubernetesを提供するアプリで、Mac（IntelとApple Siliconの両方）、Windows、Linuxで利用可能。
Rancher Desktopでは、コンテナイメージをbuild、push、pullする機能と、コンテナを実行する機能が提供されている。これは、Docker CLI（エンジンとしてMoby/dockerdを選択した場合）またはnerdctl（エンジンとしてcontainerdを選択した場合）のいずれかによって提供される。

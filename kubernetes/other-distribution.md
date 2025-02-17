# その他のKubernetes ディストリビューション

## 一般的な開発環境や、CI/CDでの利用

### **Minikube（ミニキューブ）**

Minikube は、主にローカル開発環境での Kubernetes クラスタの構築を目的としたツール。仮想マシン（VirtualBox、VMware、KVM、Hyper-V など）やコンテナランタイム（Docker、Podman など）上にシングルノードの Kubernetes クラスタを立ち上げることができる。

```sh
minikube start
```

### **MicroK8s（マイクロケートルズ）**

Canonical（Ubuntu の開発元）によって提供される MicroK8s は、シングルノードの Kubernetes インスタンスで、開発やテスト環境に適している。スナップパッケージとして提供されるため、インストールと管理が非常にシンプル。また、軽量かつモジュラー型で、必要なアドオン（DNS、ダッシュボード、Istio、Knative、RBAC など）を容易に有効化できる。

```sh
sudo snap install microk8s --classic
sudo microk8s.start
```

### **Kind（Kubernetes IN Docker）**

Kind は、Kubernetes のノードを Docker コンテナとして実行する Kubernetes のためのツール。CI 環境やローカルのシングルマシンでの Kubernetes クラスタの迅速なセットアップに特化している。

```sh
kind create cluster
```

## 軽量、エッジコンピューティング

### **k3s**

k3sは、Rancher Labsによって開発された`軽量なKubernetes（K8s）ディストリビューション`。Kubernetesは本番環境でのコンテナオーケストレーションを目的として設計されており、多くの機能を持っているが、そのために多くの計算リソースを消費する。これに対し、k3sはその軽量さと低リソース消費を特徴としている。

## エンタープライズ用途

### **OpenShift（OKD）**

Red Hat の OpenShift は、エンタープライズ向けの Kubernetes を基盤としたコンテナプラットフォームです。OpenShift は、厳密には軽量ディストリビューションではないが、CI/CD やログ管理、監視、セキュリティなどの強力なエンタープライズ機能が統合されている。

## マルチクラウドデプロイメント、オンプレミス環境

### **RKE（Rancher Kubernetes Engine）**

RKE は Rancher Labs によって提供される、フル機能の Kubernetes クラスタをスクリプトベースで迅速にデプロイするためのツール。特にオンプレミスやクラウド環境の複数ノードクラスタの構築に最適。

## その他

### **k0s**

Mirantis によって提供される k0s は、フルスペックかつシンプルで、設定ファイルが一つだけという特徴がある。マスターノードのないデザイン（フルクラスター API サーバーを含む）もサポートしており、マスターノードがない分だけシンプルに管理ができるポイントがある。

```sh
curl -sSLf https://get.k0sproject.io | sudo sh
sudo k0s install controller
sudo k0s start
```

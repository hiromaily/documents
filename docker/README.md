# Docker Tips

- [2021: Dockerfile のベストプラクティス Top 20](https://sysdig.jp/blog/dockerfile-best-practices/)
- [awesome-docker](https://github.com/veggiemonk/awesome-docker)

## 1. Useful Commands

### Check specific container still running or not

```sh
while [ $(docker ps -f name=container-name --format "{{.Names}}" | wc -l | tr -s " ") -ne 0 ];do
    echo 'waiting shuting down for container-name  ...' && sleep 2;
done
```

### Clean everything

```sh
docker system prune
```

### Clean unused images

```sh
docker image prune -a
 or
docker rmi -f $(docker images -aqf "dangling=true" --no-trunc)
```

### Clean all containers

```sh
docker container prune
 or
docker rm -f $(docker ps -a --format "{{.Names}}")
```

### Clean all volumes

```sh
docker volume prune
```

## 2. How to connect services in different docker-compose files

First create network

```sh
docker network create --driver bridge our_network
```

1. **compose A**:

    ```yaml
    services:
      app1:
        image: app1:1.0
        container_name: app1
        ports:
          - "8888:8888"
        networks:
          - our_network

    networks:
      our_network:
        external: true
    ```

2. **compose B**:

    ```yaml
    services:
      app2:
        image: app2:1.0
        container_name: app2
        ports:
          - "8888:8888"
        networks:
          - our_network

    networks:
      our_network:
        external: true
    ```

In this case, app1 can connect to app2 with container_name and internal port

## 3. run complicated shell in command in compose

```yaml
  something-service:
    image: "something:latest"
    command: >
      bash -c "
        while ! nc -z localhost 9545; do
          sleep 1
        done
        node index.js xxxxx &&
        node index.js xxxxxx false
      "
```

## 4. Dockerfile linter

- [`--check` option](./debug.md)で実現できる

```sh
docker build -f ./docker/Dockerfile . --check
```

- Outdated: [hadolint](https://github.com/hadolint/hadolint)
  - 2022年から更新されていない

## 5. Containerを待機状態にして、コマンドを待ち受ける

```yaml
  batch:
    build:
      context: .
      dockerfile: ./apps/Dockerfile
    container_name: "batch"
    profiles: ["batch"]
    command: ["sleep", "infinity"]
    networks:
      - localnetwork
```

service `batch`に対して、コマンドを実行

```sh
docker exec -it sample-batch go run apps/batch/main.go
```

### `sleep infinity`について

- This approach has minimal impact on system resources, as the sleep command is extremely lightweight.
- CPU Usage: sleep infinity uses virtually no CPU resources because it doesn’t actively perform any operations
- Memory Usage: The memory footprint of a process running sleep infinity is very small
- `shell`による待受よりリソース消費が少ない

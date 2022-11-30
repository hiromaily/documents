# Docker Tips

- [commands](https://github.com/hiromaily/documents/blob/main/docker-tips/commands.md)

## 1. Useful Commands

- check specific container still running or not

```
while [ $(docker ps -f name=container-name --format "{{.Names}}" | wc -l | tr -s " ") -ne 0 ];do
    echo 'waiting shuting down for container-name  ...' && sleep 2;
done
```

- clean everything

```
docker system prune
```

- clean unused images

```
docker image prune -a
 or
docker rmi -f $(docker images -aqf "dangling=true" --no-trunc)
```

- clean all containers

```
docker container prune
 or
docker rm -f $(docker ps -a --format "{{.Names}}")
```

- clean all volumes

```
docker volume prune
```

## 2. How to connect services in different docker-compose files

First create network

```
docker network create --driver bridge our_network
```

1. compose A

```
version: '3'
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

2. compose B

```
version: '3'
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

```
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

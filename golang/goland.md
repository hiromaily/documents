# Goland

## Preferences

register for shortcut of coding

- `[Editor]`-`[Live Templates]`

## Useful tips

### bookmark

```
[fn] + [option] + [F3]
 or
[fn] + [F3]
```

### change to different window

```
[Command] + 「`」
```

### move to the code last changed

```
[Command] + 「[」
[Command] + 「]」
```

### exclude files or directory from file search

```
right click target directory from right project tab
select [Mark Directory As] - [Excluded]
```

### jump to declaration (or implementation) of func

```
[Command] + 「B」
[Command] + [Option] +「B」
```

### see reference of function where to be called

```
[Control] + [Option] + 「H」
```

### see structure of file

```
[Command] + 7
```

### see changed source code in project

```
[Command] + 9
```

## Local Debugging

1. Click [Edit configurations] from the top right
2. Click [+]button from the top left and choose [Go Build]
3. Right Configuration is
   - [Run kind] file
   - [Files] ./cmd/main.go
   - [Working directory] your project(git repo) directory
   - [Program arguments] arguments that your app requres

## Remote Debugging

Note: At the following version, remote debugging is not working. Use VSCODE with dap

### Environement

- GoLand 2021.3.2
- go version go1.17.5 darwin/amd64
- Docker Version 4.3.2 (72729)

### 手順

1. Dockerfile

```Dockerfile
# As debug mode
RUN go build -v -gcflags "all=-N -l" -o /workspace/app .
# Install dlv
RUN GOBIN=/workspace go install github.com/go-delve/delve/cmd/dlv@latest
```

2. Command to run dlv with binary on remote host

```sh
dlv --listen=:40000 --headless=true --api-version=2 --accept-multiclient exec /usr/bin/app
```

3. docker-compose.yml

```yml
services:
  my-app:
    container_name: my-container
    image: my-image:latest
    ports:
      - 40000:40000
    security_opt:
      - "seccomp:unconfined"
    cap_add:
      - SYS_PTRACE
    #privileged: true
```

4. Goland setting
   File–> settings –> Go –> Go Modules and select both “Enable Go module integration” and “Enable Vendoring support automatically”

5. Remote Debug by Goland

- Host: localhost
- Port: 40000

### Reference for debug

- [Attach to running Go processes with the debugger](https://www.jetbrains.com/help/go/attach-to-running-go-processes-with-debugger.html)
- [デバッガーで実行中の Go プロセスにアタッチする](https://pleiades.io/help/go/attach-to-running-go-processes-with-debugger.html)
- [Debugging a Go application inside a Docker container](https://blog.jetbrains.com/go/2020/05/06/debugging-a-go-application-inside-a-docker-container/)
- [Debugging Go applications with Docker Compose](https://blog.jetbrains.com/go/2020/05/08/running-go-applications-using-docker-compose-in-goland/#debugging-go-applications-with-docker-compose)
- [Debugging Go Code in docker-compose](https://lukelogbook.tech/2021/03/04/debugging-go-code-in-docker-compose/)

### Out dated way as of 2022 Jan

1. Click [Edit configurations] from the top right
2. Click [+]button from the top left and choose [Go Remote]
3. Install `dlv` by `go get -u github.com/go-delve/delve/cmd/dlv`
4. If you wanna run go program in Docker container, Dockerfile should include `dlv` installation as the above.
5. Docker setting is

```yml
dc-service:
  ports:
    - 2345:2345
  privileged: true
  command: bash -c "go build -o /go/bin/xxx ./cmd/main.go && dlv --listen=:2345 --headless=true --api-version=2 exec /go/bin/xxx -- --config xxxx.conf"
```

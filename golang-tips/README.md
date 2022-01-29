# Golang Tips

- [Useful functionalities](https://github.com/hiromaily/documents/blob/main/golang-tips/useful-functionality.md)

## 1. Useful websites

- [Awesome Go](https://go.libhunt.com/)
- [Uber Go Style Guide](https://github.com/uber-go/guide/blob/master/style.md)

## 2. IDE: Goland Settings

### 2.1. Preferences

- [Editor]-[Live Templates]
  register for shortcut of coding

### 2.2. Useful tips

1. bookmark

```
[fn] + [option] + [F3]
 or
[fn] + [F3]
```

2. change to different window

```
[Command] + 「`」
```

3. move to the code last changed

```
[Command] + 「[」
[Command] + 「]」
```

4. exclude files or directory from file search

```
right click target directory from right project tab
select [Mark Directory As] - [Excluded]
```

5. jump to declaration (or implementation) of func

```
[Command] + 「B」
[Command] + [Option] +「B」
```

6. see reference of function where to be called

```
[Control] + [Option] + 「H」
```

7. see structure of file

```
[Command] + 7
```

8. see changed source code in project

```
[Command] + 9
```

### 2.3. Local Debugging

1. Click [Edit configurations] from the top right
2. Click [+]button from the top left and choose [Go Build]
3. Right Configuration is
   - [Run kind] file
   - [Files] ./cmd/main.go
   - [Working directory] your project(git repo) directory
   - [Program arguments] arguments that your app requres

### 2.4. Remote Debugging

- Environement

  - GoLand 2021.3.2
  - go version go1.17.5 darwin/amd64
  - Docker Version 4.3.2 (72729)

- [Attach to running Go processes with the debugger](https://www.jetbrains.com/help/go/attach-to-running-go-processes-with-debugger.html)
- [デバッガーで実行中の Go プロセスにアタッチする](https://pleiades.io/help/go/attach-to-running-go-processes-with-debugger.html)
- [Debugging a Go application inside a Docker container](https://blog.jetbrains.com/go/2020/05/06/debugging-a-go-application-inside-a-docker-container/)
- [Debugging Go applications with Docker Compose](https://blog.jetbrains.com/go/2020/05/08/running-go-applications-using-docker-compose-in-goland/#debugging-go-applications-with-docker-compose)
- [Debugging Go Code in docker-compose](https://lukelogbook.tech/2021/03/04/debugging-go-code-in-docker-compose/)

1. Dockerfile

```
# As debug mode
RUN go build -v -gcflags "all=-N -l" -o /workspace/app .
# Install dlv
RUN GOBIN=/workspace go install github.com/go-delve/delve/cmd/dlv@latest
```

2. Command to run dlv with binary on remote host

```
dlv --listen=:40000 --headless=true --api-version=2 --accept-multiclient exec /usr/bin/app
```

3. docker-compose.yaml

```
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

#### Out dated way as of 2022 Jan

1. Click [Edit configurations] from the top right
2. Click [+]button from the top left and choose [Go Remote]
3. Install `dlv` by `go get -u github.com/go-delve/delve/cmd/dlv`
4. If you wanna run go program in Docker container, Dockerfile should include `dlv` installation as the above.
5. Docker setting is

```
  dc-service:
    ports:
      - 2345:2345
    privileged: true
    command: bash -c "go build -o /go/bin/xxx ./cmd/main.go && dlv --listen=:2345 --headless=true --api-version=2 exec /go/bin/xxx -- --config xxxx.conf"
```

## 3. IDE: VS Code

### 3.1. Debugging

- [github:vscode-go](https://github.com/golang/vscode-go)
- [github:vscode-go docs](https://github.com/golang/vscode-go/tree/master/docs)
- [github:vscode-go debuging](https://github.com/golang/vscode-go/blob/master/docs/debugging.md)
- [vscode debuging](https://code.visualstudio.com/docs/editor/debugging)

## 4. `make` with slice

```
package main

import (
	"fmt"
)

func main() {
	sliceData := make([]int, 0, 3)

	sliceData = append(sliceData, 1)
	fmt.Printf("len=%d cap=%d %v\n", len(sliceData), cap(sliceData), sliceData)
	//len=1 cap=3 [1]

	sliceData = append(sliceData, 2)
	fmt.Printf("len=%d cap=%d %v\n", len(sliceData), cap(sliceData), sliceData)
	//len=2 cap=3 [1 2]

	sliceData = append(sliceData, 3)
	fmt.Printf("len=%d cap=%d %v\n", len(sliceData), cap(sliceData), sliceData)
	//len=3 cap=3 [1 2 3]

	sliceData = append(sliceData, 4)
	fmt.Printf("len=%d cap=%d %v\n", len(sliceData), cap(sliceData), sliceData)
	//len=4 cap=8 [1 2 3 4]

	sliceData = append(sliceData, 5)
	fmt.Printf("len=%d cap=%d %v\n", len(sliceData), cap(sliceData), sliceData)
	//len=5 cap=8 [1 2 3 4 5]
}
```

## 5. Golang Modules

### 5.1.Using private repository

- [How to set GOPRIVATE environment variable](https://stackoverflow.com/questions/58305567/how-to-set-goprivate-environment-variable)

add the below setting in ~/.gitconfig

```
[url "git@github.com:private-repo-name/"]
	insteadOf = https://github.com/private-repo-name/
```

or

```
[url "git@github.yourhost.com:"]
	insteadOf = https://github.yourhost.com/
```

## 6. How to use pointer without definition as variable

- struct

```
(*SomethingStruct)(&SomethingStruct{}).SomethingFunc(param)
```

- string

```
(*string)(&s.SomethingType)
```

## 7. To avoid problems using 3rd party

### 7.1. [aerospike-client-go](https://github.com/aerospike/aerospike-client-go)

#### Don't use pointer of map object as much as possible

- Though PutObject() func works, GetObject() func doesn't work when parsing pointer of map

```
type Something struct {
	SomeMap SomeMap `as:"something"`
	//SomeMap *SomeMap `as:"something"` //pointer of map doesn't work
}

type SomeMap map[string]*AnyContent

type AnyContent struct {
	count int64             `as:"count"`
}
```

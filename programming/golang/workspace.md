# Golang workspace

Go1.18で追加された、`Workspace mode`

[Tutorial: Getting started with multi-module workspaces](https://go.dev/doc/tutorial/workspaces)

```txt
workspace
   ├── moduleA
   │   ├── go.mod
   │   └── moduleA.go
   └── moduleB
       ├── go.mod
       └── main.go
```

```sh
go work init ./hello

go work use ./example/hello
```

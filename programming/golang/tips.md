# Tips

## `make` with slice

```go
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

## How to use pointer without definition as variable

struct

```go
(*SomethingStruct)(&SomethingStruct{}).SomethingFunc(param)
```

string

```go
(*string)(&s.SomethingType)
```

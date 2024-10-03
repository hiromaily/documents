# Golang Snippets

## [vscode-go の snippets](https://github.com/golang/vscode-go/blob/825de6bd32ae38bb4a6ae737e451f0ad98f1ecb2/extension/snippets/go.json)

### Imports

- **Single Import**

  - **Prefix**: `im`
  - **Body**: `import "${1:package}"`
  - **Description**: Snippet for import statement

- **Multiple Imports**
  - **Prefix**: `ims`
  - **Body**: `import (\n\t"${1:package}"\n)`
  - **Description**: Snippet for a import block

### Constants

- **Single Constant**

  - **Prefix**: `co`
  - **Body**: `const ${1:name} = ${2:value}`
  - **Description**: Snippet for a constant

- **Multiple Constants**
  - **Prefix**: `cos`
  - **Body**: `const (\n\t${1:name} = ${2:value}\n)`
  - **Description**: Snippet for a constant block

### Type Declarations

- **Function**

  - **Prefix**: `tyf`
  - **Body**: `type ${1:name} func($3) $4`
  - **Description**: Snippet for a type function declaration

- **Interface**

  - **Prefix**: `tyi`
  - **Body**: `type ${1:name} interface {\n\t$0\n}`
  - **Description**: Snippet for a type interface

- **Struct**
  - **Prefix**: `tys`
  - **Body**: `type ${1:name} struct {\n\t$0\n}`
  - **Description**: Snippet for a struct declaration

### Functions

- **Package Main and Main Function**

  - **Prefix**: `pkgm`
  - **Body**: `package main\n\nfunc main() {\n\t$0\n}`
  - **Description**: Snippet for main package & function

- **Function Declaration**
  - **Prefix**: `func`
  - **Body**: `func $1($2) $3 {\n\t$0\n}`
  - **Description**: Snippet for function declaration

### Variables

- **Single Variable**

  - **Prefix**: `var`
  - **Body**: `var ${1:name} ${2:type}`
  - **Description**: Snippet for a variable

- **Multiple Variables**
  - **Prefix**: `vars`
  - **Body**: `var (\n\t${1:name} ${2:type}\n)`
  - **Description**: Snippet for variable block

### Statements

- **If Statement**

  - **Prefix**: `if`
  - **Body**: `if ${1:condition} {\n\t$0\n}`
  - **Description**: Snippet for if statement

- **Else Branch**

  - **Prefix**: `el`
  - **Body**: `else {\n\t$0\n}`
  - **Description**: Snippet for else branch

- **If Else Statement**

  - **Prefix**: `ie`
  - **Body**: `if ${1:condition} {\n\t$2\n} else {\n\t$0\n}`
  - **Description**: Snippet for if else

- **For Loop**

  - **Prefix**: `for`
  - **Body**: `for ${1:i} := ${2:0}; $1 < ${3:count}; $1${4:++} {\n\t$0\n}`
  - **Description**: Snippet for a for loop

- **For Range Loop**
  - **Prefix**: `forr`
  - **Body**: `for ${1:_, }${2:v} := range ${3:v} {\n\t$0\n}`
  - **Description**: Snippet for a for range loop

### Print & Log

- **fmt.Println**

  - **Prefix**: `fp`
  - **Body**: `fmt.Println("$1")`
  - **Description**: Snippet for fmt.Println()

- **fmt.Printf**

  - **Prefix**: `ff`
  - **Body**: `fmt.Printf("$1", ${2:var})`
  - **Description**: Snippet for fmt.Printf()

- **log.Println**

  - **Prefix**: `lp`
  - **Body**: `log.Println("$1")`
  - **Description**: Snippet for log.Println()

- **log.Printf**
  - **Prefix**: `lf`
  - **Body**: `log.Printf("$1", ${2:var})`
  - **Description**: Snippet for log.Printf()

### Test Functions

- **Test Function**

  - **Prefix**: `tf`
  - **Body**: `func Test$1(t *testing.T) {\n\t$0\n}`
  - **Description**: Snippet for Test function

- **Benchmark Function**

  - **Prefix**: `bf`
  - **Body**: `func Benchmark$1(b *testing.B) {\n\tfor ${2:i} := 0; ${2:i} < b.N; ${2:i}++ {\n\t\t$0\n\t}\n}`
  - **Description**: Snippet for Benchmark function

- **Example Function**

  - **Prefix**: `ef`
  - **Body**: `func Example$1() {\n\t$2\n\t//Output:\n\t$3\n}`
  - **Description**: Snippet for Example function

- **Table Driven Test**
  - **Prefix**: `tdt`
  - **Body**: `func Test$1(t *testing.T) {\n\ttestCases := []struct {\n\t\tdesc\tstring\n\t\t$2\n\t}{\n\t\t{\n\t\t\tdesc: "$3",\n\t\t\t$4\n\t\t},\n\t}\n\tfor _, tC := range testCases {\n\t\tt.Run(tC.desc, func(t *testing.T) {\n\t\t\t$0\n\t\t})\n\t}\n}`
  - **Description**: Snippet for table driven test

### Miscellaneous

- **Channel Declaration**

  - **Prefix**: `ch`
  - **Body**: `chan ${1:type}`
  - **Description**: Snippet for a channel

- **Map Declaration**

  - **Prefix**: `map`
  - **Body**: `map[${1:type}]${2:type}`
  - **Description**: Snippet for a map

- **Empty Interface**

  - **Prefix**: `in`
  - **Body**: `interface{}`
  - **Description**: Snippet for empty interface

- **Hello World Web App**

  - **Prefix**: `helloweb`
  - **Body**: `package main\n\nimport (\n\t"fmt"\n\t"net/http"\n\t"time"\n)\n\nfunc greet(w http.ResponseWriter, r *http.Request) {\n\tfmt.Fprintf(w, "Hello World! %s", time.Now())\n}\n\nfunc main() {\n\thttp.HandleFunc("/", greet)\n\thttp.ListenAndServe(":8080", nil)\n}`
  - **Description**: Snippet for sample hello world webapp

- **Sort Implementation**
  - **Prefix**: `sort`
  - **Body**: `type ${1:SortBy} []${2:Type}\n\nfunc (a $1) Len() int           { return len(a) }\nfunc (a $1) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }\nfunc (a $1) Less(i, j int) bool { ${3:return a[i] < a[j]} }`
  - **Description**: Snippet for a custom sort.Sort interface implementation, for a given slice type.

## [Golang Snippets](https://marketplace.visualstudio.com/items?itemName=honnamkuan.golang-snippets)

これは自分には不要かも

# IDE

## EditorConfig

- [EditorConfig](https://editorconfig.org/)

EditorConfig helps maintain consistent coding styles for multiple developers working on the same project across various editors and IDEs. The EditorConfig project consists of a file format for defining coding styles and a collection of text editor plugins that enable editors to read the file format and adhere to defined styles. EditorConfig files are easily readable and they work nicely with version control systems.

This file name must be `.editorconfig`

- example

```
root = true

[*]
end_of_line = lf
insert_final_newline = true
charset = utf-8
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

[*.go]
indent_style = tab
indent_size = 4

[*Dockerfile]
indent_style = tab
indent_size = 4

[Makefile]
indent_style = tab
indent_size = 4

[*.md]
indent_style = tab
```

- For Visual Studio Code, [extension](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig) is required.

# MUI
MUI offers a comprehensive suite of UI tools to help you ship new features faster.
Start with Material UI, our fully-loaded component library, 
or bring your own design system to our production-ready components.

Material UI is a library of React UI components that implements Google's Material Design.


`MUI Core`の中に、`Material UI`, `Joy UI`, `MUI Base`, `MUI System`とあり、それぞれ独立してinstallが必要
## References
- [Official](https://mui.com/)
  - [Material UI Docs](https://mui.com/material-ui/getting-started/overview/)
- [github](https://github.com/mui) 
- [React templates & tools](https://mui.com/store/)
- [MUI Component Template](https://mui.com/templates/)


## Products
- [MUI Core](https://mui.com/core/)
  - Component library
    - [Supported components](https://mui.com/material-ui/getting-started/supported-components/)
  - Theming
  - Styling
- [MUI X](https://mui.com/x/)
  - React component library for advanced use-cases
  - Data Grid
  - Theming
- [Templates](https://mui.com/templates/)
  - [React templates & tools to start your next project](https://mui.com/store/)
- [Design kits](https://mui.com/design-kits/)

## Install and start using
- [Installation](https://mui.com/material-ui/getting-started/installation/)

- Install packages
```bash
npm install @mui/material @emotion/react @emotion/styled
```

- Or install packages using styled-components
```bash
npm install @mui/system @mui/styled-engine-sc styled-components
```

## Use  modify html
- [Typography](https://mui.com/material-ui/react-typography/)

```html
<!-- Roboto font -->
<link
  rel="stylesheet"
  href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
/>
<!-- Font icons -->
<link
  rel="stylesheet"
  href="https://fonts.googleapis.com/icon?family=Material+Icons"
/>
```

# Material Icons
- [Material Icons](https://mui.com/material-ui/material-icons/)
```bash
npm install @mui/icons-material
```

- use icons
```tsx
import MenuIcon from "@mui/icons-material/Menu";
import SearchIcon from "@mui/icons-material/Search";
import AccountCircle from "@mui/icons-material/AccountCircle";
import MailIcon from "@mui/icons-material/Mail";
import NotificationsIcon from "@mui/icons-material/Notifications";
```

## How to use components
- use components
```tsx
import { Button } from "@mui/material";
...

  return (
    <div className="App">
      <header className="App-header">
        <Button variant="outlined">Material-UI Button</Button>
      </header>
    </div>
  );
}
```

## Theme
`theme`と呼ばれるオブジェクトで、スタイリングを調整する

```tsx
import { createTheme } from "@mui/material/styles";
import { ThemeProvider } from "@mui/material/styles";
import CssBaseline from "@mui/material/CssBaseline";

let theme = createTheme({
    palette: {
        primary: {
        main: "#42a5f5",
        light: "#1976d2",
        dark: "#1565c0",
        },
})

const App = () => {
  return (
    <ThemeProvider theme={theme}>
        <CssBaseline />
        <Box component="div">
            <Button color="primary" sx={{
                color: theme.palette.primary.main,
            }}>
                Button
            <Button>
        </Box>
    </ThemeProvider>
    );
}
```

## Components
### Box
Boxはdefaultで`div`として機能し、`component`属性で要素を変更できる
```tsx
<Box component="main" />

<Box component="div" sx={{
    height: 300,
    width: 350,
}}>
```

### Container
Boxと基本は同じだが、要素を中央に寄せたい場合`maxWidth`属性で設定できる
```tsx
<Container maxWidth="xs" />
```

### Typography (仕上がり、デザイン)
themeのtypographyオブジェクトを使用してスタイリングできる
```tsx
<Typography variant="h1">text</Typography>
```

## Componentのセンタリング方法
- [4 ways to center a component in Material-UI](https://medium.com/@tsubasakondo_36683/4-ways-to-center-a-component-in-material-ui-a4bcafe6688e)

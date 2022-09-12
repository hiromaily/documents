# Mui
MUI offers a comprehensive suite of UI tools to help you ship new features faster.
Start with Material UI, our fully-loaded component library, 
or bring your own design system to our production-ready components.

Material UI is a library of React UI components that implements Google's Material Design.

## References
- [Official](https://mui.com/)
  - [Material UI Docs](https://mui.com/material-ui/getting-started/overview/)
- [github](https://github.com/mui) 

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
- install packages
```bash
npm install @mui/material @emotion/react @emotion/styled
npm install @mui/icons-material
```

- modify html
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

- use icons
```tsx
import MenuIcon from "@mui/icons-material/Menu";
import SearchIcon from "@mui/icons-material/Search";
import AccountCircle from "@mui/icons-material/AccountCircle";
import MailIcon from "@mui/icons-material/Mail";
import NotificationsIcon from "@mui/icons-material/Notifications";
```
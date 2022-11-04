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

- [React + Material-UIで管理画面を作成してみた](https://dev.classmethod.jp/articles/react-material-ui/)

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

## Components v5
- Inputs
  - [Autocomplete](https://mui.com/material-ui/react-autocomplete/)
    - autocomplete機能を持つText Input
  - [Button](https://mui.com/material-ui/react-button/)
  - [Button Group](https://mui.com/material-ui/react-button-group/)
    - 複数のbuttonをグループ化したもの
  - [Checkbox](https://mui.com/material-ui/react-checkbox/)
  - [Floating Action Button](https://mui.com/material-ui/react-floating-action-button/)
    - 円形のリッチなbutton
  - [Radio Group](https://mui.com/material-ui/react-radio-button/)
  - [Rating](https://mui.com/material-ui/react-rating/)
    - 星マークでレーティングできる
  - [Select](https://mui.com/material-ui/react-select/)
    - コンボボックス
  - [Slider](https://mui.com/material-ui/react-slider/)
  - [Switch](https://mui.com/material-ui/react-switch/)
  - [Text Field](https://mui.com/material-ui/react-text-field/)
  - [Transfer List](https://mui.com/material-ui/react-transfer-list/)
    - 2つのリストのグループがあり、項目を移動できるもの
  - [Toggle Button](https://mui.com/material-ui/react-toggle-button/) 
    - 並んだアイコンから、どれかを選択した状態にできるもの
- Data display
  - [Avatar](https://mui.com/material-ui/react-avatar/)
    - 顔写真や名前のイニシャルなどのアイコン
  - [Badge](https://mui.com/material-ui/react-badge/)
    - メールやカートアイコンに、ナンバーが表示したもの
  - [Chip](https://mui.com/material-ui/react-chip/)
    - 補足説明を担うようなチップ(アイコン)
  - [Divider]
    - hrタグ(horizontal rule)と同じで、水平の横線を引くためのもの
    - ListItemなどで、境界線などに使われる
  - [Icons](https://mui.com/material-ui/icons/)
    - `npm install @mui/icons-material`によるinstallが必要で、様々なアイコンが用意されている
    - 次項の`Material Icon`を参照
    - そのほかのライブラリも使える
      - [MDI](https://mui.com/material-ui/icons/)は、2000を超えるアイコンが用意されている 
  - [Material Icons](https://mui.com/material-ui/material-icons/)
  - [Lists](https://mui.com/material-ui/react-list/)
    - メニュー的なリスト
  - [Table](https://mui.com/material-ui/react-table/)
  - [Tooltip](https://mui.com/material-ui/react-tooltip/)
  - [Typography](https://mui.com/material-ui/react-typography/)
    - Fontの事前installが必要
    - `<Typography variant="h1"></Typography>` のように`variant`要素でstyleを指定する
- Feed back
  - [Alert](https://mui.com/material-ui/react-alert/)
    - Error, Warning, Info, Success といった、アラーム要素(ダイアログではない)を表示する
  - [Backdrop](https://mui.com/material-ui/react-backdrop/)
    - ポップアップを表示させるときに、画面全体をグレーアウトするための背景を表示する
    - `Dialog`だけでは実現できない？
  - [Dialog](https://mui.com/material-ui/react-dialog/)
  - [Progress](https://mui.com/material-ui/react-progress/)
    - くるくる回るローダーを表示する
  - [Skeleton](https://mui.com/material-ui/react-skeleton/)
    - データが読み込まれる前にコンテンツのプレースホルダー プレビューを表示する
  - [Snackbar](https://mui.com/material-ui/react-snackbar/)
    - 短い通知を表示する。`Alert`と似ている
- Surfaces
  - [Accordion](https://mui.com/material-ui/react-accordion/)
    - 開閉式のリストを表示する
  - [App Bar](https://mui.com/material-ui/react-app-bar/)
    - buttonやtitleを含むヘッダーを表示する
  - [Card](https://mui.com/material-ui/react-card/)
    - 四角形のimageやtextを含む要素を表示する
  - [Paper](https://mui.com/material-ui/react-paper/)
    - アプリケーションの背景は、1 枚の紙の平らで不透明なテクスチャに似ており、アプリケーションの動作は、サイズ変更、シャッフル、および複数のシートへの結合を行う紙の機能を模倣している
- Navigation
  - [Bottom Navigation](https://mui.com/material-ui/react-bottom-navigation/)
    - スマホの画面に見られるフッターのようなもの
  - [Breadcrumbs](https://mui.com/material-ui/react-breadcrumbs/)
    - パンくずリスト
  - [Drawer](https://mui.com/material-ui/react-drawer/)
    - 画面外に隠れたメニューリストをスライドして表示させる
  - [Links](https://mui.com/material-ui/react-link/)
  - [Menu](https://mui.com/material-ui/react-menu/)
    - buttonやtextをクリックすることで、メニューリストを表示させる
  - [Pagination](https://mui.com/material-ui/react-pagination/)
  - [Speed Dial](https://mui.com/material-ui/react-speed-dial/)
    - `Menu`と似ているが、複数の円形オブジェクトから成るメニューリストを表示させる
  - [Stepper](https://mui.com/material-ui/react-stepper/)
    - 現在の進捗状況を、step1, step2, step3と今どの状況か知らせるためのUI
  - [Tabs](https://mui.com/material-ui/react-tabs/)
    - タブ
- Layout
  - [Box](https://mui.com/material-ui/react-box/)
    - wrapper componentとして機能し、`sx` propでstyleを指定してデザインする
    - defaultでは`div`要素が実態となるが、`component` propで要素を変更できる
      - `<Box component="span" sx={{ p: 2, border: '1px dashed grey' }}>`
    - `component`にはあらゆる要素を指定できる？
```tsx
<Box component="div" sx={{
    height: 300,
    width: 350,
}}>
<Box component="main" />
<Box component="form">
<Box component="img" alt="" src=""/>
<Box component="span"/>
<Box component="a" href=""/>
<Box component="strong" href=""/>
<Box component="h1" href=""/>
```
  - [Container](https://mui.com/material-ui/react-container/)
    - Boxと基本は同じだが、要素を中央に寄せたい場合`maxWidth`属性で設定できる
    - Componentのセンタリング方法
      - [4 ways to center a component in Material-UI](https://medium.com/@tsubasakondo_36683/4-ways-to-center-a-component-in-material-ui-a4bcafe6688e)
  - [Grid](https://mui.com/material-ui/react-grid/)
    - レスポンシブ レイアウト グリッドによって、画面のサイズと向きに適応し、レイアウト間の一貫性を確保する
    - デザインレイアウトの要となるもの？
  - [Grid version 2](https://mui.com/material-ui/react-grid2/)
    - `Grid`コンポーネントの問題を解消したもので、こちらを使う
  - [Stack](https://mui.com/material-ui/react-stack/)
    - `Grid`と似ているが、`Stack` コンポーネントは、垂直軸または水平軸に沿って直下の子のレイアウトを管理し、オプションで各子の間に間隔や仕切りを配置する
  - [Image List](https://mui.com/material-ui/react-image-list/)
    - 画像の集合体をgridで表示する
  - [Hidden](https://mui.com/material-ui/react-hidden/)
    - deprecated
- Utils
  - [Click-Away Listener](https://mui.com/material-ui/react-click-away-listener/)
    - 子要素の外でクリックイベントが発生したことを検出する
  - [CSS Baseline](https://mui.com/material-ui/react-css-baseline/)
    - 各ブラウザーの差異を平均化させる `normalize.css` のような役割を果たすベースライン
    - CssBaseline ... 全体要素に適用するときに利用し、global resetの機能を持たせるもの
    - ScopedCssBaseline ... 子要素のみに適用したい場合はこちらを使用する
```tsx
<ThemeProvider theme={theme}>
  <CssBaseline />
  <Container maxWidth="sm">
    <MediaCard />
  </Container>
</ThemeProvider>
```
  - [Modal](https://mui.com/material-ui/react-modal/)
    - dialogs, popovers, lightboxesなどを作成するための強固な基盤を提供する
  - [No SSR](https://mui.com/material-ui/react-no-ssr/)
    - サーバー サイド レンダリング (SSR) の対象からコンポーネントを意図的に削除するもの 
  - [Popover](https://mui.com/material-ui/react-popover/)
    - コンテンツを別のコンテンツの上に表示できる
  - [Popper](https://mui.com/material-ui/react-popper/)
    - コンテンツを別のコンテンツの上に表示できる。`react-popper` の代替品
  - [Portal](https://mui.com/material-ui/react-portal/)
    - その子要素を現在の DOM 階層の外側にある新しい「サブツリー」にレンダリングする
  - [Textarea Autosize](https://mui.com/material-ui/react-textarea-autosize/)
    - テキストエリア
  - [Transitions](https://mui.com/material-ui/transitions/)
    - 非表示のものを表示させる際に、アニメーションを使って表示させる
    - 種類は
      - Collapse
      - Fade
      - Grow
      - Slide
      - Zoom
  - [useMediaQuery](https://mui.com/material-ui/react-use-media-query/)
    - ReactのCSS media query hook
- Mui X
  - [Data grid](https://mui.com/x/react-data-grid/)
    - 高速で拡張可能なReactデータ テーブルとReactデータ グリッド
    - これは、MIT または商用バージョンで利用できる機能豊富なコンポーネント
  - [Date / Time pickers](https://mui.com/x/react-date-pickers/getting-started/)
    - 日付ピッカーと時間ピッカーを使用すると、事前に定義されたセットから 1 つの値を選択できる
- LAB

## Customization
### Theming
- テーマで MUI をカスタマイズできる。これにより、色、タイポグラフィなどを変更できる
- テーマは、コンポーネントの色、表面の暗さ、影のレベル、インク要素の適切な不透明度などを指定する
- テーマを使用すると、アプリに一貫したトーンを適用できる
- ビジネスやブランドの特定のニーズを満たすために、プロジェクトのすべてのデザイン面をカスタマイズできる。
- アプリ間の一貫性を高めるために、`light`と`dark`のテーマ タイプから選択できる。
  - デフォルトでは、コンポーネントは `light` テーマ タイプを使用する。

#### ThemeProvider
- テーマをカスタマイズする場合は`ThemeProvider`によって、アプリケーションにテーマを挿入する
- ただし、これはオプションであり、MUI コンポーネントには、既定のテーマが付属している

#### Theme configuration variables
- `.palette`
  - ブランドに合わせてコンポーネントの色を変更できる
- `.typography`
  - レイアウト グリッドともうまく連携する一連の文字サイズを提供する
- `.spacing`
  - UI の要素間に一貫した間隔を作成するには、`theme.spacing()` ヘルパーを使用する
- `.breakpoints`
  - さまざまなコンテキストでブレークポイントを使用できるようにする API 
- `.zIndex`
  - z-index は、コンテンツを配置するための 3 番目の軸を提供することでレイアウトを制御するのに役立つ CSS プロパティ
- `.transitions`
  - テーマ キーを使用すると、MUI コンポーネント全体で使用されるさまざまなトランジションの継続時間とイージングをカスタマイズでき、カスタム トランジションを作成するためのユーティリティが提供される
- `.components`
  - テーマ内のキーを使用して、コンポーネントのスタイル、デフォルトのpropsなどをカスタマイズできる

#### Theme builder
- [Material-UI Theme Creator](https://bareynol.github.io/mui-theme-creator/)
- [Color palettes](https://m2.material.io/inline-tools/color/)

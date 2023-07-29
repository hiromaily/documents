# 演算子

## 論理演算子

### `&&`
```ts
const x = a && b;
```
- a の真偽値がtrueであれば、a && b の真偽は b に託されるため、b を返す
- a の真偽値がfalseであれば、a && b の真偽は a に託されるため、a を返す

#### 真偽値がfalseとなるもの
- false
- 0
- 空文字列
- null
- undefined

### `||`
```ts
const y = a || b;
```
- a の真偽値がtrueであれば、a || b の真偽は a に託されるため、a を返す
- a の真偽値がfalseであれば、a || b の真偽は b に託されるため、b を返す

#### 真偽値がfalseとなるもの
- false
- 0
- 空文字列
- null
- undefined


### `??`
```ts
const z = a ?? b;
```
- a の真偽値がtrueであれば、a ?? b の真偽は a に託されるため、a を返す
- a の真偽値がfalseであれば、a ?? b の真偽は b に託されるため、b を返す

#### 真偽値がfalseとなるもの
- null
- undefined


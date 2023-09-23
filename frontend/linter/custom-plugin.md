# Custom Plugin for ESLint

- [Create Plugins](https://eslint.org/docs/latest/extend/plugins)
- [eslint plugin tutorial](https://github.com/Quramy/eslint-plugin-tutorial)
- [Beginner’s Guide to Custom ESLint Plugins](https://medium.com/@brandongregoryscott/beginners-guide-to-custom-eslint-plugins-77aca43f05c6)

## Eslint の Plugin の構成

- [Custom Rule](https://eslint.org/docs/latest/extend/custom-rules)

- meta: ルールのメタ情報
- create: ルールを実装した object を返す

## Experiment

例えば、以下のような同じ group の const は、import コストも高く使いづらいため、1 つの object に別々 property を与えたほうが利用しやすい。  
これを警告、もしくは自動変換するような lint の plugin を作成したい

- before

```ts
const CHAIN_ID_ETHEREUM = 1;
const CHAIN_ID_GOERLI = 2;
const CHAIN_ID_BSC = 3;
```

- after

```ts
export const ChainId = {
  ETHEREUM: 1,
  GOERLI: 5,
  BSC: 56,
} as const;
```

### github

- [eslint-plugin-same-group-constant](https://github.com/hiromaily/eslint-plugin-same-group-constant)

## 開発した eslint plugin の 公開

- [tsup](https://github.com/egoist/tsup)

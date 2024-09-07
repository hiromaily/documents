# React Hook の Test について

- [React 18 で Custom Hooks のテストを書くときの注意点](https://zenn.dev/k_kazukiiiiii/articles/9f48bdd20435d2)
- [react-hooks-testing-library](https://github.com/testing-library/react-hooks-testing-library)
  - 更新が既に止まっている
  - `@testing-library/react-hooks`は<React@18.x>で動かないため、`@testing-library/react`を使用する
- [別途まとめた Hook の Test](../framework/react/hooks/test.md)

```ts
import { renderHook, act, waitFor } from "@testing-library/react";
import { useMyHook } from "../useMyHook";

test("should increment counter", () => {
  const { result } = renderHook(() => useMyHook());

  act(() => {
    result.current.increment();
  });

  expect(result.current.count).toBe(1);
});
```

```ts
import { renderHook, waitFor } from '@testing-library/react'
import 'cross-fetch/polyfill'
import { rest } from 'msw';
import { setupServer } from 'msw/node';
import { useCustomAPI } from './useCustomAPI';

...

describe("test useCustomAPI", () => {
  it('calls /foobar', async () => {
    const expected = {};
    const { result } = renderHook(() => useCustomAPI(KEY_GET_CONTRACTS));

    await waitFor(() => {
      expect(result.current.error).toBeUndefined();
      expect(result.current.data).toEqual(expected);
    }, { timeout: 1000 },
    );
  });
});
```

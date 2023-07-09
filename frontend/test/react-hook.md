# React Hook の Test について

- [React 18 で Custom Hooks のテストを書くときの注意点](https://zenn.dev/k_kazukiiiiii/articles/9f48bdd20435d2)
- [react-hooks-testing-library](https://github.com/testing-library/react-hooks-testing-library)
  - 更新が既に止まっている
  - `@testing-library/react-hooks`はReact@18.xで動かないため、`@testing-library/react`を使用する
- [別途まとめた Hook の Test](../framework/react/hooks/test.md)

```ts
import { renderHook, act, waitFor } from '@testing-library/react';
import { useMyHook } from '../useMyHook';

test('should increment counter', () => {
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
import { useBackendAPI } from '../useBackendAPI'; // The hook to be tested

...

describe("test useBackendAPI", () => {
  it('calls get_contracts', async () => {
    // call /get_contracts
    const { result } = renderHook(() => useBackendAPI(KEY_GET_CONTRACTS));

    await waitFor(() => {
      expect(result.current.error).toBe(null);
      expect(result.current.data.contracts?.length).toBe(2);
      expect(result.current.data.contracts[0]?.chainId).toBe('0x1');
      expect(result.current.data.contracts[0]?.contractId).toBe('0x1');
      expect(result.current.data.contracts[0]?.contractType).toBe(2);
      expect(result.current.data.contracts[0]?.contractName).toBe('Pool(TOKI)');
    }, { timeout: 1000 },
    );
  });
});
```

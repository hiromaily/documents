# Hook の Test

[test/hook](../../../test/react-hook.md)

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

# Hook の Test

- [react-hooks-testing-library](https://www.npmjs.com/package/@testing-library/react-hooks)は古いので注意
- 代わりに、`@testing-library/react`を使う

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

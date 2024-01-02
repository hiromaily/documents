# Hooks Parameter

```tsx
// Hook function
interface Props {
  someId: number;
  anyId: number;
  amount?: number;
}

export const useSomething = ({
  someId,
  anyId,
  amount,
}: Props): anyResponse => {
...

return {...};

};

// caller
const { resp, error } =
  useSomething({ someId, anyId, amount });
```

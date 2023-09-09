# Example for Hook functions

## `useState`, `useCallback`, `useEffect`を使った例

- `useCallback()`でラップした function を`useEffect()`内で実行する
- `useCallback()`内で実行した function の結果は、`useState()`で管理する
- `useEffect()`の`依存する配列`には、全体の hook に渡されるパラメータと、内部で実行する function をセットする

```ts
import { useCallback, useEffect, useState } from "react";
import { EstimateContractGasParameters, formatEther } from "viem";
import { usePublicClient } from "wagmi";

export type UseEstimateGasReturnType = {
  estimation: bigint;
  price: bigint;
  cost: bigint;
  costInEth: string;
};

export function useEstimateGas(
  props: EstimateContractGasParameters
): UseEstimateGasReturnType {
  const [estimations, setEstimations] = useState<UseEstimateGasReturnType>();
  const publicClient = usePublicClient();

  const estimate = useCallback(async () => {
    const estimation = await publicClient.estimateContractGas(props);
    const price = await publicClient.getGasPrice();
    const cost = estimation * price;
    const costInEth = formatEther(cost);

    setEstimations({
      estimation,
      price,
      cost,
      costInEth,
    });
  }, [publicClient, props]);

  useEffect(() => {
    estimate();
  }, [estimate, props]);

  return estimations as UseEstimateGasReturnType;
}
```

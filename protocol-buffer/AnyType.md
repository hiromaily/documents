# Any Type

- [any.proto](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/any.proto)

## example of proto file

```
import "google/protobuf/any.proto";
message Account {
  string              address = 1;
  google.protobuf.Any pub_key = 2;
}
```

## Any type を JSON に decode する (TypeScript Version)

1. Any を含む構造体の型を定義

   - [sample proto](https://github.com/cosmos/cosmos-sdk/blob/master/proto/cosmos/tx/v1beta1/tx.proto)

   ```
   // Tx is the standard type used for broadcasting transactions.
   message Tx {
     TxBody body = 1;
     AuthInfo auth_info = 2;
     repeated bytes signatures = 3;
   }

   message TxBody {
     repeated google.protobuf.Any messages = 1;
     string memo = 2;
     uint64 timeout_height = 3;
     repeated google.protobuf.Any extension_options = 1023;
     repeated google.protobuf.Any non_critical_extension_options = 2047;
   }
   ```

2. protoc でコンパイル

- 以下 plugin が必要
  - [protoc-gen-ts](https://www.npmjs.com/package/protoc-gen-ts)
  - [ts-proto](https://www.npmjs.com/package/ts-proto)

```
#`--ts_proto_opt` に `outputTypeRegistry=true` をセット
protoc \
  --plugin="$(yarn bin protoc-gen-ts_proto)" \
  --ts_proto_out="$OUT_DIR" \
  --proto_path="$PROTO_DIR" \
  --proto_path="$THIRD_PARTY_PROTO_DIR" \
  --ts_proto_opt="esModuleInterop=true,forceLong=long,useOptionals=true,outputTypeRegistry=true" \
  "$PROTO_DIR/cosmos/tx/v1beta1/tx.proto" \
```

3. コンパイル後に生成された ts ファイル

- 生成されたファイルに、Any type が含まれている場合、`outputTypeRegistry` によって、`$type: 'cosmos.tx.v1beta1.Tx'` が追加される

```
export interface Tx {
  $type: 'cosmos.tx.v1beta1.Tx';
  body?: TxBody;
  authInfo?: AuthInfo;
  signatures: Uint8Array[];
}

export interface TxBody {
  $type: 'cosmos.tx.v1beta1.TxBody';
  messages: Any[];
  memo: string;
  timeoutHeight: Long;
  extensionOptions: Any[];
  nonCriticalExtensionOptions: Any[];
}

- `typeRegistry.ts` というファイルも生成されているので、こちらもapp.tsから参照するようにする。
```

4. interface 型の object を JSON に変換する

- 以下の例では、`decodeAnyFromJSON()`によって再起的に、json データの Any が decode される。
- json ファイルの場合、snakecase が必要になる場合、別ライブラリで最終的に変換しているが、
  - ts-proto の option によって、実現可能っぽい。`--ts_proto_opt=snakeToCamel=keys,json`

```
import snakecaseKeys from 'snakecase-keys';
import { decodeAnyFromJSON } from '@src/utils/decodeAny';

const txToJSON = (tx: Tx, optExcludes?: string[]): string | undefined => {
  const decodedJSON = decodeAnyFromJSON(Tx.toJSON(tx)) as any;
  let excludes: string[] = ['@type'];
  if (optExcludes && optExcludes.length > 0)
    excludes = excludes.concat(optExcludes);
  return JSON.stringify(snakecaseKeys(decodedJSON, { exclude: excludes }));
};
```

- decodeAny.ts

```
//import mapObject, { mapObjectSkip } from 'map-obj';
import mapObject from 'map-obj';
import { messageTypeRegistry, MessageType } from '@src/codec/typeRegistry';
import '@src/codec/cosmos/crypto/secp256k1/keys'; // somehow this module was not loaded
import { bytesFromBase64 } from '@src/utils/base64';

const isAny = (value: any): boolean => {
  return (
    typeof value === 'object' &&
    value.typeUrl !== undefined &&
    value.value !== undefined
  );
};

type ToJSONFunction = (targetType: MessageType, value: string) => unknown;
const exceptionalTypeURLs = new Map<string, ToJSONFunction>();

// ----------------------------------------------------------------------------
// if exceptional logic is required to unpack specific object, refer to the below code
// however, it's not used anywhere for now
// ----------------------------------------------------------------------------
// const paymentAuthExtensionToJSON = (
//   targetType: MessageType,
//   value: string
// ): unknown => {
//   // expected response
//   // {
//   //   "@type": "/extension.auth.PaymentAuthExtension",
//   //   "sign_type": "SIGNTYPE_PERSONAL_SIGN"
//   // }
//   return {
//     '@type': `/${targetType.$type}`,
//     sign_type: fromBase64(value),
//   };
// };
// exceptionalTypeURLs.set(PaymentAuthExtension.$type, paymentAuthExtensionToJSON);

const toJSON = (targetType: MessageType, value: string): unknown => {
  const targetValue = bytesFromBase64(value);
  const decoded = targetType.decode(targetValue);
  const jsonObj = targetType.toJSON(decoded);

  // add @type
  (jsonObj as any)['@type'] = `/${decoded.$type}`;
  return jsonObj;
};

const unpackAny = (value: any): unknown | undefined => {
  // get target type from typeUrl
  // Note: if typeUrl includes `/` it must be removed
  const typeUrls = (value.typeUrl as string).split('/');
  const targetUrl =
    typeUrls.length == 1
      ? typeUrls[0]
      : typeUrls.length == 2
      ? typeUrls[1]
      : '';
  if (!messageTypeRegistry.has(targetUrl)) return undefined;
  const targetType = messageTypeRegistry.get(targetUrl);
  if (targetType === undefined) return undefined;

  // decode value by target type
  // Note: decode pattern must be changed by typeUrl
  if (exceptionalTypeURLs.has(targetUrl)) {
    const targetFn = exceptionalTypeURLs.get(targetUrl);
    if (targetFn !== undefined)
      return targetFn(targetType, value.value as string);
  } else {
    return toJSON(targetType, value.value as string);
  }
  return undefined;
};

const decodeAnyFromJSON = (target: any): unknown => {
  return mapObject(
    target,
    (key: any, value: any) => {
      // check value
      if (Array.isArray(value)) {
        const anyList = value;
        anyList.forEach((anyObj, idx) => {
          if (isAny(anyObj)) {
            const result = unpackAny(anyObj);
            if (result !== undefined) anyList[idx] = result;
          }
        });
        return [key, anyList];
      } else if (isAny(value)) {
        // object
        const result = unpackAny(value);
        if (result !== undefined) return [key, result];
      }

      // return
      //return mapObjectSkip; //when skipping
      return [key, value];
    },
    { deep: true }
  ) as unknown;
};

export { decodeAnyFromJSON };

```

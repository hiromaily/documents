# zodを使ってtype guard functionsを作成する

- [Typescript: Type guards with zod](https://dev.to/sachitsac/typescript-type-guards-with-zod-1m12)

```ts
import z from "zod";
import { invalidUser, invalidUserUuid, logisUesr, mockedCorrectUser } from "./test_data"

const userSchema = z.object({
  uuid: z.string().uuid(),
  name: z.string().optional(),
  email: z.string().email(),
  verified: z.boolean().default(false),
})

type User = z.infer<typeof userSchema>;
// interface User {
//   name: string;
//   email: string;
//   uuid: string;
//   verified: boolean;
// }

const isUser = (obj: any): obj is User => {
  if (!userSchema.safeParse(obj).success) return false;
  return true;
}

logIsUser(mockedCorrectUser, isUser);
logIsUser(invalidUser, isUser);
logIsUser(invalidUserUuid, isUser);
```

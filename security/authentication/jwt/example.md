# Node.jsでJWTを使用した基本的な認証フローの例

## Node.jsによるトークン発行

```js
const jwt = require('jsonwebtoken');
const secret = 'your-256-bit-secret';

const token = jwt.sign(
  {
    sub: '1234567890',
    name: 'John Doe',
    admin: true
  },
  secret,
  { expiresIn: '1h' }
);

console.log(token);
```

## Node.jsによるトークンの検証

```js
const jwt = require('jsonwebtoken');
const secret = 'your-256-bit-secret';
const token = 'JWT-TOKEN-HERE';

try {
  const decoded = jwt.verify(token, secret);
  console.log(decoded);
} catch (err) {
  console.error('Invalid token', err);
}
```

これにより、JWTを使った認証の基本的なロジックを実装できる。JWTは、そのシンプルさと柔軟性によって、多くの現代的な認証システムで重宝されている。

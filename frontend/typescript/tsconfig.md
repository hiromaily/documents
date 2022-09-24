# tsconfig

## `tsconfig.json`
### import pathの絶対指定
```json
{
  "baseUrl": "./",
  "paths": {
      "@/*": ["./src/*"]
  }
}
```

```tsx
import moduleA from '@/modules/A'
```
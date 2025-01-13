# git hooks

- [husky](https://github.com/typicode/husky) + [lint-staged](https://github.com/lint-staged/lint-staged)
- [lefthook](https://github.com/evilmartians/lefthook)
  
## lefthook

### monorepo構成時、repository単位で実行することは可能か？

[参考](https://github.com/evilmartians/lefthook/blob/master/docs/configuration.md)

```yml
pre-commit:
  # 各コマンドを並列実行する
  parallel: true
  commands:
    backend-lint-format:
      root: "backend/"
      glob: "**/*.{ts}"
      run: |
        npx tsc -b --dry --force && npm run lint && npm run format && npm run test && npm run check:dip-dependencies
      stage_fixed: true
    frontend-lint-format:
      root: "frontend/"
      glob: "**/*.{ts,tsx}"
      run: |
        npx tsc -b --dry --force && npm run lint:fix && npm run format && npm run test
      stage_fixed: true
    mock-backend-lint-format:
      root: "mock/"
      glob: "**/*.{ts}"
      run: |
        npx tsc -b --dry --force && npm run lint:fix && npm run format && npm run test
      stage_fixed: true
    shaerd-lint-format:
      root: "shared/"
      glob: "**/*.{ts}"
      run: |
        npx tsc -b --dry --force && npm run lint:fix && npm run format && npm run test
      stage_fixed: true
    sheared-prisma-lint-format:
      root: "shared-prisma/"
      glob: "**/*.{ts}"
      run: |
        npx tsc -b --dry --force && npm run lint:fix && npm run format
      stage_fixed: true
    line-frontend-lint-format:
      root: "line_frontend/"
      glob: "**/*.{ts,tsx}"
      run: |
        npx tsc -b --dry --force && npm run lint:fix && npm run format && npm run test
      stage_fixed: true
    batch:
      root: "batch/"
      glob: "**/*.{go}"
      run: |
        make lint test it
    line-backend-lint-format:
      root: "line_backend/"
      glob: "**/*.{ts}"
      run: |
        npx tsc -b --dry --force && npm run lint && npm run format && npm run test
      stage_fixed: true
    webhook-lint-format:
      root: "webhook/"
      glob: "**/*.{ts}"
      run: |
        npx tsc -b --dry --force && npm run lint && npm run format
      stage_fixed: true
```

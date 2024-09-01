# Bun with Monorepo

[Docs Package manager](https://bun.sh/guides/install)

- Add a dependency with Bun
- Add a Git dependency with Bun
- Add a peer dependency with Bun
- Add a tarball dependency with Bun
- Add a trusted dependency with Bun
- Add an optional dependency with Bun
- Add a development dependency with Bun
- Generate a human-readable lockfile with Bun
- Configuring a monorepo using workspaces with Bun
- Install a package under a different name with Bun
- Configure git to diff Bun's lockb lockfile
- Install dependencies with Bun in GitHub Actions
- Override the default npm registry for bun install
- Using bun install with an Azure Artifacts npm registry
- Configure a private registry for an organization scope with bun install

## [Configuring a monorepo using workspaces with Bun](https://bun.sh/guides/install/workspaces)

- root package.json

```json
{
  "name": "my-monorepo",
  "private": true,
  "workspaces": ["packages/*"]
}
```

- workspace

```json
{
  "name": "stuff-b",
  "dependencies": {
    "stuff-a": "workspace:*"
  }
}
```

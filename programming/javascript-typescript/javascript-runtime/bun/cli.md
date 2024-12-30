# Bun CLI

`package.json` の scripts は、`bun <task-name>` or `bun run <task-name>`のいずれでも実行できる

- `bun run`: JavaScript または TypeScript ファイルを実行
  - `bun run index.tsx` :# TS and JSX supported out of the box
  - `bun run start` : `start`という script を実行
- `bun install`: package.json の 依存を install
- `bun install --frozen-lockfile`: package.json の 依存を clean install
- `bun install --global`: global install
- `bun add <pkg>`: パッケージの 追加
- `bun add -d <pkg>`: パッケージの dev install
- `bun test`: 組み込みテストフレームワークでユニットテストを実行
- `bun build ./index.tsx`: ブラウザのための project をバンドルする
- `bunx cowsay 'Hello, world！`: dependencies として install されているバイナリを実行する

## `--help`の確認 (version: 1.1.26)

- `bun --help`

```sh
❯ bun --help
Bun is a fast JavaScript runtime, package manager, bundler, and test runner. (1.1.26+0a37423ba)

Usage: bun <command> [...flags] [...args]

Commands:
  run       ./my-script.ts       Execute a file with Bun
            lint                 Run a package.json script
  test                           Run unit tests with Bun
  x         vite                 Execute a package binary (CLI), installing if needed (bunx)
  repl                           Start a REPL session with Bun
  exec                           Run a shell script directly with Bun

  install                        Install dependencies for a package.json (bun i)
  add       zod                  Add a dependency to package.json (bun a)
  remove    jquery               Remove a dependency from package.json (bun rm)
  update    tailwindcss          Update outdated dependencies
  outdated                       Display latest versions of outdated dependencies
  link      [<package>]          Register or link a local npm package
  unlink                         Unregister a local npm package
  patch <pkg>                    Prepare a package for patching
  pm <subcommand>                Additional package management utilities

  build     ./a.ts ./b.jsx       Bundle TypeScript & JavaScript into a single file

  init                           Start an empty Bun project from a blank template
  create    svelte               Create a new project from a template (bun c)
  upgrade                        Upgrade to latest version of Bun.
  <command> --help               Print help text for command.

Flags:
      --watch                    Automatically restart the process on file change
      --hot                      Enable auto reload in the Bun runtime, test runner, or bundler
      --no-clear-screen          Disable clearing the terminal screen on reload when --hot or --watch is enabled
      --smol                     Use less memory, but run garbage collection more often
  -r, --preload                  Import a module before other modules are loaded
      --inspect                  Activate Bun's debugger
      --inspect-wait             Activate Bun's debugger, wait for a connection before executing
      --inspect-brk              Activate Bun's debugger, set breakpoint on first line of code and wait
      --if-present               Exit without an error if the entrypoint does not exist
      --no-install               Disable auto install in the Bun runtime
      --install                  Configure auto-install behavior. One of "auto" (default, auto-installs when no node_modules), "fallback" (missing packages only), "force" (always).
  -i                             Auto-install dependencies during execution. Equivalent to --install=fallback.
  -e, --eval                     Evaluate argument as a script
      --print                    Evaluate argument as a script and print the result
      --prefer-offline           Skip staleness checks for packages in the Bun runtime and resolve from disk
      --prefer-latest            Use the latest matching versions of packages in the Bun runtime, always checking npm
  -p, --port                     Set the default port for Bun.serve
      --conditions               Pass custom conditions to resolve
      --fetch-preconnect         Preconnect to a URL while code is loading
      --silent                   Don't print the script command
  -v, --version                  Print version and exit
      --revision                 Print version with revision and exit
      --filter                   Run a script in all workspace packages matching the pattern
  -b, --bun                      Force a script or package to use Bun's runtime instead of Node.js (via symlinking node)
      --shell                    Control the shell used for package.json scripts. Supports either 'bun' or 'system'
      --env-file                 Load environment variables from the specified file(s)
      --cwd                      Absolute path to resolve files & entry points from. This just changes the process' cwd.
  -c, --config                   Specify path to Bun config file. Default $cwd/bunfig.toml
  -h, --help                     Display this menu and exit
```

- `bun pm --help`

```sh
❯ bun pm --help
bun pm: Package manager utilities

  bun pm bin                print the path to bin folder
  └  -g                     print the global path to bin folder
  bun pm ls                 list the dependency tree according to the current lockfile
  └  --all                  list the entire dependency tree according to the current lockfile
  bun pm hash               generate & print the hash of the current lockfile
  bun pm hash-string        print the string used to hash the lockfile
  bun pm hash-print         print the hash stored in the current lockfile
  bun pm cache              print the path to the cache folder
  bun pm cache rm           clear the cache
  bun pm migrate            migrate another package manager's lockfile without installing anything
  bun pm untrusted          print current untrusted dependencies with scripts
  bun pm trust names ...    run scripts for untrusted dependencies and add to `trustedDependencies`
  └  --all                  trust all untrusted dependencies
  bun pm default-trusted    print the default trusted dependencies list

Learn more about these at https://bun.sh/docs/cli/pm
```

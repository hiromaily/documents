# truffle

- [Docs](https://trufflesuite.com/)

## Debug

- txID を取得後、以下のコマンドを実行する
  - network name は`truffle-config.js`の定義より取得

```
npx truffle debug <txID> --network <network-name>
```

### Migration

```
npx truffle migrate --network development

npx truffle migrate --network development --reset

npx truffle migrate -f 2 --to 2 --network development --reset
```

### Debug Command

```
Commands:
(enter) last command entered (step next)
(o) step over, (i) step into, (u) step out, (n) step next
(c) continue until breakpoint, (Y) reset & continue to previous error
(y) (if at end) reset & continue to final error
(;) step instruction (include number to step multiple)
(g) turn on generated sources, (G) turn off generated sources except via `;`
(p) print instruction & state (`p [mem|cal|sto]*`; see docs for more)
(l) print additional source context, (s) print stacktrace, (h) print this help
(q) quit, (r) reset, (t) load new transaction, (T) unload transaction
(b) add breakpoint (`b [[<source-file>:]<line-number>]`; see docs for more)
(B) remove breakpoint (similar to adding, or `B all` to remove all)
(+) add watch expression (`+:<expr>`), (-) remove watch expression (-:<expr>)
(?) list existing watch expressions and breakpoints
(v) print variables and values, (:) evaluate expression - see `v`
```
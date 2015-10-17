
Cirru WASM AST transfomer
----

Working in progress...

Based on the work of https://github.com/indutny/wasm-ast

### Usage

```coffee
transformer = require 'cirru-wasm-ast'
transformer.parse '\ (void test) ((i64 a))'
# returns AST defined in wasm-ast
```

Read `exmaples/` for details.

### License

MIT

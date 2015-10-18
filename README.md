
Cirru WASM AST transfomer
----

Based on the work of https://github.com/indutny/wasm-ast

Working in progress...

```cirru
✓ index-params
✓ parse-64bit-literal
✓ parse-AssignmentExpression
✓ parse-IfStatement
✓ parse-SequenceExpression
✓ parse-VariableDeclaration
✓ parse-basic-function
✓ parse-blockless-IfStatement
✓ parse-builtin-statement
✗ parse-call-statement
✓ parse-do_while-loop
✓ parse-empty-ReturnStatement
✓ parse-export-import
✓ parse-forever-loop-with-break-continue
✓ parse-forever-loop
✓ parse-literal
```

### Usage

```coffee
transformer = require 'cirru-wasm-ast'
transformer.parse '\ (void test) ((i64 a))'
# returns AST defined in wasm-ast
```

Read `exmaples/` for details.

### License

MIT

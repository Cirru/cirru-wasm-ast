module.exports = [
  {
    type: 'ExpressionStatement',
    expression: {
      type: 'CallExpression',
      fn: { type: 'FunctionRef', name: 'test', index: 1 },
      arguments: [ { type: 'Param', name: 'a', index: 0 } ]
    }
  }
]
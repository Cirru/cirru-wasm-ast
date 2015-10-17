module.exports = [
  {
    type: 'ExpressionStatement',
    expression: {
      type: 'AssignmentExpression',
      operator: '=',
      left: { type: 'Identifier', name: 'a' },
      right: {
        type: 'AssignmentExpression',
        operator: '=',
        left: { type: 'Identifier', name: 'b' },
        right: { type: 'Identifier', name: 'c' }
      }
    }
  }

]
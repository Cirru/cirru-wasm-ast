BN = require('bn.js');

module.exports = [
  {
    type: 'VariableDeclaration',
    id: {
      name: 't',
      type: 'Identifier'
    },
    result: {
      type: 'Type',
      name: 'i64'
    },
    init: {
      type: 'Builtin',
      result: { type: 'Type', name: 'i64' },
      method: 'const',
      arguments: [ {
        type: 'Literal',
        value: new BN(1)
      } ]
    }
  },
  {
    type: 'ForeverStatement',
    body: {
      type: 'BlockStatement',
      body: [
        {
          type: 'ExpressionStatement',
          expression: {
            type: 'AssignmentExpression',
            operator: '=',
            left: { type: 'Identifier', name: 't' },
            right: {
              type: 'Builtin',
              result: { type: 'Type', name: 'i64' },
              method: 'add',
              arguments: [ {
                type: 'Identifier', name: 't'
              }, {
                type: 'Identifier', name: 't'
              } ]
            }
          }
        }
      ]
    }
  },
  {
    type: 'ReturnStatement',
    argument: { type: 'Identifier', name: 't' }
  }

]
BN = require('bn.js');

module.exports = [
  {
    type: 'ReturnStatement',
    argument: {
      type: 'SequenceExpression',
      expressions: [
        {
          type: 'Builtin',
          result: { type: 'Type', name: 'i64' },
          method: 'const',
          arguments: [ {
            type: 'Literal',
            value: new BN(1)
          } ]
        },
        {
          type: 'Builtin',
          result: { type: 'Type', name: 'i64' },
          method: 'const',
          arguments: [ {
            type: 'Literal',
            value: new BN(2)
          } ]
        },
        {
          type: 'Builtin',
          result: { type: 'Type', name: 'i64' },
          method: 'const',
          arguments: [ {
            type: 'Literal',
            value: new BN(3)
          } ]
        }
      ]
    }
  }
]
BN = require('bn.js');

module.exports = [
  {
    id: {
      name: 'a',
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
    },
    type: 'VariableDeclaration'
  },
  {
    id: {
      name: 'b',
      type: 'Identifier'
    },
    result: {
      type: 'Type',
      name: 'i64'
    },
    init: null,
    type: 'VariableDeclaration'
  }

]
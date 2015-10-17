BN = require('bn.js');

exports = [
  {
    type: 'ReturnStatement',
    argument: {
      type: 'Builtin',
      result: { type: 'Type', name: 'i64' },
      method: 'const',
      arguments: [ {
        type: 'Literal',
        value: new BN('deadbeefabbadead', 16)
      } ]
    }
  }
]
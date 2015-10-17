BN = require('bn.js');

module.exports = [
  {
     type: 'IfStatement',
     test: { type: 'Identifier', name: 'a' },
     consequent: {
       type: 'BlockStatement',
       body: [ {
         type: 'ReturnStatement',
         argument: { type: 'Identifier', name: 'a' }
       } ]
     },
     alternate: {
       type: 'ReturnStatement',
       argument: {
         type: 'Builtin',
         result: { type: 'Type', name: 'i64' },
         method: 'const',
         arguments: [ {
           type: 'Literal',
           value: new BN(1)
         } ]
       }
     }
   }
]
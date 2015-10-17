module.exports = {
  type: 'Program',
  body: [
    {
      type: 'Function',
      localCount: 0,
      name: { type: 'Identifier', name: 'mul' },
      params: [ {
        type: 'ParamDeclaration',
        result: { type: 'Type', name: 'i32' },
        name: { type: 'Identifier', name: 'a' }
      }, {
        type: 'ParamDeclaration',
        result: { type: 'Type', name: 'i32' },
        name: { type: 'Identifier', name: 'b' }
      } ],
      result: { type: 'Type', name: 'i64' },
      body: [
        {
          type: 'ReturnStatement',
          argument: {
            type: 'Builtin',
            result: { type: 'Type', name: 'i64' },
            method: 'mul',
            arguments: [ {
              type: 'Builtin',
              result: { type: 'Type', name: 'i64' },
              method: 'extend_u',
              arguments: [ { type: 'Identifier', name: 'a' } ]
            }, {
              type: 'Builtin',
              result: { type: 'Type', name: 'i64' },
              method: 'extend_u',
              arguments: [ { type: 'Identifier', name: 'b' } ]
            } ]
          }
        }
      ]
    }
  ]
}

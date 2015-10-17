module.exports = {
  type: 'Program',
  body: [
    {
      type: 'Function',
      localCount: 0,
      name: { type: 'FunctionRef', name: 'second', index: 0 },
      params: [
        {
          type: 'ParamDeclaration',
          result: { type: 'Type', name: 'i32' },
          name: { type: 'Param', name: 'a', index: 0 }
        },
        {
          type: 'ParamDeclaration',
          result: { type: 'Type', name: 'i32' },
          name: { type: 'Param', name: 'b', index: 1 }
        },
        {
          type: 'ParamDeclaration',
          result: { type: 'Type', name: 'i32' },
          name: { type: 'Param', name: 'c', index: 2 }
        }
      ],
      result: { type: 'Type', name: 'i64' },
      body: [
        {
          type: 'ReturnStatement',
          argument: {
            type: 'Param', name: 'b', index: 1
          }
        }
      ]
    }
  ]

}
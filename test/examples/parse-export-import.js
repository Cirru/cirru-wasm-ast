module.exports = {
  type: 'Program',
  body: [
    {
      type: 'ImportStatement',
      names: [
        { type: 'External', module: 'std', name: 'resize_memory' },
        { type: 'External', module: 'std', name: 'log' }
      ],
      module: { type: 'Identifier', name: 'std' }
    },
    {
      type: 'Function',
      result: { type: 'Type', name: 'void' },
      name: { type: 'Identifier', name: 'mul' },
      params: [
        {
          type: 'ParamDeclaration',
          result: { type: 'Type', name: 'i32' },
          name: { type: 'Identifier', name: 'a' }
        },
        {
          type: 'ParamDeclaration',
          result: { type: 'Type', name: 'i32' },
          name: { type: 'Identifier', name: 'b' }
        }
      ],
      body: [ {
        type: 'ExpressionStatement',
        expression: {
          type: 'CallExpression',
          fn: { type: 'External', module: 'std', name: 'resize_memory' },
          arguments: [ { type: 'Identifier', name: 'a' } ]
        }
      } ],
      localCount: 0
    },
    {
      type: 'Function',
      result: { type: 'Type', name: 'void' },
      name: { type: 'Identifier', name: 'div' },
      params: [
        {
          type: 'ParamDeclaration',
          result: { type: 'Type', name: 'i32' },
          name: { type: 'Identifier', name: 'a' }
        },
        {
          type: 'ParamDeclaration',
          result: { type: 'Type', name: 'i32' },
          name: { type: 'Identifier', name: 'b' }
        }
      ],
      body: [ {
        type: 'ExpressionStatement',
        expression: {
          type: 'CallExpression',
          fn: { type: 'External', module: 'std', name: 'assert' },
          arguments: [ { type: 'Identifier', name: 'a' } ]
        }
      } ],
      localCount: 0
    },
    {
      type: 'ExportStatement',
      names: [
        { type: 'Identifier', name: 'mul' },
        { type: 'Identifier', name: 'div' }
      ]
    }
  ]

}
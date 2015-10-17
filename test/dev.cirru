
var
  transformer $ require :../src/transformer

var name :index-params
var source $ require $ + :../examples/ name :.cirru
var data $ require $ + :../examples/ name

console.log $ JSON.stringify (transformer.parse source) null 2

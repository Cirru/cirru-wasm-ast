
var
  transformer $ require :../src/transformer

var name :parse-call-statement
var source $ require $ + :../examples/ name :.cirru
var data $ require $ + :../examples/ name

console.log $ JSON.stringify (transformer.parse source) null 2
console.log $ transformer.parse source

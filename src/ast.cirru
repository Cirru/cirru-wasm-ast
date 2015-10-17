
-- from wasm-ast 3.0.1
-- https://github.com/indutny/wasm-ast/blob/master/test/parser-test.js

var
  Immutable $ require :immutable
  fromJS Immutable.fromJS

= exports.AssignmentExpression $ fromJS $ {}
  :type :AssignmentExpression
  :operator :=
  :left undefined
  :right undefined

= exports.BlockStatement $ fromJS $ {}
  :type :BlockStatement
  :body $ []

= exports.BreakStatement $ fromJS $ {}
  :type :BreakStatement

= exports.Builtin $ fromJS $ {}
  :type :Builtin
  :result undefined
  :method :undefined
  arguments $ []

= exports.CallExpression $ fromJS $ {}
  :type :CallExpression
  :fn undefined
  :arguments $ []

= exports.ContinueStatement $ fromJS $ {}
  :type :ContinueStatement

= exports.DoWhileStatement $ fromJS $ {}
  :type :DoWhileStatement
  :test undefined
  :body undefined

= exports.ExportStatement $ fromJS $ {}
  :type :ExportStatement
  :names $ []

= exports.ExpressionStatement $ fromJS $ {}
  :type :ExportStatement
  :expression undefined

= exports.External $ fromJS $ {}
  :type :External
  :module undefined
  :name undefined

= exports.ForeverStatement $ fromJS $ {}
  :type :ForeverStatement
  :body :undefined

= exports.Function $ fromJS $ {}
  :type :Function
  :name :undefined
  :result :undefined
  :params $ []
  :body $ []

= exports.FunctionRef $ fromJS $ {}
  :type :FunctionRef
  :name undefined
  :index undefined

= exports.Identifier $ fromJS $ {}
  :type :Identifier
  :name undefined

= exports.IfStatement $ fromJS $ {}
  :type :IfStatement
  :test :undefined
  :consequent undefined
  :alternate undefined

= exports.ImportStatement $ fromJS $ {}
  :type :ImportStatement
  :names $ []

= exports.Literal $ fromJS $ {}
  :type :Literal
  :value undefined

= exports.Param $ fromJS $ {}
  :type :Param
  :name undefined
  :index undefined

= exports.ParamDeclaration $ fromJS $ {}
  :type :ParamDeclaration
  :result undefined
  :name undefined

= exports.Program $ fromJS $ {}
  :type :Program
  :body $ []

= exports.ReturnStatement $ fromJS $ {}
  :type :ReturnStatement
  :argument undefined

= exports.SequenceExpression $ fromJS $ {}
  :type :SequenceExpression
  :expressions $ []

= exports.Type $ fromJS $ {}
  :type :Type
  :name undefined

= exports.VariableDeclaration $ fromJS $ {}
  :type :VariableDeclaration
  :id undefined
  :result undefined
  init undefined

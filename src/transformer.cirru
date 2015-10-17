
var
  BN $ require :bn.js
  Immutable $ require :immutable
  parser $ require :cirru-parser

var
  ast $ require :./ast

var
  fromJS Immutable.fromJS

= exports.parse $ \ (code filename)
  var tree $ fromJS $ parser.pare code $ or filename :
  exports.transform tree

= exports.transform $ \ (tree)
  var result $ ast.Program.set :body
    transformLines tree
  result.toJS

var bind $ \ (v k) (k v)

var transform $ \ (tree inline)
  case (typeof tree)
    :string $ transformToken tree
    else $ bind (tree.get 0) $ \ (operator) $ case operator
      :\ $ transformFunction tree
      :return $ transformReturn tree
      := $ cond inline
        transformAssignment tree
        ast.ExpressionStatement.set :expression
          transformAssignment tree
      :if $ transformIf tree
      :sequence $ transformSequence tree
      :var $ transformVariable tree
      :do $ transformBlock tree
      :do-while $ transformDoWhile tree
      :forever $ transformForever tree
      :continue $ transformContinue tree
      :break $ transformBreak tree
      :export $ transformExport tree
      :import $ transformImport tree
      else $ case true
        (? $ operator.match /^i64\.) $ transformBuiltin tree
        (? $ operator.match /^i32\.) $ transformBuiltin tree
        (? $ operator.match /^addr\.) $ transformBuiltin tree
        else :UNKNOWN

var transformFunction $ \ (tree)
  var functionName $ tree.get 1
  var argumentItems $ tree.get 2
  var body $ tree.slice 3
  ... ast.Function
    set :name $ ... ast.FunctionRef
      set :name $ functionName.get 1
      set :index 0
    set :result $ ast.Type.set :name $ functionName.get 0
    set :params $ argumentItems.map $ \ (item index)
      ... ast.ParamDeclaration
        set :result $ ast.Type.set :name $ item.get 0
        set :name $ ... ast.Param
          set :name $ item.get 1
          set :index index
    set :body $ transformLines body

var transformReturn $ \ (tree)
  var argument $ tree.get 1
  ast.ReturnStatement.set :argument
    cond (? argument)
      transform argument true
      , null

var transformToken $ \ (token)
  case true
    (? $ token.match /^0x) $ ast.Literal.set :value $ new BN token 16
    (? $ token.match /^\d) $ ast.Literal.set :value $ new BN token 16
    (? $ token.match /^\w) $ ast.Identifier.set :name token
    else :UNKNOWN

var transformBuiltin $ \ (tree)
  var
    operator $ tree.get 0
    argumentItems $ tree.slice 1
    pieces $ operator.split :.
    typeName $ . pieces 0
    method $ . pieces 1
  ... ast.Builtin
    set :result $ ast.Type.set :name typeName
    set :method method
    set :arguments $ argumentItems.map transform

var transformAssignment $ \ (tree)
  ... ast.AssignmentExpression
    set :left $ transform $ tree.get 1
    set :right $ transform $ tree.get 2

var transformIf $ \ (tree)
  var
    condition $ tree.get 1
    consequent $ tree.get 2
    alternate $ tree.get 3
  ... ast.IfStatement
    set :test $ transform condition
    set :consequent $ transform consequent
    set :alternate $ transform alternate

var transformSequence $ \ (tree)
  ast.SequenceExpression.set :expressions
    tree.map transform

var transformVariable $ \ (tree)
  var
    name $ tree.get 1
    init $ tree.get 2
  ... ast.VariableDeclaration
    set :id $ transform $ name.get 1
    set :result $ ast.Type.set :name $ name.get 0
    set :init $ cond (? init)
      transform init true
      , null

var transformBlock $ \ (tree)
  ast.BlockStatement.set :body
    transformLines $ tree.slice 1

var transformDoWhile $ \ (tree)
  var
    condition $ tree.get 1
    body $ tree.slice 2
  ... ast.DoWhileStatement
    set :test $ transform condition
    set :body $ body.map transform

var transformForever $ \ (tree)
  ast.ForeverStatement.set :body
    transform $ tree.get 1

var transformLines $ \ (tree)
  ... tree
    filterNot $ \ (line)
      is (line.get 0) :--
    map transform

var transformContinue $ \ (tree)
  , ast.ContinueStatement

var transformBreak $ \ (tree)
  , ast.BreakStatement

var transformExport $ \ (tree)
  var names $ tree.slice 1
  ast.ExportStatement.set :names
    names.map transform

var transformImport $ \ (tree)
  var
    module $ tree.get 1
    names $ tree.get 2
  ... ast.ImportStatement
    set :module module
    set :names $ names.map transform

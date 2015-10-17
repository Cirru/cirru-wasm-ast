
var
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
    tree.map transform
  result.toJS

var transform $ \ (tree)
  case (typeof tree)
    :string $ transformToken tree
    else $ case (tree.get 0)
      :\ $ transformFunction tree
      :return $ transformReturn tree
      else :unknown

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
    set :body $ body.map transform

var transformReturn $ \ (tree)
  var argument $ tree.get 1
  ast.ReturnStatement.set :argument
    transform argument

var transformToken $ \ (tree)
  ast.Identifier.set :name tree


var
  BN $ require :bn.js
  Immutable $ require :immutable
  parser $ require :cirru-parser

var
  ast $ require :./ast

var
  fromJS Immutable.fromJS

var
  extract $ \ (state)
    state.get :result

= exports.parse $ \ (code filename)
  var tree $ fromJS $ parser.pare code $ or filename :
  var initialState $ fromJS $ {}
    :functions $ {}
    :externals $ {}
    :variables $ {}
    :result null
  transformProgram initialState tree

var transformProgram $ \ (initialState tree)
  var result $ ast.Program.set :body
    extract $ transformLines initialState tree
  result.toJS

var bind $ \ (v k) (k v)

var transform $ \ (state tree inline)
  console.log
    JSON.stringify $ state.get :functions
  case (typeof tree)
    :string $ transformToken state tree
    else $ bind (tree.get 0) $ \ (operator) $ case operator
      :\ $ transformFunction state tree
      :return $ transformReturn state tree
      := $ cond inline
        transformAssignment state tree
        ast.ExpressionStatement.set :expression
          transformAssignment state tree
      :if $ transformIf state tree
      :sequence $ transformSequence state tree
      :var $ transformVariable state tree
      :do $ transformBlock state tree
      :do-while $ transformDoWhile state tree
      :forever $ transformForever state tree
      :continue $ transformContinue state tree
      :break $ transformBreak state tree
      :export $ transformExport state tree
      :import $ transformImport state tree
      else $ case true
        (? $ operator.match /^i64\.) $ transformBuiltin state tree
        (? $ operator.match /^i32\.) $ transformBuiltin state tree
        (? $ operator.match /^addr\.) $ transformBuiltin state tree
        (? $ operator.match /::) $ transformExternal state tree
        (state.hasIn $ [] :externals operator)
          cond inline
            transformCallExternal state tree
            state.set :result $ ast.ExpressionStatement.set :expression
              extract $ transformCallExternal state tree
        (state.hasIn $ [] :functions operator)
          cond inline
            transformCallFunction state tree
            state.set :result $ ast.ExpressionStatement.set :expression
              extract $ transformCallFunction state tree
        else $ state.set :result :UNKNOWN

var transformFunction $ \ (state tree)
  var functionItem $ tree.get 1
  var functionName $ functionItem.get 1
  var argumentItems $ tree.get 2
  var body $ tree.slice 3
  ... state
    set :result $ ... ast.Function
      set :name $ ... ast.FunctionRef
        set :name functionName
        set :index 0
      set :result $ ast.Type.set :name $ functionItem.get 0
      set :params $ extract $ argumentItems.map $ \ (item index)
        ... ast.ParamDeclaration
          set :result $ ast.Type.set :name $ item.get 0
          set :name $ ... ast.Param
            set :name $ item.get 1
            set :index index
      set :body $ extract $ transformLines state body
    setIn ([] :functions functionName) $ ... ast.FunctionRef
      set :name functionName

var transformReturn $ \ (state tree)
  var argument $ tree.get 1
  state.set :result $ extract $ ast.ReturnStatement.set :argument
    cond (? argument)
      transform argument true
      , null

var transformToken $ \ (state token)
  state.set :result $ case true
    (? $ token.match /^0x) $ ast.Literal.set :value $ new BN token 16
    (? $ token.match /^\d) $ ast.Literal.set :value $ new BN token 16
    (? $ token.match /^\w) $ ast.Identifier.set :name token
    else $ state.set :result :UNKNOWN

var transformBuiltin $ \ (state tree)
  var
    operator $ tree.get 0
    argumentItems $ tree.slice 1
    pieces $ operator.split :.
    typeName $ . pieces 0
    method $ . pieces 1
  state.set :result $ ... ast.Builtin
    set :result $ ast.Type.set :name typeName
    set :method method
    set :arguments $ extract $ argumentItems.map $ \ (item)
      transform state item

var transformAssignment $ \ (state tree)
  state.set :result $ ... ast.AssignmentExpression
    set :left $ extract $ transform state $ tree.get 1
    set :right $ extract $ transform state $ tree.get 2

var transformIf $ \ (state tree)
  var
    condition $ tree.get 1
    consequent $ tree.get 2
    alternate $ tree.get 3
  state.set :result $ ... ast.IfStatement
    set :test $ extract $ transform state condition
    set :consequent $ extract $ transform state consequent
    set :alternate $ extract $ transform state alternate

var transformSequence $ \ (state tree)
  state.set :result $ ast.SequenceExpression.set :expressions
    extract $ tree.map $ \ (item)
      transform state item

var transformVariable $ \ (state tree)
  var
    name $ tree.get 1
    init $ tree.get 2
  state.set :result $ ... ast.VariableDeclaration
    extract $ set :id $ transform state $ name.get 1
    set :result $ ast.Type.set :name $ name.get 0
    set :init $ cond (? init)
      extract $ transform state init true
      , null

var transformBlock $ \ (state tree)
  state.set :result $ ast.BlockStatement.set :body
    extract $ transformLines state $ tree.slice 1

var transformDoWhile $ \ (state tree)
  var
    condition $ tree.get 1
    body $ tree.slice 2
  state.set :result $ ... ast.DoWhileStatement
    set :test $ extract $ transform state condition
    set :body $ extract $ transformLines state body

var transformForever $ \ (state tree)
  state.set :result $ ast.ForeverStatement.set :body
    extract $ transform state $ tree.get 1

var transformLines $ \ (state tree)
  ... tree
    filterNot $ \ (line)
      is (line.get 0) :--
    reduce
      \ (acc line)
        var oldResult $ acc.get :result
        var lineState $ transform acc line
        lineState.update :result $ \ (lineResult)
          oldResult.push lineResult
      state.set :result $ Immutable.List

var transformContinue $ \ (state tree)
  state.set :result ast.ContinueStatement

var transformBreak $ \ (state tree)
  state.set :result ast.BreakStatement

var transformExport $ \ (state tree)
  var names $ tree.slice 1
  state.set :result $ ast.ExportStatement.set :names
    names.map $ \ (name)
      extract $ transform state name

var transformImport $ \ (state tree)
  var
    module $ tree.get 1
    names $ tree.get 2
  ... state
    update :externals $ \ (externals)
      names.reduce
        \ (acc name)
          acc.set name $ ... ast.External
            set :module $ ast.Identifier.set :name module
            set :name $ ast.Identifier.set :name name
        , externals
    set :result $ ... ast.ImportStatement
      set :module $ ast.Identifier.set :name module
      set :names $ names.map $ \ (name)
        extract $ transform state name

var transformCallExternal $ \ (state tree)
  var operator $ tree.get 0
  var fn $ state.getIn $ [] :externals operator
  var argumentItems $ tree.slice 1
  state.set :result $ ... ast.CallExpression
    set :fn fn
    set :arguments $ argumentItems.map $ \ (item)
      extract $ transform state item

var transformCallFunction $ \ (state tree)
  var operator $ tree.get 0
  var fn $ state.getIn $ [] :functions operator
  var argumentItems $ tree.slice 1
  state.set :result $ ... ast.CallExpression
    set :fn fn
    set :arguments $ argumentItems.map $ \ (item)
      extract $ transform state item

var transformExternal $ \ (state tree)
  var
    operator $ tree.get 0
    pieces $ operator.split :::
    module $ . pieces 0
    name $ . pieces 1
    argumentItems $ tree.slice 1
  state.set :result $ ... ast.CallExpression
    set :fn $ ... ast.External
      set :module $ ast.Identifier.set :name module
      set :name $ ast.Identifier.set :name name
    set :arguments $ argumentItems.map $ \ (item)
      extract $ transform state item

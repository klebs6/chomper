
Expression :
      ExpressionWithoutBlock
   | ExpressionWithBlock

ExpressionWithoutBlock :
   OuterAttribute*†
   (
         LiteralExpression
      | PathExpression
      | OperatorExpression
      | GroupedExpression
      | ArrayExpression
      | AwaitExpression
      | IndexExpression
      | TupleExpression
      | TupleIndexingExpression
      | StructExpression
      | CallExpression
      | MethodCallExpression
      | FieldExpression
      | ClosureExpression
      | ContinueExpression
      | BreakExpression
      | RangeExpression
      | ReturnExpression
      | MacroInvocation
   )

ExpressionWithBlock :
   OuterAttribute*†
   (
         BlockExpression
      | AsyncBlockExpression
      | UnsafeBlockExpression
      | LoopExpression
      | IfExpression
      | IfLetExpression
      | MatchExpression
   )

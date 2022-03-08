
BlockExpression :
   {
      InnerAttribute*
      Statements?
   }

Statements :
      Statement+
   | Statement+ ExpressionWithoutBlock
   | ExpressionWithoutBlock

AsyncBlockExpression :
   async move? BlockExpression


UnsafeBlockExpression :
   unsafe BlockExpression

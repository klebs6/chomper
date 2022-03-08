
LoopExpression :
   LoopLabel? (
         InfiniteLoopExpression
      | PredicateLoopExpression
      | PredicatePatternLoopExpression
      | IteratorLoopExpression
   )

InfiniteLoopExpression :
   loop BlockExpression

PredicateLoopExpression :
   while Expressionexcept struct expression BlockExpression

PredicatePatternLoopExpression :
   while let Pattern = Scrutineeexcept lazy boolean operator expression BlockExpression

IteratorLoopExpression :
   for Pattern in Expressionexcept struct expression BlockExpression

LoopLabel :
   LIFETIME_OR_LABEL :

BreakExpression :
   break LIFETIME_OR_LABEL? Expression?

ContinueExpression :
   continue LIFETIME_OR_LABEL?

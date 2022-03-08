
Statement :
      ;
   | Item
   | LetStatement
   | ExpressionStatement
   | MacroInvocationSemi

LetStatement :
   OuterAttribute* let PatternNoTopAlt ( : Type )? (= Expression )? ;

ExpressionStatement :
      ExpressionWithoutBlock ;
   | ExpressionWithBlock ;?


ClosureExpression :
   move?
   ( || | | ClosureParameters? | )
   (Expression | -> TypeNoBounds BlockExpression)

ClosureParameters :
   ClosureParam (, ClosureParam)* ,?

ClosureParam :
   OuterAttribute* PatternNoTopAlt ( : Type )?

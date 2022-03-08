
RangeExpression :
      RangeExpr
   | RangeFromExpr
   | RangeToExpr
   | RangeFullExpr
   | RangeInclusiveExpr
   | RangeToInclusiveExpr

RangeExpr :
   Expression .. Expression

RangeFromExpr :
   Expression ..

RangeToExpr :
   .. Expression

RangeFullExpr :
   ..

RangeInclusiveExpr :
   Expression ..= Expression

RangeToInclusiveExpr :
   ..= Expression

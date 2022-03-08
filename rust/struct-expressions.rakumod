
StructExpression :
      StructExprStruct
   | StructExprTuple
   | StructExprUnit

StructExprStruct :
   PathInExpression { (StructExprFields | StructBase)? }

StructExprFields :
   StructExprField (, StructExprField)* (, StructBase | ,?)

StructExprField :
      IDENTIFIER
   | (IDENTIFIER | TUPLE_INDEX) : Expression

StructBase :
   .. Expression

StructExprTuple :
   PathInExpression (
      ( Expression (, Expression)* ,? )?
   )

StructExprUnit : PathInExpression

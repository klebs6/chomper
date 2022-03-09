
GenericArgs :
      < >
   | < ( GenericArg , )* GenericArg ,? >

GenericArg :
   Lifetime | Type | GenericArgsConst | GenericArgsBinding

GenericArgsConst :
      BlockExpression
   | LiteralExpression
   | - LiteralExpression
   | SimplePathSegment

GenericArgsBinding :
   IDENTIFIER = Type

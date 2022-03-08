
SimplePath :
   ::? SimplePathSegment (:: SimplePathSegment)*

SimplePathSegment :
   IDENTIFIER | super | self | crate | $crate

PathInExpression :
   ::? PathExprSegment (:: PathExprSegment)*

PathExprSegment :
   PathIdentSegment (:: GenericArgs)?

PathIdentSegment :
   IDENTIFIER | super | self | Self | crate | $crate

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

QualifiedPathInExpression :
   QualifiedPathType (:: PathExprSegment)+

QualifiedPathType :
   < Type (as TypePath)? >

QualifiedPathInType :
   QualifiedPathType (:: TypePathSegment)+

TypePath :
   ::? TypePathSegment (:: TypePathSegment)*

TypePathSegment :
   PathIdentSegment ::? (GenericArgs | TypePathFn)?

TypePathFn :
( TypePathFnInputs? ) (-> Type)?

TypePathFnInputs :
Type (, Type)* ,?

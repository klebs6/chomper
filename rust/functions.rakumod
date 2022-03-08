
Function :
   FunctionQualifiers fn IDENTIFIER GenericParams?
      ( FunctionParameters? )
      FunctionReturnType? WhereClause?
      ( BlockExpression | ; )

FunctionQualifiers :
   const? async1? unsafe? (extern Abi?)?

Abi :
   STRING_LITERAL | RAW_STRING_LITERAL

FunctionParameters :
      SelfParam ,?
   | (SelfParam ,)? FunctionParam (, FunctionParam)* ,?

SelfParam :
   OuterAttribute* ( ShorthandSelf | TypedSelf )

ShorthandSelf :
   (& | & Lifetime)? mut? self

TypedSelf :
   mut? self : Type

FunctionParam :
   OuterAttribute* ( FunctionParamPattern | ... | Type 2 )

FunctionParamPattern :
   PatternNoTopAlt : ( Type | ... )

FunctionReturnType :
   -> Type

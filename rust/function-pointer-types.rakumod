
BareFunctionType :
   ForLifetimes? FunctionTypeQualifiers fn
      ( FunctionParametersMaybeNamedVariadic? ) BareFunctionReturnType?

FunctionTypeQualifiers:
   unsafe? (extern Abi?)?

BareFunctionReturnType:
   -> TypeNoBounds

FunctionParametersMaybeNamedVariadic :
   MaybeNamedFunctionParameters | MaybeNamedFunctionParametersVariadic

MaybeNamedFunctionParameters :
   MaybeNamedParam ( , MaybeNamedParam )* ,?

MaybeNamedParam :
   OuterAttribute* ( ( IDENTIFIER | _ ) : )? Type

MaybeNamedFunctionParametersVariadic :
   ( MaybeNamedParam , )* MaybeNamedParam , OuterAttribute* ...



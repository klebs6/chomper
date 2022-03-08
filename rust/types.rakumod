
Type :
      TypeNoBounds
   | ImplTraitType
   | TraitObjectType

TypeNoBounds :
      ParenthesizedType
   | ImplTraitTypeOneBound
   | TraitObjectTypeOneBound
   | TypePath
   | TupleType
   | NeverType
   | RawPointerType
   | ReferenceType
   | ArrayType
   | SliceType
   | InferredType
   | QualifiedPathInType
   | BareFunctionType
   | MacroInvocation

ParenthesizedType :
   ( Type )

NeverType : !

TupleType :
      ( )
   | ( ( Type , )+ Type? )

ArrayType :
   [ Type ; Expression ]

SliceType :
   [ Type ]

ReferenceType :
   & Lifetime? mut? TypeNoBounds


RawPointerType :
   * ( mut | const ) TypeNoBounds

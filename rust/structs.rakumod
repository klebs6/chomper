
Struct :
      StructStruct
   | TupleStruct

StructStruct :
   struct IDENTIFIER  GenericParams? WhereClause? ( { StructFields? } | ; )

TupleStruct :
   struct IDENTIFIER  GenericParams? ( TupleFields? ) WhereClause? ;

StructFields :
   StructField (, StructField)* ,?

StructField :
   OuterAttribute*
   Visibility?
   IDENTIFIER : Type

TupleFields :
   TupleField (, TupleField)* ,?

TupleField :
   OuterAttribute*
   Visibility?
   Type

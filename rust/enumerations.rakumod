
Enumeration :
   enum IDENTIFIER  GenericParams? WhereClause? { EnumItems? }

EnumItems :
   EnumItem ( , EnumItem )* ,?

EnumItem :
   OuterAttribute* Visibility?
   IDENTIFIER ( EnumItemTuple | EnumItemStruct | EnumItemDiscriminant )?

EnumItemTuple :
   ( TupleFields? )

EnumItemStruct :
   { StructFields? }

EnumItemDiscriminant :
   = Expression

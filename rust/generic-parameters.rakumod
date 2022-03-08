
GenericParams :
      < >
   | < (GenericParam ,)* GenericParam ,? >

GenericParam :
   OuterAttribute* ( LifetimeParam | TypeParam | ConstParam )

LifetimeParam :
   LIFETIME_OR_LABEL ( : LifetimeBounds )?

TypeParam :
   IDENTIFIER( : TypeParamBounds? )? ( = Type )?

ConstParam:
   const IDENTIFIER : Type


WhereClause :
   where ( WhereClauseItem , )* WhereClauseItem ?

WhereClauseItem :
      LifetimeWhereClauseItem
   | TypeBoundWhereClauseItem

LifetimeWhereClauseItem :
   Lifetime : LifetimeBounds

TypeBoundWhereClauseItem :
   ForLifetimes? Type : TypeParamBounds?

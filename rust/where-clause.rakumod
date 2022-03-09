WhereClause :
   where ( WhereClauseItem , )* WhereClauseItem ?

WhereClauseItem :
      LifetimeWhereClauseItem
   | TypeBoundWhereClauseItem

LifetimeWhereClauseItem :
   Lifetime : LifetimeBounds

TypeBoundWhereClauseItem :
   ForLifetimes? Type : TypeParamBounds?


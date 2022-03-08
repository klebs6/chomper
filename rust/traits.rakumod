
Trait :
   unsafe? trait IDENTIFIER  GenericParams? ( : TypeParamBounds? )? WhereClause? {
     InnerAttribute*
     AssociatedItem*
   }

Implementation :
   InherentImpl | TraitImpl

InherentImpl :
   impl GenericParams? Type WhereClause? {
      InnerAttribute*
      AssociatedItem*
   }

TraitImpl :
   unsafe? impl GenericParams? !? TypePath for Type
   WhereClause?
   {
      InnerAttribute*
      AssociatedItem*
   }

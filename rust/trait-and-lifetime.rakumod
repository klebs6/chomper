
TypeParamBounds :
   TypeParamBound ( + TypeParamBound )* +?

TypeParamBound :
      Lifetime | TraitBound

TraitBound :
      ?? ForLifetimes? TypePath
   | ( ?? ForLifetimes? TypePath )

LifetimeBounds :
   ( Lifetime + )* Lifetime?

Lifetime :
      LIFETIME_OR_LABEL
   | 'static
   | '_

ForLifetimes :
   for GenericParams

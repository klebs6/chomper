
TypePath :
   ::? TypePathSegment (:: TypePathSegment)*

TypePathSegment :
   PathIdentSegment ::? (GenericArgs | TypePathFn)?

TypePathFn :
( TypePathFnInputs? ) (-> Type)?

TypePathFnInputs :
Type (, Type)* ,?

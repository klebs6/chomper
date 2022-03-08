
UseDeclaration :
   use UseTree ;

UseTree :
      (SimplePath? ::)? *
   | (SimplePath? ::)? { (UseTree ( , UseTree )* ,?)? }
   | SimplePath ( as ( IDENTIFIER | _ ) )?

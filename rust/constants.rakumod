
ConstantItem :
   const ( IDENTIFIER | _ ) : Type ( = Expression )? ;

StaticItem :
   static mut? IDENTIFIER : Type ( = Expression )? ;

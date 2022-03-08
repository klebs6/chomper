
ExternBlock :
   unsafe? extern Abi? {
      InnerAttribute*
      ExternalItem*
   }

ExternalItem :
   OuterAttribute* (
         MacroInvocationSemi
      | ( Visibility? ( StaticItem | Function ) )
   )

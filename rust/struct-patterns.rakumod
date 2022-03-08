
StructPattern :
   PathInExpression {
      StructPatternElements ?
   }

StructPatternElements :
      StructPatternFields (, | , StructPatternEtCetera)?
   | StructPatternEtCetera

StructPatternFields :
   StructPatternField (, StructPatternField) *

StructPatternField :
   OuterAttribute *
   (
         TUPLE_INDEX : Pattern
      | IDENTIFIER : Pattern
      | ref? mut? IDENTIFIER
   )

StructPatternEtCetera :
   OuterAttribute *
   ..

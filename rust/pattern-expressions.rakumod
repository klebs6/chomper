
Pattern :
      |? PatternNoTopAlt ( | PatternNoTopAlt )*

PatternNoTopAlt :
      PatternWithoutRange
   | RangePattern

PatternWithoutRange :
      LiteralPattern
   | IdentifierPattern
   | WildcardPattern
   | RestPattern
   | ReferencePattern
   | StructPattern
   | TupleStructPattern
   | TuplePattern
   | GroupedPattern
   | SlicePattern
   | PathPattern
   | MacroInvocation

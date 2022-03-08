
RangePattern :
      InclusiveRangePattern
   | HalfOpenRangePattern
   | ObsoleteRangePattern

InclusiveRangePattern :
      RangePatternBound ..= RangePatternBound

HalfOpenRangePattern :
   | RangePatternBound ..

ObsoleteRangePattern :
   RangePatternBound ... RangePatternBound

RangePatternBound :
      CHAR_LITERAL
   | BYTE_LITERAL
   | -? INTEGER_LITERAL
   | -? FLOAT_LITERAL
   | PathInExpression
   | QualifiedPathInExpression

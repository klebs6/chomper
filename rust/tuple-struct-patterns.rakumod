
TupleStructPattern :
   PathInExpression ( TupleStructItems? )

TupleStructItems :
   Pattern ( , Pattern )* ,?

TuplePattern :
   ( TuplePatternItems? )

TuplePatternItems :
      Pattern ,
   | RestPattern
   | Pattern (, Pattern)+ ,?

GroupedPattern :
   ( Pattern )

SlicePattern :
   [ SlicePatternItems? ]

SlicePatternItems :
   Pattern (, Pattern)* ,?

PathPattern :
      PathInExpression
   | QualifiedPathInExpression

LazyBooleanExpression :
      Expression || Expression
   | Expression && Expression

ComparisonExpression :
      Expression == Expression
   | Expression != Expression
   | Expression > Expression
   | Expression < Expression
   | Expression >= Expression
   | Expression <= Expression


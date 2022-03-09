NegationExpression :
      - Expression
   | ! Expression

ArithmeticOrLogicalExpression :
      Expression + Expression
   | Expression - Expression
   | Expression * Expression
   | Expression / Expression
   | Expression % Expression
   | Expression & Expression
   | Expression | Expression
   | Expression ^ Expression
   | Expression << Expression
   | Expression >> Expression



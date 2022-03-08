
MatchExpression :
   match Scrutinee {
      InnerAttribute*
      MatchArms?
   }

Scrutinee :
   Expressionexcept struct expression

MatchArms :
   ( MatchArm => ( ExpressionWithoutBlock , | ExpressionWithBlock ,? ) )*
   MatchArm => Expression ,?

MatchArm :
   OuterAttribute* Pattern MatchArmGuard?

MatchArmGuard :
   if Expression

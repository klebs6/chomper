
CallExpression :
   Expression ( CallParams? )

CallParams :
   Expression ( , Expression )* ,?

MethodCallExpression :
   Expression . PathExprSegment (CallParams? )

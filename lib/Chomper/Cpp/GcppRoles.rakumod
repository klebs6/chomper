unit module Chomper::Cpp::GcppRoles;

our role ILiteral             { ... }
our role INestedNameSpecifier { ... }
our role IReturnStatementBody { ... }
our role IAbstractDeclarator  { ... }
our role IBlockDeclaration    { ... }
our role ICondition           { ... }
our role IDeclSpecifier       { ... }
our role IDeclSpecifierSeq    { ... }
our role IDeclaration         { ... }
our role IExpression          { ... }
our role IForInitStatement    { ... }
our role IInitializerClause   { ... }
our role ISimpleTypeSpecifier { ... }
our role IStatement           { ... }
our role ITypeSpecifier       { ... }
our role ITypeSpecifierSeq    { ... }
our role ITemplateArgument    { ... }

our role INewTypeId           {  }
our role IPointerDeclarator   {  }
our role IInitializerList     {  }

#-------------------------------
our role  IConstantExpression                     { }
our role IDeclarationStatement                    { }
our role IInitDeclarator                          { }
our role  INestedNameSpecifier                    { }
our role  INoPointerDeclarator                    { }
our role  ITheTypeId                              { }
our role  ITypeSpecifierSeq                       { }

our role INot                                     { }
our role IAndAnd                                  { }
our role IOrOr                                    { }
our role IIdentifierStart                         { }
our role IIdentifierContinue                      { }
our role IIntegersuffix                           { }
our role ILonglongsuffix                          { }
our role ICchar                                   { }
our role IEscapesequence                          { }
our role ISimpleescapesequence                    { }
our role IFractionalconstant                      { }
our role IEncodingprefix                          { }
our role ISchar                                   { }
our role IUserDefinedIntegerLiteral does ILiteral { }
our role IUserDefinedFloatingLiteral              { }

our role IPostfixExpressionTail { }

# token postfix-expression-body { 
#   || <postfix-expression-list> 
#   || <postfix-expression-cast> 
#   || <postfix-expression-typeid> 
#   || <primary-expression> 
# }
our role IUnqualifiedId                                       { }
our role INestedNameSpecifierPrefix does INestedNameSpecifier { }
our role INestedNameSpecifierSuffix                           { }
our role ILambdaCapture                                       { }
our role ICaptureDefault                                      { }
our role ICaptureList                                         { }
our role ICapture    does ICaptureList                        { }
our role ISimpleCapture                                       { }
our role IBracketTail                                         { }
our role ICastToken                                           { }
our role IPostListHead                                        { }
our role IPostListTail                                        { }
our role IPseudoDestructorName                                { }

our role IUnaryOperator                                       { }
our role INewExpression does IInitializerClause               { }
our role INewInitializer                                      { }
our role IPointerMemberOperator                               { }
our role IMultiplicativeOperator                              { }
our role IAdditiveOperator                                    { }
our role IShiftOperator                                       { }
our role IRelationalOperator                                  { }
our role IEqualityOperator                                    { }

our role IExpression does IReturnStatementBody {}

our role IAssignmentExpression 
does IStatement
does IExpression
does IInitializerClause
does ICondition { }

our role IAssignmentOperator                           { }
our role IComment                                      { }
our role IStatement                                    { }
our role IAttributedStatementBody                      { }
our role ILabeledStatementLabelBody                    { }
our role ISelectionStatement         does IStatement   { }
our role ICondition                                    { }
our role IConditionDeclTail                            { }
our role IIterationStatement         does IStatement   { }
our role IForInitStatement                             { }
our role IForRangeInitializer                          { }
our role IJumpStatement              does IStatement   { }
our role IReturnStatementBody                          { }
our role IDeclaration                does IStatement   { }
our role IBlockDeclaration           does IDeclaration { }

our role ISimpleDeclaration 
does IBlockDeclaration
does IForInitStatement { }

our role IDeclSpecifierSeq                              { }
our role IDeclSpecifier          does IDeclSpecifierSeq { }
our role IStorageClassSpecifier  does IDeclSpecifier    { }
our role IFunctionSpecifier      does IDeclSpecifier    { }
our role ITypeSpecifier          does IDeclSpecifier does ITypeSpecifierSeq    { }
our role ITrailingTypeSpecifier  does ITypeSpecifier    { }
our role ISimpleTypeLengthModifier                      { }

our role ISimpleTypeSpecifier          
does ITemplateArgument
does IDeclSpecifierSeq
does ITheTypeId
does ITypeSpecifier { }

our role ISimpleTypeSignednessModifier 
does ISimpleTypeSpecifier { }

our role ITheTypeName                                   { }
our role IDecltypeSpecifierBody                         { }

our role INamespaceName                                 { }
our role INamespaceTag                                  { }
our role IUsingDeclarationPrefix                        { }
our role ILinkageSpecificationBody                      { }
our role IAttributeSpecifier                            { }
our role IAlignmentspecifierbody                        { }
our role IBalancedrule                                  { }
our role IDeclarator                                    { }
our role INoPointerDeclaratorBase                       { }
our role INoPointerDeclaratorTail                       { }
our role IAugmentedPointerOperator                      { }

our role IPointerOperator 
does IAbstractDeclarator
does IAugmentedPointerOperator {  }

our role ICvQualifier                                   { }
our role IRefqualifier                                  { }
our role IAbstractDeclarator                            { }
our role IPointerAbstractDeclarator                     { }
our role INoPointerAbstractDeclaratorBody               { }
our role INoPointerAbstractDeclaratorBase               { }
our role INoPointerAbstractPackDeclaratorBody           { }
our role IParameterDeclarationBody                      { }
our role IFunctionBody                                  { }
our role IInitializer                                   { }
our role IBraceOrEqualInitializer does IInitializer     { }
our role IInitializerClause       does IInitializer     { }
our role IClassName                                     { }
our role IClassHead                                     { }
our role IClassKey                                      { }
our role IMemberSpecificationBase                       { }
our role IMemberdeclaration                             { }
our role IMemberDeclarator                              { }
our role IVirtualSpecifier                              { }
our role IBaseSpecifier                                 { }
our role IClassOrDeclType                               { }
our role IAccessSpecifier                               { }
our role IMemInitializer                                { }
our role IMeminitializerid                              { }
our role ILiteralOperatorId                             { }
our role ITemplateParameter                             { }
our role ITypeParameterBase                             { }
our role ITypeParameterSuffix                           { }
our role ITemplateId                                    { }
our role ITemplateArgument                              { }
our role ITypeNameSpecifier                             { }
our role ISomeDeclarator                                { }
our role IExceptionDeclaration                          { }
our role IExceptionSpecification                        { }
our role INoeExceptSpecification                        { }
our role ITheOperator                                   { }

our role IConditionalExpression    does IAssignmentExpression     { }
our role ILogicalOrExpression      does IConditionalExpression    { }
our role ILogicalAndExpression     does ILogicalOrExpression      { }
our role IInclusiveOrExpression    does ILogicalAndExpression     { }
our role IExclusiveOrExpression    does IInclusiveOrExpression    { }
our role IAndExpression            does IExclusiveOrExpression    { }
our role IEqualityExpression       does IAndExpression            { }
our role IRelationalExpression     does IEqualityExpression       { }
our role IShiftExpression          does IRelationalExpression     { }
our role IAdditiveExpression       does IShiftExpression          { }
our role IMultiplicativeExpression does IAdditiveExpression       { }
our role IPointerMemberExpression  does IMultiplicativeExpression { }
our role ICastExpression           does IPointerMemberExpression  { }

# rule unary-expression { <new-expression> || <unary-expression-case> }
our role IUnaryExpression       does ICastExpression        { }
our role IUnaryExpressionCase   does IUnaryExpression       { }
our role IPostfixExpressionBody does IUnaryExpressionCase   { }

our role IPrimaryExpression     
does IConstantExpression
does IPostfixExpressionBody { }

our role ILiteral               does IPrimaryExpression     { }

our role IIdExpression          
does IInitDeclarator
does IDeclarator #should we be?
does IPrimaryExpression     { }

our role ICharacterLiteralPrefix { }

# token literal:sym<int> { <integer-literal> }
our role IIntegerLiteral  
does IAlignmentspecifierbody
does ILiteral { }

# token literal:sym<float> { <floating-literal> }
our role IFloatingLiteral    does ILiteral { }

# token literal:sym<bool> { <boolean-literal> }
our role IBooleanLiteral     does ILiteral { }

# token literal:sym<user-defined> { <user-defined-literal> }
our role IUserDefinedLiteral does ILiteral { }

our sub maybe-extend($in, $expr, :$treemark,:$padr = False, :$padl = False) {

    my $res = $in;

    if $expr {
        if $padl {
            $res ~= " ";
        }

        $res ~= $expr.gist(:$treemark);

        if $padr {
            $res ~= " ";
        }
    }

    $res
}
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

our role INewTypeId           is export {  }
our role IPointerDeclarator   is export {  }
our role IInitializerList     is export {  }

#-------------------------------
our role  IConstantExpression                     is export { }
our role IDeclarationStatement                    is export { }
our role IInitDeclarator                          is export { }
our role  INestedNameSpecifier                    is export { }
our role  INoPointerDeclarator                    is export { }
our role  ITheTypeId                              is export { }
our role  ITypeSpecifierSeq                       is export { }

our role INot                                     is export { }
our role IAndAnd                                  is export { }
our role IOrOr                                    is export { }
our role IIdentifierStart                         is export { }
our role IIdentifierContinue                      is export { }
our role IIntegersuffix                           is export { }
our role ILonglongsuffix                          is export { }
our role ICchar                                   is export { }
our role IEscapeSequence                          is export { }
our role ISimpleEscapeSequence                    is export { }
our role IFractionalConstant                      is export { }
our role IEncodingprefix                          is export { }
our role ISchar                                   is export { }
our role IUserDefinedIntegerLiteral does ILiteral is export { }
our role IUserDefinedFloatingLiteral              is export { }

our role IPostfixExpressionTail is export { }

# token postfix-expression-body { 
#   || <postfix-expression-list> 
#   || <postfix-expression-cast> 
#   || <postfix-expression-typeid> 
#   || <primary-expression> 
# }
our role IUnqualifiedId                                       is export { }
our role INestedNameSpecifierPrefix does INestedNameSpecifier is export { }
our role INestedNameSpecifierSuffix                           is export { }
our role ILambdaCapture                                       is export { }
our role ICaptureDefault                                      is export { }
our role ICaptureList                                         is export { }
our role ICapture    does ICaptureList                        is export { }
our role ISimpleCapture                                       is export { }
our role IBracketTail                                         is export { }
our role ICastToken                                           is export { }
our role IPostListHead                                        is export { }
our role IPostListTail                                        is export { }
our role IPseudoDestructorName                                is export { }

our role IUnaryOperator                                       is export { }
our role INewExpression does IInitializerClause               is export { }
our role INewInitializer                                      is export { }
our role IPointerMemberOperator                               is export { }
our role IMultiplicativeOperator                              is export { }
our role IAdditiveOperator                                    is export { }
our role IShiftOperator                                       is export { }
our role IRelationalOperator                                  is export { }
our role IEqualityOperator                                    is export { }

our role IExpression does IReturnStatementBody is export {}

our role IAssignmentExpression 
does IStatement
does IExpression
does IInitializerClause
does ICondition is export { }

our role IAssignmentOperator                           is export { }
our role IComment                                      is export { }
our role IStatement                                    is export { }
our role IAttributedStatementBody                      is export { }
our role ILabeledStatementLabelBody                    is export { }
our role ISelectionStatement         does IStatement   is export { }
our role ICondition                                    is export { }
our role IConditionDeclTail                            is export { }
our role IIterationStatement         does IStatement   is export { }
our role IForInitStatement                             is export { }
our role IForRangeInitializer                          is export { }
our role IJumpStatement              does IStatement   is export { }
our role IReturnStatementBody                          is export { }
our role IDeclaration                does IStatement   is export { }
our role IBlockDeclaration           does IDeclaration is export { }

our role ISimpleDeclaration 
does IBlockDeclaration
does IForInitStatement is export { }

our role IDeclSpecifierSeq                              is export { }
our role IDeclSpecifier          does IDeclSpecifierSeq is export { }
our role IStorageClassSpecifier  does IDeclSpecifier    is export { }
our role IFunctionSpecifier      does IDeclSpecifier    is export { }
our role ITypeSpecifier          does IDeclSpecifier does ITypeSpecifierSeq    is export { }
our role ITrailingTypeSpecifier  does ITypeSpecifier    is export { }
our role ISimpleTypeLengthModifier                      is export { }

our role ISimpleTypeSpecifier          
does ITemplateArgument
does IDeclSpecifierSeq
does ITheTypeId
does ITypeSpecifier is export { }

our role ISimpleTypeSignednessModifier 
does ISimpleTypeSpecifier is export { }

our role ITheTypeName                                   is export { }
our role IDecltypeSpecifierBody                         is export { }

our role INamespaceName                                 is export { }
our role INamespaceTag                                  is export { }
our role IUsingDeclarationPrefix                        is export { }
our role ILinkageSpecificationBody                      is export { }
our role IAttributeSpecifier                            is export { }
our role IAlignmentspecifierbody                        is export { }
our role IBalancedrule                                  is export { }
our role IDeclarator                                    is export { }
our role INoPointerDeclaratorBase                       is export { }
our role INoPointerDeclaratorTail                       is export { }
our role IAugmentedPointerOperator                      is export { }

our role IPointerOperator 
does IAbstractDeclarator
does IAugmentedPointerOperator is export {  }

our role ICvQualifier                                   is export { }
our role IRefQualifier                                  is export { }
our role IAbstractDeclarator                            is export { }
our role IPointerAbstractDeclarator                     is export { }
our role INoPointerAbstractDeclaratorBody               is export { }
our role INoPointerAbstractDeclaratorBase               is export { }
our role INoPointerAbstractPackDeclaratorBody           is export { }
our role IParameterDeclarationBody                      is export { }
our role IFunctionBody                                  is export { }
our role IInitializer                                   is export { }
our role IBraceOrEqualInitializer does IInitializer     is export { }
our role IInitializerClause       does IInitializer     is export { }
our role IClassName                                     is export { }
our role IClassHead                                     is export { }
our role IClassKey                                      is export { }
our role IMemberSpecificationBase                       is export { }
our role IMemberdeclaration                             is export { }
our role IMemberDeclarator                              is export { }
our role IVirtualSpecifier                              is export { }
our role IBaseSpecifier                                 is export { }
our role IClassOrDeclType                               is export { }
our role IAccessSpecifier                               is export { }
our role IMemInitializer                                is export { }
our role IMeminitializerid                              is export { }
our role ILiteralOperatorId                             is export { }
our role ITemplateParameter                             is export { }
our role ITypeParameterBase                             is export { }
our role ITypeParameterSuffix                           is export { }
our role ITemplateId                                    is export { }
our role ITemplateArgument                              is export { }
our role ITypeNameSpecifier                             is export { }
our role ISomeDeclarator                                is export { }
our role IExceptionDeclaration                          is export { }
our role IExceptionSpecification                        is export { }
our role INoeExceptSpecification                        is export { }
our role ITheOperator                                   is export { }

our role IConditionalExpression    does IAssignmentExpression     is export { }
our role ILogicalOrExpression      does IConditionalExpression    is export { }
our role ILogicalAndExpression     does ILogicalOrExpression      is export { }
our role IInclusiveOrExpression    does ILogicalAndExpression     is export { }
our role IExclusiveOrExpression    does IInclusiveOrExpression    is export { }
our role IAndExpression            does IExclusiveOrExpression    is export { }
our role IEqualityExpression       does IAndExpression            is export { }
our role IRelationalExpression     does IEqualityExpression       is export { }
our role IShiftExpression          does IRelationalExpression     is export { }
our role IAdditiveExpression       does IShiftExpression          is export { }
our role IMultiplicativeExpression does IAdditiveExpression       is export { }
our role IPointerMemberExpression  does IMultiplicativeExpression is export { }
our role ICastExpression           does IPointerMemberExpression  is export { }

# rule unary-expression { <new-expression> || <unary-expression-case> }
our role IUnaryExpression       does ICastExpression        is export { }
our role IUnaryExpressionCase   does IUnaryExpression       is export { }
our role IPostfixExpressionBody does IUnaryExpressionCase   is export { }

our role IPrimaryExpression     
does IConstantExpression
does IPostfixExpressionBody is export { }

our role ILiteral               does IPrimaryExpression     is export { }

our role IIdExpression          
does IInitDeclarator
does IDeclarator #should we be?
does IPrimaryExpression     is export { }

our role ICharacterLiteralPrefix is export { }

# token literal:sym<int> { <integer-literal> }
our role IIntegerLiteral  
does IAlignmentspecifierbody
does ILiteral is export { }

# token literal:sym<float> { <floating-literal> }
our role IFloatingLiteral    does ILiteral is export { }

# token literal:sym<bool> { <boolean-literal> }
our role IBooleanLiteral     does ILiteral is export { }

# token literal:sym<user-defined> { <user-defined-literal> }
our role IUserDefinedLiteral does ILiteral is export { }

our sub maybe-extend($in, $expr, :$treemark,:$padr = False, :$padl = False) is export {

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

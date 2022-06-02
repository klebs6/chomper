unit module Chomper::Cpp::GcppRoles;

our role Named is export {
    method name { "WRITEME" }
}

our role CppBase does Named is export { }

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

our role INewTypeId         does CppBase is export {  }
our role IPointerDeclarator does CppBase is export {  }
our role IInitializerList   does CppBase is export {  }

#-------------------------------
our role IConstantExpression   does CppBase is export { }
our role IDeclarationStatement does CppBase is export { }
our role IInitDeclarator       does CppBase is export { }
our role INestedNameSpecifier  does CppBase is export { }
our role INoPointerDeclarator  does CppBase is export { }
our role ITheTypeId            does CppBase is export { }
our role ITypeSpecifierSeq     does CppBase is export { }

our role INot                        does CppBase is export { }
our role IAndAnd                     does CppBase is export { }
our role IOrOr                       does CppBase is export { }
our role IIdentifierStart            does CppBase is export { }
our role IIdentifierContinue         does CppBase is export { }
our role IIntegerSuffix              does CppBase is export { }
our role ILongLongSuffix             does CppBase is export { }
our role ICchar                      does CppBase is export { }
our role IEscapeSequence             does ICchar does CppBase is export { }
our role ISimpleEscapeSequence       does ICchar does CppBase is export { }
our role IFractionalConstant         does CppBase is export { }
our role IEncodingPrefix             does CppBase is export { }
our role ISchar                      does CppBase is export { }
our role IUserDefinedIntegerLiteral  does CppBase does ILiteral is export { }
our role IUserDefinedFloatingLiteral does CppBase is export { }

our role IPostfixExpressionTail does CppBase is export { }

# token postfix-expression-body { 
#   || <postfix-expression-list> 
#   || <postfix-expression-cast> 
#   || <postfix-expression-typeid> 
#   || <primary-expression> 
# }
our role IUnqualifiedId             does CppBase is export { }
our role INestedNameSpecifierPrefix does CppBase does INestedNameSpecifier is export { }
our role INestedNameSpecifierSuffix does CppBase is export { }
our role ILambdaCapture             does CppBase is export { }
our role ICaptureDefault            does CppBase is export { }
our role ICaptureList               does CppBase is export { }
our role ICapture                   does CppBase does ICaptureList                        is export { }
our role ISimpleCapture             does CppBase is export { }
our role IBracketTail               does CppBase is export { }
our role ICastToken                 does CppBase is export { }
our role IPostListHead              does CppBase is export { }
our role IPostListTail              does CppBase is export { }
our role IPseudoDestructorName      does CppBase is export { }

our role IUnaryOperator             does CppBase is export { }
our role INewExpression             does CppBase does IInitializerClause is export { }
our role INewInitializer            does CppBase is export { }
our role IPointerMemberOperator     does CppBase is export { }
our role IMultiplicativeOperator    does CppBase is export { }
our role IAdditiveOperator          does CppBase is export { }
our role IShiftOperator             does CppBase is export { }
our role IRelationalOperator        does CppBase is export { }
our role IEqualityOperator          does CppBase is export { }

our role IExpression does CppBase does IReturnStatementBody is export {}

our role IAssignmentExpression does CppBase 
does IStatement
does IExpression
does IInitializerClause
does ICondition is export { }

our role IAssignmentOperator        does CppBase is export { }
our role IComment                   does CppBase is export { }
our role IStatement                 does CppBase is export { }
our role IAttributedStatementBody   does CppBase is export { }
our role ILabeledStatementLabelBody does CppBase is export { }
our role ISelectionStatement        does CppBase does IStatement   is export { }
our role ICondition                 does CppBase is export { }
our role IConditionDeclTail         does CppBase is export { }
our role IIterationStatement        does CppBase does IStatement   is export { }
our role IForInitStatement          does CppBase is export { }
our role IForRangeInitializer       does CppBase is export { }
our role IJumpStatement             does CppBase does IStatement   is export { }
our role IReturnStatementBody       does CppBase is export { }
our role IDeclaration               does CppBase does IStatement   is export { }
our role IBlockDeclaration          does CppBase does IDeclaration is export { }

our role ISimpleDeclaration does CppBase 
does IBlockDeclaration
does IForInitStatement is export { }

our role IDeclSpecifierSeq         does CppBase is export { }
our role IDeclSpecifier            does CppBase does IDeclSpecifierSeq is export { }
our role IStorageClassSpecifier    does CppBase does IDeclSpecifier    is export { }
our role IFunctionSpecifier        does CppBase does IDeclSpecifier    is export { }
our role ITypeSpecifier            does CppBase does IDeclSpecifier does ITypeSpecifierSeq is export { }
our role ITrailingTypeSpecifier    does CppBase does ITypeSpecifier    is export { }
our role ISimpleTypeLengthModifier does CppBase is export { }

our role ISimpleTypeSpecifier does CppBase          
does ITemplateArgument
does IDeclSpecifierSeq
does ITheTypeId
does ITypeSpecifier is export { }

our role ISimpleTypeSignednessModifier does CppBase 
does ISimpleTypeSpecifier is export { }

our role ITheTypeName           does CppBase is export { }
our role IDecltypeSpecifierBody does CppBase is export { }

our role INamespaceName            does CppBase is export { }
our role INamespaceTag             does CppBase is export { }
our role IUsingDeclarationPrefix   does CppBase is export { }
our role ILinkageSpecificationBody does CppBase is export { }
our role IAttributeSpecifier       does CppBase is export { }
our role IAttributeSpecifierSeq    does CppBase is export { }
our role IAlignmentSpecifierBody   does CppBase is export { }
our role IBalancedRule             does CppBase is export { }
our role IDeclarator               does CppBase is export { }
our role INoPointerDeclaratorBase  does CppBase is export { }
our role INoPointerDeclaratorTail  does CppBase is export { }
our role IAugmentedPointerOperator does CppBase is export { }

our role IPointerOperator does CppBase 
does IAbstractDeclarator
does IAugmentedPointerOperator is export {  }

our role ICvQualifier                         does CppBase is export { }
our role IRefQualifier                        does CppBase is export { }
our role IAbstractDeclarator                  does CppBase is export { }
our role IPointerAbstractDeclarator           does CppBase is export { }
our role INoPointerAbstractDeclaratorBody     does CppBase is export { }
our role INoPointerAbstractDeclaratorBase     does CppBase is export { }
our role INoPointerAbstractPackDeclaratorBody does CppBase is export { }
our role IParameterDeclarationBody            does CppBase is export { }
our role IFunctionBody                        does CppBase is export { }
our role IInitializer                         does CppBase is export { }
our role IBraceOrEqualInitializer             does CppBase does IInitializer is export { }
our role IInitializerClause                   does CppBase does IInitializer is export { }
our role IClassName                           does CppBase is export { }
our role IClassHead                           does CppBase is export { }
our role IClassKey                            does CppBase is export { }
our role IMemberSpecificationBase             does CppBase is export { }
our role IMemberDeclaration                   does CppBase is export { }
our role IMemberDeclarator                    does CppBase is export { }
our role IVirtualSpecifier                    does CppBase is export { }
our role IBaseSpecifier                       does CppBase is export { }
our role IClassOrDeclType                     does CppBase is export { }
our role IAccessSpecifier                     does CppBase is export { }
our role IMemInitializer                      does CppBase is export { }
our role IMemInitializerId                    does CppBase is export { }
our role ILiteralOperatorId                   does CppBase is export { }
our role ITemplateParameter                   does CppBase is export { }
our role ITypeParameterBase                   does CppBase is export { }
our role ITypeParameterSuffix                 does CppBase is export { }
our role ITemplateId                          does CppBase is export { }
our role ITemplateArgument                    does CppBase is export { }
our role ITypeNameSpecifier                   does CppBase is export { }
our role ISomeDeclarator                      does CppBase is export { }
our role IExceptionDeclaration                does CppBase is export { }
our role IExceptionSpecification              does CppBase is export { }
our role INoExceptSpecification               does CppBase is export { }
our role ITheOperator                         does CppBase is export { }

our role IConditionalExpression    does CppBase does IAssignmentExpression     is export { }
our role ILogicalOrExpression      does CppBase does IConditionalExpression    is export { }
our role ILogicalAndExpression     does CppBase does ILogicalOrExpression      is export { }
our role IInclusiveOrExpression    does CppBase does ILogicalAndExpression     is export { }
our role IExclusiveOrExpression    does CppBase does IInclusiveOrExpression    is export { }
our role IAndExpression            does CppBase does IExclusiveOrExpression    is export { }
our role IEqualityExpression       does CppBase does IAndExpression            is export { }
our role IRelationalExpression     does CppBase does IEqualityExpression       is export { }
our role IShiftExpression          does CppBase does IRelationalExpression     is export { }
our role IAdditiveExpression       does CppBase does IShiftExpression          is export { }
our role IMultiplicativeExpression does CppBase does IAdditiveExpression       is export { }
our role IPointerMemberExpression  does CppBase does IMultiplicativeExpression is export { }
our role ICastExpression           does CppBase does IPointerMemberExpression  is export { }

# rule unary-expression { <new-expression> || <unary-expression-case> }
our role IUnaryExpression       does CppBase does ICastExpression        is export { }
our role IUnaryExpressionCase   does CppBase does IUnaryExpression       is export { }
our role IPostfixExpressionBody does CppBase does IUnaryExpressionCase   is export { }

our role IPrimaryExpression does CppBase     
does IConstantExpression
does IPostfixExpressionBody is export { }

our role ILiteral does CppBase               does IPrimaryExpression     is export { }

our role IIdExpression does CppBase          
does IInitDeclarator
does IDeclarator #should we be?
does IPrimaryExpression     is export { }

our role ICharacterLiteralPrefix does CppBase is export { }

# token literal:sym<int> { <integer-literal> }
our role IIntegerLiteral does CppBase  
does IAlignmentSpecifierBody
does ILiteral is export { }

# token literal:sym<float> { <floating-literal> }
our role IFloatingLiteral does CppBase    does ILiteral is export { }

# token literal:sym<bool> { <boolean-literal> }
our role IBooleanLiteral does CppBase     does ILiteral is export { }

# token literal:sym<user-defined> { <user-defined-literal> }
our role IUserDefinedLiteral does CppBase does ILiteral is export { }

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

#-------------------------------[fwd declare]

our class AbstractPackDeclarator                   { ... }
our class AliasDeclaration                         { ... }
our class AsmDefinition                            { ... }
our class AttributeArgumentClause                  { ... }
our class AttributeDeclaration                     { ... }
our class AttributeList                            { ... }
our class AttributeNamespace                       { ... }
our class AttributeSpecifierSeq                    { ... }
our class AugmentedPointerOperator                 { ... }
our class BalancedTokenSeq                         { ... }
our class BaseClause                               { ... }
our class BaseSpecifierList                        { ... }
our class BaseTypeSpecifier                        { ... }
our class BracedInitList                           { ... }
our class CaptureList                              { ... }
our class CastExpression                           { ... }
our class ClassHeadName                            { ... }
our class ClassSpecifier                           { ... }
our class ClassVirtSpecifier                       { ... }
our class CompoundStatement                        { ... }
our class ConstantExpression                       { ... }
our role  IConstantExpression                      {     }
our class ConstructorInitializer                   { ... }
our class ConversionDeclarator                     { ... }
our class ConversionFunctionId                     { ... }
our class ConversionTypeId                         { ... }
our class Cvqualifierseq                           { ... }
our class DeclSpecifierSeq                         { ... }
our class DeclarationStatement                     { ... }
our role IDeclarationStatement                     {  }
our class Declarationseq                           { ... }
our class Declaratorid                             { ... }
our class DecltypeSpecifier                        { ... }
our class DeleteExpression                         { ... }
our class Digitsequence                            { ... }
our class DynamicExceptionSpecification            { ... }
our class EmptyDeclaration                         { ... }
our class EnumName                                 { ... }
our class EnumSpecifier                            { ... }
our class Enumerator                               { ... }
our class EnumeratorDefinition                     { ... }
our class EnumeratorList                           { ... }
our class ExplicitInstantiation                    { ... }
our class ExplicitSpecialization                   { ... }
our class Exponentpart                             { ... }
our class Expression                               { ... }
our class ExpressionList                           { ... }
our class ExpressionStatement                      { ... }
our class Floatingsuffix                           { ... }
our class ForRangeDeclaration                      { ... }
our class FunctionDefinition                       { ... }
our class FunctionTryBlock                         { ... }
our class Handler                                  { ... }
our class HandlerSeq                               { ... }
our class Hexadecimalescapesequence                { ... }
our class InitDeclarator                           { ... }
our role IInitDeclarator                           {  }
our class Initcapture                              { ... }
our class InitializerList                          { ... }
our class LabeledStatement                         { ... }
our class LambdaDeclarator                         { ... }
our class LambdaExpression                         { ... }
our class LambdaIntroducer                         { ... }
our class LinkageSpecification                     { ... }
our class Longsuffix                               { ... }
our class MemInitializerList                       { ... }
our class MemberDeclaratorList                     { ... }
our class MemberSpecification                      { ... }
our class MultiplicativeExpressionTail             { ... }
our class NamespaceAlias                           { ... }
our class NamespaceAliasDefinition                 { ... }
our class NamespaceDefinition                      { ... }
our class NestedNameSpecifier                      { ... }
our role  INestedNameSpecifier                      {  }
our class NewDeclarator                            { ... }
our class NewPlacement                             { ... }
our class NewTypeId                                { ... }
our class NoExceptExpression                       { ... }
our class NoPointerAbstractDeclarator              { ... }
our class NoPointerAbstractDeclaratorBracketedBase { ... }
our class NoPointerAbstractPackDeclarator          { ... }
our class NoPointerDeclarator                      { ... }
our role  INoPointerDeclarator                     {}
our class NoPointerNewDeclarator                   { ... }
our class NoPointerNewDeclaratorTail               { ... }
our class Octalescapesequence                      { ... }
our class OpaqueEnumDeclaration                    { ... }
our class OperatorFunctionId                       { ... }
our class OriginalNamespaceName                    { ... }
our class ParameterDeclaration                     { ... }
our class ParameterDeclarationClause               { ... }
our class ParametersAndQualifiers                  { ... }
our class PointerDeclarator                        { ... }
our class PointerMemberExpression                  { ... }
our class PointerMemberExpressionTail              { ... }
our class PureSpecifier                            { ... }
our class QualifiedId                              { ... }
our class Qualifiednamespacespecifier              { ... }
our class SimpleTemplateId                         { ... }
our class StatementSeq                             { ... }
our class StaticAssertDeclaration                  { ... }
our class TemplateArgumentList                     { ... }
our class TemplateDeclaration                      { ... }
our class TemplateParameterList                    { ... }
our class TheTypeId                                { ... }
our role  ITheTypeId                                {  }
our class ThrowExpression                          { ... }
our class TrailingReturnType                       { ... }
our class TryBlock                                 { ... }
our class TypeIdList                               { ... }
our class TypeIdOfTheTypeId                        { ... }
our class TypeParameter                            { ... }
our class TypeSpecifierSeq                         { ... }
our role  ITypeSpecifierSeq                        {  }
our class Unsignedsuffix                           { ... }
our class UserDefinedCharacterLiteral              { ... }
our class UserDefinedStringLiteral                 { ... }
our class UsingDeclaration                         { ... }
our class UsingDirective                           { ... }
our class VirtualSpecifierSeq                      { ... }

our role IAssignmentExpression                    { ... }
our role IAttributedStatementBody                 { ... }
our role ICapture                                 { ... }
our role IAbstractDeclarator                       { ... }
our role IAccessSpecifier                          { ... }
our role IAlignmentSpecifier                       { ... }
our role IAssignmentOperator                       { ... }
our role IAttributeSpecifier                       { ... }
our role IAttributeSpecifierSeq                    { ... }
our role IBalancedrule                             { ... }
our role IBaseSpecifier                            { ... }
our role IBlockDeclaration                         { ... }
our role IBraceOrEqualInitializer                  { ... }
our role ICaptureDefault                           { ... }
our role ICase                                     { ... }
our role ICchar                                    { ... }
our role ICharacterLiteralPrefix                   { ... }
our role IClassName                                { ... }
our role ICondition                                { ... }
our role ICvQualifier                              { ... }
our role IDeclaration                              { ... }
our role IDeclarationseq                           { ... }
our role IDeclarator                               { ... }
our role IElaboratedTypeSpecifier                  { ... }
our role IEncodingprefix                           { ... }
our role IEnumBase                                 { ... }
our role IEscapesequence                           { ... }
our role IExceptionDeclaration                     { ... }
our role IExceptionSpecification                   { ... }
our role IForInitStatement                         { ... }
our role IForRangeInitializer                      { ... }
our role IFractionalconstant                       { ... }
our role IFunctionBody                             { ... }
our role IFunctionSpecifier                        { ... }
our role IIdExpression                             { ... }
our role IInitializer                              { ... }
our role IInitializerClause                        { ... }
our role IIntegersuffix                            { ... }
our role IIntegersuffix                            { ... }
our role IIterationStatement                       { ... }
our role IJumpStatement                            { ... }
our role ILambdaCapture                            { ... }
our role ILiteral                                  { ... }
our role ILiteralOperatorId                        { ... }
our role ILonglongsuffix                           { ... }
our role IMemInitializer                           { ... }
our role IMemberDeclarator                         { ... }
our role IMemberdeclaration                        { ... }
our role IMeminitializerid                         { ... }
our role IMultiplicativeOperator                   { ... }
our role INamespaceName                            { ... }
our role INamespaceTag                             { ... }
our role INewExpression                            { ... }
our role INewInitializer                           { ... }
our role INoPointerAbstractDeclaratorBase          { ... }
our role INoPointerAbstractPackDeclaratorBody      { ... }
our role INoeExceptSpecification                   { ... }
our role IParameterDeclarationBody                 { ... }
our role IPointerAbstractDeclarator                { ... }
our role IPointerOperator                          { ... }
our role IPseudoDestructorName                     { ... }
our role IRefqualifier                             { ... }
our role IReturnStatementBody                      { ... }
our role ISelectionStatement                       { ... }
our role IShiftOperator                            { ... }
our role ISimpleCapture                            { ... }
our role ISimpleDeclaration                        { ... }
our role ISimpleTypeSpecifier                      { ... }
our role ISimpleescapesequence                     { ... }
our role IStorageClassSpecifier                    { ... }
our role ITemplateArgument                         { ... }
our role ITemplateId                               { ... }
our role ITemplateParameter                        { ... }
our role ITheOperator                              { ... }
our role ITheTypeName                              { ... }
our role ITrailingTypeSpecifier                    { ... }
our role ITypeNameSpecifier                        { ... }
our role ITypeSpecifier                            { ... }
our role ITypeid                                   { ... }
our role IUnaryOperator                            { ... }
our role IUnqualifiedId                            { ... }
our role IUserDefinedFloatingLiteral               { ... }
our role IUserDefinedIntegerLiteral                { ... }
our role IVirtualSpecifier                         { ... }

our role INot    { }
our role IAndAnd { }
our role IOrOr   { }
our role IIdentifierStart { }
our role IIdentifierContinue { }
our role IIntegersuffix { }
our role ILonglongsuffix { }
our role ICchar { }
our role IEscapesequence { }
our role ISimpleescapesequence { }
our role IFractionalconstant { }
our role IEncodingprefix { }
our role ISchar { }
our role IUserDefinedIntegerLiteral does ILiteral { }
our role IUserDefinedFloatingLiteral { }

our role IPostfixExpressionTail { }

# token postfix-expression-body { 
#   || <postfix-expression-list> 
#   || <postfix-expression-cast> 
#   || <postfix-expression-typeid> 
#   || <primary-expression> 
# }
our role IUnqualifiedId { }
our role INestedNameSpecifierPrefix does INestedNameSpecifier { }
our role INestedNameSpecifierSuffix { }
our role ILambdaCapture { }
our role ICaptureDefault { }
our role ICapture { }
our role ISimpleCapture { }
our role IBracketTail { }
our role ICastToken { }
our role IPostListHead { }
our role IPostListTail { }
our role IPseudoDestructorName { }

our role IUnaryOperator { }
our role INewExpression { }
our role INewInitializer { }
our role IPointerMemberOperator { }
our role IMultiplicativeOperator { }
our role IAdditiveOperator { }
our role IShiftOperator { }
our role IRelationalOperator { }
our role IEqualityOperator { }

our role IExpression does IReturnStatementBody {}

our role IStatement { ... }
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
our role ISimpleTypeSpecifier          does ITypeSpecifier { }
our role ISimpleTypeSignednessModifier does ISimpleTypeSpecifier { }
our role ITheTypeName                                   { }
our role IDecltypeSpecifierBody                         { }
our role IElaboratedTypeSpecifier                       { }
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
our role IPrimaryExpression     does IPostfixExpressionBody { }
our role ILiteral               does IPrimaryExpression     { }
our role IIdExpression          does IPrimaryExpression     { }

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

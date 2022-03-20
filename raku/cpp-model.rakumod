
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
our role ITrailingTypeSpecifier does ITypeSpecifier     { }
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

#-------------------------------
our class Not::Bang does INot { 

    has $.text;

    method gist { 
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Not::Not does INot { 

    has $.text;

    method gist { 
        say "need write gist!";
        ddt self;
        exit;
    }
}


#-------------------------------
our class AndAnd::AndAnd does IAndAnd { 

    has $.text;

    method gist {

    }
}

our class AndAnd::And does IAndAnd { 

    has $.text;

    method gist {

    }
}


#-------------------------------
our class OrOr::PipePipe does IOrOr { 

    has $.text;

    method gist {

    }
}

our class OrOr::Or does IOrOr { 

    has $.text;

    method gist {

    }
}


our role ICharacterLiteralPrefix { }

# token literal:sym<int> { <integer-literal> }
our role IIntegerLiteral  
does IAlignmentspecifierbody
does ILiteral { }

# token literal:sym<float> { <floating-literal> }
our role IFloatingLiteral does ILiteral { }

# token literal:sym<bool> { <boolean-literal> }
our role IBooleanLiteral  does ILiteral { }

# token literal:sym<user-defined> { <user-defined-literal> }
our role IUserDefinedLiteral does ILiteral { }

#-------------------------------
our class Identifier 
does ITheTypeId
does ITemplateArgument
does ISimpleTypeSpecifier
does IConstantExpression
does IDeclSpecifier
does IPointerMemberExpression
does INoPointerDeclarator
does IForRangeInitializer
does IMultiplicativeExpression
does IInitDeclarator
does IUnqualifiedId
does IIdExpression
does IPostfixExpressionBody
does IPostfixExpressionTail
does IPostListHead
does IDeclarator
does IDeclSpecifierSeq
does INoPointerDeclaratorBase
does ITheTypeName { 
    has Str $.value is required; 
}

our class Nondigit {
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Digit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class DecimalLiteral { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class OctalLiteral { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class HexadecimalLiteral {
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class BinaryLiteral { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Nonzerodigit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Octaldigit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Hexadecimaldigit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Binarydigit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our subset Quad of List where (HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral);

#-------------------------------

our class IntegerLiteral::Dec does IIntegerLiteral {
    has DecimalLiteral $.decimal-literal is required;
    has IIntegersuffix $.integersuffix;

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class IntegerLiteral::Oct does IIntegerLiteral {
    has OctalLiteral       $.octal-literal is required;
    has IIntegersuffix      $.integersuffix;

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class IntegerLiteral::Hex does IIntegerLiteral {
    has HexadecimalLiteral $.hexadecimal-literal is required;
    has IIntegersuffix      $.integersuffix;

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class IntegerLiteral::Bin does IIntegerLiteral {
    has BinaryLiteral      $.binary-literal is required;
    has IIntegersuffix      $.integersuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

our class CharacterLiteralPrefix::U    does ICharacterLiteralPrefix { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class CharacterLiteralPrefix::BigU does ICharacterLiteralPrefix { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class CharacterLiteralPrefix::L    does ICharacterLiteralPrefix { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------
# token literal:sym<char> { <character-literal> }
our class CharacterLiteral {
    has ICharacterLiteralPrefix $.character-literal-prefix;
    has ICchar                  @.cchar;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class FloatingLiteral::Frac does IFloatingLiteral {
    has IFractionalconstant $.fractionalconstant is required;
    has Exponentpart        $.exponentpart;
    has Floatingsuffix      $.floatingsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class FloatingLiteral::Digit does IFloatingLiteral {
    has Digitsequence  $.digitsequence is required;
    has Exponentpart   $.exponentpart  is required;
    has Floatingsuffix $.floatingsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token literal:sym<str> { <string-literal> }
our class StringLiteral does ILiteral { 
    has Str $.value;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

our class BooleanLiteral::F does IBooleanLiteral { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class BooleanLiteral::T does IBooleanLiteral { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token literal:sym<ptr> { <pointer-literal> }
our class PointerLiteral does ILiteral {

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

our class UserDefinedLiteral::Int { 
    has IUserDefinedIntegerLiteral   $.user-defined-integer-literal is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class UserDefinedLiteral::Float does IUserDefinedLiteral {
    has IUserDefinedFloatingLiteral  $.user-defined-floating-literal is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class UserDefinedLiteral::Str does IUserDefinedLiteral {
    has UserDefinedStringLiteral    $.user-defined-string-literal is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class UserDefinedLiteral::Char does IUserDefinedLiteral {
    has UserDefinedCharacterLiteral $.user-defined-character-literal is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------
our class MultiLineMacro { 
    has Str $.content is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Directive { 
    has Str $.content is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Hexquad { 
    has Quad @hexadecimaldigit is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

our class Universalcharactername {
    has Hexquad $.first is required;
    has Hexquad $.second;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

our class IdentifierStart::Nondigit does IIdentifierStart {
    has Nondigit $.nondigit is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class IdentifierStart::Ucn does IIdentifierStart {
    has Universalcharactername $.universalcharactername is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

our class IdentifierContinue::Digit does IIdentifierContinue {
    has Digit $.digit is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class IdentifierContinue::Nondigit does IIdentifierContinue {
    has Nondigit $.nondigit is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class IdentifierContinue::Ucn does IIdentifierContinue {
    has Universalcharactername $.universalcharactername is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

our class Integersuffix::Ul does IIntegersuffix {
    has Unsignedsuffix $.unsignedsuffix is required;
    has Longsuffix     $.longsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Integersuffix::Ull does IIntegersuffix {
    has Unsignedsuffix $.unsignedsuffix is required;
    has ILonglongsuffix $.longlongsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Integersuffix::Lu does IIntegersuffix {
    has Longsuffix     $.longsuffix is required;
    has Unsignedsuffix $.unsignedsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Integersuffix::Llu does IIntegersuffix {
    has ILonglongsuffix $.longsuffix is required;
    has Unsignedsuffix $.unsignedsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Unsignedsuffix { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Longsuffix { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------
our class Longlongsuffix::Ll does ILonglongsuffix { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Longlongsuffix::LL does ILonglongsuffix { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

our class Cchar::Basic does ICchar {
    has Str $.value is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Cchar::Escape does ICchar {
    has IEscapesequence $.escapesequence is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Cchar::Universal does ICchar {
    has Universalcharactername $.universalcharactername is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

our class Escapesequence::Simple does IEscapesequence {
    has ISimpleescapesequence $.simpleescapesequence is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Escapesequence::Octal does IEscapesequence {
    has Octalescapesequence $.octalescapesequence is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Escapesequence::Hex does IEscapesequence {
    has Hexadecimalescapesequence $.hexadecimalescapesequence is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------
our class Simpleescapesequence::Slash       does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::Quote       does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::Question    does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::DoubleSlash does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::A does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::B does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::F does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::N does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::R does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::T does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::V does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::RnN does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


our class Octalescapesequence {
    has Octaldigit @.digits is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Hexadecimalescapesequence {
    has Hexadecimaldigit @.digits is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

our class Fractionalconstant::WithTail does IFractionalconstant {
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Fractionalconstant::NoTail does IFractionalconstant {
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class ExponentpartPrefix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Exponentpart { 
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Sign::Plus { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Sign::Minus { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Digitsequence { 
    has Digit @.digits is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Floatingsuffix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

our class Encodingprefix::U8 does IEncodingprefix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Encodingprefix::u  does IEncodingprefix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Encodingprefix::U  does IEncodingprefix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Encodingprefix::L  does IEncodingprefix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

our class Schar::Basic does ISchar {
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Schar::Escape does ISchar {
    has IEscapesequence $.escapesequence is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Schar::Ucn does ISchar {
    has Universalcharactername $.universalcharactername is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Rawstring { 
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

# token user-defined-integer-literal:sym<dec> { <decimal-literal> <udsuffix> }
our class UserDefinedIntegerLiteral::Dec does IUserDefinedIntegerLiteral {
    has DecimalLiteral $.decimal-literal is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token user-defined-integer-literal:sym<oct> { <octal-literal> <udsuffix> }
our class UserDefinedIntegerLiteral::Oct does IUserDefinedIntegerLiteral {
    has OctalLiteral $.octal-literal is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token user-defined-integer-literal:sym<hex> { <hexadecimal-literal> <udsuffix> }
our class UserDefinedIntegerLiteral::Hex does IUserDefinedIntegerLiteral {
    has HexadecimalLiteral $.hexadecimal-literal is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token user-defined-integer-literal:sym<bin> { <binary-literal> <udsuffix> }      #-------------------
our class UserDefinedIntegerLiteral::Bin does IUserDefinedIntegerLiteral {
    has BinaryLiteral $.binary-literal is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# token user-defined-floating-literal:sym<frac> { <fractionalconstant> <exponentpart>?  <udsuffix> }
our class UserDefinedFloatingLiteral::Frac does IUserDefinedFloatingLiteral {
    has IFractionalconstant $.fractionalconstant is required;
    has Exponentpart        $.exponentpart;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token user-defined-floating-literal:sym<digi> { <digitsequence> <exponentpart> <udsuffix> } #-------------------
our class UserDefinedFloatingLiteral::Digi does IUserDefinedFloatingLiteral {
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token user-defined-string-literal { <string-literal> <udsuffix> }
our class UserDefinedStringLiteral { 
    has Str $.value is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token user-defined-character-literal { <character-literal> <udsuffix> }
our class UserDefinedCharacterLiteral { 
    has Str $.value is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token udsuffix { <identifier> }
our class Udsuffix { 
    has Str $.value is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token block-comment { '/*' .*?  '*/' }
our class BlockComment { 
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token line-comment {         '//' <-[ \r \n ]>*     }
our class LineComment { 
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token translation-unit {         <declarationseq>?  $     }
our class TranslationUnit { 
    has IDeclarationseq $.declarationseq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#------------------------------

# token primary-expression:sym<literal> { <literal>+ }
our class PrimaryExpression::Literal does IPrimaryExpression {
    has ILiteral @.literal is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token primary-expression:sym<this>    { <this> }
our class PrimaryExpression::This does IPrimaryExpression { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token primary-expression:sym<expr>    { <.left-paren> <expression> <.right-paren> }
our class PrimaryExpression::Expr does IPrimaryExpression {
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token primary-expression:sym<id>      { <id-expression> }
our class PrimaryExpression::Id does IPrimaryExpression {
    has IIdExpression $.id-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token primary-expression:sym<lambda>  { <lambda-expression> }     
our class PrimaryExpression::Lambda does IPrimaryExpression {
    has LambdaExpression $.lambda-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


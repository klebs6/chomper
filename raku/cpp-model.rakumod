
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

#------------------------------

# regex id-expression:sym<qualified>   { <qualified-id> }
our class IdExpression::Qualified does IIdExpression {
    has QualifiedId $.qualified-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex id-expression:sym<unqualified> { <unqualified-id> }     
our class IdExpression::Unqualified does IIdExpression {
    has IUnqualifiedId $.unqualified-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#------------------------------

# regex unqualified-id:sym<ident> { <identifier> }
our class UnqualifiedId::Ident does IUnqualifiedId {
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex unqualified-id:sym<op-func-id>          { <operator-function-id> }
our class UnqualifiedId::OpFuncId does IUnqualifiedId {
    has OperatorFunctionId $.operator-function-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex unqualified-id:sym<conversion-func-id>  { <conversion-function-id> }
our class UnqualifiedId::ConversionFuncId does IUnqualifiedId {
    has ConversionFunctionId $.conversion-function-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex unqualified-id:sym<literal-operator-id> { <literal-operator-id> }
our class UnqualifiedId::LiteralOperatorId does IUnqualifiedId {
    has ILiteralOperatorId $.literal-operator-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex unqualified-id:sym<tilde-classname>     { <tilde> <class-name> }
our class UnqualifiedId::TildeClassname does IUnqualifiedId {
    has IClassName $.class-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex unqualified-id:sym<tilde-decltype>      { <tilde> <decltype-specifier> }
our class UnqualifiedId::TildeDecltype does IUnqualifiedId {
    has DecltypeSpecifier $.decltype-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex unqualified-id:sym<template-id>  { <template-id> }
our class UnqualifiedId::TemplateId does IUnqualifiedId {
    has ITemplateId $.template-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex qualified-id { <nested-name-specifier> <template>? <unqualified-id> }      
our class QualifiedId does IIdExpression { 
    has INestedNameSpecifier $.nested-name-specifier is required;
    has Bool                $.template              is required;
    has IUnqualifiedId      $.unqualified-id        is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# regex nested-name-specifier-prefix:sym<null> { <doublecolon> }
our class NestedNameSpecifierPrefix::Null does INestedNameSpecifierPrefix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex nested-name-specifier-prefix:sym<type> { <the-type-name> <doublecolon> }
our class NestedNameSpecifierPrefix::Type does INestedNameSpecifierPrefix {
    has ITheTypeName $.the-type-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex nested-name-specifier-prefix:sym<ns> { <namespace-name> <doublecolon> }
our class NestedNameSpecifierPrefix::Ns does INestedNameSpecifierPrefix {
    has INamespaceName $.namespace-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex nested-name-specifier-prefix:sym<decl> { <decltype-specifier> <doublecolon> }
our class NestedNameSpecifierPrefix::Decl does INestedNameSpecifierPrefix {
    has DecltypeSpecifier $.decltype-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#--------------------------
# regex nested-name-specifier-suffix:sym<id> { <identifier> <doublecolon> }
our class NestedNameSpecifierSuffix::Id does INestedNameSpecifierSuffix {
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex nested-name-specifier-suffix:sym<template> { <template>? <simple-template-id> <doublecolon> } 
our class NestedNameSpecifierSuffix::Template does INestedNameSpecifierSuffix {
    has Bool             $.template is required;
    has SimpleTemplateId $.simple-template-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex nested-name-specifier { <nested-name-specifier-prefix> <nested-name-specifier-suffix>* }
our class NestedNameSpecifier does INestedNameSpecifier { 
    has INestedNameSpecifierPrefix $.nested-name-specifier-prefix   is required;
    has INestedNameSpecifierSuffix @.nested-name-specifier-suffixes;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule lambda-expression { <lambda-introducer> <lambda-declarator>? <compound-statement> }
our class LambdaExpression { 
    has LambdaIntroducer  $.lambda-introducer is required;
    has LambdaDeclarator  $.lambda-declarator;
    has CompoundStatement $.compound-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule lambda-introducer { <.left-bracket> <lambda-capture>? <.right-bracket> }
our class LambdaIntroducer { 
    has ILambdaCapture $.lambda-capture;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule lambda-capture:sym<list> { <capture-list> }
our class LambdaCapture::List does ILambdaCapture {
    has CaptureList $.capture-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule lambda-capture:sym<def> { <capture-default> [ <comma> <capture-list> ]? } 
our class LambdaCapture::Def does ILambdaCapture {
    has ICaptureDefault $.capture-default is required;
    has CaptureList    $.capture-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule capture-default:sym<and> { <and_> }
our class CaptureDefault::And does ICaptureDefault { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule capture-default:sym<assign> { <assign> } #-------------------------------
our class CaptureDefault::Assign does ICaptureDefault { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule capture-list { <capture> [ <comma> <capture> ]* <ellipsis>? } #-------------------------------
our class CaptureList {
    has ICapture @.captures is required;
    has Bool     $.trailing-ellipsis is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------

# rule capture:sym<simple> { <simple-capture> }
our class Capture::Simple does ICapture {
    has ISimpleCapture $.simple-capture is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule capture:sym<init> { <initcapture> } #-------------------------------
our class Capture::Init does ICapture {
    has Initcapture $.init-capture is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-capture:sym<id> { <and_>? <identifier> }
our class SimpleCapture::Id does ISimpleCapture {
    has Bool       $.has-and;
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-capture:sym<this> { <this> } #-------------------------------
our class SimpleCapture::This does ISimpleCapture { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule initcapture { <and_>? <identifier> <initializer> } #-------------------------------
our class Initcapture { 
    has Bool $.has-and;
    has Identifier  $.identifier  is required;
    has IInitializer $.initializer is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule lambda-declarator { 
#   <.left-paren> 
#   <parameter-declaration-clause>? 
#   <.right-paren> 
#   <mutable>? 
#   <exception-specification>? 
#   <attribute-specifier-seq>? 
#   <trailing-return-type>? 
# }
our class LambdaDeclarator { 
    has ParameterDeclarationClause $.parameter-declaration-clause is required;
    has Bool                       $.mutable                      is required;
    has IExceptionSpecification    $.exception-specification;
    has IAttributeSpecifierSeq      $.attribute-specifier-seq;
    has TrailingReturnType         $.trailing-return-type;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression { <postfix-expression-body> <postfix-expression-tail>* }
our class PostfixExpression 
does IStatement 
does IReturnStatementBody 
does IUnaryExpression { 
    has IPostfixExpressionBody $.postfix-expression-body is required;
    has IPostfixExpressionTail @.postfix-expression-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class PostfixExpressionTail::Null does IPostfixExpressionTail {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#------------------------------

# rule bracket-tail { <.left-bracket> [ <expression> || <braced-init-list> ] <.right-bracket> }
our class BracketTail::Expression does IPostfixExpressionTail { 
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class BracketTail::BracedInitList does IPostfixExpressionTail { 
    has IBracketTail $.bracket-tail is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression-tail:sym<bracket> { <bracket-tail> }
our class PostfixExpressionTail::Bracket does IPostfixExpressionTail {
    has IBracketTail $.bracket-tail is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression-tail:sym<parens> { <.left-paren> <expression-list>? <.right-paren> }
our class PostfixExpressionTail::Parens does IPostfixExpressionTail {
    has ExpressionList $.expression-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression-tail:sym<indirection-id> { [ <dot> || <arrow> ] <template>? <id-expression> }
our class PostfixExpressionTail::IndirectionId does IPostfixExpressionTail {
    has Bool         $.template is required;
    has IIdExpression $.id-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression-tail:sym<indirection-pseudo-dtor> { [ <dot> || <arrow> ] <pseudo-destructor-name> }
our class PostfixExpressionTail::IndirectionPseudoDtor does IPostfixExpressionTail {
    has IPseudoDestructorName $.pseudo-destructor-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression-tail:sym<pp-mm> { [ <plus-plus> || <minus-minus> ] } 
our class PostfixExpressionTail::PlusPlus does IPostfixExpressionTail { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class PostfixExpressionTail::MinusMinus does IPostfixExpressionTail { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# token cast-token:sym<dyn> { <dynamic_cast> }
our class CastToken::Dyn does ICastToken { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token cast-token:sym<static> { <static_cast> }
our class CastToken::Static does ICastToken { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token cast-token:sym<reinterpret> { <reinterpret_cast> }
our class CastToken::Reinterpret does ICastToken { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token cast-token:sym<const> { <const_cast> }
our class CastToken::Const does ICastToken { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression-cast { 
#   <cast-token> 
#   <less> 
#   <the-type-id> 
#   <greater> 
#   <.left-paren> 
#   <expression> 
#   <.right-paren> 
# }
our class PostfixExpressionCast 
does IInitializer 
does IUnaryExpression 
does IPostfixExpressionBody { 

    has ICastToken  $.cast-token  is required;
    has ITheTypeId  $.the-type-id is required;
    has IExpression $.expression  is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression-typeid { 
# <type-id-of-the-type-id> 
# <.left-paren> 
# [ <expression> || <the-type-id>] 
# <.right-paren> 
# } 
our class PostfixExpressionTypeid::Expr { 
    has TypeIdOfTheTypeId $.type-id-of-the-type-id is required;
    has IExpression       $.expression             is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class PostfixExpressionTypeid::TypeId { 
    has TypeIdOfTheTypeId $.type-id-of-the-type-id is required;
    has ITheTypeId        $.the-type-id            is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token post-list-head:sym<simple> { <simple-type-specifier> }
our class PostListHead::Simple does IPostListHead {
    has ISimpleTypeSpecifier $.simple-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token post-list-head:sym<type-name> { <type-name-specifier> } 
our class PostListHead::TypeName does IPostListHead {
    has ITypeNameSpecifier $.type-name-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

=begin comment
# token post-list-tail:sym<parenthesized> { <.left-paren> <expression-list>? <.right-paren> }
our class PostListTail::Parenthesized does IPostListTail {
    has ExpressionList $.expression-list;
}

# token post-list-tail:sym<braced> { <braced-init-list> }
our class PostListTail::Braced does IPostListTail {
    has BracedInitList $.braced-init-list is required;
}
=end comment

our class PostListTail does IPostListTail {
    has $.value is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token postfix-expression-list { <post-list-head> <post-list-tail> } 
our class PostfixExpressionList 
does IInitializer 
does IUnaryExpression 
does IPostfixExpressionBody { 

    has IPostListHead $.post-list-head is required;
    has IPostListTail $.post-list-tail is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule type-id-of-the-type-id { <typeid_> }
our class TypeIdOfTheTypeId {
    has ITypeid $.typeid is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule expression-list { <initializer-list> }
our class ExpressionList does IPostfixExpressionTail { 
    has InitializerList $.initializer-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------

# rule pseudo-destructor-name:sym<basic> { 
#   <nested-name-specifier>? 
#   [ <the-type-name> <doublecolon> ]? 
#   <tilde> 
#   <the-type-name> 
# }
our class PseudoDestructorName::Basic does IPseudoDestructorName {
    has Bool        $.nested-name-specifier;
    has ITheTypeName $.the-scoped-type-name;
    has ITheTypeName $.the-type-anme is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pseudo-destructor-name:sym<template> { 
#   <nested-name-specifier> 
#   <template> 
#   <simple-template-id> 
#   <doublecolon> 
#   <tilde> 
#   <the-type-name> 
# }
our class PseudoDestructorName::Template does IPseudoDestructorName {
    has INestedNameSpecifier $.nested-name-specifier is required;
    has SimpleTemplateId     $.simple-template-id    is required;
    has ITheTypeName         $.the-type-name         is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pseudo-destructor-name:sym<decltype> { <tilde> <decltype-specifier> } #-------------------------------------
our class PseudoDestructorName::Decltype does IPseudoDestructorName {
    has DecltypeSpecifier $.decltype-specifier is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class UnaryExpression::New does IUnaryExpression { 
    has INewExpression $.new-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class UnaryExpression::Case does IUnaryExpression {
    has IUnaryExpressionCase $.case is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#--------------------------

# rule unary-expression-case:sym<postfix> { <postfix-expression> }
our class UnaryExpressionCase::Postfix does IUnaryExpressionCase {
    has PostfixExpression $.postfix-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<pp> { <plus-plus> <unary-expression> }
our class UnaryExpressionCase::PlusPlus does IUnaryExpressionCase {
    has IUnaryExpression $.unary-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<mm> { <minus-minus> <unary-expression> }
our class UnaryExpressionCase::MinusMinus does IUnaryExpressionCase {
    has IUnaryExpression $.unary-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<unary-op> { <unary-operator> <unary-expression> }
our class UnaryExpressionCase::UnaryOp does IPostfixExpressionBody does IUnaryExpressionCase {
    has IUnaryOperator   $.unary-operator   is required;
    has IUnaryExpression $.unary-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<sizeof> { <sizeof> <unary-expression> }
our class UnaryExpressionCase::Sizeof does IUnaryExpressionCase {
    has IUnaryExpression $.unary-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<sizeof-typeid> { <sizeof> <.left-paren> <the-type-id> <.right-paren> }
our class UnaryExpressionCase::SizeofTypeid does IUnaryExpressionCase {
    has ITheTypeId $.the-type-id is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<sizeof-ids> { <sizeof> <ellipsis> <.left-paren> <identifier> <.right-paren> }
our class UnaryExpressionCase::SizeofIds does IUnaryExpressionCase {
    has Identifier $.identifier is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<alignof> { <alignof> <.left-paren> <the-type-id> <.right-paren> }
our class UnaryExpressionCase::Alignof does IUnaryExpressionCase {
    has ITheTypeId $.the-type-id is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<noexcept> { <no-except-expression> }
our class UnaryExpressionCase::Noexcept does IUnaryExpressionCase {
    has NoExceptExpression $.no-except-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<delete> { <delete-expression> } #--------------------------------------
our class UnaryExpressionCase::Delete does IUnaryExpressionCase {
    has DeleteExpression $.delete-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#---------------------------

# rule unary-operator:sym<or_> { <or_> }
our class UnaryOperator::Or does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-operator:sym<star> { <star> }
our class UnaryOperator::Star does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-operator:sym<and_> { <and_> }
our class UnaryOperator::And does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-operator:sym<plus> { <plus> }
our class UnaryOperator::Plus does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-operator:sym<tilde> { <tilde> }
our class UnaryOperator::Tilde does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-operator:sym<minus> { <minus> }
our class UnaryOperator::Minus does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-operator:sym<not> { <not_> } #--------------------------------------
our class UnaryOperator::Not does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#----------------------------------

# rule new-expression:sym<new-type-id> { <doublecolon>? <new_> <new-placement>? <new-type-id> <new-initializer>? }
our class NewExpression::NewTypeId does INewExpression {
    has NewPlacement   $.new-placement;
    has NewTypeId      $.new-type-id is required;
    has INewInitializer $.new-initializer;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-expression:sym<the-type-id> { <doublecolon>? <new_> <new-placement>? <.left-paren> <the-type-id> <.right-paren> <new-initializer>? }
our class NewExpression::TheTypeId does INewExpression {
    has NewPlacement    $.new-placement;
    has ITheTypeId      $.the-type-id is required;
    has INewInitializer $.new-initializer;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-placement { <.left-paren> <expression-list> <.right-paren> }
our class NewPlacement { 
    has ExpressionList $.expression-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-type-id { <type-specifier-seq> <new-declarator>? }
our class NewTypeId { 
    has ITypeSpecifierSeq $.type-specifier-seq is required;
    has NewDeclarator    $.new-declarator     is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-declarator { 
#   <pointer-operator>* 
#   <no-pointer-new-declarator>? 
# }
our class NewDeclarator { 
    has IPointerOperator @.pointer-operators;
    has NoPointerNewDeclarator $.no-pointer-new-declarator;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-pointer-new-declarator { <.left-bracket> <expression> <.right-bracket> <attribute-specifier-seq>? <no-pointer-new-declarator-tail>* }
our class NoPointerNewDeclarator { 
    has IExpression                $.expression is required;
    has IAttributeSpecifierSeq     $.attribute-specifier-seq;
    has NoPointerNewDeclaratorTail @.no-pointer-new-declarator-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-pointer-new-declarator-tail { <.left-bracket> <constant-expression> <.right-bracket> <attribute-specifier-seq>? } #------------------------
our class NoPointerNewDeclaratorTail {
    has IConstantExpression    $.constant-expression is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-initializer:sym<expr-list> { <.left-paren> <expression-list>? <.right-paren> }
our class NewInitializer::ExprList does INewInitializer {
    has ExpressionList $.expression-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-initializer:sym<braced> { <braced-init-list> } #------------------------
our class NewInitializer::Braced does INewInitializer {
    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule delete-expression { <doublecolon>? <delete> [ <.left-bracket> <.right-bracket> ]? <cast-expression> }
our class DeleteExpression { 
    has ICastExpression $.cast-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-except-expression { <noexcept> <.left-paren> <expression> <.right-paren> }
our class NoExceptExpression { 
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule cast-expression { [ <.left-paren> <the-type-id> <.right-paren> ]* <unary-expression> }
our class CastExpression does ICastExpression { 
    has ITheTypeId       @.the-type-ids     is required;
    has IUnaryExpression $.unary-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-----------------------

# rule pointer-member-operator:sym<dot> { <dot-star> }
our class PointerMemberOperator::Dot does IPointerMemberOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pointer-member-operator:sym<arrow> { <arrow-star> }
our class PointerMemberOperator::Arrow does IPointerMemberOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pointer-member-expression { <cast-expression> <pointer-member-expression-tail>* }
our class PointerMemberExpression does IPointerMemberExpression { 
    has ICastExpression             $.cast-expression is required;
    has PointerMemberExpressionTail @.pointer-member-expression-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pointer-member-expression-tail { <pointer-member-operator> <cast-expression> }
our class PointerMemberExpressionTail { 
    has IPointerMemberOperator $.pointer-member-operator is required;
    has ICastExpression         $.cast-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-----------------------

# token multiplicative-operator:sym<*> { <star> }
our class MultiplicativeOperator::Star does IMultiplicativeOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token multiplicative-operator:sym</> { <div_> }
our class MultiplicativeOperator::Slash does IMultiplicativeOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token multiplicative-operator:sym<%> { <mod_> }
our class MultiplicativeOperator::Mod does IMultiplicativeOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule multiplicative-expression { <pointer-member-expression> <multiplicative-expression-tail>* }
our class MultiplicativeExpression does IMultiplicativeExpression {
    has IPointerMemberExpression     $.pointer-member-expression is required;
    has MultiplicativeExpressionTail @.multiplicative-expression-tail is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule multiplicative-expression-tail { <multiplicative-operator> <pointer-member-expression> }
our class MultiplicativeExpressionTail {
    has IMultiplicativeOperator  $.multiplicative-operator is required;
    has IPointerMemberExpression $.pointer-member-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token additive-operator:sym<plus> { <plus> }
our class AdditiveOperator::Plus does IAdditiveOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token additive-operator:sym<minus> { <minus> }
our class AdditiveOperator::Minus does IAdditiveOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule additive-expression-tail { <additive-operator> <multiplicative-expression> }
our class AdditiveExpressionTail {
    has IAdditiveOperator        $.additive-operator         is required;
    has IMultiplicativeExpression $.multiplicative-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule additive-expression { <multiplicative-expression> <additive-expression-tail>* }
our class AdditiveExpression does IAdditiveExpression {
    has IMultiplicativeExpression $.multiplicative-expression is required;
    has AdditiveExpressionTail   @.additive-expression-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule shift-expression-tail { <shift-operator> <additive-expression> }
our class ShiftExpressionTail {
    has IShiftOperator      $.shift-operator      is required;
    has IAdditiveExpression $.additive-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule shift-expression { <additive-expression> <shift-expression-tail>* } #-----------------------
our class ShiftExpression does IShiftExpression {
    has IAdditiveExpression  $.additive-expression is required;
    has ShiftExpressionTail @.shift-expression-tail is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule shift-operator:sym<right> { <.greater> <.greater> }
our class ShiftOperator::Right does IShiftOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule shift-operator:sym<left> { <.less> <.less> } #-----------------------
our class ShiftOperator::Left does IShiftOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule relational-operator:sym<less> { <.less> }
our class RelationalOperator::Less does IRelationalOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule relational-operator:sym<greater> { <.greater> }
our class RelationalOperator::Greater does IRelationalOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule relational-operator:sym<less-eq> { <.less-equal> }
our class RelationalOperator::LessEq does IRelationalOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule relational-operator:sym<greater-eq> { <.greater-equal> } #-----------------------
our class RelationalOperator::GreaterEq does IRelationalOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex relational-expression-tail { <.ws> <relational-operator> <.ws> <shift-expression> }
our class RelationalExpressionTail {
    has IRelationalOperator  $.relational-operator is required;
    has IShiftExpression     $.shift-expression    is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex relational-expression { <shift-expression> <relational-expression-tail>* } #-----------------------
our class RelationalExpression does IRelationalExpression {
    has IShiftExpression         $.shift-expression is required;
    has RelationalExpressionTail @.relational-expression-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token equality-operator:sym<eq> { <equal> }
our class EqualityOperator::Eq does IEqualityOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token equality-operator:sym<neq> { <not-equal> } #-----------------------
our class EqualityOperator::Neq does IEqualityOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule equality-expression-tail { <equality-operator> <relational-expression> }
our class EqualityExpressionTail {
    has IEqualityOperator     $.equality-operator     is required;
    has IRelationalExpression $.relational-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule equality-expression { <relational-expression> <equality-expression-tail>* }
our class EqualityExpression does IEqualityExpression {
    has IRelationalExpression  $.relational-expression is required;
    has EqualityExpressionTail @.equality-expression-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule and-expression { <equality-expression> [ <and_> <equality-expression> ]* }
our class AndExpression does IAndExpression {
    has IEqualityExpression @.equality-expressions is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule exclusive-or-expression { <and-expression> [ <caret> <and-expression> ]* }
our class ExclusiveOrExpression does IExclusiveOrExpression {
    has IAndExpression @.and-expressions is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule inclusive-or-expression { <exclusive-or-expression> [ <or_> <exclusive-or-expression> ]* }
our class InclusiveOrExpression does IInclusiveOrExpression {
    has IExclusiveOrExpression @.exclusive-or-expressions is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule logical-and-expression { <inclusive-or-expression> [ <and-and> <inclusive-or-expression>]* }
our class LogicalAndExpression does ILogicalAndExpression {
    has IInclusiveOrExpression @.inclusive-or-expressions is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule logical-or-expression { <logical-and-expression> [ <or-or> <logical-and-expression> ]* }
our class LogicalOrExpression does ILogicalOrExpression {
    has ILogicalAndExpression @.logical-and-expressions is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule conditional-expression-tail { <question> <expression> <colon> <assignment-expression> }
our class ConditionalExpressionTail {
    has IExpression           $.question-expression   is required;
    has IAssignmentExpression $.assignment-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule conditional-expression { <logical-or-expression> <conditional-expression-tail>? } #-----------------------
our class ConditionalExpression does IMultiplicativeExpression does IConditionalExpression {
    has ILogicalOrExpression      $.logical-or-expression is required;
    has ConditionalExpressionTail $.conditional-expression-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule assignment-expression:sym<throw> { <throw-expression> }
our class AssignmentExpression::Throw does IAssignmentExpression {
    has ThrowExpression $.throw-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule assignment-expression:sym<basic> { 
#   <logical-or-expression> 
#   <assignment-operator> 
#   <initializer-clause> 
# }
our class AssignmentExpression::Basic does IAssignmentExpression {
    has ILogicalOrExpression $.logical-or-expression is required;
    has IAssignmentOperator  $.assignment-operator   is required;
    has IInitializerClause   $.initializer-clause    is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule assignment-expression:sym<conditional> { <conditional-expression> }
our class AssignmentExpression::Conditional does IAssignmentExpression {
    has IConditionalExpression $.conditional-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<assign> { <.assign> }
our class AssignmentOperator::Assign does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<star-assign> { <.star-assign> }
our class AssignmentOperator::StarAssign does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<div-assign> { <.div-assign> }
our class AssignmentOperator::DivAssign does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<mod-assign> { <.mod-assign> }
our class AssignmentOperator::ModAssign does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<plus-assign> { <.plus-assign> }
our class AssignmentOperator::PlusAssign does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<minus-assign> { <.minus-assign> }
our class AssignmentOperator::MinusAssign does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<rshift-assign> { <.right-shift-assign> }
our class AssignmentOperator::RshiftAssign does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<lshift-assign> { <.left-shift-assign> }
our class AssignmentOperator::LshiftAssign does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<and-assign> { <.and-assign> }
our class AssignmentOperator::AndAssign does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<xor-assign> { <.xor-assign> }
our class AssignmentOperator::XorAssign does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<or-assign> { <.or-assign> }
our class AssignmentOperator::OrAssign does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule expression { <assignment-expression>+ %% <.comma> }
our class Expression 
does IExpression 
does IForRangeInitializer 
does ICondition { 

    has IAssignmentExpression @.assignment-expressions is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule constant-expression { <conditional-expression> }
our class ConstantExpression does IConstantExpression {
    has IConditionalExpression $.conditional-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex comment:sym<line> { [<line-comment> <.ws>?]+ }
our class Comment::Line does IComment {
    has LineComment @.line-comments is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token statement:sym<attributed> { <comment>? <attribute-specifier-seq>? <attributed-statement-body> }
our class Statement::Attributed does IStatement {
    has IComment                 $.comment;
    has IAttributeSpecifierSeq   $.attribute-specifier-seq;
    has IAttributedStatementBody $.attributed-statement-body is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token statement:sym<labeled> { <comment>? <labeled-statement> }
our class Statement::Labeled does IStatement {
    has IComment         $.comment;
    has LabeledStatement $.labeled-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token statement:sym<declaration> { <comment>? <declaration-statement> }
our class Statement::Declaration does IStatement {
    has IComment              $.comment;
    has IDeclarationStatement $.declaration-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attributed-statement-body:sym<expression> { <expression-statement> }
our class AttributedStatementBody::Expression does IAttributedStatementBody {
    has ExpressionStatement $.expression-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attributed-statement-body:sym<compound> { <compound-statement> }
our class AttributedStatementBody::Compound does IAttributedStatementBody {
    has CompoundStatement $.compound-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attributed-statement-body:sym<selection> { <selection-statement> }
our class AttributedStatementBody::Selection does IAttributedStatementBody {
    has ISelectionStatement $.selection-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attributed-statement-body:sym<iteration> { <iteration-statement> }
our class AttributedStatementBody::Iteration does IAttributedStatementBody {
    has IIterationStatement $.iteration-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attributed-statement-body:sym<jump> { <jump-statement> }
our class AttributedStatementBody::Jump does IAttributedStatementBody {
    has IJumpStatement $.jump-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attributed-statement-body:sym<try> { <try-block> } #-----------------------------
our class AttributedStatementBody::Try does IAttributedStatementBody {
    has TryBlock $.try-block is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule labeled-statement-label-body:sym<id> { <identifier> }
our class LabeledStatementLabelBody::Id does ILabeledStatementLabelBody {
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule labeled-statement-label-body:sym<case-expr> { <case> <constant-expression> }
our class LabeledStatementLabelBody::CaseExpr does ILabeledStatementLabelBody {
    has IConstantExpression $.constant-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule labeled-statement-label-body:sym<default> { <default_> } #-----------------------------
our class LabeledStatementLabelBody::Default does ILabeledStatementLabelBody {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule labeled-statement-label { <attribute-specifier-seq>? <labeled-statement-label-body> <colon> }
our class LabeledStatementLabel {
    has IAttributeSpecifierSeq     $.attribute-specifier-seq;
    has ILabeledStatementLabelBody $.labeled-statement-label-body is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule labeled-statement { <labeled-statement-label> <statement> }
our class LabeledStatement {
    has LabeledStatementLabel $.labeled-statement-label is required;
    has IStatement            $.statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule declaration-statement { <block-declaration> } #-----------------------------
our class DeclarationStatement does IDeclarationStatement {
    has IBlockDeclaration $.block-declaration is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule expression-statement { <expression>? <semi> }
our class ExpressionStatement does IStatement { 
    has IComment    $.comment;
    has IExpression $.expression;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule compound-statement { <.left-brace> <statement-seq>? <.right-brace> }
our class CompoundStatement {
    has StatementSeq $.statement-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex statement-seq { <statement> [<.ws> <statement>]* } #-----------------------------
our class StatementSeq {
    has IStatement @.statements is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule selection-statement:sym<if> { 
#   <.if_> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> 
#   <statement> 
#   [ <comment>? <else_> <statement> ]? 
# }
our class SelectionStatement::If 
does IAttributedStatementBody 
does ISelectionStatement {
    has ICondition  $.condition is required;
    has IStatement  @.statements is required;
    has IComment    $.else-statement-comment;
    has IStatement  @.else-statements;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule selection-statement:sym<switch> { 
#   <switch> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> 
#   <statement> 
# } #-----------------------------
our class SelectionStatement::Switch does ISelectionStatement {
    has ICondition  $.condition is required;
    has IStatement $.statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule condition:sym<expr> { <expression> } #-----------------------------
our class Condition::Expr does ICondition {
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule condition-decl-tail:sym<assign-init> { <assign> <initializer-clause> }
our class ConditionDeclTail::AssignInit does IConditionDeclTail {
    has IInitializerClause $.initializer-clause is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule condition-decl-tail:sym<braced-init> { <braced-init-list> } #-----------------------------
our class ConditionDeclTail::BracedInit does IConditionDeclTail {
    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule condition:sym<decl> { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq> 
#   <declarator> 
#   <condition-decl-tail> 
# } #-----------------------------
our class Condition::Decl does ICondition {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IDeclSpecifierSeq      $.decl-specifier-seq  is required;
    has IDeclarator            $.declarator          is required;
    has IConditionDeclTail    $.condition-decl-tail is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule iteration-statement:sym<while> { 
#   <while_> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> <statement> 
# }
our class IterationStatement::While does IIterationStatement {
    has ICondition $.condition is required;
    has IStatement @.statements is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule iteration-statement:sym<do> { 
#   <.do_> 
#   <statement> 
#   <.while_> 
#   <.left-paren> 
#   <expression> 
#   <.right-paren> 
#   <.semi> 
# }
our class IterationStatement::Do does IIterationStatement {
    has IComment    $.comment;
    has IStatement  $.statement is required;
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule iteration-statement:sym<for> { 
#   <.for_> 
#   <.left-paren> 
#   <for-init-statement> 
#   <condition>? 
#   <semi> 
#   <expression>? 
#   <.right-paren> 
#   <statement> 
# }
our class IterationStatement::For does IIterationStatement {
    has IForInitStatement $.for-init-statement is required;
    has ICondition        $.condition;
    has IExpression       $.expression;
    has IStatement        @.statements is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule iteration-statement:sym<for-range> { 
#   <.for_> 
#   <.left-paren> 
#   <for-range-declaration> 
#   <.colon> 
#   <for-range-initializer> 
#   <.right-paren> 
#   <statement> 
# } #-----------------------------
our class IterationStatement::ForRange does IIterationStatement {
    has ForRangeDeclaration  $.for-range-declaration is required;
    has IForRangeInitializer $.for-range-initializer is required;
    has IStatement           @.statements is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule for-init-statement:sym<expression-statement> { <expression-statement> }
our class ForInitStatement::ExpressionStatement 
does IForInitStatement {

    has ExpressionStatement $.expression-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule for-init-statement:sym<simple-declaration> { <simple-declaration> }
our class ForInitStatement::SimpleDeclaration does IForInitStatement {
    has ISimpleDeclaration $.simple-declaration is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule for-range-declaration { <attribute-specifier-seq>? <decl-specifier-seq> <declarator> }
our class ForRangeDeclaration {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IDeclSpecifierSeq      $.decl-specifier-seq is required;
    has IDeclarator            $.declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule for-range-initializer:sym<expression> { <expression> }
our class ForRangeInitializer::Expression does IForRangeInitializer {
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule for-range-initializer:sym<braced-init-list> { <braced-init-list> } #-------------------------------
our class ForRangeInitializer::BracedInitList does IForRangeInitializer {
    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#----------------------

# rule jump-statement:sym<break> { <break_> <semi> }
our class JumpStatement::Break does IJumpStatement { 
    has IComment $.comment;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule jump-statement:sym<continue> { <continue_> <semi> }
our class JumpStatement::Continue does IJumpStatement {
    has IComment $.comment;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule jump-statement:sym<return> { <return_> <return-statement-body>? <semi> }
our class JumpStatement::Return 
does IAttributedStatementBody 
does IJumpStatement {

    has IComment             $.comment;
    has IReturnStatementBody $.return-statement-body;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule jump-statement:sym<goto> { <goto_> <identifier> <semi> }
our class JumpStatement::Goto does IJumpStatement {
    has IComment   $.comment;
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#----------------------

# rule return-statement-body:sym<expr> { <expression> }
our class ReturnStatementBody::Expr does IReturnStatementBody {
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule return-statement-body:sym<braced-init-list> { <braced-init-list> }
our class ReturnStatementBody::BracedInitList does IReturnStatementBody {
    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule declarationseq { <declaration>+ } #-------------------------------
our class Declarationseq { 
    has IDeclaration @.declarations is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule alias-declaration { 
#   <.using> 
#   <identifier> 
#   <attribute-specifier-seq>? 
#   <.assign> 
#   <the-type-id> 
#   <.semi> 
# } #---------------------------
our class AliasDeclaration { 
    has IComment               $.comment;
    has Identifier             $.identifier is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has ITheTypeId             $.the-type-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule simple-declaration:sym<basic> { <decl-specifier-seq>? <init-declarator-list>? <.semi> }
our class SimpleDeclaration::Basic 
does IDeclarationStatement 
does ISimpleDeclaration {

    has IComment           $.comment;
    has IDeclSpecifierSeq   $.decl-specifier-seq;
    has IInitDeclarator     @.init-declarator-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-declaration:sym<init-list> { <attribute-specifier-seq> <decl-specifier-seq>? <init-declarator-list> <.semi> }
our class SimpleDeclaration::InitList 
does ISimpleDeclaration {

    has IComment            $.comment;
    has IAttributeSpecifier @.attribute-specifiers is required;
    has IDeclSpecifierSeq   $.decl-specifier-seq;
    has IInitDeclarator     @.init-declarator-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule static-assert-declaration { 
#   <.static_assert> 
#   <.left-paren> 
#   <constant-expression> 
#   <.comma> 
#   <string-literal> 
#   <.right-paren> 
#   <.semi> 
# }
our class StaticAssertDeclaration { 
    has IComment            $.comment;
    has IConstantExpression $.constant-expression is required;
    has StringLiteral       $.string-literal is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule empty-declaration { <.semi> }
our class EmptyDeclaration { 
    has IComment           $.comment;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attribute-declaration { <attribute-specifier-seq> <.semi> }
our class AttributeDeclaration { 
    has IComment               $.comment;
    has IAttributeSpecifierSeq $.attribute-specifier-seq is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------

# regex decl-specifier-seq { 
#   <decl-specifier> 
#   [<.ws> <decl-specifier>]*? 
#   <attribute-specifier-seq>? 
# }
our class DeclSpecifierSeq does IDeclSpecifierSeq { 
    has IDeclSpecifier        @.decl-specifiers is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule storage-class-specifier:sym<extern> { <.extern> }
our class StorageClassSpecifier::Extern does IStorageClassSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule storage-class-specifier:sym<mutable> { <.mutable> } #---------------------------
our class StorageClassSpecifier::Mutable does IStorageClassSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule storage-class-specifier:sym<register> { <.register> }
our class StorageClassSpecifier::Register does IStorageClassSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule storage-class-specifier:sym<static> { <.static> }
our class StorageClassSpecifier::Static does IStorageClassSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule storage-class-specifier:sym<thread_local> { <.thread_local> }
our class StorageClassSpecifier::Thread_local does IStorageClassSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule function-specifier:sym<inline> { <.inline> }
our class FunctionSpecifier::Inline does IFunctionSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule function-specifier:sym<virtual> { <.virtual> }
our class FunctionSpecifier::Virtual does IFunctionSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule function-specifier:sym<explicit> { <.explicit> }
our class FunctionSpecifier::Explicit does IFunctionSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule typedef-name { <identifier> } #---------------------------
our class TypedefName { 
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule trailing-type-specifier:sym<cv-qualifier> { <cv-qualifier> <simple-type-specifier> }
our class TrailingTypeSpecifier::CvQualifier does ITrailingTypeSpecifier {
    has ICvQualifier         $.cv-qualifier          is required;
    has ISimpleTypeSpecifier $.simple-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule type-specifier-seq { <type-specifier>+ <attribute-specifier-seq>? }
our class TypeSpecifierSeq does ITypeSpecifierSeq { 
    has ITypeNameSpecifier     @.type-specifiers is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule trailing-type-specifier-seq { <trailing-type-specifier>+ <attribute-specifier-seq>? }
our class TrailingTypeSpecifierSeq { 
    has ITrailingTypeSpecifier @.trailing-type-specifiers is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-type-length-modifier:sym<short> { <.short> }
our class SimpleTypeLengthModifier::Short does ISimpleTypeLengthModifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-type-length-modifier:sym<long_> { <.long_> }
our class SimpleTypeLengthModifier::Long does ISimpleTypeLengthModifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-type-signedness-modifier:sym<unsigned> { <.unsigned> }
our class SimpleTypeSignednessModifier::Unsigned does ISimpleTypeSignednessModifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-type-signedness-modifier:sym<signed> { <.signed> }
our class SimpleTypeSignednessModifier::Signed does ISimpleTypeSignednessModifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule full-type-name { <nested-name-specifier>? <the-type-name> }
our class FullTypeName does IPostListHead does IDeclSpecifier { 
    has INestedNameSpecifier $.nested-name-specifier;
    has ITheTypeName         $.the-type-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule scoped-template-id { <nested-name-specifier> <.template> <simple-template-id> }
our class ScopedTemplateId { 
    has INestedNameSpecifier $.nested-name-specifier is required;
    has SimpleTemplateId    $.simple-template-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-int-type-specifier { 
#   <simple-type-signedness-modifier>? 
#   <simple-type-length-modifier>* 
#   <int_> 
# }
our class SimpleIntTypeSpecifier { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has ISimpleTypeLengthModifier     @.simple-type-length-modifiers is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-char-type-specifier { <simple-type-signedness-modifier>? <char_> }
our class SimpleCharTypeSpecifier { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-char16-type-specifier { <simple-type-signedness-modifier>? <char16> }
our class SimpleChar16TypeSpecifier { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-char32-type-specifier { <simple-type-signedness-modifier>? <char32> }
our class SimpleChar32TypeSpecifier { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-wchar-type-specifier { <simple-type-signedness-modifier>? <wchar> }
our class SimpleWcharTypeSpecifier { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-double-type-specifier { <simple-type-length-modifier>? <double> } #------------------------------
our class SimpleDoubleTypeSpecifier { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<int> { <simple-int-type-specifier> }
our class SimpleTypeSpecifier::Int_ does ISimpleTypeSpecifier {
    has SimpleIntTypeSpecifier $.simple-int-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<full> { <full-type-name> }
our class SimpleTypeSpecifier::Full does ISimpleTypeSpecifier {
    has FullTypeName $.full-type-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<scoped> { <scoped-template-id> }
our class SimpleTypeSpecifier::Scoped does ISimpleTypeSpecifier {
    has ScopedTemplateId $.scoped-template-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<signedness-mod> { <simple-type-signedness-modifier> }
our class SimpleTypeSpecifier::SignednessMod does ISimpleTypeSpecifier {
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<signedness-mod-length> { <simple-type-signedness-modifier>? <simple-type-length-modifier>+ }
our class SimpleTypeSpecifier::SignednessModLength does ISimpleTypeSpecifier {
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has ISimpleTypeLengthModifier     @.simple-type-length-modifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<char> { <simple-char-type-specifier> }
our class SimpleTypeSpecifier::Char does ISimpleTypeSpecifier {
    has SimpleCharTypeSpecifier $.simple-char-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<char16> { <simple-char16-type-specifier> }
our class SimpleTypeSpecifier::Char16 does ISimpleTypeSpecifier {
    has SimpleChar16TypeSpecifier $.simple-char16-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<char32> { <simple-char32-type-specifier> }
our class SimpleTypeSpecifier::Char32 does ISimpleTypeSpecifier {
    has SimpleChar32TypeSpecifier $.simple-char32-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<wchar> { <simple-wchar-type-specifier> }
our class SimpleTypeSpecifier::Wchar does ISimpleTypeSpecifier {
    has SimpleWcharTypeSpecifier $.simple-wchar-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<bool> { <bool_> }
our class SimpleTypeSpecifier::Bool does ISimpleTypeSpecifier {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<float> { <float> }
our class SimpleTypeSpecifier::Float does ISimpleTypeSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<double> { <simple-double-type-specifier> }
our class SimpleTypeSpecifier::Double does ISimpleTypeSpecifier {
    has SimpleDoubleTypeSpecifier $.simple-double-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<void> { <void_> }
our class SimpleTypeSpecifier::Void does ISimpleTypeSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<auto> { <auto> }
our class SimpleTypeSpecifier::Auto does ISimpleTypeSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex simple-type-specifier:sym<decltype> { <decltype-specifier> } #------------------------------
our class SimpleTypeSpecifier::Decltype does ISimpleTypeSpecifier {
    has DecltypeSpecifier $.decltype-specifier is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule the-type-name:sym<simple-template-id> { <simple-template-id> }
our class TheTypeName::SimpleTemplateId does ITheTypeName {
    has SimpleTemplateId $.simple-template-id is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule the-type-name:sym<class> { <class-name> }
our class TheTypeName::Class does ITheTypeName {
    has IClassName $.class-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule the-type-name:sym<enum> { <enum-name> }
our class TheTypeName::Enum does ITheTypeName {
    has EnumName $.enum-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule the-type-name:sym<typedef> { <typedef-name> } #------------------------------
our class TheTypeName::Typedef does ITheTypeName {
    has TypedefName $.typedef-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule decltype-specifier-body:sym<expr> { <expression> }
our class DecltypeSpecifierBody::Expr does IDecltypeSpecifierBody {
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule decltype-specifier-body:sym<auto> { <auto> }
our class DecltypeSpecifierBody::Auto does IDecltypeSpecifierBody {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule decltype-specifier { 
#   <decltype> 
#   <.left-paren> 
#   <decltype-specifier-body> 
#   <.right-paren> 
# } #------------------------------
our class DecltypeSpecifier { 
    has IDecltypeSpecifierBody $.decltype-specifier-body is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule elaborated-type-specifier:sym<class-ident> { <.class-key> <attribute-specifier-seq>? <nested-name-specifier>? <identifier> }
our class ElaboratedTypeSpecifier::ClassIdent does IElaboratedTypeSpecifier {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has INestedNameSpecifier   $.nested-name-specifier;
    has Identifier            $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule elaborated-type-specifier:sym<class-template-id> { <.class-key> <simple-template-id> }
our class ElaboratedTypeSpecifier::ClassTemplateId does IElaboratedTypeSpecifier {
    has SimpleTemplateId $.simple-template-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule elaborated-type-specifier:sym<class-nested-template-id> { <.class-key> <nested-name-specifier> <template>? <simple-template-id> }
our class ElaboratedTypeSpecifier::ClassNestedTemplateId does IElaboratedTypeSpecifier {
    has INestedNameSpecifier $.nested-name-specifier is required;
    has SimpleTemplateId    $.simple-template-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule elaborated-type-specifier:sym<enum> { <.enum_> <nested-name-specifier>? <identifier> } #------------------------------
our class ElaboratedTypeSpecifier::Enum does IElaboratedTypeSpecifier {
    has INestedNameSpecifier $.nested-name-specifier;
    has Identifier          $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-----------------------

# rule virtual-specifier-seq { <virtual-specifier>+ } #-----------------------------
our class VirtualSpecifierSeq { 
    has IVirtualSpecifier @.virtual-specifiers is required;
}


# rule virtual-specifier:sym<override> { <override> }
our class VirtualSpecifier::Override does IVirtualSpecifier { }

# rule virtual-specifier:sym<final> { <final> } #-----------------------------
our class VirtualSpecifier::Final does IVirtualSpecifier { }

# rule pure-specifier { 
#   <assign> 
#   <val=octal-literal> 
#   #|{if($val.text.compareTo("0")!=0) throw new InputMismatchException(this); } 
# }
our class PureSpecifier { 
    has OctalLiteral $.val is required;
}

# rule base-clause { <colon> <base-specifier-list> }
our class BaseClause { 
    has BaseSpecifierList $.base-specifier-list is required;
}

# rule base-specifier-list { 
#   <base-specifier> 
#   <ellipsis>? 
#   [ <.comma> <base-specifier> <ellipsis>? ]* 
# } #-----------------------------
our class BaseSpecifierList { 
    has IBaseSpecifier @.base-specifiers is required;
}


# rule base-specifier:sym<base-type> { <attribute-specifier-seq>? <base-type-specifier> }
our class BaseSpecifier::BaseType does IBaseSpecifier {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has BaseTypeSpecifier $.base-type-specifier is required;
}

# rule base-specifier:sym<virtual> { <attribute-specifier-seq>? <virtual> <access-specifier>? <base-type-specifier> }
our class BaseSpecifier::Virtual does IBaseSpecifier {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IAccessSpecifier $.access-specifier;
    has BaseTypeSpecifier $.base-type-specifier is required;
}

# rule base-specifier:sym<access> { 
#   <attribute-specifier-seq>? 
#   <access-specifier> 
#   <virtual>? 
#   <base-type-specifier> 
# }
our class BaseSpecifier::Access does IBaseSpecifier {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IAccessSpecifier       $.access-specifier    is required;
    has Bool                  $.is-virtual          is required;
    has BaseTypeSpecifier     $.base-type-specifier is required;
}


# rule class-or-decl-type:sym<class> { <nested-name-specifier>? <class-name> }
our class ClassOrDeclType::Class does IClassOrDeclType {
    has INestedNameSpecifier $.nested-name-specifier;
    has IClassName           $.class-name is required;
}

# rule class-or-decl-type:sym<decltype> { <decltype-specifier> } #-----------------------------
our class ClassOrDeclType::Decltype does IClassOrDeclType {
    has DecltypeSpecifier $.decltype-specifier is required;
}

# rule base-type-specifier { <class-or-decl-type> }
our class BaseTypeSpecifier { 
    has IClassOrDeclType $.class-or-decl-type is required;
}


# rule access-specifier:sym<private> { <private> }
our class AccessSpecifier::Private does IAccessSpecifier { }

# rule access-specifier:sym<protected> { <protected> }
our class AccessSpecifier::Protected does IAccessSpecifier { }

# rule access-specifier:sym<public> { <public> }
our class AccessSpecifier::Public does IAccessSpecifier { }

# rule conversion-function-id { <operator> <conversion-type-id> }
our class ConversionFunctionId { 
    has ConversionTypeId $.conversion-type-id is required;
}

# rule conversion-type-id { <type-specifier-seq> <conversion-declarator>? }
our class ConversionTypeId { 
    has ITypeSpecifierSeq    $.type-specifier-seq is required;
    has ConversionDeclarator $.conversion-declarator;
}

# rule conversion-declarator { <pointer-operator> <conversion-declarator>? }
our class ConversionDeclarator { 
    has IPointerOperator      $.pointer-operator is required;
    has ConversionDeclarator $.conversion-declarator;
}

# rule constructor-initializer { <colon> <mem-initializer-list> }
our class ConstructorInitializer { 
    has MemInitializerList $.mem-initializer-list is required;
}

# rule mem-initializer-list { 
#   <mem-initializer> 
#   <ellipsis>? 
#   [ <.comma> <mem-initializer> <ellipsis>? ]* 
# } #-----------------------------
our class MemInitializerList { 
    has IMemInitializer @.mem-initializers is required;
}


# rule mem-initializer:sym<expr-list> { 
#   <meminitializerid> 
#   <.left-paren> 
#   <expression-list>? 
#   <.right-paren> 
# }
our class MemInitializer::ExprList does IMemInitializer {
    has IMeminitializerid $.meminitializerid is required;
    has ExpressionList   $.expression-list;
}

# rule mem-initializer:sym<braced> { 
#   <meminitializerid> 
#   <braced-init-list> 
# } #-----------------------------
our class MemInitializer::Braced does IMemInitializer {
    has IMeminitializerid $.meminitializerid is required;
    has BracedInitList   $.braced-init-list   is required;
}


# rule meminitializerid:sym<class-or-decl> { <class-or-decl-type> }
our class Meminitializerid::ClassOrDecl does IMeminitializerid {
    has IClassOrDeclType $.class-or-decl-type is required;
}

# rule meminitializerid:sym<ident> { <identifier> }
our class Meminitializerid::Ident does IMeminitializerid {
    has Identifier $.identifier is required;
}

# rule operator-function-id { 
#   <operator> 
#   <the-operator> 
# } #-----------------------------
our class OperatorFunctionId { 
    has ITheOperator $.the-operator is required;
}


# rule literal-operator-id:sym<string-lit> { <operator> <string-literal> <identifier> }
our class LiteralOperatorId::StringLit does ILiteralOperatorId {
    has StringLiteral $.string-literal is required;
    has Identifier    $.identifier     is required;
}

# rule literal-operator-id:sym<user-defined> { 
#   <operator> 
#   <user-defined-string-literal> 
# } #-----------------------------
our class LiteralOperatorId::UserDefined does ILiteralOperatorId {
    has UserDefinedStringLiteral $.user-defined-string-literal is required;
}

# rule template-declaration { 
#   <template> 
#   <less> 
#   <templateparameter-list> 
#   <greater> 
#   <declaration> 
# }
our class TemplateDeclaration { 
    has TemplateParameterList $.templateparameter-list is required;
    has IDeclaration          $.declaration            is required;
}

# rule templateparameter-list { 
#   <template-parameter> 
#   [ <.comma> <template-parameter> ]* 
# }
our class TemplateParameterList { 
    has ITemplateParameter @.template-parameters is required;
}


# rule template-parameter:sym<type> { <type-parameter> }
our class TemplateParameter::Type does ITemplateParameter {
    has TypeParameter $.type-parameter is required;
}

# rule template-parameter:sym<param> { <parameter-declaration> } #-----------------------------
our class TemplateParameter::Param does ITemplateParameter {
    has ParameterDeclaration $.parameter-declaration is required;
}


# rule type-parameter-base:sym<basic> { 
# [ <template> <less> <templateparameter-list> <greater> ]? 
# <class_> 
# }
our class TypeParameterBase::Basic does ITypeParameterBase {
    has TemplateParameterList $.templateparameter-list;
}

# rule type-parameter-base:sym<typename> { <typename_> } #-----------------------------
our class TypeParameterBase::Typename does ITypeParameterBase { }


# rule type-parameter-suffix:sym<maybe-ident> { <ellipsis>? <identifier>? }
our class TypeParameterSuffix::MaybeIdent does ITypeParameterSuffix {
    has Bool       $.has-ellipsis;
    has Identifier $.identifier;
}

# rule type-parameter-suffix:sym<assign-type-id> { <identifier>? <assign> <the-type-id> } #-----------------------------
our class TypeParameterSuffix::AssignTypeId does ITypeParameterSuffix {
    has Identifier $.identifier;
    has ITheTypeId $.the-type-id is required;
}

# rule type-parameter { <type-parameter-base> <type-parameter-suffix> }
our class TypeParameter { 
    has ITypeParameterBase   $.type-parameter-base   is required;
    has ITypeParameterSuffix $.type-parameter-suffix is required;
}

# rule simple-template-id { 
# <template-name> 
# <less> 
# <template-argument-list>? 
# <greater> 
# }
our class SimpleTemplateId 
does IDeclSpecifierSeq
does IPostListHead
{ 
    has Identifier           $.template-name is required;
    has ITemplateArgument @.template-arguments;
}


# rule template-id:sym<simple> { <simple-template-id> }
our class TemplateId::Simple does ITemplateId {
    has SimpleTemplateId $.simple-template-id is required;
}

# rule template-id:sym<operator-function-id> { <operator-function-id> <less> <template-argument-list>? <greater> }
our class TemplateId::OperatorFunctionId does ITemplateId {
    has OperatorFunctionId   $.operator-function-id is required;
    has TemplateArgumentList $.template-argument-list;
}

# rule template-id:sym<literal-operator-id> { 
# <literal-operator-id> 
# <less> 
# <template-argument-list>? 
# <greater> } #-----------------------------
our class TemplateId::LiteralOperatorId does ITemplateId {
    has ILiteralOperatorId   $.literal-operator-id is required;
    has TemplateArgumentList $.template-argument-list;
}

# rule template-argument-list { 
# <template-argument> 
# <ellipsis>? 
# [ <.comma> <template-argument> <ellipsis>? ]* 
# }
our class TemplateArgumentList { 
    has ITemplateArgument @.template-arguments is required;
}


# token template-argument:sym<type-id> { <the-type-id> }
our class TemplateArgument::TypeId does ITemplateArgument {
    has ITheTypeId $.the-type-id is required;
}

# token template-argument:sym<const-expr> { <constant-expression> }
our class TemplateArgument::ConstExpr does ITemplateArgument {
    has IConstantExpression $.constant-expression is required;
}

# token template-argument:sym<id-expr> { <id-expression> } #---------------------
our class TemplateArgument::IdExpr does ITemplateArgument {
    has IIdExpression $.id-expression is required;
}


# rule type-name-specifier:sym<ident> { <typename_> <nested-name-specifier> <identifier> }
our class TypeNameSpecifier::Ident does ITypeNameSpecifier {
    has INestedNameSpecifier $.nested-name-specifier is required;
    has Identifier $.identifier is required;
}

# rule type-name-specifier:sym<template> { 
#   <typename_> 
#   <nested-name-specifier> 
#   <template>? 
#   <simple-template-id> 
# }
our class TypeNameSpecifier::Template does ITypeNameSpecifier {
    has INestedNameSpecifier $.nested-name-specifier is required;
    has Bool                $.has-template          is required;
    has SimpleTemplateId    $.simple-template-id    is required;
}

# rule explicit-instantiation { <extern>? <template> <declaration> }
our class ExplicitInstantiation { 
    has Bool        $.extern      is required;
    has IDeclaration $.declaration is required; 
}

# rule explicit-specialization { <template> <less> <greater> <declaration> }
our class ExplicitSpecialization { 
    has IDeclaration $.declaration is required;
}

# rule try-block { <try_> <compound-statement> <handler-seq> }
our class TryBlock { 
    has CompoundStatement $.compound-statement is required;
    has HandlerSeq        $.handler-seq        is required;
}

# rule function-try-block { <try_> <constructor-initializer>? <compound-statement> <handler-seq> }
our class FunctionTryBlock { 
    has ConstructorInitializer $.constructor-initializer;
    has CompoundStatement      $.compound-statement is required;
    has HandlerSeq             $.handler-seq is required;
}

# rule handler-seq { <handler>+ }
our class HandlerSeq { 
    has Handler @.handlers is required;
}

# rule handler { 
#   <catch> 
#   <.left-paren> 
#   <exception-declaration> 
#   <.right-paren> 
#   <compound-statement> 
# }
our class Handler { 
    has IExceptionDeclaration $.exception-declaration is required;
    has CompoundStatement    $.compound-statement is required;
}


# rule some-declarator:sym<basic> { <declarator> }
our class SomeDeclarator::Basic does ISomeDeclarator {
    has IDeclarator $.declarator is required;
}

# rule some-declarator:sym<abstract> { <abstract-declarator> } #---------------------
our class SomeDeclarator::Abstract does ISomeDeclarator {
    has IAbstractDeclarator $.abstract-declarator is required;
}


# rule exception-declaration:sym<basic> { <attribute-specifier-seq>? <type-specifier-seq> <some-declarator>? }
our class ExceptionDeclaration::Basic does IExceptionDeclaration {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has ITypeSpecifierSeq      $.type-specifier-seq is required;
    has ISomeDeclarator        $.some-declarator;
}

# rule exception-declaration:sym<ellipsis> { <ellipsis> }
our class ExceptionDeclaration::Ellipsis does IExceptionDeclaration { }

# rule throw-expression { <throw> <assignment-expression>? } #---------------------
our class ThrowExpression does IAssignmentExpression { 
    has IAssignmentExpression $.assignment-expression;
}

# token exception-specification:sym<dynamic> { <dynamic-exception-specification> }
our class ExceptionSpecification::Dynamic does IExceptionSpecification {
    has DynamicExceptionSpecification $.dynamic-exception-specification is required;
}

# token exception-specification:sym<noexcept> { <noe-except-specification> } #---------------------
our class ExceptionSpecification::Noexcept does IExceptionSpecification {
    has INoeExceptSpecification $.noe-except-specification is required;
}

# rule dynamic-exception-specification { <throw> <.left-paren> <type-id-list>? <.right-paren> }
our class DynamicExceptionSpecification { 
    has TypeIdList $.type-id-list;
}

# rule type-id-list { <the-type-id> <ellipsis>? [ <.comma> <the-type-id> <ellipsis>? ]* } #---------------------
our class TypeIdList { 
    has ITheTypeId @.the-type-ids is required;
}

# token noe-except-specification:sym<full> { <noexcept> <.left-paren> <constant-expression> <.right-paren> }
our class NoeExceptSpecification::Full does INoeExceptSpecification {
    has IConstantExpression $.constant-expression is required;
}

# token noe-except-specification:sym<keyword-only> { <noexcept> } #---------------------
our class NoeExceptSpecification::KeywordOnly does INoeExceptSpecification { }

# token the-operator:sym<new> { <new_> [ <.left-bracket> <.right-bracket>]? }
our class TheOperator::New does ITheOperator { }

# token the-operator:sym<delete> { <delete> [ <.left-bracket> <.right-bracket>]? }
our class TheOperator::Delete does ITheOperator { }

# token the-operator:sym<plus> { <plus> }
our class TheOperator::Plus does ITheOperator { }

# token the-operator:sym<minus> { <minus> }
our class TheOperator::Minus does ITheOperator { }

# token the-operator:sym<star> { <star> }
our class TheOperator::Star does ITheOperator { }

# token the-operator:sym<div_> { <div_> }
our class TheOperator::Div does ITheOperator { }

# token the-operator:sym<mod_> { <mod_> }
our class TheOperator::Mod does ITheOperator { }

# token the-operator:sym<caret> { <caret> }
our class TheOperator::Caret does ITheOperator { }

# token the-operator:sym<and_> { <and_> <!before <and_>> }
our class TheOperator::And does ITheOperator { }

# token the-operator:sym<or_> { <or_> }
our class TheOperator::Or does ITheOperator { }

# token the-operator:sym<tilde> { <tilde> }
our class TheOperator::Tilde does ITheOperator { }

# token the-operator:sym<not> { <not_> }
our class TheOperator::Not does ITheOperator { }

# token the-operator:sym<assign> { <assign> }
our class TheOperator::Assign does ITheOperator { }

# token the-operator:sym<greater> { <greater> }
our class TheOperator::Greater does ITheOperator { }

# token the-operator:sym<less> { <less> }
our class TheOperator::Less does ITheOperator { }

# token the-operator:sym<greater-equal> { <greater-equal> }
our class TheOperator::GreaterEqual does ITheOperator { }

# token the-operator:sym<plus-assign> { <plus-assign> }
our class TheOperator::PlusAssign does ITheOperator { }

# token the-operator:sym<minus-assign> { <minus-assign> }
our class TheOperator::MinusAssign does ITheOperator { }

# token the-operator:sym<star-assign> { <star-assign> }
our class TheOperator::StarAssign does ITheOperator { }

# token the-operator:sym<mod-assign> { <mod-assign> }
our class TheOperator::ModAssign does ITheOperator { }

# token the-operator:sym<xor-assign> { <xor-assign> }
our class TheOperator::XorAssign does ITheOperator { }

# token the-operator:sym<and-assign> { <and-assign> }
our class TheOperator::AndAssign does ITheOperator { }

# token the-operator:sym<or-assign> { <or-assign> }
our class TheOperator::OrAssign does ITheOperator { }

# token the-operator:sym<LessLess> { <less> <less> }
our class TheOperator::LessLess does ITheOperator { }

# token the-operator:sym<GreaterGreater> { <greater> <greater> }
our class TheOperator::GreaterGreater does ITheOperator { }

# token the-operator:sym<right-shift-assign> { <right-shift-assign> }
our class TheOperator::RightShiftAssign does ITheOperator { }

# token the-operator:sym<left-shift-assign> { <left-shift-assign> }
our class TheOperator::LeftShiftAssign does ITheOperator { }

# token the-operator:sym<equal> { <equal> }
our class TheOperator::Equal does ITheOperator { }

# token the-operator:sym<not-equal> { <not-equal> }
our class TheOperator::NotEqual does ITheOperator { }

# token the-operator:sym<less-equal> { <less-equal> }
our class TheOperator::LessEqual does ITheOperator { }

# token the-operator:sym<and-and> { <and-and> }
our class TheOperator::AndAnd does ITheOperator { }

# token the-operator:sym<or-or> { <or-or> }
our class TheOperator::OrOr does ITheOperator { }

# token the-operator:sym<plus-plus> { <plus-plus> }
our class TheOperator::PlusPlus does ITheOperator { }

# token the-operator:sym<minus-minus> { <minus-minus> }
our class TheOperator::MinusMinus does ITheOperator { }

# token the-operator:sym<comma> { <.comma> }
our class TheOperator::Comma does ITheOperator { }

# token the-operator:sym<arrow-star> { <arrow-star> }
our class TheOperator::ArrowStar does ITheOperator { }

# token the-operator:sym<arrow> { <arrow> }
our class TheOperator::Arrow does ITheOperator { }

# token the-operator:sym<Parens> { <.left-paren> <.right-paren> }
our class TheOperator::Parens does ITheOperator { }

# token the-operator:sym<Brak> { <.left-bracket> <.right-bracket> }
our class TheOperator::Brak does ITheOperator { }

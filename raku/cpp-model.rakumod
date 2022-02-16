
our class Identifier         { has Str $.value is required; }
our class Nondigit           { has Str $.value is required; }
our class Digit              { has Str $.value is required; }
our class DecimalLiteral     { has Str $.value is required; }
our class OctalLiteral       { has Str $.value is required; }
our class HexadecimalLiteral { has Str $.value is required; }
our class BinaryLiteral      { has Str $.value is required; }
our class Nonzerodigit       { has Str $.value is required; }
our class Octaldigit         { has Str $.value is required; }
our class Hexadecimaldigit   { has Str $.value is required; }
our class Binarydigit        { has Str $.value is required; }

#-------------------------------
our role INot { }
our class Not::Bang      does INot { }
our class Not::Not       does INot { }

#-------------------------------
our role IAndAnd { }
our class AndAnd::AndAnd does IAndAnd { }
our class AndAnd::And    does IAndAnd { }

#-------------------------------
our role IOrOr { }
our class OrOr::PipePipe does IOrOr { }
our class OrOr::Or       does IOrOr { }

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
our class ConstructorInitializer                   { ... }
our class ConversionDeclarator                     { ... }
our class ConversionFunctionId                     { ... }
our class ConversionTypeId                         { ... }
our class Cvqualifierseq                           { ... }
our class DeclSpecifierSeq                         { ... }
our class DeclarationStatement                     { ... }
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
our class InitDeclaratorList                       { ... }
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
our class NewDeclarator                            { ... }
our class NewPlacement                             { ... }
our class NewTypeId                                { ... }
our class NoExceptExpression                       { ... }
our class NoPointerAbstractDeclarator              { ... }
our class NoPointerAbstractDeclaratorBracketedBase { ... }
our class NoPointerAbstractPackDeclarator          { ... }
our class NoPointerDeclarator                      { ... }
our class NoPointerNewDeclarator                   { ... }
our class NoPointerNewDeclaratorTail               { ... }
our class Octalescapesequence                      { ... }
our class OpaqueEnumDeclaration                    { ... }
our class OperatorFunctionId                       { ... }
our class OriginalNamespaceName                    { ... }
our class ParameterDeclaration                     { ... }
our class ParameterDeclarationClause               { ... }
our class ParameterDeclarationList                 { ... }
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
our class TemplateName                             { ... }
our class TemplateParameterList                    { ... }
our class TheTypeId                                { ... }
our class ThrowExpression                          { ... }
our class TrailingReturnType                       { ... }
our class TryBlock                                 { ... }
our class TypeIdList                               { ... }
our class TypeIdOfTheTypeId                        { ... }
our class TypeParameter                            { ... }
our class TypeSpecifierSeq                         { ... }
our class Unsignedsuffix                           { ... }
our class UserDefinedCharacterLiteral              { ... }
our class UserDefinedStringLiteral                 { ... }
our class UsingDeclaration                         { ... }
our class UsingDirective                           { ... }
our class VirtualSpecifierSeq                      { ... }

our role IAssignmentExpression                    { ... }
our role IAttributedStatementBody                 { ... }
our role ICapture                                 { ... }
our role IUnaryExpression                          { ... }
our role IUnaryExpressionCase does IUnaryExpression  { ... }
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

our role ICharacterLiteralPrefix { }

# token literal:sym<int> { <integer-literal> }
our role IIntegerLiteral  does ILiteral { }

# token literal:sym<float> { <floating-literal> }
our role IFloatingLiteral does ILiteral { }

# token literal:sym<bool> { <boolean-literal> }
our role IBooleanLiteral  does ILiteral { }

# token literal:sym<user-defined> { <user-defined-literal> }
our role IUserDefinedLiteral does ILiteral { }

our role IUniversalcharactername { }
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
our role IUserDefinedIntegerLiteral { }
our role IUserDefinedFloatingLiteral { }

our role IPostfixExpressionTail { }

# token postfix-expression-body { 
#   || <postfix-expression-list> 
#   || <postfix-expression-cast> 
#   || <postfix-expression-typeid> 
#   || <primary-expression> 
# }
our role IPostfixExpressionBody { }

our role IPrimaryExpression does IPostfixExpressionBody { }
our role IIdExpression { }
our role IUnqualifiedId { }
our role INestedNameSpecifierPrefix { }
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
# rule unary-expression { <new-expression> || <unary-expression-case> }
our role IUnaryExpression { }
our role IUnaryExpressionCase does IUnaryExpression { }

our role IUnaryOperator { }
our role INewExpression { }
our role INewInitializer { }
our role IPointerMemberOperator { }
our role IMultiplicativeOperator { }
our role IAdditiveOperator { }
our role IShiftOperator { }
our role IRelationalOperator { }
our role IEqualityOperator { }
our role IAssignmentExpression { }
our role IAssignmentOperator { }
our role IComment { }
our role IStatement { }
our role IAttributedStatementBody { }
our role ILabeledStatementLabelBody { }
our role ISelectionStatement { }
our role ICondition { }
our role IConditionDeclTail { }
our role IIterationStatement { }
our role IForInitStatement { }
our role IForRangeInitializer { }
our role IJumpStatement { }
our role IReturnStatementBody { }
our role IDeclaration { }
our role IBlockDeclaration { }
our role ISimpleDeclaration { }
our role IDeclSpecifier { }
our role IStorageClassSpecifier { }
our role IFunctionSpecifier { }
our role ITypeSpecifier { }
our role ITrailingTypeSpecifier { }
our role ISimpleTypeLengthModifier { }
our role ISimpleTypeSignednessModifier { }
our role ISimpleTypeSpecifier { }
our role ITheTypeName { }
our role IDecltypeSpecifierBody { }
our role IElaboratedTypeSpecifier { }
our role INamespaceName { }
our role INamespaceTag { }
our role IUsingDeclarationPrefix { }
our role ILinkageSpecificationBody { }
our role IAttributeSpecifier { }
our role IAlignmentspecifierbody { }
our role IBalancedrule { }
our role IDeclarator { }
our role INoPointerDeclaratorBase { }
our role INoPointerDeclaratorTail { }
our role IPointerOperator { }
our role ICvQualifier { }
our role IRefqualifier { }
our role IAbstractDeclarator { }
our role IPointerAbstractDeclarator { }
our role INoPointerAbstractDeclaratorBody { }
our role INoPointerAbstractDeclaratorBase { }
our role INoPointerAbstractPackDeclaratorBody { }
our role IParameterDeclarationBody { }
our role IFunctionBody { }
our role IInitializer { }
our role IBraceOrEqualInitializer { }
our role IInitializerClause { }
our role IClassName { }
our role IClassHead { }
our role IClassKey { }
our role IMemberSpecificationBase { }
our role IMemberdeclaration { }
our role IMemberDeclarator { }
our role IVirtualSpecifier { }
our role IBaseSpecifier { }
our role IClassOrDeclType { }
our role IAccessSpecifier { }
our role IMemInitializer { }
our role IMeminitializerid { }
our role ILiteralOperatorId { }
our role ITemplateParameter { }
our role ITypeParameterBase { }
our role ITypeParameterSuffix { }
our role ITemplateId { }
our role ITemplateArgument { }
our role ITypeNameSpecifier { }
our role ISomeDeclarator { }
our role IExceptionDeclaration { }
our role IExceptionSpecification { }
our role INoeExceptSpecification { }
our role ITheOperator { }
our role ILiteral { }

our subset Quad of List where (HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral);

#-------------------------------

our class IntegerLiteral::Dec does IIntegerLiteral {
    has DecimalLiteral     $.decimal-literal is required;
    has IIntegersuffix      $.integersuffix;
}

our class IntegerLiteral::Oct does IIntegerLiteral {
    has OctalLiteral       $.octal-literal is required;
    has IIntegersuffix      $.integersuffix;
}

our class IntegerLiteral::Hex does IIntegerLiteral {
    has HexadecimalLiteral $.hexadecimal-literal is required;
    has IIntegersuffix      $.integersuffix;
}

our class IntegerLiteral::Bin does IIntegerLiteral {
    has BinaryLiteral      $.binary-literal is required;
    has IIntegersuffix      $.integersuffix;
}

#-------------------------------

our class CharacterLiteralPrefix::U    does ICharacterLiteralPrefix { }
our class CharacterLiteralPrefix::BigU does ICharacterLiteralPrefix { }
our class CharacterLiteralPrefix::L    does ICharacterLiteralPrefix { }

#-------------------------------
# token literal:sym<char> { <character-literal> }
our class CharacterLiteral { 
    has ICharacterLiteralPrefix $.character-literal-prefix;
    has ICchar                  @.cchar;
}


our class FloatingLiteral::Frac does IFloatingLiteral {
    has IFractionalconstant $.fractionalconstant is required;
    has Exponentpart        $.exponentpart;
    has Floatingsuffix      $.floatingsuffix;
}

our class FloatingLiteral::Digit does IFloatingLiteral {
    has Digitsequence  $.digitsequence is required;
    has Exponentpart   $.exponentpart  is required;
    has Floatingsuffix $.floatingsuffix;
}

# token literal:sym<str> { <string-literal> }
our class StringLiteral does ILiteral { 
    has Str $.value;
}

#-------------------------------

our class BooleanLiteral::F does IBooleanLiteral { }

our class BooleanLiteral::T does IBooleanLiteral { }

# token literal:sym<ptr> { <pointer-literal> }
our class PointerLiteral does ILiteral { }

#-------------------------------

our class UserDefinedLiteral::Int { 
    has IUserDefinedIntegerLiteral   $.user-defined-integer-literal is required;
}

our class UserDefinedLiteral::Float does IUserDefinedLiteral {
    has IUserDefinedFloatingLiteral  $.user-defined-floating-literal is required;
}

our class UserDefinedLiteral::Str does IUserDefinedLiteral {
    has UserDefinedStringLiteral    $.user-defined-string-literal is required;
}

our class UserDefinedLiteral::Char does IUserDefinedLiteral {
    has UserDefinedCharacterLiteral $.user-defined-character-literal is required;
}

#-------------------------------
our class MultiLineMacro { 
    has Str $.content is required;
}

our class Directive { 
    has Str $.content is required;
}

our class Hexquad { 
    has Quad @hexadecimaldigit is required;
}

#-------------------------------

our class Universalcharactername::One does IUniversalcharactername {
    has Hexquad $.first is required;
}

our class Universalcharactername::Two does IUniversalcharactername {
    has Hexquad $.first is required;
    has Hexquad $.second is required;
}

#-------------------------------

our class IdentifierStart::Nondigit does IIdentifierStart {
    has Nondigit $.nondigit is required;
}

our class IdentifierStart::Ucn does IIdentifierStart {
    has IUniversalcharactername $.universalcharactername is required;
}

#-------------------------------

our class IdentifierContinue::Digit does IIdentifierContinue {
    has Digit $.digit is required;
}

our class IdentifierContinue::Nondigit does IIdentifierContinue {
    has Nondigit $.nondigit is required;
}

our class IdentifierContinue::Ucn does IIdentifierContinue {
    has IUniversalcharactername $.universalcharactername is required;
}

#-------------------------------

our class Integersuffix::Ul does IIntegersuffix {
    has Unsignedsuffix $.unsignedsuffix is required;
    has Longsuffix     $.longsuffix;
}

our class Integersuffix::Ull does IIntegersuffix {
    has Unsignedsuffix $.unsignedsuffix is required;
    has ILonglongsuffix $.longlongsuffix;
}

our class Integersuffix::Lu does IIntegersuffix {
    has Longsuffix     $.longsuffix is required;
    has Unsignedsuffix $.unsignedsuffix;
}

our class Integersuffix::Llu does IIntegersuffix {
    has ILonglongsuffix $.longsuffix is required;
    has Unsignedsuffix $.unsignedsuffix;
}

our class Unsignedsuffix { }
our class Longsuffix     { }

#-------------------------------
our class Longlongsuffix::Ll does ILonglongsuffix { }
our class Longlongsuffix::LL does ILonglongsuffix { }

#-------------------------------

our class Cchar::Basic does ICchar {
    has Str $.value is required;
}

our class Cchar::Escape does ICchar {
    has IEscapesequence $.escapesequence is required;
}

our class Cchar::Universal does ICchar {
    has IUniversalcharactername $.universalcharactername is required;
}

#-------------------------------

our class Escapesequence::Simple does IEscapesequence {
    has ISimpleescapesequence $.simpleescapesequence is required;
}

our class Escapesequence::Octal does IEscapesequence {
    has Octalescapesequence $.octalescapesequence is required;
}

our class Escapesequence::Hex does IEscapesequence {
    has Hexadecimalescapesequence $.hexadecimalescapesequence is required;
}

#-------------------------------
our class Simpleescapesequence::Slash       does ISimpleescapesequence { }
our class Simpleescapesequence::Quote       does ISimpleescapesequence { }
our class Simpleescapesequence::Question    does ISimpleescapesequence { }
our class Simpleescapesequence::DoubleSlash does ISimpleescapesequence { }
our class Simpleescapesequence::A           does ISimpleescapesequence { }
our class Simpleescapesequence::B           does ISimpleescapesequence { }
our class Simpleescapesequence::F           does ISimpleescapesequence { }
our class Simpleescapesequence::N           does ISimpleescapesequence { }
our class Simpleescapesequence::R           does ISimpleescapesequence { }
our class Simpleescapesequence::T           does ISimpleescapesequence { }
our class Simpleescapesequence::V           does ISimpleescapesequence { }
our class Simpleescapesequence::RnN         does ISimpleescapesequence { }

our class Octalescapesequence { 
    has Octaldigit @.digits is required;
}

our class Hexadecimalescapesequence { 
    has Hexadecimaldigit @.digits is required;
}

#-------------------------------

our class Fractionalconstant::WithTail does IFractionalconstant {
    has Str $.value is required;
}

our class Fractionalconstant::NoTail does IFractionalconstant {
    has Str $.value is required;
}

our class ExponentpartPrefix { }

our class Exponentpart { 
    has Str $.value is required;
}

our class Sign::Plus  { }
our class Sign::Minus { }

our class Digitsequence { 
    has Digit @.digits is required;
}

our class Floatingsuffix { }

#-------------------------------

our class Encodingprefix::U8 does IEncodingprefix { }
our class Encodingprefix::u  does IEncodingprefix { }
our class Encodingprefix::U  does IEncodingprefix { }
our class Encodingprefix::L  does IEncodingprefix { }

#-------------------------------

our class Schar::Basic does ISchar {
    has Str $.value is required;
}

our class Schar::Escape does ISchar {
    has IEscapesequence $.escapesequence is required;
}

our class Schar::Ucn does ISchar {
    has IUniversalcharactername $.universalcharactername is required;
}

our class Rawstring { 
    has Str $.value is required;
}

#-------------------------------

# token user-defined-integer-literal:sym<dec> { <decimal-literal> <udsuffix> }
our class UserDefinedIntegerLiteral::Dec does IUserDefinedIntegerLiteral {
    has DecimalLiteral $.decimal-literal is required;
}

# token user-defined-integer-literal:sym<oct> { <octal-literal> <udsuffix> }
our class UserDefinedIntegerLiteral::Oct does IUserDefinedIntegerLiteral {
    has OctalLiteral $.octal-literal is required;
}

# token user-defined-integer-literal:sym<hex> { <hexadecimal-literal> <udsuffix> }
our class UserDefinedIntegerLiteral::Hex does IUserDefinedIntegerLiteral {
    has HexadecimalLiteral $.hexadecimal-literal is required;
}

# token user-defined-integer-literal:sym<bin> { <binary-literal> <udsuffix> }      #-------------------
our class UserDefinedIntegerLiteral::Bin does IUserDefinedIntegerLiteral {
    has BinaryLiteral $.binary-literal is required;
}


# token user-defined-floating-literal:sym<frac> { <fractionalconstant> <exponentpart>?  <udsuffix> }
our class UserDefinedFloatingLiteral::Frac does IUserDefinedFloatingLiteral {
    has IFractionalconstant $.fractionalconstant is required;
    has Exponentpart        $.exponentpart;
}

# token user-defined-floating-literal:sym<digi> { <digitsequence> <exponentpart> <udsuffix> }      #-------------------
our class UserDefinedFloatingLiteral::Digi does IUserDefinedFloatingLiteral {
    has Str $.value is required;
}

# token user-defined-string-literal    { <string-literal> <udsuffix> }
our class UserDefinedStringLiteral { 
    has Str $.value is required;
}

# token user-defined-character-literal { <character-literal> <udsuffix> }
our class UserDefinedCharacterLiteral { 
    has Str $.value is required;
}

# token udsuffix {         <identifier>     }
our class Udsuffix { 
    has Str $.value is required;
}

# token block-comment {         '/*' .*?  '*/'     }
our class BlockComment { 
    has Str $.value is required;
}

# token line-comment {         '//' <-[ \r \n ]>*     }
our class LineComment { 
    has Str $.value is required;
}

# token translation-unit {         <declarationseq>?  $     }
our class TranslationUnit { 
    has IDeclarationseq $.declarationseq;
}

#------------------------------

# token primary-expression:sym<literal> { <literal>+ }
our class PrimaryExpression::Literal does IPrimaryExpression {
    has ILiteral @.literal is required;
}

# token primary-expression:sym<this>    { <this> }
our class PrimaryExpression::This does IPrimaryExpression { }

# token primary-expression:sym<expr>    { <.left-paren> <expression> <.right-paren> }
our class PrimaryExpression::Expr does IPrimaryExpression {
    has Expression $.expression is required;
}

# token primary-expression:sym<id>      { <id-expression> }
our class PrimaryExpression::Id does IPrimaryExpression {
    has IIdExpression $.id-expression is required;
}

# token primary-expression:sym<lambda>  { <lambda-expression> }     
our class PrimaryExpression::Lambda does IPrimaryExpression {
    has LambdaExpression $.lambda-expression is required;
}

#------------------------------

# regex id-expression:sym<qualified>   { <qualified-id> }
our class IdExpression::Qualified does IIdExpression {
    has QualifiedId $.qualified-id is required;
}

# regex id-expression:sym<unqualified> { <unqualified-id> }     
our class IdExpression::Unqualified does IIdExpression {
    has IUnqualifiedId $.unqualified-id is required;
}

#------------------------------


# regex unqualified-id:sym<ident> { <identifier> }
our class UnqualifiedId::Ident does IUnqualifiedId {
    has Identifier $.identifier is required;
}

# regex unqualified-id:sym<op-func-id>          { <operator-function-id> }
our class UnqualifiedId::OpFuncId does IUnqualifiedId {
    has OperatorFunctionId $.operator-function-id is required;
}

# regex unqualified-id:sym<conversion-func-id>  { <conversion-function-id> }
our class UnqualifiedId::ConversionFuncId does IUnqualifiedId {
    has ConversionFunctionId $.conversion-function-id is required;
}

# regex unqualified-id:sym<literal-operator-id> { <literal-operator-id> }
our class UnqualifiedId::LiteralOperatorId does IUnqualifiedId {
    has ILiteralOperatorId $.literal-operator-id is required;
}

# regex unqualified-id:sym<tilde-classname>     { <tilde> <class-name> }
our class UnqualifiedId::TildeClassname does IUnqualifiedId {
    has IClassName $.class-name is required;
}

# regex unqualified-id:sym<tilde-decltype>      { <tilde> <decltype-specifier> }
our class UnqualifiedId::TildeDecltype does IUnqualifiedId {
    has DecltypeSpecifier $.decltype-specifier is required;
}

# regex unqualified-id:sym<template-id>  { <template-id> }
our class UnqualifiedId::TemplateId does IUnqualifiedId {
    has ITemplateId $.template-id is required;
}

# regex qualified-id { <nested-name-specifier> <template>? <unqualified-id> }      
our class QualifiedId { 
    has NestedNameSpecifier $.nested-name-specifier is required;
    has Bool                $.template              is required;
    has IUnqualifiedId      $.unqualified-id        is required;
}


# regex nested-name-specifier-prefix:sym<null> { <doublecolon> }
our class NestedNameSpecifierPrefix::Null does INestedNameSpecifierPrefix { }

# regex nested-name-specifier-prefix:sym<type> { <the-type-name> <doublecolon> }
our class NestedNameSpecifierPrefix::Type does INestedNameSpecifierPrefix {
    has ITheTypeName $.the-type-name is required;
}

# regex nested-name-specifier-prefix:sym<ns> { <namespace-name> <doublecolon> }
our class NestedNameSpecifierPrefix::Ns does INestedNameSpecifierPrefix {
    has INamespaceName $.namespace-name is required;
}

# regex nested-name-specifier-prefix:sym<decl> { <decltype-specifier> <doublecolon> }
our class NestedNameSpecifierPrefix::Decl does INestedNameSpecifierPrefix {
    has DecltypeSpecifier $.decltype-specifier is required;
}

#--------------------------
# regex nested-name-specifier-suffix:sym<id> { <identifier> <doublecolon> }
our class NestedNameSpecifierSuffix::Id does INestedNameSpecifierSuffix {
    has Identifier $.identifier is required;
}

# regex nested-name-specifier-suffix:sym<template> { <template>? <simple-template-id> <doublecolon> } 
our class NestedNameSpecifierSuffix::Template does INestedNameSpecifierSuffix {
    has Bool             $.template is required;
    has SimpleTemplateId $.simple-template-id is required;
}

# regex nested-name-specifier { <nested-name-specifier-prefix> <nested-name-specifier-suffix>* }
our class NestedNameSpecifier { 
    has INestedNameSpecifierPrefix $.nested-name-specifier-prefix   is required;
    has INestedNameSpecifierSuffix @.nested-name-specifier-suffixes;
}

# rule lambda-expression { <lambda-introducer> <lambda-declarator>? <compound-statement> }
our class LambdaExpression { 
    has LambdaIntroducer  $.lambda-introducer is required;
    has LambdaDeclarator  $.lambda-declarator;
    has CompoundStatement $.compound-statement is required;
}

# rule lambda-introducer { <.left-bracket> <lambda-capture>? <.right-bracket> }
our class LambdaIntroducer { 
    has ILambdaCapture $.lambda-capture;
}

# rule lambda-capture:sym<list> { <capture-list> }
our class LambdaCapture::List does ILambdaCapture {
    has CaptureList $.capture-list is required;
}

# rule lambda-capture:sym<def> { <capture-default> [ <comma> <capture-list> ]? } 
our class LambdaCapture::Def does ILambdaCapture {
    has ICaptureDefault $.capture-default is required;
    has CaptureList    $.capture-list;
}

# rule capture-default:sym<and> { <and_> }
our class CaptureDefault::And does ICaptureDefault { }

# rule capture-default:sym<assign> { <assign> } #-------------------------------
our class CaptureDefault::Assign does ICaptureDefault { }

# rule capture-list { <capture> [ <comma> <capture> ]* <ellipsis>? } #-------------------------------
our class CaptureList { 
    has ICapture @.captures is required;
    has Bool     $.trailing-ellipsis is required;
}

#-------------------

# rule capture:sym<simple> { <simple-capture> }
our class Capture::Simple does ICapture {
    has ISimpleCapture $.simple-capture is required;
}

# rule capture:sym<init> { <initcapture> } #-------------------------------
our class Capture::Init does ICapture {
    has Initcapture $.init-capture is required;
}


# rule simple-capture:sym<id> { <and_>? <identifier> }
our class SimpleCapture::Id does ISimpleCapture {
    has Bool       $.has-and_;
    has Identifier $.identifier is required;
}

# rule simple-capture:sym<this> { <this> } #-------------------------------
our class SimpleCapture::This does ISimpleCapture { }

# rule initcapture { <and_>? <identifier> <initializer> } #-------------------------------
our class Initcapture { 
    has Bool $.has-and;
    has Identifier  $.identifier  is required;
    has IInitializer $.initializer is required;
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
}

# rule postfix-expression { <postfix-expression-body> <postfix-expression-tail>* }
our class PostfixExpression { 
    has IPostfixExpressionBody $.postfix-expression-body is required;
    has IPostfixExpressionTail @.postfix-expression-tail;
}

#------------------------------


# rule bracket-tail { <.left-bracket> [ <expression> || <braced-init-list> ] <.right-bracket> }
our class BracketTail::Expression { 
    has Expression $.expression is required;
}

our class BracketTail::BracedInitList { 
    has IBracketTail $.bracket-tail is required;
}

# rule postfix-expression-tail:sym<bracket> { <bracket-tail> }
our class PostfixExpressionTail::Bracket does IPostfixExpressionTail {
    has IBracketTail $.bracket-tail is required;
}

# rule postfix-expression-tail:sym<parens> { <.left-paren> <expression-list>? <.right-paren> }
our class PostfixExpressionTail::Parens does IPostfixExpressionTail {
    has ExpressionList $.expression-list;
}

# rule postfix-expression-tail:sym<indirection-id> { [ <dot> || <arrow> ] <template>? <id-expression> }
our class PostfixExpressionTail::IndirectionId does IPostfixExpressionTail {
    has Bool         $.template is required;
    has IIdExpression $.id-expression is required;
}

# rule postfix-expression-tail:sym<indirection-pseudo-dtor> { [ <dot> || <arrow> ] <pseudo-destructor-name> }
our class PostfixExpressionTail::IndirectionPseudoDtor does IPostfixExpressionTail {
    has IPseudoDestructorName $.pseudo-destructor-name is required;
}

# rule postfix-expression-tail:sym<pp-mm> { [ <plus-plus> || <minus-minus> ] } 
our class PostfixExpressionTail::PlusPlus does IPostfixExpressionTail { }

our class PostfixExpressionTail::MinusMinus does IPostfixExpressionTail { }


# token cast-token:sym<dyn> { <dynamic_cast> }
our class CastToken::Dyn does ICastToken { }

# token cast-token:sym<static> { <static_cast> }
our class CastToken::Static does ICastToken { }

# token cast-token:sym<reinterpret> { <reinterpret_cast> }
our class CastToken::Reinterpret does ICastToken { }

# token cast-token:sym<const> { <const_cast> }
our class CastToken::Const does ICastToken { }

# rule postfix-expression-cast { 
#   <cast-token> 
#   <less> 
#   <the-type-id> 
#   <greater> 
#   <.left-paren> 
#   <expression> 
#   <.right-paren> 
# }
our class PostfixExpressionCast { 
    has ICastToken $.cast-token  is required;
    has TheTypeId  $.the-type-id is required;
    has Expression $.expression  is required;
}

# rule postfix-expression-typeid { 
# <type-id-of-the-type-id> 
# <.left-paren> 
# [ <expression> || <the-type-id>] 
# <.right-paren> 
# } 
our class PostfixExpressionTypeid::Expr { 
    has TypeIdOfTheTypeId $.type-id-of-the-type-id is required;
    has Expression        $.expression             is required;
}

our class PostfixExpressionTypeid::TypeId { 
    has TypeIdOfTheTypeId $.type-id-of-the-type-id is required;
    has TheTypeId         $.the-type-id            is required;
}


# token post-list-head:sym<simple> { <simple-type-specifier> }
our class PostListHead::Simple does IPostListHead {
    has ISimpleTypeSpecifier $.simple-type-specifier is required;
}

# token post-list-head:sym<type-name> { <type-name-specifier> } 
our class PostListHead::TypeName does IPostListHead {
    has ITypeNameSpecifier $.type-name-specifier is required;
}


# token post-list-tail:sym<parenthesized> { <.left-paren> <expression-list>? <.right-paren> }
our class PostListTail::Parenthesized does IPostListTail {
    has ExpressionList $.expression-list;
}

# token post-list-tail:sym<braced> { <braced-init-list> }
our class PostListTail::Braced does IPostListTail {
    has BracedInitList $.braced-init-list is required;
}

# token postfix-expression-list { <post-list-head> <post-list-tail> } 
our class PostfixExpressionList does IPostfixExpressionBody { }

# rule type-id-of-the-type-id { <typeid_> }
our class TypeIdOfTheTypeId { 
    has ITypeid $.typeid is required;
}

# rule expression-list { <initializer-list> }
our class ExpressionList { 
    has InitializerList $.initializer-list is required;
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
    has NestedNameSpecifier $.nested-name-specifier is required;
    has SimpleTemplateId    $.simple-template-id    is required;
    has ITheTypeName         $.the-type-name         is required;
}

# rule pseudo-destructor-name:sym<decltype> { <tilde> <decltype-specifier> } #-------------------------------------
our class PseudoDestructorName::Decltype does IPseudoDestructorName {
    has DecltypeSpecifier $.decltype-specifier is required;
}


our class IUnaryExpression::New { 
    has INewExpression $.new-expression is required;
}

our class IUnaryExpression::Case { 
    has IUnaryExpressionCase $.case is required;
}

#--------------------------

# rule unary-expression-case:sym<postfix> { <postfix-expression> }
our class UnaryExpressionCase::Postfix does IUnaryExpressionCase {
    has PostfixExpression $.postfix-expression is required;
}

# rule unary-expression-case:sym<pp> { <plus-plus> <unary-expression> }
our class UnaryExpressionCase::PlusPlus does IUnaryExpressionCase {
    has IUnaryExpression $.unary-expression is required;
}

# rule unary-expression-case:sym<mm> { <minus-minus> <unary-expression> }
our class UnaryExpressionCase::MinusMinus does IUnaryExpressionCase {
    has IUnaryExpression $.unary-expression is required;
}

# rule unary-expression-case:sym<unary-op> { <unary-operator> <unary-expression> }
our class UnaryExpressionCase::UnaryOp does IUnaryExpressionCase {
    has IUnaryOperator   $.unary-operator   is required;
    has IUnaryExpression $.unary-expression is required;
}

# rule unary-expression-case:sym<sizeof> { <sizeof> <unary-expression> }
our class UnaryExpressionCase::Sizeof does IUnaryExpressionCase {
    has IUnaryExpression $.unary-expression is required;
}

# rule unary-expression-case:sym<sizeof-typeid> { <sizeof> <.left-paren> <the-type-id> <.right-paren> }
our class UnaryExpressionCase::SizeofTypeid does IUnaryExpressionCase {
    has TheTypeId $.the-type-id is required;
}

# rule unary-expression-case:sym<sizeof-ids> { <sizeof> <ellipsis> <.left-paren> <identifier> <.right-paren> }
our class UnaryExpressionCase::SizeofIds does IUnaryExpressionCase {
    has Identifier $.identifier is required;
}

# rule unary-expression-case:sym<alignof> { <alignof> <.left-paren> <the-type-id> <.right-paren> }
our class UnaryExpressionCase::Alignof does IUnaryExpressionCase {
    has TheTypeId $.the-type-id is required;
}

# rule unary-expression-case:sym<noexcept> { <no-except-expression> }
our class UnaryExpressionCase::Noexcept does IUnaryExpressionCase {
    has NoExceptExpression $.no-except-expression is required;
}

# rule unary-expression-case:sym<delete> { <delete-expression> } #--------------------------------------
our class UnaryExpressionCase::Delete does IUnaryExpressionCase {
    has DeleteExpression $.delete-expression is required;
}

#---------------------------

# rule unary-operator:sym<or_> { <or_> }
our class UnaryOperator::Or does IUnaryOperator { }

# rule unary-operator:sym<star> { <star> }
our class UnaryOperator::Star does IUnaryOperator { }

# rule unary-operator:sym<and_> { <and_> }
our class UnaryOperator::And does IUnaryOperator { }

# rule unary-operator:sym<plus> { <plus> }
our class UnaryOperator::Plus does IUnaryOperator { }

# rule unary-operator:sym<tilde> { <tilde> }
our class UnaryOperator::Tilde does IUnaryOperator { }

# rule unary-operator:sym<minus> { <minus> }
our class UnaryOperator::Minus does IUnaryOperator { }

# rule unary-operator:sym<not> { <not_> } #--------------------------------------
our class UnaryOperator::Not does IUnaryOperator { }

#----------------------------------

# rule new-expression:sym<new-type-id> { <doublecolon>? <new_> <new-placement>? <new-type-id> <new-initializer>? }
our class NewExpression::NewTypeId does INewExpression {
    has NewPlacement   $.new-placement;
    has NewTypeId      $.new-type-id is required;
    has INewInitializer $.new-initializer;
}

# rule new-expression:sym<the-type-id> { <doublecolon>? <new_> <new-placement>? <.left-paren> <the-type-id> <.right-paren> <new-initializer>? }
our class NewExpression::TheTypeId does INewExpression {
    has NewPlacement   $.new-placement;
    has TheTypeId      $.the-type-id is required;
    has INewInitializer $.new-initializer;
}

# rule new-placement { <.left-paren> <expression-list> <.right-paren> }
our class NewPlacement { 
    has ExpressionList $.expression-list is required;
}

# rule new-type-id { <type-specifier-seq> <new-declarator>? }
our class NewTypeId { 
    has TypeSpecifierSeq $.type-specifier-seq is required;
    has NewDeclarator    $.new-declarator     is required;
}

# rule new-declarator { 
#   <pointer-operator>* 
#   <no-pointer-new-declarator>? 
# }
our class NewDeclarator { 
    has IPointerOperator @.pointer-operators;
    has NoPointerNewDeclarator $.no-pointer-new-declarator;
}


# rule no-pointer-new-declarator { <.left-bracket> <expression> <.right-bracket> <attribute-specifier-seq>? <no-pointer-new-declarator-tail>* }
our class NoPointerNewDeclarator { 
    has Expression                 $.expression is required;
    has IAttributeSpecifierSeq      $.attribute-specifier-seq;
    has NoPointerNewDeclaratorTail @.no-pointer-new-declarator-tail;
}

# rule no-pointer-new-declarator-tail { <.left-bracket> <constant-expression> <.right-bracket> <attribute-specifier-seq>? } #------------------------
our class NoPointerNewDeclaratorTail {
    has ConstantExpression    $.constant-expression is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
}


# rule new-initializer:sym<expr-list> { <.left-paren> <expression-list>? <.right-paren> }
our class NewInitializer::ExprList does INewInitializer {
    has ExpressionList $.expression-list;
}

# rule new-initializer:sym<braced> { <braced-init-list> } #------------------------
our class NewInitializer::Braced does INewInitializer {
    has BracedInitList $.braced-init-list is required;
}

# rule delete-expression { <doublecolon>? <delete> [ <.left-bracket> <.right-bracket> ]? <cast-expression> }
our class DeleteExpression { 
    has CastExpression $.cast-expression is required;
}

# rule no-except-expression { <noexcept> <.left-paren> <expression> <.right-paren> }
our class NoExceptExpression { 
    has Expression $.expression is required;
}

# rule cast-expression { [ <.left-paren> <the-type-id> <.right-paren> ]* <unary-expression> }
our class CastExpression { 
    has TheTypeId @.the-type-ids           is required;
    has IUnaryExpression $.unary-expression is required;
}

#-----------------------

# rule pointer-member-operator:sym<dot> { <dot-star> }
our class PointerMemberOperator::Dot does IPointerMemberOperator { }

# rule pointer-member-operator:sym<arrow> { <arrow-star> }
our class PointerMemberOperator::Arrow does IPointerMemberOperator { }

# rule pointer-member-expression { <cast-expression> <pointer-member-expression-tail>* }
our class PointerMemberExpression { 
    has CastExpression              $.cast-expression is required;
    has PointerMemberExpressionTail @.pointer-member-expression-tail;
}

# rule pointer-member-expression-tail { <pointer-member-operator> <cast-expression> }
our class PointerMemberExpressionTail { 
    has IPointerMemberOperator $.pointer-member-operator is required;
    has CastExpression         $.cast-expression is required;
}

#-----------------------

# token multiplicative-operator:sym<*> { <star> }
our class MultiplicativeOperator::Star does IMultiplicativeOperator { }

# token multiplicative-operator:sym</> { <div_> }
our class MultiplicativeOperator::Slash does IMultiplicativeOperator { }

# token multiplicative-operator:sym<%> { <mod_> }
our class MultiplicativeOperator::Mod does IMultiplicativeOperator { }

# rule multiplicative-expression { <pointer-member-expression> <multiplicative-expression-tail>* }
our class MultiplicativeExpression { 
    has PointerMemberExpression      $.pointer-member-expression is required;
    has MultiplicativeExpressionTail @.multiplicative-expression-tail is required;
}

# rule multiplicative-expression-tail { <multiplicative-operator> <pointer-member-expression> }
our class MultiplicativeExpressionTail { 
    has IMultiplicativeOperator  $.multiplicative-operator is required;
    has PointerMemberExpression $.pointer-member-expression is required;
}


# token additive-operator:sym<plus> { <plus> }
our class AdditiveOperator::Plus does IAdditiveOperator { }

# token additive-operator:sym<minus> { <minus> }
our class AdditiveOperator::Minus does IAdditiveOperator { }

# rule additive-expression-tail { <additive-operator> <multiplicative-expression> }
our class AdditiveExpressionTail { 
    has IAdditiveOperator        $.additive-operator         is required;
    has MultiplicativeExpression $.multiplicative-expression is required;
}

# rule additive-expression { <multiplicative-expression> <additive-expression-tail>* }
our class AdditiveExpression { 
    has MultiplicativeExpression $.multiplicative-expression is required;
    has AdditiveExpressionTail   @.additive-expression-tail;
}

# rule shift-expression-tail { <shift-operator> <additive-expression> }
our class ShiftExpressionTail { 
    has IShiftOperator      $.shift-operator      is required;
    has AdditiveExpression $.additive-expression is required;
}

# rule shift-expression { <additive-expression> <shift-expression-tail>* } #-----------------------
our class ShiftExpression { 
    has AdditiveExpression  $.additive-expression is required;
    has ShiftExpressionTail @.shift-expression-tail is required;
}


# rule shift-operator:sym<right> { <.greater> <.greater> }
our class ShiftOperator::Right does IShiftOperator { }

# rule shift-operator:sym<left> { <.less> <.less> } #-----------------------
our class ShiftOperator::Left does IShiftOperator { }


# rule relational-operator:sym<less> { <.less> }
our class RelationalOperator::Less does IRelationalOperator { }

# rule relational-operator:sym<greater> { <.greater> }
our class RelationalOperator::Greater does IRelationalOperator { }

# rule relational-operator:sym<less-eq> { <.less-equal> }
our class RelationalOperator::LessEq does IRelationalOperator { }

# rule relational-operator:sym<greater-eq> { <.greater-equal> } #-----------------------
our class RelationalOperator::GreaterEq does IRelationalOperator { }

# regex relational-expression-tail { <.ws> <relational-operator> <.ws> <shift-expression> }
our class RelationalExpressionTail { 
    has IRelationalOperator $.relational-operator is required;
    has ShiftExpression     $.shift-expression    is required;
}

# regex relational-expression { <shift-expression> <relational-expression-tail>* } #-----------------------
our class RelationalExpression { 
    has ShiftExpression          $.shift-expression is required;
    has RelationalExpressionTail @.relational-expression-tail is required;
}


# token equality-operator:sym<eq> { <equal> }
our class EqualityOperator::Eq does IEqualityOperator { }

# token equality-operator:sym<neq> { <not-equal> } #-----------------------
our class EqualityOperator::Neq does IEqualityOperator { }

# rule equality-expression-tail { <equality-operator> <relational-expression> }
our class EqualityExpressionTail { 
    has IEqualityOperator    $.equality-operator     is required;
    has RelationalExpression $.relational-expression is required;
}

# rule equality-expression { <relational-expression> <equality-expression-tail>* }
our class EqualityExpression { 
    has RelationalExpression   $.relational-expression is required;
    has EqualityExpressionTail @.equality-expression-tail is required;
}

# rule and-expression { <equality-expression> [ <and_> <equality-expression> ]* }
our class AndExpression { 
    has EqualityExpression @.equality-expressions is required;
}

# rule exclusive-or-expression { <and-expression> [ <caret> <and-expression> ]* }
our class ExclusiveOrExpression { 
    has AndExpression @.and-expressions is required;
}

# rule inclusive-or-expression { <exclusive-or-expression> [ <or_> <exclusive-or-expression> ]* }
our class InclusiveOrExpression { 
    has ExclusiveOrExpression @.exclusive-or-expressions is required;
}

# rule logical-and-expression { <inclusive-or-expression> [ <and-and> <inclusive-or-expression>]* }
our class LogicalAndExpression { 
    has InclusiveOrExpression @.inclusive-or-expressions is required;
}

# rule logical-or-expression { <logical-and-expression> [ <or-or> <logical-and-expression> ]* }
our class LogicalOrExpression { 
    has LogicalAndExpression @.logical-and-expressions is required;
}

# rule conditional-expression-tail { <question> <expression> <colon> <assignment-expression> }
our class ConditionalExpressionTail { 
    has Expression           $.question-expression   is required;
    has IAssignmentExpression $.assignment-expression is required;
}

# rule conditional-expression { <logical-or-expression> <conditional-expression-tail>? } #-----------------------
our class ConditionalExpression { 
    has LogicalOrExpression       $.logical-or-expression is required;
    has ConditionalExpressionTail $.conditional-expression-tail;
}


# rule assignment-expression:sym<throw> { <throw-expression> }
our class AssignmentExpression::Throw does IAssignmentExpression {
    has ThrowExpression $.throw-expression is required;
}

# rule assignment-expression:sym<basic> { <logical-or-expression> <assignment-operator> <initializer-clause> }
our class AssignmentExpression::Basic does IAssignmentExpression {
    has LogicalOrExpression $.logical-or-expression is required;
    has IAssignmentOperator $.assignment-operator is required;
    has IInitializerClause $.initializer-clause is required;
}

# rule assignment-expression:sym<conditional> { <conditional-expression> }
our class AssignmentExpression::Conditional does IAssignmentExpression {
    has ConditionalExpression $.conditional-expression is required;
}


# token assignment-operator:sym<assign> { <.assign> }
our class AssignmentOperator::Assign does IAssignmentOperator { }

# token assignment-operator:sym<star-assign> { <.star-assign> }
our class AssignmentOperator::StarAssign does IAssignmentOperator { }

# token assignment-operator:sym<div-assign> { <.div-assign> }
our class AssignmentOperator::DivAssign does IAssignmentOperator { }

# token assignment-operator:sym<mod-assign> { <.mod-assign> }
our class AssignmentOperator::ModAssign does IAssignmentOperator { }

# token assignment-operator:sym<plus-assign> { <.plus-assign> }
our class AssignmentOperator::PlusAssign does IAssignmentOperator { }

# token assignment-operator:sym<minus-assign> { <.minus-assign> }
our class AssignmentOperator::MinusAssign does IAssignmentOperator { }

# token assignment-operator:sym<rshift-assign> { <.right-shift-assign> }
our class AssignmentOperator::RshiftAssign does IAssignmentOperator { }

# token assignment-operator:sym<lshift-assign> { <.left-shift-assign> }
our class AssignmentOperator::LshiftAssign does IAssignmentOperator { }

# token assignment-operator:sym<and-assign> { <.and-assign> }
our class AssignmentOperator::AndAssign does IAssignmentOperator { }

# token assignment-operator:sym<xor-assign> { <.xor-assign> }
our class AssignmentOperator::XorAssign does IAssignmentOperator { }

# token assignment-operator:sym<or-assign> { <.or-assign> }
our class AssignmentOperator::OrAssign does IAssignmentOperator { }

# rule expression { <assignment-expression>+ %% <.comma> }
our class Expression { 
    has IAssignmentExpression @.assignment-expressions is required;
}

# rule constant-expression { <conditional-expression> }
our class ConstantExpression { 
    has ConditionalExpression $.conditional-expression is required;
}


# regex comment:sym<line> { [<line-comment> <.ws>?]+ }
our class Comment::Line does IComment {
    has LineComment @.line-comments is required;
}

# token statement:sym<attributed> { <comment>? <attribute-specifier-seq>? <attributed-statement-body> }
our class Statement::Attributed does IStatement {
    has IComment                 $.comment;
    has IAttributeSpecifierSeq   $.attribute-specifier-seq;
    has IAttributedStatementBody $.attributed-statement-body is required;
}

# token statement:sym<labeled> { <comment>? <labeled-statement> }
our class Statement::Labeled does IStatement {
    has IComment         $.comment;
    has LabeledStatement $.labeled-statement is required;
}

# token statement:sym<declaration> { <comment>? <declaration-statement> }
our class Statement::Declaration does IStatement {
    has IComment             $.comment;
    has DeclarationStatement $.declaration-statement is required;
}


# rule attributed-statement-body:sym<expression> { <expression-statement> }
our class AttributedStatementBody::Expression does IAttributedStatementBody {
    has ExpressionStatement $.expression-statement is required;
}

# rule attributed-statement-body:sym<compound> { <compound-statement> }
our class AttributedStatementBody::Compound does IAttributedStatementBody {
    has CompoundStatement $.compound-statement is required;
}

# rule attributed-statement-body:sym<selection> { <selection-statement> }
our class AttributedStatementBody::Selection does IAttributedStatementBody {
    has ISelectionStatement $.selection-statement is required;
}

# rule attributed-statement-body:sym<iteration> { <iteration-statement> }
our class AttributedStatementBody::Iteration does IAttributedStatementBody {
    has IIterationStatement $.iteration-statement is required;
}

# rule attributed-statement-body:sym<jump> { <jump-statement> }
our class AttributedStatementBody::Jump does IAttributedStatementBody {
    has IJumpStatement $.jump-statement is required;
}

# rule attributed-statement-body:sym<try> { <try-block> } #-----------------------------
our class AttributedStatementBody::Try does IAttributedStatementBody {
    has TryBlock $.try-block is required;
}


# rule labeled-statement-label-body:sym<id> { <identifier> }
our class LabeledStatementLabelBody::Id does ILabeledStatementLabelBody {
    has Identifier $.identifier is required;
}

# rule labeled-statement-label-body:sym<case-expr> { <case> <constant-expression> }
our class LabeledStatementLabelBody::CaseExpr does ILabeledStatementLabelBody {
    has ConstantExpression $.constant-expression is required;
}

# rule labeled-statement-label-body:sym<default> { <default_> } #-----------------------------
our class LabeledStatementLabelBody::Default does ILabeledStatementLabelBody { }

# rule labeled-statement-label { <attribute-specifier-seq>? <labeled-statement-label-body> <colon> }
our class LabeledStatementLabel { 
    has IAttributeSpecifierSeq     $.attribute-specifier-seq;
    has ILabeledStatementLabelBody $.labeled-statement-label-body is required;
}

# rule labeled-statement { <labeled-statement-label> <statement> }
our class LabeledStatement { 
    has LabeledStatementLabel $.labeled-statement-label is required;
    has IStatement            $.statement is required;
}

# rule declaration-statement { <block-declaration> } #-----------------------------
our class DeclarationStatement { 
    has IBlockDeclaration $.block-declaration is required;
}

# rule expression-statement { <expression>? <semi> }
our class ExpressionStatement { 
    has IComment   $.comment;
    has Expression $.expression;
}

# rule compound-statement { <.left-brace> <statement-seq>? <.right-brace> }
our class CompoundStatement { 
    has StatementSeq $.statement-seq;
}

# regex statement-seq { <statement> [<.ws> <statement>]* } #-----------------------------
our class StatementSeq { 
    has IStatement @.statements is required;
}


# rule selection-statement:sym<if> { 
#   <.if_> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> 
#   <statement> 
#   [ <comment>? <else_> <statement> ]? 
# }
our class SelectionStatement::If does ISelectionStatement {
    has ICondition  $.condition is required;
    has IStatement $.statement is required;
    has IComment   $.else-statement-comment;
    has IStatement $.else-statement;
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
}


# rule condition:sym<expr> { <expression> } #-----------------------------
our class Condition::Expr does ICondition {
    has Expression $.expression is required;
}


# rule condition-decl-tail:sym<assign-init> { <assign> <initializer-clause> }
our class ConditionDeclTail::AssignInit does IConditionDeclTail {
    has IInitializerClause $.initializer-clause is required;
}

# rule condition-decl-tail:sym<braced-init> { <braced-init-list> } #-----------------------------
our class ConditionDeclTail::BracedInit does IConditionDeclTail {
    has BracedInitList $.braced-init-list is required;
}

# rule condition:sym<decl> { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq> 
#   <declarator> 
#   <condition-decl-tail> 
# } #-----------------------------
our class Condition::Decl does ICondition {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has DeclSpecifierSeq      $.decl-specifier-seq  is required;
    has IDeclarator            $.declarator          is required;
    has IConditionDeclTail    $.condition-decl-tail is required;
}


# rule iteration-statement:sym<while> { 
#   <while_> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> <statement> 
# }
our class IterationStatement::While does IIterationStatement {
    has ICondition  $.condition is required;
    has IStatement $.statement is required;
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
    has IComment   $.comment;
    has IStatement $.statement is required;
    has Expression $.expression is required;
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
    has Expression       $.expression;
    has IStatement       $.statement is required;
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
    has ForRangeDeclaration $.for-range-declaration is required;
    has IForRangeInitializer $.for-range-initializer is required;
    has IStatement          $.statement is required;
}


# rule for-init-statement:sym<expression-statement> { <expression-statement> }
our class ForInitStatement::ExpressionStatement does IForInitStatement {
    has ExpressionStatement $.expression-statement is required;
}

# rule for-init-statement:sym<simple-declaration> { <simple-declaration> }
our class ForInitStatement::SimpleDeclaration does IForInitStatement {
    has ISimpleDeclaration $.simple-declaration is required;
}

# rule for-range-declaration { <attribute-specifier-seq>? <decl-specifier-seq> <declarator> }
our class ForRangeDeclaration { 
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has DeclSpecifierSeq      $.decl-specifier-seq is required;
    has IDeclarator            $.declarator is required;
}


# rule for-range-initializer:sym<expression> { <expression> }
our class ForRangeInitializer::Expression does IForRangeInitializer {
    has Expression $.expression is required;
}

# rule for-range-initializer:sym<braced-init-list> { <braced-init-list> } #-------------------------------
our class ForRangeInitializer::BracedInitList does IForRangeInitializer {
    has BracedInitList $.braced-init-list is required;
}

#----------------------

# rule jump-statement:sym<break> { <break_> <semi> }
our class JumpStatement::Break does IJumpStatement { 
    has IComment $.comment;
}

# rule jump-statement:sym<continue> { <continue_> <semi> }
our class JumpStatement::Continue does IJumpStatement { 
    has IComment $.comment;
}

# rule jump-statement:sym<return> { <return_> <return-statement-body>? <semi> }
our class JumpStatement::Return does IJumpStatement {
    has IComment             $.comment;
    has IReturnStatementBody $.return-statement-body;
}

# rule jump-statement:sym<goto> { <goto_> <identifier> <semi> }
our class JumpStatement::Goto does IJumpStatement {
    has IComment   $.comment;
    has Identifier $.identifier is required;
}

#----------------------

# rule return-statement-body:sym<expr> { <expression> }
our class ReturnStatementBody::Expr does IReturnStatementBody {
    has Expression $.expression is required;
}

# rule return-statement-body:sym<braced-init-list> { <braced-init-list> }
our class ReturnStatementBody::BracedInitList does IReturnStatementBody {
    has BracedInitList $.braced-init-list is required;
}

# rule declarationseq { <declaration>+ } #-------------------------------
our class Declarationseq { 
    has IDeclaration @.declarations is required;
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
    has TheTypeId              $.the-type-id is required;
}


# rule simple-declaration:sym<basic> { <decl-specifier-seq>? <init-declarator-list>? <.semi> }
our class SimpleDeclaration::Basic does ISimpleDeclaration {
    has IComment           $.comment;
    has DeclSpecifierSeq   $.decl-specifier-seq;
    has InitDeclaratorList $.init-declarator-list;
}

# rule simple-declaration:sym<init-list> { <attribute-specifier-seq> <decl-specifier-seq>? <init-declarator-list> <.semi> }
our class SimpleDeclaration::InitList does ISimpleDeclaration {
    has IComment               $.comment;
    has IAttributeSpecifierSeq $.attribute-specifier-seq is required;
    has DeclSpecifierSeq       $.decl-specifier-seq;
    has InitDeclaratorList     $.init-declarator-list is required;
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
    has IComment           $.comment;
    has ConstantExpression $.constant-expression is required;
    has StringLiteral      $.string-literal is required;
}

# rule empty-declaration { <.semi> }
our class EmptyDeclaration { 
    has IComment           $.comment;
}

# rule attribute-declaration { <attribute-specifier-seq> <.semi> }
our class AttributeDeclaration { 
    has IComment               $.comment;
    has IAttributeSpecifierSeq $.attribute-specifier-seq is required;
}

#-------------------

# regex decl-specifier-seq { 
#   <decl-specifier> 
#   [<.ws> <decl-specifier>]*? 
#   <attribute-specifier-seq>? 
# }
our class DeclSpecifierSeq { 
    has IDeclSpecifier        @.decl-specifiers is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
}


# rule storage-class-specifier:sym<extern> { <.extern> }
our class StorageClassSpecifier::Extern does IStorageClassSpecifier { }

# rule storage-class-specifier:sym<mutable> { <.mutable> } #---------------------------
our class StorageClassSpecifier::Mutable does IStorageClassSpecifier { }

# rule storage-class-specifier:sym<register> { <.register> }
our class StorageClassSpecifier::Register does IStorageClassSpecifier { }

# rule storage-class-specifier:sym<static> { <.static> }
our class StorageClassSpecifier::Static does IStorageClassSpecifier { }

# rule storage-class-specifier:sym<thread_local> { <.thread_local> }
our class StorageClassSpecifier::Thread_local does IStorageClassSpecifier { }

# rule function-specifier:sym<inline> { <.inline> }
our class FunctionSpecifier::Inline does IFunctionSpecifier { }

# rule function-specifier:sym<virtual> { <.virtual> }
our class FunctionSpecifier::Virtual does IFunctionSpecifier { }

# rule function-specifier:sym<explicit> { <.explicit> }
our class FunctionSpecifier::Explicit does IFunctionSpecifier { }

# rule typedef-name { <identifier> } #---------------------------
our class TypedefName { 
    has Identifier $.identifier is required;
}


# rule type-specifier:sym<trailing-type-specifier> { <trailing-type-specifier> }
our class TypeSpecifier::TrailingTypeSpecifier does ITypeSpecifier {
    has ITrailingTypeSpecifier $.trailing-type-specifier is required;
}

# rule type-specifier:sym<class-specifier> { <class-specifier> }
our class TypeSpecifier::ClassSpecifier does ITypeSpecifier {
    has ClassSpecifier $.class-specifier is required;
}

# rule type-specifier:sym<enum-specifier> { <enum-specifier> } #---------------------------
our class TypeSpecifier::EnumSpecifier does ITypeSpecifier {
    has EnumSpecifier $.enum-specifier is required;
}


# rule trailing-type-specifier:sym<cv-qualifier> { <cv-qualifier> <simple-type-specifier> }
our class TrailingTypeSpecifier::CvQualifier does ITrailingTypeSpecifier {
    has ICvQualifier         $.cv-qualifier          is required;
    has ISimpleTypeSpecifier $.simple-type-specifier is required;
}

# rule trailing-type-specifier:sym<simple> { <simple-type-specifier> }
our class TrailingTypeSpecifier::Simple does ITrailingTypeSpecifier {
    has ISimpleTypeSpecifier $.simple-type-specifier is required;
}

# rule trailing-type-specifier:sym<elaborated> { <elaborated-type-specifier> }
our class TrailingTypeSpecifier::Elaborated does ITrailingTypeSpecifier {
    has IElaboratedTypeSpecifier $.elaborated-type-specifier is required;
}

# rule trailing-type-specifier:sym<typename> { <type-name-specifier> } #---------------------------
our class TrailingTypeSpecifier::Typename does ITrailingTypeSpecifier {
    has ITypeNameSpecifier $.type-name-specifier is required;
}

# rule type-specifier-seq { <type-specifier>+ <attribute-specifier-seq>? }
our class TypeSpecifierSeq { 
    has ITypeNameSpecifier     @.type-specifiers is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
}

# rule trailing-type-specifier-seq { <trailing-type-specifier>+ <attribute-specifier-seq>? }
our class TrailingTypeSpecifierSeq { 
    has ITrailingTypeSpecifier @.trailing-type-specifiers is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
}


# rule simple-type-length-modifier:sym<short> { <.short> }
our class SimpleTypeLengthModifier::Short does ISimpleTypeLengthModifier { }

# rule simple-type-length-modifier:sym<long_> { <.long_> }
our class SimpleTypeLengthModifier::Long does ISimpleTypeLengthModifier { }


# rule simple-type-signedness-modifier:sym<unsigned> { <.unsigned> }
our class SimpleTypeSignednessModifier::Unsigned does ISimpleTypeSignednessModifier { }

# rule simple-type-signedness-modifier:sym<signed> { <.signed> }
our class SimpleTypeSignednessModifier::Signed does ISimpleTypeSignednessModifier { }

# rule full-type-name { <nested-name-specifier>? <the-type-name> }
our class FullTypeName { 
    has NestedNameSpecifier $.nested-name-specifier;
    has ITheTypeName         $.the-type-name is required;
}

# rule scoped-template-id { <nested-name-specifier> <.template> <simple-template-id> }
our class ScopedTemplateId { 
    has NestedNameSpecifier $.nested-name-specifier is required;
    has SimpleTemplateId    $.simple-template-id is required;
}

# rule simple-int-type-specifier { 
#   <simple-type-signedness-modifier>? 
#   <simple-type-length-modifier>* 
#   <int_> 
# }
our class SimpleIntTypeSpecifier { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has ISimpleTypeLengthModifier     @.simple-type-length-modifiers is required;
}

# rule simple-char-type-specifier { <simple-type-signedness-modifier>? <char_> }
our class SimpleCharTypeSpecifier { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;
}

# rule simple-char16-type-specifier { <simple-type-signedness-modifier>? <char16> }
our class SimpleChar16TypeSpecifier { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;
}

# rule simple-char32-type-specifier { <simple-type-signedness-modifier>? <char32> }
our class SimpleChar32TypeSpecifier { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;
}

# rule simple-wchar-type-specifier { <simple-type-signedness-modifier>? <wchar> }
our class SimpleWcharTypeSpecifier { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;
}

# rule simple-double-type-specifier { <simple-type-length-modifier>? <double> } #------------------------------
our class SimpleDoubleTypeSpecifier { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;
}


# regex simple-type-specifier:sym<int> { <simple-int-type-specifier> }
our class SimpleTypeSpecifier::Int_ does ISimpleTypeSpecifier {
    has SimpleIntTypeSpecifier $.simple-int-type-specifier is required;
}

# regex simple-type-specifier:sym<full> { <full-type-name> }
our class SimpleTypeSpecifier::Full does ISimpleTypeSpecifier {
    has FullTypeName $.full-type-name is required;
}

# regex simple-type-specifier:sym<scoped> { <scoped-template-id> }
our class SimpleTypeSpecifier::Scoped does ISimpleTypeSpecifier {
    has ScopedTemplateId $.scoped-template-id is required;
}

# regex simple-type-specifier:sym<signedness-mod> { <simple-type-signedness-modifier> }
our class SimpleTypeSpecifier::SignednessMod does ISimpleTypeSpecifier {
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier is required;
}

# regex simple-type-specifier:sym<signedness-mod-length> { <simple-type-signedness-modifier>? <simple-type-length-modifier>+ }
our class SimpleTypeSpecifier::SignednessModLength does ISimpleTypeSpecifier {
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has ISimpleTypeLengthModifier     @.simple-type-length-modifier is required;
}

# regex simple-type-specifier:sym<char> { <simple-char-type-specifier> }
our class SimpleTypeSpecifier::Char does ISimpleTypeSpecifier {
    has SimpleCharTypeSpecifier $.simple-char-type-specifier is required;
}

# regex simple-type-specifier:sym<char16> { <simple-char16-type-specifier> }
our class SimpleTypeSpecifier::Char16 does ISimpleTypeSpecifier {
    has SimpleChar16TypeSpecifier $.simple-char16-type-specifier is required;
}

# regex simple-type-specifier:sym<char32> { <simple-char32-type-specifier> }
our class SimpleTypeSpecifier::Char32 does ISimpleTypeSpecifier {
    has SimpleChar32TypeSpecifier $.simple-char32-type-specifier is required;
}

# regex simple-type-specifier:sym<wchar> { <simple-wchar-type-specifier> }
our class SimpleTypeSpecifier::Wchar does ISimpleTypeSpecifier {
    has SimpleWcharTypeSpecifier $.simple-wchar-type-specifier is required;
}

# regex simple-type-specifier:sym<bool> { <bool_> }
our class SimpleTypeSpecifier::Bool does ISimpleTypeSpecifier {
    has Bool $.bool_ is required;
}

# regex simple-type-specifier:sym<float> { <float> }
our class SimpleTypeSpecifier::Float does ISimpleTypeSpecifier { }

# regex simple-type-specifier:sym<double> { <simple-double-type-specifier> }
our class SimpleTypeSpecifier::Double does ISimpleTypeSpecifier {
    has SimpleDoubleTypeSpecifier $.simple-double-type-specifier is required;
}

# regex simple-type-specifier:sym<void> { <void_> }
our class SimpleTypeSpecifier::Void does ISimpleTypeSpecifier { }

# regex simple-type-specifier:sym<auto> { <auto> }
our class SimpleTypeSpecifier::Auto does ISimpleTypeSpecifier { }

# regex simple-type-specifier:sym<decltype> { <decltype-specifier> } #------------------------------
our class SimpleTypeSpecifier::Decltype does ISimpleTypeSpecifier {
    has DecltypeSpecifier $.decltype-specifier is required;
}


# rule the-type-name:sym<simple-template-id> { <simple-template-id> }
our class TheTypeName::SimpleTemplateId does ITheTypeName {
    has SimpleTemplateId $.simple-template-id is required;
}

# rule the-type-name:sym<class> { <class-name> }
our class TheTypeName::Class does ITheTypeName {
    has IClassName $.class-name is required;
}

# rule the-type-name:sym<enum> { <enum-name> }
our class TheTypeName::Enum does ITheTypeName {
    has EnumName $.enum-name is required;
}

# rule the-type-name:sym<typedef> { <typedef-name> } #------------------------------
our class TheTypeName::Typedef does ITheTypeName {
    has TypedefName $.typedef-name is required;
}


# rule decltype-specifier-body:sym<expr> { <expression> }
our class DecltypeSpecifierBody::Expr does IDecltypeSpecifierBody {
    has Expression $.expression is required;
}

# rule decltype-specifier-body:sym<auto> { <auto> }
our class DecltypeSpecifierBody::Auto does IDecltypeSpecifierBody { }

# rule decltype-specifier { 
#   <decltype> 
#   <.left-paren> 
#   <decltype-specifier-body> 
#   <.right-paren> 
# } #------------------------------
our class DecltypeSpecifier { 
    has IDecltypeSpecifierBody $.decltype-specifier-body is required;
}


# rule elaborated-type-specifier:sym<class-ident> { <.class-key> <attribute-specifier-seq>? <nested-name-specifier>? <identifier> }
our class ElaboratedTypeSpecifier::ClassIdent does IElaboratedTypeSpecifier {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has NestedNameSpecifier   $.nested-name-specifier;
    has Identifier            $.identifier is required;
}

# rule elaborated-type-specifier:sym<class-template-id> { <.class-key> <simple-template-id> }
our class ElaboratedTypeSpecifier::ClassTemplateId does IElaboratedTypeSpecifier {
    has SimpleTemplateId $.simple-template-id is required;
}

# rule elaborated-type-specifier:sym<class-nested-template-id> { <.class-key> <nested-name-specifier> <template>? <simple-template-id> }
our class ElaboratedTypeSpecifier::ClassNestedTemplateId does IElaboratedTypeSpecifier {
    has NestedNameSpecifier $.nested-name-specifier is required;
    has SimpleTemplateId    $.simple-template-id is required;
}

# rule elaborated-type-specifier:sym<enum> { <.enum_> <nested-name-specifier>? <identifier> } #------------------------------
our class ElaboratedTypeSpecifier::Enum does IElaboratedTypeSpecifier {
    has NestedNameSpecifier $.nested-name-specifier;
    has Identifier          $.identifier is required;
}

# rule enum-name { <identifier> }
our class EnumName { 
    has Identifier $.identifier is required;
}

# rule enum-specifier { 
#   <enum-head> 
#   <.left-brace> 
#   [ <enumerator-list> <.comma>? ]? 
#   <.right-brace> 
# }
our class EnumSpecifier { 
    has EnumeratorList $.enumerator-list;
}

# rule enum-head { 
#   <.enumkey> 
#   <attribute-specifier-seq>? 
#   [ <nested-name-specifier>? <identifier> ]? 
#   <enumbase>? 
# }
our class EnumHead { 
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has NestedNameSpecifier   $.nested-name-specifier;
    has Identifier            $.identifier;
    has IEnumBase              $.enum-base;
}

# rule opaque-enum-declaration { 
#   <.enumkey> 
#   <attribute-specifier-seq>? 
#   <identifier> 
#   <enumbase>? 
#   <semi> 
# }
our class OpaqueEnumDeclaration { 
    has IComment               $.comment;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has Identifier             $.identifier is required;
    has IEnumBase              $.enum-base is required;
}

# rule enumkey { <enum_> [ <class_> || <struct> ]? }
our class Enumkey { }

# rule enumbase { <colon> <type-specifier-seq> }
our class Enumbase { 
    has TypeSpecifierSeq $.type-specifier-seq is required;
}

# rule enumerator-list { <enumerator-definition> [ <.comma> <enumerator-definition> ]* }
our class EnumeratorList { 
    has EnumeratorDefinition @.enumerator-definition is required;
}

# rule enumerator-definition { <enumerator> [ <assign> <constant-expression> ]? }
our class EnumeratorDefinition { 
    has Enumerator         $.enumerator is required;
    has ConstantExpression $.constant-expression;
}

# rule enumerator { <identifier> }
our class Enumerator { 
    has Identifier $.identifier is required;
}

#-----------------------

# rule namespace-name:sym<original> { <original-namespace-name> }
our class NamespaceName::Original does INamespaceName {
    has OriginalNamespaceName $.original-namespace-name is required;
}

# rule namespace-name:sym<alias> { <namespace-alias> }
our class NamespaceName::Alias does INamespaceName {
    has NamespaceAlias $.namespace-alias is required;
}

# rule original-namespace-name { <identifier> } #--------------------
our class OriginalNamespaceName { 
    has Identifier $.identifier is required;
}


# rule namespace-tag:sym<ident> { <identifier> }
our class NamespaceTag::Ident does INamespaceTag {
    has Identifier $.identifier is required;
}

# rule namespace-tag:sym<ns-name> { <original-namespace-name> } #--------------------
our class NamespaceTag::NsName does INamespaceTag {
    has OriginalNamespaceName $.original-namespace-name is required;
}

# rule namespace-definition { 
#   <inline>? 
#   <namespace> 
#   <namespace-tag>? 
#   <.left-brace> 
#   <namespaceBody=declarationseq>? 
#   <.right-brace> 
# }
our class NamespaceDefinition { 
    has Bool           $.inline is required;
    has INamespaceTag   $.namespace-tag;
    has IDeclarationseq $.namespace-body;
}

# rule namespace-alias { <identifier> }
our class NamespaceAlias { 
    has Identifier $.identifier is required;
}

# rule namespace-alias-definition { <namespace> <identifier> <assign> <qualifiednamespacespecifier> <semi> }
our class NamespaceAliasDefinition { 
    has IComment                    $.comment;
    has Identifier                  $.identifier is required;
    has Qualifiednamespacespecifier $.qualifiednamespacespecifier is required;
}

# rule qualifiednamespacespecifier { <nested-name-specifier>? <namespace-name> } #--------------------
our class Qualifiednamespacespecifier { 
    has NestedNameSpecifier $.nested-name-specifier;
    has INamespaceName       $.namespace-name is required;
}


# rule using-declaration-prefix:sym<nested> { [ <typename_>? <nested-name-specifier> ] }
our class UsingDeclarationPrefix::Nested does IUsingDeclarationPrefix {
    has NestedNameSpecifier $.nested-name-specifier is required;
}

# rule using-declaration-prefix:sym<base> { <doublecolon> } #--------------------
our class UsingDeclarationPrefix::Base does IUsingDeclarationPrefix { }

# rule using-declaration { <using> <using-declaration-prefix> <unqualified-id> <semi> }
our class UsingDeclaration { 
    has IComment                $.comment;
    has IUsingDeclarationPrefix $.using-declaration-prefix is required;
    has IUnqualifiedId          $.unqualified-id is required;
}

# rule using-directive { 
#   <attribute-specifier-seq>? 
#   <using> 
#   <namespace> 
#   <nested-name-specifier>? 
#   <namespace-name> 
#   <semi> 
# }
our class UsingDirective { 
    has IComment               $.comment;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has NestedNameSpecifier    $.nested-name-specifier;
    has INamespaceName         $.namespace-name is required;
}

# rule asm-definition { 
#   <asm> 
#   <.left-paren> 
#   <string-literal> 
#   <.right-paren> 
#   <.semi> 
# } #--------------------
our class AsmDefinition { 
    has IComment      $.comment;
    has StringLiteral $.string-literal is required;
}


# rule linkage-specification-body:sym<seq> { <.left-brace> <declarationseq>? <.right-brace> }
our class LinkageSpecificationBody::Seq does ILinkageSpecificationBody {
    has IDeclarationseq $.declarationseq;
}

# rule linkage-specification-body:sym<decl> { <declaration> }
our class LinkageSpecificationBody::Decl does ILinkageSpecificationBody {
    has IDeclaration $.declaration is required;
}

# rule linkage-specification { 
#   <extern> 
#   <string-literal> 
#   <linkage-specification-body> 
# }
our class LinkageSpecification { 
    has StringLiteral            $.string-literal is required;
    has ILinkageSpecificationBody $.linkage-specification-body is required;
}

# rule attribute-specifier-seq { <attribute-specifier>+ } #--------------------
our class AttributeSpecifierSeq { 
    has IAttributeSpecifier @.attribute-specifier is required;
}


# rule attribute-specifier:sym<double-braced> { 
#   <.left-bracket> 
#   <.left-bracket> 
#   <attribute-list>? 
#   <.right-bracket> 
#   <.right-bracket> 
# }
our class AttributeSpecifier::DoubleBraced does IAttributeSpecifier {
    has AttributeList $.attribute-list;
}

# rule attribute-specifier:sym<alignment> { <alignmentspecifier> } #--------------------
our class AttributeSpecifier::Alignment does IAttributeSpecifier {
    has IAlignmentSpecifier $.alignmentspecifier is required;
}


# rule alignmentspecifierbody:sym<type-id> { <the-type-id> }
our class Alignmentspecifierbody::TypeId does IAlignmentspecifierbody {
    has TheTypeId $.the-type-id is required;
}

# rule alignmentspecifierbody:sym<const-expr> { <constant-expression> } #--------------------
our class Alignmentspecifierbody::ConstExpr does IAlignmentspecifierbody {
    has ConstantExpression $.constant-expression is required;
}

# rule alignmentspecifier { 
#   <alignas> 
#   <.left-paren> 
#   <alignmentspecifierbody> 
#   <ellipsis>? 
#   <.right-paren> 
# }
our class Alignmentspecifier { 
    has IAlignmentspecifierbody $.alignmentspecifierbody is required;
    has Bool                    $.has-ellipsis is required;
}

# rule attribute-list { <attribute> [ <.comma> <attribute> ]* <ellipsis>? }
our class AttributeList { 
    has Attribute @.attributes is required;
    has Bool      $.has-ellipsis is required;
}

# rule attribute { 
#   [ <attribute-namespace> <doublecolon> ]? 
#   <identifier> 
#   <attribute-argument-clause>? 
# }
our class Attribute { 
    has AttributeNamespace      $.attribute-namespace;
    has Identifier              $.identifier is required;
    has AttributeArgumentClause $.attribute-argument-clause;
}

# rule attribute-namespace { <identifier> }
our class AttributeNamespace { 
    has Identifier $.identifier is required;
}

# rule attribute-argument-clause { <.left-paren> <balanced-token-seq>? <.right-paren> }
our class AttributeArgumentClause { 
    has BalancedTokenSeq $.balanced-token-seq;
}

# rule balanced-token-seq { <balancedrule>+ } #--------------------------
our class BalancedTokenSeq { 
    has IBalancedrule @.balancedrules is required;
}


# rule balancedrule:sym<parens> { 
#   <.left-paren> 
#   <balanced-token-seq> 
#   <.right-paren> 
# }
our class Balancedrule::Parens does IBalancedrule {
    has BalancedTokenSeq $.balanced-token-seq is required;
}

# rule balancedrule:sym<brackets> { <.left-bracket> <balanced-token-seq> <.right-bracket> }
our class Balancedrule::Brackets does IBalancedrule {
    has BalancedTokenSeq $.balanced-token-seq is required;
}

# rule balancedrule:sym<braces> { <.left-brace> <balanced-token-seq> <.right-brace> } #--------------------------
our class Balancedrule::Braces does IBalancedrule {
    has BalancedTokenSeq $.balanced-token-seq is required;
}

# rule init-declarator-list { <init-declarator> [ <.comma> <init-declarator> ]* }
our class InitDeclaratorList { 
    has InitDeclarator @.init-declarators is required;
}

# rule init-declarator { <declarator> <initializer>? } #--------------------------
our class InitDeclarator { 
    has IDeclarator  $.declarator is required;
    has IInitializer $.initializer;
}


# rule declarator:sym<ptr> { <pointer-declarator> }
our class Declarator::Ptr does IDeclarator {
    has PointerDeclarator $.pointer-declarator is required;
}

# rule declarator:sym<no-ptr> { <no-pointer-declarator> <parameters-and-qualifiers> <trailing-return-type> }
our class Declarator::NoPtr does IDeclarator {
    has NoPointerDeclarator     $.no-pointer-declarator     is required;
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
    has TrailingReturnType      $.trailing-return-type      is required;
}

# rule pointer-declarator { <augmented-pointer-operator>* <no-pointer-declarator> }
our class PointerDeclarator { 
    has AugmentedPointerOperator @.augmented-pointer-operators;
    has NoPointerDeclarator      $.no-pointer-declarator is required;
}

# rule augmented-pointer-operator { <pointer-operator> <const>? }
our class AugmentedPointerOperator { 
    has IPointerOperator $.pointer-operator is required;
    has Bool            $.const            is required;
}


# rule no-pointer-declarator-base:sym<base> { <declaratorid> <attribute-specifier-seq>? }
our class NoPointerDeclaratorBase::Base does INoPointerDeclaratorBase {
    has Declaratorid           $.declaratorid is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
}

# rule no-pointer-declarator-base:sym<parens> { <.left-paren> <pointer-declarator> <.right-paren> }
our class NoPointerDeclaratorBase::Parens does INoPointerDeclaratorBase {
    has PointerDeclarator $.pointer-declarator is required;
}


# rule no-pointer-declarator-tail:sym<basic> { <parameters-and-qualifiers> }
our class NoPointerDeclaratorTail::Basic does INoPointerDeclaratorTail {
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
}

# rule no-pointer-declarator-tail:sym<bracketed> { 
#   <.left-bracket> 
#   <constant-expression>? 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
# } #------------------------------
our class NoPointerDeclaratorTail::Bracketed does INoPointerDeclaratorTail {
    has ConstantExpression    $.constant-expression;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
}

# rule no-pointer-declarator { 
#   <no-pointer-declarator-base> 
#   <no-pointer-declarator-tail>* 
# } #------------------------------
our class NoPointerDeclarator { 
    has INoPointerDeclaratorBase $.no-pointer-declarator-base is required;
    has INoPointerDeclaratorTail @.no-pointer-declarator-tail;
}

# rule parameters-and-qualifiers { 
#   <.left-paren> 
#   <parameter-declaration-clause>? 
#   <.right-paren> 
#   <cvqualifierseq>? 
#   <refqualifier>? 
#   <exception-specification>? 
#   <attribute-specifier-seq>? 
# }
our class ParametersAndQualifiers { 
    has ParameterDeclarationClause $.parameter-declaration-clause;
    has Cvqualifierseq             $.cvqualifierseq;
    has IRefqualifier               $.refqualifier;
    has IExceptionSpecification     $.exception-specification;
    has IAttributeSpecifierSeq      $.attribute-specifier-seq;
}

# rule trailing-return-type { 
#   <arrow> 
#   <trailing-type-specifier-seq> 
#   <abstract-declarator>? 
# }
our class TrailingReturnType { 
    has TrailingTypeSpecifierSeq $.trailing-type-specifier-seq is required;
    has IAbstractDeclarator      $.abstract-declarator;
}


# rule pointer-operator:sym<ref> { <and_> <attribute-specifier-seq>? }
our class PointerOperator::Ref does IPointerOperator {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
}

# rule pointer-operator:sym<ref-ref> { <and-and> <attribute-specifier-seq>? }
our class PointerOperator::RefRef does IPointerOperator {
    has IAndAnd $.and-and is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
}

# rule pointer-operator:sym<star> { <nested-name-specifier>? <star> <attribute-specifier-seq>? <cvqualifierseq>? }
our class PointerOperator::Star does IPointerOperator {
    has NestedNameSpecifier   $.nested-name-specifier;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has Cvqualifierseq        $.cvqualifierseq;
}

# rule cvqualifierseq { <cv-qualifier>+ } #-----------------------------
our class Cvqualifierseq { 
    has ICvQualifier @.cv-qualifiers;
}


# rule cv-qualifier:sym<const> { <const> }
our class CvQualifier::Const does ICvQualifier { }

# rule cv-qualifier:sym<volatile> { <volatile> } #-----------------------------
our class CvQualifier::Volatile does ICvQualifier { }


# rule refqualifier:sym<and> { <and_> }
our class Refqualifier::And does IRefqualifier { }

# rule refqualifier:sym<and-and> { <and-and> } #-----------------------------
our class Refqualifier::AndAnd does IRefqualifier { }

# rule declaratorid { <ellipsis>? <id-expression> }
our class Declaratorid { 
    has Bool         $.has-ellipsis  is required;
    has IIdExpression $.id-expression is required;
}

# rule the-type-id { <type-specifier-seq> <abstract-declarator>? } #-----------------------------
our class TheTypeId { 
    has TypeSpecifierSeq   $.type-specifier-seq is required;
    has IAbstractDeclarator $.abstract-declarator;
}


# rule abstract-declarator:sym<base> { <pointer-abstract-declarator> }
our class AbstractDeclarator::Base does IAbstractDeclarator {
    has IPointerAbstractDeclarator $.pointer-abstract-declarator is required;
}

# rule abstract-declarator:sym<aug> { <no-pointer-abstract-declarator>? <parameters-and-qualifiers> <trailing-return-type> }
our class AbstractDeclarator::Aug does IAbstractDeclarator {
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator;
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
    has TrailingReturnType $.trailing-return-type is required;
}

# rule abstract-declarator:sym<abstract-pack> { <abstract-pack-declarator> } #-----------------------------
our class AbstractDeclarator::AbstractPack does IAbstractDeclarator {
    has AbstractPackDeclarator $.abstract-pack-declarator is required;
}


# rule pointer-abstract-declarator:sym<no-ptr> { <no-pointer-abstract-declarator> }
our class PointerAbstractDeclarator::NoPtr does IPointerAbstractDeclarator {
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator is required;
}

# rule pointer-abstract-declarator:sym<ptr> { 
#   <pointer-operator>+ 
#   <no-pointer-abstract-declarator>? 
# } #-----------------------------
our class PointerAbstractDeclarator::Ptr does IPointerAbstractDeclarator {
    has IPointerOperator @.pointer-operators is required;
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator;
}


# rule no-pointer-abstract-declarator-body:sym<base> { <parameters-and-qualifiers> }
our class NoPointerAbstractDeclaratorBody::Base does INoPointerAbstractDeclaratorBody {
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
}

# rule no-pointer-abstract-declarator-body:sym<brack> { <no-pointer-abstract-declarator> <no-pointer-abstract-declarator-bracketed-base> }
our class NoPointerAbstractDeclaratorBody::Brack does INoPointerAbstractDeclaratorBody {
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator is required;
    has NoPointerAbstractDeclaratorBracketedBase $.no-pointer-abstract-declarator-bracketed-base is required;
}

# rule no-pointer-abstract-declarator { 
#   <no-pointer-abstract-declarator-base> 
#   <no-pointer-abstract-declarator-body>* 
# } #-----------------------------
our class NoPointerAbstractDeclarator { 
    has INoPointerAbstractDeclaratorBase  $.no-pointer-abstract-declarator-base is required;
    has INoPointerAbstractDeclaratorBody @.no-pointer-abstract-declarator-body is required;
}


# rule no-pointer-abstract-declarator-base:sym<basic> { <parameters-and-qualifiers> }
our class NoPointerAbstractDeclaratorBase::Basic does INoPointerAbstractDeclaratorBase {
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
}

# rule no-pointer-abstract-declarator-base:sym<bracketed> { <no-pointer-abstract-declarator-bracketed-base> }
our class NoPointerAbstractDeclaratorBase::Bracketed does INoPointerAbstractDeclaratorBase {
    has NoPointerAbstractDeclaratorBracketedBase $.no-pointer-abstract-declarator-bracketed-base is required;
}

# rule no-pointer-abstract-declarator-base:sym<parenthesized> { <.left-paren> <pointer-abstract-declarator> <.right-paren> }
our class NoPointerAbstractDeclaratorBase::Parenthesized does INoPointerAbstractDeclaratorBase {
    has IPointerAbstractDeclarator $.pointer-abstract-declarator is required;
}

# rule no-pointer-abstract-declarator-bracketed-base { 
# <.left-bracket> 
# <constant-expression>? 
# <.right-bracket> 
# <attribute-specifier-seq>? }
our class NoPointerAbstractDeclaratorBracketedBase { 
    has ConstantExpression    $.constant-expression;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
}

# rule abstract-pack-declarator { 
#   <pointer-operator>* 
#   <no-pointer-abstract-pack-declarator> 
# } #-----------------------------
our class AbstractPackDeclarator { 
    has IPointerOperator                 @.pointer-operators is required;
    has NoPointerAbstractPackDeclarator $.no-pointer-abstract-pack-declarator is required;
}

# rule no-pointer-abstract-pack-declarator-basic { <parameters-and-qualifiers> }
our class NoPointerAbstractPackDeclaratorBasic { 
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
}

# rule no-pointer-abstract-pack-declarator-brackets { 
#   <.left-bracket> 
#   <constant-expression>? 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
# } #-----------------------------
our class NoPointerAbstractPackDeclaratorBrackets { 
    has ConstantExpression    $.constant-expression;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
}


# rule no-pointer-abstract-pack-declarator-body:sym<basic> { 
#   <no-pointer-abstract-pack-declarator-basic> 
# }
our class NoPointerAbstractPackDeclaratorBody::Basic does INoPointerAbstractPackDeclaratorBody {
    has NoPointerAbstractPackDeclaratorBasic $.no-pointer-abstract-pack-declarator-basic is required;
}

# rule no-pointer-abstract-pack-declarator-body:sym<brack> { 
#   <no-pointer-abstract-pack-declarator-brackets> 
# } #-----------------------------
our class NoPointerAbstractPackDeclaratorBody::Brack does INoPointerAbstractPackDeclaratorBody {
    has NoPointerAbstractPackDeclaratorBrackets $.no-pointer-abstract-pack-declarator-brackets is required;
}

# rule no-pointer-abstract-pack-declarator { 
#   <ellipsis> 
#   <no-pointer-abstract-pack-declarator-body>* 
# }
our class NoPointerAbstractPackDeclarator { 
    has INoPointerAbstractPackDeclaratorBody @.no-pointer-abstract-pack-declarator-bodies is required;
}

# rule parameter-declaration-clause { 
#   <parameter-declaration-list> 
#   [ <.comma>? <ellipsis> ]? 
# }
our class ParameterDeclarationClause { 
    has ParameterDeclarationList $.parameter-declaration-list is required;
    has Bool                     $.has-ellipsis is required;
}

# rule parameter-declaration-list { 
#   <parameter-declaration> 
#   [ <.comma> <parameter-declaration> ]* 
# } #-----------------------------
our class ParameterDeclarationList { 
    has ParameterDeclaration @.parameter-declaration is required;
}


# rule parameter-declaration-body:sym<decl> { <declarator> }
our class ParameterDeclarationBody::Decl does IParameterDeclarationBody {
    has IDeclarator $.declarator is required;
}

# rule parameter-declaration-body:sym<abst> { <abstract-declarator>? }
our class ParameterDeclarationBody::Abst does IParameterDeclarationBody {
    has IAbstractDeclarator $.abstract-declarator;
}

# rule parameter-declaration { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq> 
#   <parameter-declaration-body> 
#   [ <assign> <initializer-clause> ]? 
# }
our class ParameterDeclaration { 
    has IAttributeSpecifierSeq    $.attribute-specifier-seq;
    has DeclSpecifierSeq         $.decl-specifier-seq is required;
    has IParameterDeclarationBody $.parameter-declaration-body is required;
    has IInitializerClause        $.initializer-clause;
}

# rule function-definition { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq>? 
#   <declarator> 
#   <virtual-specifier-seq>? 
#   <function-body> 
# } #-----------------------------
our class FunctionDefinition { 
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has DeclSpecifierSeq       $.decl-specifier-seq;
    has IDeclarator            $.declarator is required;
    has VirtualSpecifierSeq    $.virtual-specifier-seq;
    has IFunctionBody          $.function-body is required;
}


# rule function-body:sym<compound> { 
#   <constructor-initializer>? 
#   <compound-statement> 
# }
our class FunctionBody::Compound does IFunctionBody {
    has ConstructorInitializer $.constructor-initializer;
    has CompoundStatement      $.compound-statement is required;
}

# rule function-body:sym<try> { <function-try-block> }
our class FunctionBody::Try does IFunctionBody {
    has FunctionTryBlock $.function-try-block is required;
}

# rule function-body:sym<assign-default> { <assign> <default_> <semi> }
our class FunctionBody::AssignDefault does IFunctionBody { 
    has IComment      $.comment;
}

# rule function-body:sym<assign-delete> { <assign> <delete> <semi> }
our class FunctionBody::AssignDelete does IFunctionBody { 
    has IComment      $.comment;
}


# rule initializer:sym<brace-or-eq> { <brace-or-equal-initializer> }
our class Initializer::BraceOrEq does IInitializer {
    has IBraceOrEqualInitializer $.brace-or-equal-initializer is required;
}

# rule initializer:sym<paren-expr-list> { 
#   <.left-paren> 
#   <expression-list> 
#   <.right-paren> 
# } #-----------------------------
our class Initializer::ParenExprList does IInitializer {
    has ExpressionList $.expression-list is required;
}


# rule brace-or-equal-initializer:sym<assign-init> { <assign> <initializer-clause> }
our class BraceOrEqualInitializer::AssignInit does IBraceOrEqualInitializer {
    has IInitializerClause $.initializer-clause is required;
}

# rule brace-or-equal-initializer:sym<braced-init-list> { <braced-init-list> }
our class BraceOrEqualInitializer::BracedInitList does IBraceOrEqualInitializer {
    has BracedInitList $.braced-init-list is required;
}


# rule initializer-clause:sym<assignment> { <comment>? <assignment-expression> }
our class InitializerClause::Assignment does IInitializerClause {
    has IComment              $.comment;
    has IAssignmentExpression $.assignment-expression is required;
}

# rule initializer-clause:sym<braced> { <comment>? <braced-init-list> } #-----------------------------
our class InitializerClause::Braced does IInitializerClause {
    has IComment       $.comment;
    has BracedInitList $.braced-init-list is required;
}

# rule initializer-list { 
#   <initializer-clause> 
#   <ellipsis>? 
#   [ <.comma> <initializer-clause> <ellipsis>? ]* 
# }
our class InitializerList { 
    has IInitializerClause @.initializer-clauses is required;
}

# rule braced-init-list { 
#   <.left-brace> 
#   [ <initializer-list> <.comma>? ]? 
#   <.right-brace> 
# } #-----------------------------
our class BracedInitList { 
    has InitializerList $.initializer-list;
}


# rule class-name:sym<id> { <identifier> }
our class ClassName::Id does IClassName {
    has Identifier $.identifier is required;
}

# rule class-name:sym<template-id> { <simple-template-id> }
our class ClassName::TemplateId does IClassName {
    has SimpleTemplateId $.simple-template-id is required;
}

# rule class-specifier { 
#   <class-head> 
#   <.left-brace> 
#   <member-specification>? 
#   <.right-brace> 
# } #-----------------------------
our class ClassSpecifier { 
    has MemberSpecification $.member-specification;
}


# rule class-head:sym<class> { 
# <.class-key> 
# <attribute-specifier-seq>? 
# [ <class-head-name> <class-virt-specifier>? ]? 
# <base-clause>? }
our class ClassHead::Class does IClassHead {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has ClassHeadName         $.class-head-name;
    has ClassVirtSpecifier    $.class-virt-specifier;
    has BaseClause            $.base-clause;
}

# rule class-head:sym<union> { 
#   <union> 
#   <attribute-specifier-seq>? 
#   [ <class-head-name> <class-virt-specifier>? ]? 
# } #-----------------------------
our class ClassHead::Union does IClassHead {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has ClassHeadName         $.class-head-name;
    has ClassVirtSpecifier    $.class-virt-specifier;
}

# rule class-head-name { <nested-name-specifier>? <class-name> }
our class ClassHeadName { 
    has NestedNameSpecifier $.nested-name-specifier;
    has IClassName           $.class-name is required;
}

# rule class-virt-specifier { <final> } #-----------------------------
our class ClassVirtSpecifier { }


# rule class-key:sym<class> { <.class_> }
our class ClassKey::Class does IClassKey { }

# rule class-key:sym<struct> { <.struct> } #-----------------------------
our class ClassKey::Struct does IClassKey { }


# rule member-specification-base:sym<decl> { <memberdeclaration> }
our class MemberSpecificationBase::Decl does IMemberSpecificationBase {
    has IMemberdeclaration $.memberdeclaration is required;
}

# rule member-specification-base:sym<access> { <access-specifier> <colon> }
our class MemberSpecificationBase::Access does IMemberSpecificationBase {
    has IAccessSpecifier $.access-specifier is required;
}

# rule member-specification { <member-specification-base>+ }
our class MemberSpecification { 
    has IMemberSpecificationBase @.member-specification-bases is required;
}


# rule memberdeclaration:sym<basic> { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq>? 
#   <member-declarator-list>? 
#   <semi> 
# }
our class Memberdeclaration::Basic does IMemberdeclaration {
    has IComment               $.comment;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has DeclSpecifierSeq       $.decl-specifier-seq;
    has MemberDeclaratorList   $.member-declarator-list;
}

# rule memberdeclaration:sym<func> { <function-definition> }
our class Memberdeclaration::Func does IMemberdeclaration {
    has FunctionDefinition $.function-definition is required;
}

# rule memberdeclaration:sym<using> { <using-declaration> }
our class Memberdeclaration::Using does IMemberdeclaration {
    has UsingDeclaration $.using-declaration is required;
}

# rule memberdeclaration:sym<static-assert> { <static-assert-declaration> }
our class Memberdeclaration::StaticAssert does IMemberdeclaration {
    has StaticAssertDeclaration $.static-assert-declaration is required;
}

# rule memberdeclaration:sym<template> { <template-declaration> }
our class Memberdeclaration::Template does IMemberdeclaration {
    has TemplateDeclaration $.template-declaration is required;
}

# rule memberdeclaration:sym<alias> { <alias-declaration> }
our class Memberdeclaration::Alias does IMemberdeclaration {
    has AliasDeclaration $.alias-declaration is required;
}

# rule memberdeclaration:sym<empty> { <empty-declaration> }
our class Memberdeclaration::Empty does IMemberdeclaration { }

# rule member-declarator-list { <member-declarator> [ <.comma> <member-declarator> ]* }
our class MemberDeclaratorList { 
    has IMemberDeclarator @.member-declarators is required;
}


# rule member-declarator:sym<virt> { <declarator> <virtual-specifier-seq>? <pure-specifier>? }
our class MemberDeclarator::Virt does IMemberDeclarator {
    has IDeclarator         $.declarator is required;
    has VirtualSpecifierSeq $.virtual-specifier-seq;
    has PureSpecifier       $.pure-specifier;
}

# rule member-declarator:sym<brace-or-eq> { 
#   <declarator> 
#   <brace-or-equal-initializer>? 
# }
our class MemberDeclarator::BraceOrEq does IMemberDeclarator {
    has IDeclarator              $.declarator is required;
    has IBraceOrEqualInitializer $.brace-or-equal-initializer;
}

# rule member-declarator:sym<ident> { 
#   <identifier>? 
#   <attribute-specifier-seq>? 
#   <colon> 
#   <constant-expression> } #-----------------------------
our class MemberDeclarator::Ident does IMemberDeclarator {
    has Identifier            $.identifier;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has ConstantExpression    $.constant-expression is required;
}

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
    has NestedNameSpecifier $.nested-name-specifier;
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
    has TypeSpecifierSeq     $.type-specifier-seq is required;
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
    has TheTypeId  $.the-type-id is required;
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
our class SimpleTemplateId { 
    has TemplateName         $.template-name is required;
    has TemplateArgumentList $.template-argument-list;
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

# token template-name { <identifier> }
our class TemplateName { 
    has Identifier $.identifier is required;
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
    has TheTypeId $.the-type-id is required;
}

# token template-argument:sym<const-expr> { <constant-expression> }
our class TemplateArgument::ConstExpr does ITemplateArgument {
    has ConstantExpression $.constant-expression is required;
}

# token template-argument:sym<id-expr> { <id-expression> } #---------------------
our class TemplateArgument::IdExpr does ITemplateArgument {
    has IIdExpression $.id-expression is required;
}


# rule type-name-specifier:sym<ident> { <typename_> <nested-name-specifier> <identifier> }
our class TypeNameSpecifier::Ident does ITypeNameSpecifier {
    has NestedNameSpecifier $.nested-name-specifier is required;
    has Identifier $.identifier is required;
}

# rule type-name-specifier:sym<template> { 
#   <typename_> 
#   <nested-name-specifier> 
#   <template>? 
#   <simple-template-id> 
# }
our class TypeNameSpecifier::Template does ITypeNameSpecifier {
    has NestedNameSpecifier $.nested-name-specifier is required;
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
    has TypeSpecifierSeq      $.type-specifier-seq is required;
    has ISomeDeclarator       $.some-declarator;
}

# rule exception-declaration:sym<ellipsis> { <ellipsis> }
our class ExceptionDeclaration::Ellipsis does IExceptionDeclaration { }

# rule throw-expression { <throw> <assignment-expression>? } #---------------------
our class ThrowExpression { 
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
    has TheTypeId @.the-type-ids is required;
}


# token noe-except-specification:sym<full> { <noexcept> <.left-paren> <constant-expression> <.right-paren> }
our class NoeExceptSpecification::Full does INoeExceptSpecification {
    has ConstantExpression $.constant-expression is required;
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

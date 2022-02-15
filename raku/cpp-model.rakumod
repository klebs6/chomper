unit package CPP14;

#-------------------------------
our class Alignas          { }
our class Alignof          { }
our class Asm              { }
our class Auto             { }
our class Bool             { }
our class Break            { }
our class Case             { }
our class Catch            { }
our class Char             { }
our class Char16           { }
our class Char32           { }
our class Class            { }
our class Const            { }
our class Constexpr        { }
our class Const_cast       { }
our class Continue         { }
our class Decltype         { }
our class Default          { }
our class Delete           { }
our class Do               { }
our class Double           { }
our class Dynamic_cast     { }
our class Else             { }
our class Enum             { }
our class Explicit         { }
our class Export           { }
our class Extern           { }
our class False            { }
our class Final            { }
our class Float            { }
our class For              { }
our class Friend           { }
our class Goto             { }
our class If               { }
our class Inline           { }
our class Int              { }
our class Long             { }
our class Mutable          { }
our class Namespace        { }
our class New              { }
our class Noexcept         { }
our class Nullptr          { }
our class Operator         { }
our class Override         { }
our class Private          { }
our class Protected        { }
our class Public           { }
our class Register         { }
our class Reinterpret_cast { }
our class Return           { }
our class Short            { }
our class Signed           { }
our class Sizeof           { }
our class Static           { }
our class Static_assert    { }
our class Static_cast      { }
our class Struct           { }
our class Switch           { }
our class Template         { }
our class This             { }
our class Thread_local     { }
our class Throw            { }
our class True             { }
our class Try              { }
our class Typedef          { }
our class Typeid           { }
our class Typename         { }
our class Union            { }
our class Unsigned         { }
our class Using            { }
our class Virtual          { }
our class Void             { }
our class Volatile         { }
our class Wchar            { }
our class While            { }
our class LeftParen        { }
our class RightParen       { }
our class LeftBracket      { }
our class RightBracket     { }
our class LeftBrace        { }
our class RightBrace       { }
our class Plus             { }
our class Minus            { }
our class Star             { }
our class Div              { }
our class Mod              { }
our class Caret            { }
our class And              { }
our class Or               { }
our class Tilde            { }
our class Assign           { }
our class Less             { }
our class Greater          { }
our class PlusAssign       { }
our class MinusAssign      { }
our class StarAssign       { }
our class DivAssign        { }
our class ModAssign        { }
our class XorAssign        { }
our class AndAssign        { }
our class OrAssign         { }
our class LeftShiftAssign  { }
our class RightShiftAssign { }
our class Equal            { }
our class NotEqual         { }
our class LessEqual        { }
our class GreaterEqual     { }
our class PlusPlus         { }
our class MinusMinus       { }
our class Comma            { }
our class ArrowStar        { }
our class Arrow            { }
our class Question         { }
our class Colon            { }
our class Doublecolon      { }
our class Semi             { }
our class Dot              { }
our class DotStar          { }
our class Ellipsis         { }

#-------------------------------
our role INot { }
our class Not::Bang      does INot { }
our class Not::Not       does INot { has Not $.not is required; }

#-------------------------------
our role IAndAnd { }
our class AndAnd::AndAnd does IAndAnd { }
our class AndAnd::And    does IAndAnd { has And $.and is required; }

#-------------------------------
our role IOrOr { }
our class OrOr::PipePipe does IOrOr { }
our class OrOr::Or       does IOrOr { has Or $.or is required; }

#-------------------------------
our role IIntegerLiteral { }

our class IntegerLiteral::Dec does IIntegerLiteral {
    has DecimalLiteral     $.decimal-literal is required;
    has Integersuffix      $.integersuffix;
}

our class IntegerLiteral::Oct does IIntegerLiteral {
    has OctalLiteral       $.octal-literal is required;
    has Integersuffix      $.integersuffix;
}

our class IntegerLiteral::Hex does IIntegerLiteral {
    has HexadecimalLiteral $.hexadecimal-literal is required;
    has Integersuffix      $.integersuffix;
}

our class IntegerLiteral::Bin does IIntegerLiteral {
    has BinaryLiteral      $.binary-literal is required;
    has Integersuffix      $.integersuffix;
}

#-------------------------------
our role ICharacterLiteralPrefix { }

our class CharacterLiteralPrefix::U    does ICharacterLiteralPrefix { }
our class CharacterLiteralPrefix::BigU does ICharacterLiteralPrefix { }
our class CharacterLiteralPrefix::L    does ICharacterLiteralPrefix { }

#-------------------------------
our class CharacterLiteral { 
    has CharacterLiteralPrefix $.character-literal-prefix;
    has Cchar                  @.cchar;
}

our role IFloatingLiteral { }

our class FloatingLiteral::Frac does IFloatingLiteral {
    has Fractionalconstant $.fractionalconstant is required;
    has Exponentpart       $.exponentpart;
    has Floatingsuffix     $.floatingsuffix;
}

our class FloatingLiteral::Digit does IFloatingLiteral {
    has Digitsequence  $.digitsequence is required;
    has Exponentpart   $.exponentpart  is required;
    has Floatingsuffix $.floatingsuffix;
}

our class StringLiteralItem { 
    has Encodingprefix $.encodingprefix;
    has Str            $.content is required;
}

our class StringLiteral { 
    has StringLiteralItem @.string-literal-items;
}

#-------------------------------
our role IBooleanLiteral { }

our class BooleanLiteral::F does IBooleanLiteral {
    has False $.false is required;
}

our class BooleanLiteral::T does IBooleanLiteral {
    has True $.true is required;
}

our class PointerLiteral { 
    has Nullptr $.nullptr is required;
}

#-------------------------------
our role IUserDefinedLiteral { }

our class UserDefinedLiteral:syn<int> { 
    has UserDefinedIntegerLiteral   $.user-defined-integer-literal is required;
}

our class UserDefinedLiteral::Float does IUserDefinedLiteral {
    has UserDefinedFloatingLiteral  $.user-defined-floating-literal is required;
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
our role IUniversalcharactername { }

our class Universalcharactername::One does IUniversalcharactername {
    has Hexquad $.first is required;
}

our class Universalcharactername::Two does IUniversalcharactername {
    has Hexquad $.first is required;
    has Hexquad $.second is required;
}

#-------------------------------
our role IIdentifierStart { }

our class IdentifierStart::Nondigit does IIdentifierStart {
    has Nondigit $.nondigit is required;
}

our class IdentifierStart::Ucn does IIdentifierStart {
    has Universalcharactername $.universalcharactername is required;
}

#-------------------------------
our role IIdentifierContinue { }

our class IdentifierContinue::Digit does IIdentifierContinue {
    has Digit $.digit is required;
}

our class IdentifierContinue::Nondigit does IIdentifierContinue {
    has Nondigit $.nondigit is required;
}

our class IdentifierContinue::Ucn does IIdentifierContinue {
    has Universalcharactername $.universalcharactername is required;
}

our class Identifier { 
    has Str $.value is required;
}

our class Nondigit { 
    has Str $.value is required;
}

our class Digit { 
    has Str $.value is required;
}

our class DecimalLiteral { 
    has Str $.value is required;
}

our class OctalLiteral { 
    has Str $.value is required;
}

our class HexadecimalLiteral { 
    has Str $.value is required;
}

our class BinaryLiteral { 
    has Str $.value is required;
}

our class Nonzerodigit { 
    has Str $.value is required;
}

our class Octaldigit { 
    has Str $.value is required;
}

our class Hexadecimaldigit { 
    has Str $.value is required;
}

our class Binarydigit { 
    has Str $.value is required;
}

#-------------------------------
our role IIntegersuffix { }

our class Integersuffix::Ul does IIntegersuffix {
    has Unsignedsuffix $.unsignedsuffix is required;
    has Longsuffix     $.longsuffix;
}

our class Integersuffix::Ull does IIntegersuffix {
    has Unsignedsuffix $.unsignedsuffix is required;
    has Longlongsuffix $.longlongsuffix;
}

our class Integersuffix::Lu does IIntegersuffix {
    has Longsuffix     $.longsuffix is required;
    has Unsignedsuffix $.unsignedsuffix;
}

our class Integersuffix::Llu does IIntegersuffix {
    has LongLongsuffix $.longsuffix is required;
    has Unsignedsuffix $.unsignedsuffix;
}

our class Unsignedsuffix { }
our class Longsuffix     { }

#-------------------------------
our role ILonglongsuffix { }
our class Longlongsuffix::Ll does ILonglongsuffix { }
our class Longlongsuffix::LL does ILonglongsuffix { }

#-------------------------------
our role ICchar { }

our class Cchar::Basic does ICchar {
    has Str $.value is required;
}

our class Cchar::Escape does ICchar {
    has Escapesequence $.escapesequence is required;
}

our class Cchar::Universal does ICchar {
    has Universalcharactername $.universalcharactername is required;
}

#-------------------------------
our role IEscapesequence { }

our class Escapesequence::Simple does IEscapesequence {
    has Simpleescapesequence $.simpleescapesequence is required;
}

our class Escapesequence::Octal does IEscapesequence {
    has Octalescapesequence $.octalescapesequence is required;
}

our class Escapesequence::Hex does IEscapesequence {
    has Hexadecimalescapesequence $.hexadecimalescapesequence is required;
}

#-------------------------------
our role ISimpleescapesequence { }
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
our role IFractionalconstant { }

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
our role IEncodingprefix { }

our class Encodingprefix::U8 does IEncodingprefix { }
our class Encodingprefix::U  does IEncodingprefix { }
our class Encodingprefix::U  does IEncodingprefix { }
our class Encodingprefix::L  does IEncodingprefix { }

#-------------------------------
our role ISchar { }

our class Schar::Basic does ISchar {
    has Str $.value is required;
}

our class Schar::Escape does ISchar {
    has Escapesequence $.escapesequence is required;
}

our class Schar::Ucn does ISchar {
    has Universalcharactername $.universalcharactername is required;
}

our class Rawstring { 
    has Str $.value is required;
}

#-------------------------------

our role IUserDefinedIntegerLiteral { }

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
    has Binaryliteral $.binary-literal is required;
}

our role IUserDefinedFloatingLiteral { }

# token user-defined-floating-literal:sym<frac> { <fractionalconstant> <exponentpart>?  <udsuffix> }
our class UserDefinedFloatingLiteral::Frac does IUserDefinedFloatingLiteral {
    has Fractionalconstant $.fractionalconstant is required;
    has Exponentpart       $.exponentpart;
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
    has Declarationseq $.declarationseq;
}

#------------------------------
our role IPrimaryExpression { }

# token primary-expression:sym<literal> { <literal>+ }
our class PrimaryExpression::Literal does IPrimaryExpression {
    has Literal @.literal is required;
}

# token primary-expression:sym<this>    { <this> }
our class PrimaryExpression::This does IPrimaryExpression {
    has This $.this is required;
}

# token primary-expression:sym<expr>    { <.left-paren> <expression> <.right-paren> }
our class PrimaryExpression::Expr does IPrimaryExpression {
    has Expression $.expression is required;
}

# token primary-expression:sym<id>      { <id-expression> }
our class PrimaryExpression::Id does IPrimaryExpression {
    has IdExpression $.id-expression is required;
}

# token primary-expression:sym<lambda>  { <lambda-expression> }     
our class PrimaryExpression::Lambda does IPrimaryExpression {
    has LambdaExpression $.lambda-expression is required;
}

#------------------------------
our role IIdExpression { }

# regex id-expression:sym<qualified>   { <qualified-id> }
our class IdExpression::Qualified does IIdExpression {
    has QualifiedId $.qualified-id is required;
}

# regex id-expression:sym<unqualified> { <unqualified-id> }     
our class IdExpression::Unqualified does IIdExpression {
    has UnqualifiedId $.unqualified-id is required;
}

#------------------------------

our role IUnqualifiedId { }

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
    has LiteralOperatorId $.literal-operator-id is required;
}

# regex unqualified-id:sym<tilde-classname>     { <tilde> <class-name> }
our class UnqualifiedId::TildeClassname does IUnqualifiedId {
    has ClassName $.class-name is required;
}

# regex unqualified-id:sym<tilde-decltype>      { <tilde> <decltype-specifier> }
our class UnqualifiedId::TildeDecltype does IUnqualifiedId {
    has DecltypeSpecifier $.decltype-specifier is required;
}

# regex unqualified-id:sym<template-id>  { <template-id> }
our class UnqualifiedId::TemplateId does IUnqualifiedId {
    has TemplateId $.template-id is required;
}

# regex qualified-id { <nested-name-specifier> <template>? <unqualified-id> }      
our class QualifiedId { 
    has NestedNameSpecifier $.nested-name-specifier is required;
    has Bool                $.template              is required;
    has UnqualifiedId       $.unqualified-id        is required;
}

our role INestedNameSpecifierPrefix { }

# regex nested-name-specifier-prefix:sym<null> { <doublecolon> }
our class NestedNameSpecifierPrefix::Null does INestedNameSpecifierPrefix { }

# regex nested-name-specifier-prefix:sym<type> { <the-type-name> <doublecolon> }
our class NestedNameSpecifierPrefix::Type does INestedNameSpecifierPrefix {
    has TheTypeName $.the-type-name is required;
}

# regex nested-name-specifier-prefix:sym<ns> { <namespace-name> <doublecolon> }
our class NestedNameSpecifierPrefix::Ns does INestedNameSpecifierPrefix {
    has NamespaceName $.namespace-name is required;
}

# regex nested-name-specifier-prefix:sym<decl> { <decltype-specifier> <doublecolon> }
our class NestedNameSpecifierPrefix::Decl does INestedNameSpecifierPrefix {
    has DecltypeSpecifier $.decltype-specifier is required;
}

#--------------------------
our role INestedNameSpecifierSuffix { }

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
    has NestedNameSpecifierPrefix $.nested-name-specifier-prefix   is required;
    has NestedNameSpecifierSuffix @.nested-name-specifier-suffixes;
}

# rule lambda-expression { <lambda-introducer> <lambda-declarator>? <compound-statement> }
our class LambdaExpression { 
    has LambdaIntroducer  $.lambda-introducer is required;
    has LambdaDeclarator  $.lambda-declarator;
    has CompoundStatement $.compound-statement is required;
}

# rule lambda-introducer { <.left-bracket> <lambda-capture>? <.right-bracket> } #-------------------------------
our class LambdaIntroducer { 
    has LambdaCapture $.lambda-capture;
}

our role ILambdaCapture { }

# rule lambda-capture:sym<list> { <capture-list> }
our class LambdaCapture::List does ILambdaCapture {
    has CaptureList $.capture-list is required;
}

# rule lambda-capture:sym<def> { <capture-default> [ <comma> <capture-list> ]? } #-------------------------------
our class LambdaCapture::Def does ILambdaCapture {
    has CaptureDefault $.capture-default is required;
    has CaptureList    $.capture-list;
}

our role ICaptureDefault { }

# rule capture-default:sym<and> { <and_> }
our class CaptureDefault::And does ICaptureDefault {
    has And $.and is required;
}

# rule capture-default:sym<assign> { <assign> } #-------------------------------
our class CaptureDefault::Assign does ICaptureDefault { }

# rule capture-list { <capture> [ <comma> <capture> ]* <ellipsis>? } #-------------------------------
our class CaptureList { 
    has Capture_ @.captures is required;
    has Bool     $.trailing-ellipsis is required;
}

#-------------------
our role ICapture { }

# rule capture:sym<simple> { <simple-capture> }
our class Capture::Simple does ICapture {
    has SimpleCapture $.simple-capture is required;
}

# rule capture:sym<init> { <initcapture> } #-------------------------------
our class Capture::Init does ICapture {
    has Initcapture $.init-capture is required;
}

our role ISimpleCapture { }

# rule simple-capture:sym<id> { <and_>? <identifier> }
our class SimpleCapture::Id does ISimpleCapture {
    has And        $.and_;
    has Identifier $.identifier is required;
}

# rule simple-capture:sym<this> { <this> } #-------------------------------
our class SimpleCapture::This does ISimpleCapture { }

# rule initcapture { <and_>? <identifier> <initializer> } #-------------------------------
our class Initcapture { 
    has And $.and;
    has Identifier  $.identifier  is required;
    has Initializer $.initializer is required;
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
    has ExceptionSpecification     $.exception-specification;
    has AttributeSpecifierSeq      $.attribute-specifier-seq;
    has TrailingReturnType         $.trailing-return-type;
}

# rule postfix-expression { <postfix-expression-body> <postfix-expression-tail>* }
our class PostfixExpression { 
    has PostfixExpressionBody $.postfix-expression-body is required;
    has PostfixExpressionTail @.postfix-expression-tail;
}

#------------------------------
our role IPostfixExpressionTail { }

# rule bracket-tail { <.left-bracket> [ <expression> || <braced-init-list> ] <.right-bracket> }
our class BracketTail::Expression { 
    has Expression $.expression is required;
}

our class BracketTail::BracedInitList { 
    has BracketTail $.bracket-tail is required;
}

# rule postfix-expression-tail:sym<bracket> { <bracket-tail> }
our class PostfixExpressionTail::Bracket does IPostfixExpressionTail {
    has BracketTail $.bracket-tail is required;
}

# rule postfix-expression-tail:sym<parens> { <.left-paren> <expression-list>? <.right-paren> }
our class PostfixExpressionTail::Parens does IPostfixExpressionTail {
    has ExpressionList $.expression-list;
}

# rule postfix-expression-tail:sym<indirection-id> { [ <dot> || <arrow> ] <template>? <id-expression> }
our class PostfixExpressionTail::IndirectionId does IPostfixExpressionTail {
    has Bool         $.template is required;
    has IdExpression $.id-expression is required;
}

# rule postfix-expression-tail:sym<indirection-pseudo-dtor> { [ <dot> || <arrow> ] <pseudo-destructor-name> }
our class PostfixExpressionTail::IndirectionPseudoDtor does IPostfixExpressionTail {
    has PseudoDestructorName $.pseudo-destructor-name is required;
}

# rule postfix-expression-tail:sym<pp-mm> { [ <plus-plus> || <minus-minus> ] } 
our class PostfixExpressionTail::PlusPlus does IPostfixExpressionTail { }

our class PostfixExpressionTail::MinusMinus does IPostfixExpressionTail { }

# token postfix-expression-body { 
#   || <postfix-expression-list> 
#   || <postfix-expression-cast> 
#   || <postfix-expression-typeid> 
#   || <primary-expression> 
# }
our role IPostfixExpressionBody { }

our role ICastToken { }

# token cast-token:sym<dyn> { <dynamic_cast> }
our class CastToken::Dyn does ICastToken {
    has Dynamic_cast $.dynamic_cast is required;
}

# token cast-token:sym<static> { <static_cast> }
our class CastToken::Static does ICastToken {
    has Static_cast $.static_cast is required;
}

# token cast-token:sym<reinterpret> { <reinterpret_cast> }
our class CastToken::Reinterpret does ICastToken {
    has Reinterpret_cast $.reinterpret_cast is required;
}

# token cast-token:sym<const> { <const_cast> }
our class CastToken::Const does ICastToken {
    has Const_cast $.const_cast is required;
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
our class PostfixExpressionCast { 
    has CastToken  $.cast-token  is required;
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

our role IPostListHead { }

# token post-list-head:sym<simple> { <simple-type-specifier> }
our class PostListHead::Simple does IPostListHead {
    has SimpleTypeSpecifier $.simple-type-specifier is required;
}

# token post-list-head:sym<type-name> { <type-name-specifier> } 
our class PostListHead::TypeName does IPostListHead {
    has TypeNameSpecifier $.type-name-specifier is required;
}

our role IPostListTail { }

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
    has Typeid $.typeid is required;
}

# rule expression-list { <initializer-list> }
our class ExpressionList { 
    has InitializerList $.initializer-list is required;
}

#-------------------------------
our role IPseudoDestructorName { }

# rule pseudo-destructor-name:sym<basic> { 
#   <nested-name-specifier>? 
#   [ <the-type-name> <doublecolon> ]? 
#   <tilde> 
#   <the-type-name> 
# }
our class PseudoDestructorName::Basic does IPseudoDestructorName {
    has Bool        $.nested-name-specifier;
    has TheTypeName $.the-scoped-type-name;
    has TheTypeName $.the-type-anme is required;
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
    has Template            $.template              is required;
    has SimpleTemplateId    $.simple-template-id    is required;
    has Doublecolon         $.doublecolon           is required;
    has Tilde               $.tilde                 is required;
    has TheTypeName         $.the-type-name         is required;
}

# rule pseudo-destructor-name:sym<decltype> { <tilde> <decltype-specifier> } #-------------------------------------
our class PseudoDestructorName::Decltype does IPseudoDestructorName {
    has DecltypeSpecifier $.decltype-specifier is required;
}

# rule unary-expression { <new-expression> || <unary-expression-case> }
our role IUnaryExpression { }

our class IUnaryExpression::New { 
    has NewExpression $.new-expression is required;
}

our class IUnaryExpression::Case { 
    has IUnaryExpressionCase $.case is required;
}

#--------------------------
our role IUnaryExpressionCase { }

# rule unary-expression-case:sym<postfix> { <postfix-expression> }
our class UnaryExpressionCase::Postfix does IUnaryExpressionCase {
    has PostfixExpression $.postfix-expression is required;
}

# rule unary-expression-case:sym<pp> { <plus-plus> <unary-expression> }
our class UnaryExpressionCase::Pp does IUnaryExpressionCase {
    has PlusPlus        $.plus-plus        is required;
    has UnaryExpression $.unary-expression is required;
}

# rule unary-expression-case:sym<mm> { <minus-minus> <unary-expression> }
our class UnaryExpressionCase::Mm does IUnaryExpressionCase {
    has MinusMinus      $.minus-minus      is required;
    has UnaryExpression $.unary-expression is required;
}

# rule unary-expression-case:sym<unary-op> { <unary-operator> <unary-expression> }
our class UnaryExpressionCase::UnaryOp does IUnaryExpressionCase {
    has UnaryOperator   $.unary-operator   is required;
    has UnaryExpression $.unary-expression is required;
}

# rule unary-expression-case:sym<sizeof> { <sizeof> <unary-expression> }
our class UnaryExpressionCase::Sizeof does IUnaryExpressionCase {
    has Sizeof          $.sizeof           is required;
    has UnaryExpression $.unary-expression is required;
}

# rule unary-expression-case:sym<sizeof-typeid> { <sizeof> <.left-paren> <the-type-id> <.right-paren> }
our class UnaryExpressionCase::SizeofTypeid does IUnaryExpressionCase {
    has Sizeof    $.sizeof      is required;
    has TheTypeId $.the-type-id is required;
}

# rule unary-expression-case:sym<sizeof-ids> { <sizeof> <ellipsis> <.left-paren> <identifier> <.right-paren> }
our class UnaryExpressionCase::SizeofIds does IUnaryExpressionCase {
    has Sizeof $.sizeof is required;
    has Ellipsis $.ellipsis is required;
    has Identifier $.identifier is required;
}

# rule unary-expression-case:sym<alignof> { <alignof> <.left-paren> <the-type-id> <.right-paren> }
our class UnaryExpressionCase::Alignof does IUnaryExpressionCase {
    has Alignof $.alignof is required;
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
our role IUnaryOperator { }

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
our role INewExpression { }

# rule new-expression:sym<new-type-id> { <doublecolon>? <new_> <new-placement>? <new-type-id> <new-initializer>? }
our class NewExpression::NewTypeId does INewExpression {
    has NewPlacement   $.new-placement;
    has NewTypeId      $.new-type-id is required;
    has NewInitializer $.new-initializer;
}

# rule new-expression:sym<the-type-id> { <doublecolon>? <new_> <new-placement>? <.left-paren> <the-type-id> <.right-paren> <new-initializer>? }
our class NewExpression::TheTypeId does INewExpression {
    has NewPlacement   $.new-placement;
    has TheTypeId      $.the-type-id is required;
    has NewInitializer $.new-initializer;
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
    has PointerOperator @.pointer-operators;
    has NoPointerNewDeclarator $.no-pointer-new-declarator;
}


# rule no-pointer-new-declarator { <.left-bracket> <expression> <.right-bracket> <attribute-specifier-seq>? <no-pointer-new-declarator-tail>* }
our class NoPointerNewDeclarator { 
    has Expression                 $.expression is required;
    has AttributeSpecifierSeq      $.attribute-specifier-seq;
    has NoPointerNewDeclaratorTail @.no-pointer-new-declarator-tail;
}

# rule no-pointer-new-declarator-tail { <.left-bracket> <constant-expression> <.right-bracket> <attribute-specifier-seq>? } #------------------------
our class NoPointerNewDeclaratorTail {
    has ConstantExpression    $.constant-expression is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

our role INewInitializer { }

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
    has UnaryExpression $.unary-expression is required;
}

#-----------------------
our role IPointerMemberOperator { }

# rule pointer-member-operator:sym<dot> { <dot-star> }
our class PointerMemberOperator::Dot does IPointerMemberOperator {
    has DotStar $.dot-star is required;
}

# rule pointer-member-operator:sym<arrow> { <arrow-star> }
our class PointerMemberOperator::Arrow does IPointerMemberOperator {
    has ArrowStar $.arrow-star is required;
}

# rule pointer-member-expression { <cast-expression> <pointer-member-expression-tail>* }
our class PointerMemberExpression { 
    has CastExpression              $.cast-expression is required;
    has PointerMemberExpressionTail @.pointer-member-expression-tail;
}

# rule pointer-member-expression-tail { <pointer-member-operator> <cast-expression> }
our class PointerMemberExpressionTail { 
    has PointerMemberOperator $.pointer-member-operator is required;
    has CastExpression        $.cast-expression is required;
}

#-----------------------
our role IMultiplicativeOperator { }

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
    has MultiplicativeOperator  $.multiplicative-operator is required;
    has PointerMemberExpression $.pointer-member-expression is required;
}

our role IAdditiveOperator { }

# token additive-operator:sym<plus> { <plus> }
our class AdditiveOperator::Plus does IAdditiveOperator {
    has Plus $.plus is required;
}

# token additive-operator:sym<minus> { <minus> }
our class AdditiveOperator::Minus does IAdditiveOperator { }

# rule additive-expression-tail { <additive-operator> <multiplicative-expression> }
our class AdditiveExpressionTail { 
    has AdditiveOperator         $.additive-operator         is required;
    has MultiplicativeExpression $.multiplicative-expression is required;
}

# rule additive-expression { <multiplicative-expression> <additive-expression-tail>* }
our class AdditiveExpression { 
    has MultiplicativeExpression $.multiplicative-expression is required;
    has AdditiveExpressionTail   @.additive-expression-tail;
}

# rule shift-expression-tail { <shift-operator> <additive-expression> }
our class ShiftExpressionTail { 
    has ShiftOperator      $.shift-operator      is required;
    has AdditiveExpression $.additive-expression is required;
}

# rule shift-expression { <additive-expression> <shift-expression-tail>* } #-----------------------
our class ShiftExpression { 
    has AdditiveExpression  $.additive-expression is required;
    has ShiftExpressionTail $.shift-expression-tail is required;
}

our role IShiftOperator { }

# rule shift-operator:sym<right> { <.greater> <.greater> }
our class ShiftOperator::Right does IShiftOperator { }

# rule shift-operator:sym<left> { <.less> <.less> } #-----------------------
our class ShiftOperator::Left does IShiftOperator { }

our role IRelationalOperator { }

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
    has RelationalOperator $.relational-operator is required;
    has ShiftExpression    $.shift-expression    is required;
}

# regex relational-expression { <shift-expression> <relational-expression-tail>* } #-----------------------
our class RelationalExpression { 
    has ShiftExpression          $.shift-expression is required;
    has RelationalExpressionTail @.relational-expression-tail is required;
}

our role IEqualityOperator { }

# token equality-operator:sym<eq> { <equal> }
our class EqualityOperator::Eq does IEqualityOperator { }

# token equality-operator:sym<neq> { <not-equal> } #-----------------------
our class EqualityOperator::Neq does IEqualityOperator { }

# rule equality-expression-tail { <equality-operator> <relational-expression> }
our class EqualityExpressionTail { 
    has EqualityOperator     $.equality-operator     is required;
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
    has AssignmentExpression $.assignment-expression is required;
}

# rule conditional-expression { <logical-or-expression> <conditional-expression-tail>? } #-----------------------
our class ConditionalExpression { 
    has LogicalOrExpression       $.logical-or-expression is required;
    has ConditionalExpressionTail $.conditional-expression-tail;
}

our role IAssignmentExpression { }

# rule assignment-expression:sym<throw> { <throw-expression> }
our class AssignmentExpression::Throw does IAssignmentExpression {
    has ThrowExpression $.throw-expression is required;
}

# rule assignment-expression:sym<basic> { <logical-or-expression> <assignment-operator> <initializer-clause> }
our class AssignmentExpression::Basic does IAssignmentExpression {
    has LogicalOrExpression $.logical-or-expression is required;
    has AssignmentOperator $.assignment-operator is required;
    has InitializerClause $.initializer-clause is required;
}

# rule assignment-expression:sym<conditional> { <conditional-expression> }
our class AssignmentExpression::Conditional does IAssignmentExpression {
    has ConditionalExpression $.conditional-expression is required;
}

our role IAssignmentOperator { }

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
    has AssignmentExpression @.assignment-expressions is required;
}

# rule constant-expression { <conditional-expression> }
our class ConstantExpression { 
    has ConditionalExpression $.conditional-expression is required;
}

our role IComment { }

# regex comment:sym<line> { [<line-comment> <.ws>?]+ }
our class Comment::Line does IComment {
    has LineComment @.line-comments is required;
}

# rule comment:sym<block> { <block-comment> } #-----------------------------
our class Comment::Block does IComment {
    has BlockComment @.block-comments is required;
}

our role IStatement { }

# token statement:sym<attributed> { <comment>? <attribute-specifier-seq>? <attributed-statement-body> }
our class Statement::Attributed does IStatement {
    has Comment                 $.comment;
    has AttributeSpecifierSeq   $.attribute-specifier-seq;
    has AttributedStatementBody $.attributed-statement-body is required;
}

# token statement:sym<labeled> { <comment>? <labeled-statement> }
our class Statement::Labeled does IStatement {
    has Comment          $.comment;
    has LabeledStatement $.labeled-statement is required;
}

# token statement:sym<declaration> { <comment>? <declaration-statement> }
our class Statement::Declaration does IStatement {
    has Comment              $.comment;
    has DeclarationStatement $.declaration-statement is required;
}

our role IAttributedStatementBody { }

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
    has SelectionStatement $.selection-statement is required;
}

# rule attributed-statement-body:sym<iteration> { <iteration-statement> }
our class AttributedStatementBody::Iteration does IAttributedStatementBody {
    has IterationStatement $.iteration-statement is required;
}

# rule attributed-statement-body:sym<jump> { <jump-statement> }
our class AttributedStatementBody::Jump does IAttributedStatementBody {
    has JumpStatement $.jump-statement is required;
}

# rule attributed-statement-body:sym<try> { <try-block> } #-----------------------------
our class AttributedStatementBody::Try does IAttributedStatementBody {
    has TryBlock $.try-block is required;
}

our role ILabeledStatementLabelBody { }

# rule labeled-statement-label-body:sym<id> { <identifier> }
our class LabeledStatementLabelBody::Id does ILabeledStatementLabelBody {
    has Identifier $.identifier is required;
}

# rule labeled-statement-label-body:sym<case-expr> { <case> <constant-expression> }
our class LabeledStatementLabelBody::CaseExpr does ILabeledStatementLabelBody {
    has Case               $.case                is required;
    has ConstantExpression $.constant-expression is required;
}

# rule labeled-statement-label-body:sym<default> { <default_> } #-----------------------------
our class LabeledStatementLabelBody::Default does ILabeledStatementLabelBody { }

# rule labeled-statement-label { <attribute-specifier-seq>? <labeled-statement-label-body> <colon> }
our class LabeledStatementLabel { 
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has LabeledStatementLabelBody $.labeled-statement-label-body is required;
}

# rule labeled-statement { <labeled-statement-label> <statement> }
our class LabeledStatement { 
    has LabeledStatementLabel $.labeled-statement-label is required;
    has Statement             $.statement is required;
}

# rule declaration-statement { <block-declaration> } #-----------------------------
our class DeclarationStatement { 
    has BlockDeclaration $.block-declaration is required;
}

# rule expression-statement { <expression>? <semi> }
our class ExpressionStatement { 
    has Expression $.expression;
}

# rule compound-statement { <.left-brace> <statement-seq>? <.right-brace> }
our class CompoundStatement { 
    has StatementSeq $.statement-seq;
}

# regex statement-seq { <statement> [<.ws> <statement>]* } #-----------------------------
our class StatementSeq { 
    has Statement @.statements is required;
}

our role ISelectionStatement { }

# rule selection-statement:sym<if> { 
#   <.if_> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> 
#   <statement> 
#   [ <comment>? <else_> <statement> ]? 
# }
our class SelectionStatement::If does ISelectionStatement {
    has Condition $.condition is required;
    has Statement $.statement is required;
    has Comment   $.else-statement-comment;
    has Statement $.else-statement;
}

# rule selection-statement:sym<switch> { 
#   <switch> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> 
#   <statement> 
# } #-----------------------------
our class SelectionStatement::Switch does ISelectionStatement {
    has Condition $.condition is required;
    has Statement $.statement is required;
}

our role ICondition { }

# rule condition:sym<expr> { <expression> } #-----------------------------
our class Condition::Expr does ICondition {
    has Expression $.expression is required;
}

our role IConditionDeclTail { }

# rule condition-decl-tail:sym<assign-init> { <assign> <initializer-clause> }
our class ConditionDeclTail::AssignInit does IConditionDeclTail {
    has Assign            $.assign             is required;
    has InitializerClause $.initializer-clause is required;
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
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has DeclSpecifierSeq      $.decl-specifier-seq  is required;
    has Declarator            $.declarator          is required;
    has ConditionDeclTail     $.condition-decl-tail is required;
}

our role IIterationStatement { }

# rule iteration-statement:sym<while> { 
#   <while_> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> <statement> 
# }
our class IterationStatement::While does IIterationStatement {
    has Condition $.condition is required;
    has Statement $.statement is required;
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
    has Statement  $.statement is required;
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
    has ForInitStatement $.for-init-statement is required;
    has Condition        $.condition;
    has Expression       $.expression;
    has Statement        $.statement is required;
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
    has ForRangeInitializer $.for-range-initializer is required;
    has Statement           $.statement is required;
}

our role IForInitStatement { }

# rule for-init-statement:sym<expression-statement> { <expression-statement> }
our class ForInitStatement::ExpressionStatement does IForInitStatement {
    has ExpressionStatement $.expression-statement is required;
}

# rule for-init-statement:sym<simple-declaration> { <simple-declaration> }
our class ForInitStatement::SimpleDeclaration does IForInitStatement {
    has SimpleDeclaration $.simple-declaration is required;
}

# rule for-range-declaration { <attribute-specifier-seq>? <decl-specifier-seq> <declarator> }
our class ForRangeDeclaration { 
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has DeclSpecifierSeq      $.decl-specifier-seq is required;
    has Declarator            $.declarator is required;
}

our role IForRangeInitializer { }

# rule for-range-initializer:sym<expression> { <expression> }
our class ForRangeInitializer::Expression does IForRangeInitializer {
    has Expression $.expression is required;
}

# rule for-range-initializer:sym<braced-init-list> { <braced-init-list> } #-------------------------------
our class ForRangeInitializer::BracedInitList does IForRangeInitializer {
    has BracedInitList $.braced-init-list is required;
}

#----------------------
our role IJumpStatement { }

# rule jump-statement:sym<break> { <break_> <semi> }
our class JumpStatement::Break does IJumpStatement { }

# rule jump-statement:sym<continue> { <continue_> <semi> }
our class JumpStatement::Continue does IJumpStatement { }

# rule jump-statement:sym<return> { <return_> <return-statement-body>? <semi> }
our class JumpStatement::Return does IJumpStatement {
    has Return              $.return_ is required;
    has ReturnStatementBody $.return-statement-body;
}

# rule jump-statement:sym<goto> { <goto_> <identifier> <semi> }
our class JumpStatement::Goto does IJumpStatement {
    has Identifier $.identifier is required;
}

#----------------------
our role IReturnStatementBody { }

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
    has Declaration @.declarations is required;
}

our role IDeclaration { }

# rule declaration:sym<block-declaration> { <block-declaration> }
our class Declaration::BlockDeclaration does IDeclaration {
    has BlockDeclaration $.block-declaration is required;
}

# rule declaration:sym<function-definition> { <function-definition> }
our class Declaration::FunctionDefinition does IDeclaration {
    has FunctionDefinition $.function-definition is required;
}

# rule declaration:sym<template-declaration> { <template-declaration> }
our class Declaration::TemplateDeclaration does IDeclaration {
    has TemplateDeclaration $.template-declaration is required;
}

# rule declaration:sym<explicit-instantiation> { <explicit-instantiation> }
our class Declaration::ExplicitInstantiation does IDeclaration {
    has ExplicitInstantiation $.explicit-instantiation is required;
}

# rule declaration:sym<explicit-specialization> { <explicit-specialization> }
our class Declaration::ExplicitSpecialization does IDeclaration {
    has ExplicitSpecialization $.explicit-specialization is required;
}

# rule declaration:sym<linkage-specification> { <linkage-specification> }
our class Declaration::LinkageSpecification does IDeclaration {
    has LinkageSpecification $.linkage-specification is required;
}

# rule declaration:sym<namespace-definition> { <namespace-definition> }
our class Declaration::NamespaceDefinition does IDeclaration {
    has NamespaceDefinition $.namespace-definition is required;
}

# rule declaration:sym<empty-declaration> { <empty-declaration> }
our class Declaration::EmptyDeclaration does IDeclaration {
    has EmptyDeclaration $.empty-declaration is required;
}

# rule declaration:sym<attribute-declaration> { <attribute-declaration> }
our class Declaration::AttributeDeclaration does IDeclaration {
    has AttributeDeclaration $.attribute-declaration is required;
}

our role IBlockDeclaration { }

# rule block-declaration:sym<simple> { <simple-declaration> }
our class BlockDeclaration::Simple does IBlockDeclaration {
    has SimpleDeclaration $.simple-declaration is required;
}

# rule block-declaration:sym<asm> { <asm-definition> }
our class BlockDeclaration::Asm does IBlockDeclaration {
    has AsmDefinition $.asm-definition is required;
}

# rule block-declaration:sym<namespace-alias> { <namespace-alias-definition> }
our class BlockDeclaration::NamespaceAlias does IBlockDeclaration {
    has NamespaceAliasDefinition $.namespace-alias-definition is required;
}

# rule block-declaration:sym<using-decl> { <using-declaration> }
our class BlockDeclaration::UsingDecl does IBlockDeclaration {
    has UsingDeclaration $.using-declaration is required;
}

# rule block-declaration:sym<using-directive> { <using-directive> }
our class BlockDeclaration::UsingDirective does IBlockDeclaration {
    has UsingDirective $.using-directive is required;
}

# rule block-declaration:sym<static-assert> { <static-assert-declaration> }
our class BlockDeclaration::StaticAssert does IBlockDeclaration {
    has StaticAssertDeclaration $.static-assert-declaration is required;
}

# rule block-declaration:sym<alias> { <alias-declaration> }
our class BlockDeclaration::Alias does IBlockDeclaration {
    has AliasDeclaration $.alias-declaration is required;
}

# rule block-declaration:sym<opaque-enum-decl> { <opaque-enum-declaration> }
our class BlockDeclaration::OpaqueEnumDecl does IBlockDeclaration {
    has OpaqueEnumDeclaration $.opaque-enum-declaration is required;
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
    has Identifier $.identifier is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has TheTypeId $.the-type-id is required;
}

our role ISimpleDeclaration { }

# rule simple-declaration:sym<basic> { <decl-specifier-seq>? <init-declarator-list>? <.semi> }
our class SimpleDeclaration::Basic does ISimpleDeclaration {
    has DeclSpecifierSeq   $.decl-specifier-seq;
    has InitDeclaratorList $.init-declarator-list;
}

# rule simple-declaration:sym<init-list> { <attribute-specifier-seq> <decl-specifier-seq>? <init-declarator-list> <.semi> }
our class SimpleDeclaration::InitList does ISimpleDeclaration {
    has AttributeSpecifierSeq $.attribute-specifier-seq is required;
    has DeclSpecifierSeq      $.decl-specifier-seq;
    has InitDeclaratorList    $.init-declarator-list is required;
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
    has ConstantExpression $.constant-expression is required;
    has StringLiteral      $.string-literal is required;
}

# rule empty-declaration { <.semi> }
our class EmptyDeclaration { }

# rule attribute-declaration { <attribute-specifier-seq> <.semi> }
our class AttributeDeclaration { 
    has AttributeSpecifierSeq $.attribute-specifier-seq is required;
}

#-------------------
our role IDeclSpecifier { }

# token decl-specifier:sym<storage-class> { <storage-class-specifier> }
our class DeclSpecifier::StorageClass does IDeclSpecifier {
    has StorageClassSpecifier $.storage-class-specifier is required;
}

# token decl-specifier:sym<type> { <type-specifier> }
our class DeclSpecifier::Type does IDeclSpecifier {
    has TypeSpecifier $.type-specifier is required;
}

# token decl-specifier:sym<func> { <function-specifier> }
our class DeclSpecifier::Func does IDeclSpecifier {
    has FunctionSpecifier $.function-specifier is required;
}

# token decl-specifier:sym<friend> { <.friend> }
our class DeclSpecifier::Friend does IDeclSpecifier { }

# token decl-specifier:sym<typedef> { <.typedef> }
our class DeclSpecifier::Typedef does IDeclSpecifier { }

# token decl-specifier:sym<constexpr> { <.constexpr> }
our class DeclSpecifier::Constexpr does IDeclSpecifier { }

# regex decl-specifier-seq { 
#   <decl-specifier> 
#   [<.ws> <decl-specifier>]*? 
#   <attribute-specifier-seq>? 
# }
our class DeclSpecifierSeq { 
    has DeclSpecifier @.decl-specifiers is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

our role IStorageClassSpecifier { }

# rule storage-class-specifier:sym<register> { <.register> }
our class StorageClassSpecifier::Register does IStorageClassSpecifier { }

# rule storage-class-specifier:sym<static> { <.static> }
our class StorageClassSpecifier::Static does IStorageClassSpecifier { }

# rule storage-class-specifier:sym<thread_local> { <.thread_local> }
our class StorageClassSpecifier::Thread_local does IStorageClassSpecifier { }

# rule storage-class-specifier:sym<extern> { <.extern> }
our class StorageClassSpecifier::Extern does IStorageClassSpecifier { }

# rule storage-class-specifier:sym<mutable> { <.mutable> } #---------------------------
our class StorageClassSpecifier::Mutable does IStorageClassSpecifier { }

our role IFunctionSpecifier { }

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

our role ITypeSpecifier { }

# rule type-specifier:sym<trailing-type-specifier> { <trailing-type-specifier> }
our class TypeSpecifier::TrailingTypeSpecifier does ITypeSpecifier {
    has TrailingTypeSpecifier $.trailing-type-specifier is required;
}

# rule type-specifier:sym<class-specifier> { <class-specifier> }
our class TypeSpecifier::ClassSpecifier does ITypeSpecifier {
    has ClassSpecifier $.class-specifier is required;
}

# rule type-specifier:sym<enum-specifier> { <enum-specifier> } #---------------------------
our class TypeSpecifier::EnumSpecifier does ITypeSpecifier {
    has EnumSpecifier $.enum-specifier is required;
}

our role ITrailingTypeSpecifier { }

# rule trailing-type-specifier:sym<cv-qualifier> { <cv-qualifier> <simple-type-specifier> }
our class TrailingTypeSpecifier::CvQualifier does ITrailingTypeSpecifier {
    has CvQualifier         $.cv-qualifier          is required;
    has SimpleTypeSpecifier $.simple-type-specifier is required;
}

# rule trailing-type-specifier:sym<simple> { <simple-type-specifier> }
our class TrailingTypeSpecifier::Simple does ITrailingTypeSpecifier {
    has SimpleTypeSpecifier $.simple-type-specifier is required;
}

# rule trailing-type-specifier:sym<elaborated> { <elaborated-type-specifier> }
our class TrailingTypeSpecifier::Elaborated does ITrailingTypeSpecifier {
    has ElaboratedTypeSpecifier $.elaborated-type-specifier is required;
}

# rule trailing-type-specifier:sym<typename> { <type-name-specifier> } #---------------------------
our class TrailingTypeSpecifier::Typename does ITrailingTypeSpecifier {
    has TypeNameSpecifier $.type-name-specifier is required;
}

# rule type-specifier-seq { <type-specifier>+ <attribute-specifier-seq>? }
our class TypeSpecifierSeq { 
    has TypeNameSpecifier     @.type-specifiers is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

# rule trailing-type-specifier-seq { <trailing-type-specifier>+ <attribute-specifier-seq>? }
our class TrailingTypeSpecifierSeq { 
    has TrailingTypeSpecifier @.trailing-type-specifiers is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

our role ISimpleTypeLengthModifier { }

# rule simple-type-length-modifier:sym<short> { <.short> }
our class SimpleTypeLengthModifier::Short does ISimpleTypeLengthModifier { }

# rule simple-type-length-modifier:sym<long_> { <.long_> }
our class SimpleTypeLengthModifier::Long does ISimpleTypeLengthModifier { }

our role ISimpleTypeSignednessModifier { }

# rule simple-type-signedness-modifier:sym<unsigned> { <.unsigned> }
our class SimpleTypeSignednessModifier::Unsigned does ISimpleTypeSignednessModifier { }

# rule simple-type-signedness-modifier:sym<signed> { <.signed> }
our class SimpleTypeSignednessModifier::Signed does ISimpleTypeSignednessModifier { }

# rule full-type-name { <nested-name-specifier>? <the-type-name> }
our class FullTypeName { 
    has NestedNameSpecifier $.nested-name-specifier;
    has TheTypeName         $.the-type-name is required;
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
    has SimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has SimpleTypeLengthModifier     @.simple-type-length-modifiers is required;
}

# rule simple-char-type-specifier { <simple-type-signedness-modifier>? <char_> }
our class SimpleCharTypeSpecifier { 
    has SimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has Char_                        $.char is required;
}

# rule simple-char16-type-specifier { <simple-type-signedness-modifier>? <char16> }
our class SimpleChar16TypeSpecifier { 
    has SimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has Char16                       $.char16 is required;
}

# rule simple-char32-type-specifier { <simple-type-signedness-modifier>? <char32> }
our class SimpleChar32TypeSpecifier { 
    has SimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has Char32                       $.char32 is required;
}

# rule simple-wchar-type-specifier { <simple-type-signedness-modifier>? <wchar> }
our class SimpleWcharTypeSpecifier { 
    has SimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has WChar                        $.wchar is required;
}

# rule simple-double-type-specifier { <simple-type-length-modifier>? <double> } #------------------------------
our class SimpleDoubleTypeSpecifier { 
    has SimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has Double                       $.double is required;
}

our role ISimpleTypeSpecifier { }

# regex simple-type-specifier:sym<int> { <simple-int-type-specifier> }
our class SimpleTypeSpecifier::Int does ISimpleTypeSpecifier {
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
    has SimpleTypeSignednessModifier $.simple-type-signedness-modifier is required;
}

# regex simple-type-specifier:sym<signedness-mod-length> { <simple-type-signedness-modifier>? <simple-type-length-modifier>+ }
our class SimpleTypeSpecifier::SignednessModLength does ISimpleTypeSpecifier {
    has SimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has SimpleTypeLengthModifier     @.simple-type-length-modifier is required;
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
our class SimpleTypeSpecifier::Float does ISimpleTypeSpecifier {
    has Float $.float is required;
}

# regex simple-type-specifier:sym<double> { <simple-double-type-specifier> }
our class SimpleTypeSpecifier::Double does ISimpleTypeSpecifier {
    has SimpleDoubleTypeSpecifier $.simple-double-type-specifier is required;
}

# regex simple-type-specifier:sym<void> { <void_> }
our class SimpleTypeSpecifier::Void does ISimpleTypeSpecifier {
    has Void $.void_ is required;
}

# regex simple-type-specifier:sym<auto> { <auto> }
our class SimpleTypeSpecifier::Auto does ISimpleTypeSpecifier {
    has Auto $.auto is required;
}

# regex simple-type-specifier:sym<decltype> { <decltype-specifier> } #------------------------------
our class SimpleTypeSpecifier::Decltype does ISimpleTypeSpecifier {
    has DecltypeSpecifier $.decltype-specifier is required;
}

our role ITheTypeName { }

# rule the-type-name:sym<simple-template-id> { <simple-template-id> }
our class TheTypeName::SimpleTemplateId does ITheTypeName {
    has SimpleTemplateId $.simple-template-id is required;
}

# rule the-type-name:sym<class> { <class-name> }
our class TheTypeName::Class does ITheTypeName {
    has ClassName $.class-name is required;
}

# rule the-type-name:sym<enum> { <enum-name> }
our class TheTypeName::Enum does ITheTypeName {
    has EnumName $.enum-name is required;
}

# rule the-type-name:sym<typedef> { <typedef-name> } #------------------------------
our class TheTypeName::Typedef does ITheTypeName {
    has TypedefName $.typedef-name is required;
}

our role IDecltypeSpecifierBody { }

# rule decltype-specifier-body:sym<expr> { <expression> }
our class DecltypeSpecifierBody::Expr does IDecltypeSpecifierBody {
    has Expression $.expression is required;
}

# rule decltype-specifier-body:sym<auto> { <auto> }
our class DecltypeSpecifierBody::Auto does IDecltypeSpecifierBody {
    has Auto $.auto is required;
}

# rule decltype-specifier { 
#   <decltype> 
#   <.left-paren> 
#   <decltype-specifier-body> 
#   <.right-paren> 
# } #------------------------------
our class DecltypeSpecifier { 
    has DecltypeSpecifierBody $.decltype-specifier-body is required;
}

our role IElaboratedTypeSpecifier { }

# rule elaborated-type-specifier:sym<class-ident> { <.class-key> <attribute-specifier-seq>? <nested-name-specifier>? <identifier> }
our class ElaboratedTypeSpecifier::ClassIdent does IElaboratedTypeSpecifier {
    has AttributeSpecifierSeq $.attribute-specifier-seq;
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
    has Template            $.template;
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
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has NestedNameSpecifier   $.nested-name-specifier;
    has Identifier            $.identifier;
    has EnumBase              $.enum-base;
}

# rule opaque-enum-declaration { 
#   <.enumkey> 
#   <attribute-specifier-seq>? 
#   <identifier> 
#   <enumbase>? 
#   <semi> 
# }
our class OpaqueEnumDeclaration { 
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has Identifier            $.identifier is required;
    has EnumBase              $.enum-base is required;
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
our role INamespaceName { }

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

our role INamespaceTag { }

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
    has NamespaceTag   $.namespace-tag;
    has Declarationseq $.namespace-body;
}

# rule namespace-alias { <identifier> }
our class NamespaceAlias { 
    has Identifier $.identifier is required;
}

# rule namespace-alias-definition { <namespace> <identifier> <assign> <qualifiednamespacespecifier> <semi> }
our class NamespaceAliasDefinition { 
    has Identifier $.identifier is required;
    has Qualifiednamespacespecifier $.qualifiednamespacespecifier is required;
}

# rule qualifiednamespacespecifier { <nested-name-specifier>? <namespace-name> } #--------------------
our class Qualifiednamespacespecifier { 
    has NestedNameSpecifier $.nested-name-specifier;
    has NamespaceName       $.namespace-name is required;
}

our role IUsingDeclarationPrefix { }

# rule using-declaration-prefix:sym<nested> { [ <typename_>? <nested-name-specifier> ] }
our class UsingDeclarationPrefix::Nested does IUsingDeclarationPrefix {
    has NestedNameSpecifier $.nested-name-specifier is required;
}

# rule using-declaration-prefix:sym<base> { <doublecolon> } #--------------------
our class UsingDeclarationPrefix::Base does IUsingDeclarationPrefix { }

# rule using-declaration { <using> <using-declaration-prefix> <unqualified-id> <semi> }
our class UsingDeclaration { 
    has UsingDeclarationPrefix $.using-declaration-prefix is required;
    has UnqualifiedId          $.unqualified-id is required;
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
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has NestedNameSpecifier   $.nested-name-specifier;
    has NamespaceName         $.namespace-name is required;
}

# rule asm-definition { 
#   <asm> 
#   <.left-paren> 
#   <string-literal> 
#   <.right-paren> 
#   <.semi> 
# } #--------------------
our class AsmDefinition { 
    has StringLiteral $.string-literal is required;
}

our role ILinkageSpecificationBody { }

# rule linkage-specification-body:sym<seq> { <.left-brace> <declarationseq>? <.right-brace> }
our class LinkageSpecificationBody::Seq does ILinkageSpecificationBody {
    has Declarationseq $.declarationseq;
}

# rule linkage-specification-body:sym<decl> { <declaration> }
our class LinkageSpecificationBody::Decl does ILinkageSpecificationBody {
    has Declaration $.declaration is required;
}

# rule linkage-specification { 
#   <extern> 
#   <string-literal> 
#   <linkage-specification-body> 
# }
our class LinkageSpecification { 
    has StringLiteral            $.string-literal is required;
    has LinkageSpecificationBody $.linkage-specification-body is required;
}

# rule attribute-specifier-seq { <attribute-specifier>+ } #--------------------
our class AttributeSpecifierSeq { 
    has AttributeSpecifier @.attribute-specifier is required;
}

our role IAttributeSpecifier { }

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
    has AlignmentSpecifier $.alignmentspecifier is required;
}

our role IAlignmentspecifierbody { }

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
    has Alignmentspecifierbody $.alignmentspecifierbody is required;
    has Bool                   $.has-ellipsis is required;
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
    has Balancedrule @.balancedrules is required;
}

our role IBalancedrule { }

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
    has Declarator  $.declarator is required;
    has Initializer $.initializer;
}

our role IDeclarator { }

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
    has PointerOperator $.pointer-operator is required;
    has Bool            $.const            is required;
}

our role INoPointerDeclaratorBase { }

# rule no-pointer-declarator-base:sym<base> { <declaratorid> <attribute-specifier-seq>? }
our class NoPointerDeclaratorBase::Base does INoPointerDeclaratorBase {
    has Declaratorid          $.declaratorid is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

# rule no-pointer-declarator-base:sym<parens> { <.left-paren> <pointer-declarator> <.right-paren> }
our class NoPointerDeclaratorBase::Parens does INoPointerDeclaratorBase {
    has PointerDeclarator $.pointer-declarator is required;
}

our role INoPointerDeclaratorTail { }

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
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

# rule no-pointer-declarator { 
#   <no-pointer-declarator-base> 
#   <no-pointer-declarator-tail>* 
# } #------------------------------
our class NoPointerDeclarator { 
    has NoPointerDeclaratorBase $.no-pointer-declarator-base is required;
    has NoPointerDeclaratorTail @.no-pointer-declarator-tail;
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
    has Refqualifier               $.refqualifier;
    has ExceptionSpecification     $.exception-specification;
    has AttributeSpecifierSeq      $.attribute-specifier-seq;
}

# rule trailing-return-type { 
#   <arrow> 
#   <trailing-type-specifier-seq> 
#   <abstract-declarator>? 
# }
our class TrailingReturnType { 
    has TrailingTypeSpecifierSeq $.trailing-type-specifier-seq is required;
    has AbstractDeclarator       $.abstract-declarator;
}

our role IPointerOperator { }

# rule pointer-operator:sym<ref> { <and_> <attribute-specifier-seq>? }
our class PointerOperator::Ref does IPointerOperator {
    has And                   $.and_ is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

# rule pointer-operator:sym<ref-ref> { <and-and> <attribute-specifier-seq>? }
our class PointerOperator::RefRef does IPointerOperator {
    has AndAnd $.and-and is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

# rule pointer-operator:sym<star> { <nested-name-specifier>? <star> <attribute-specifier-seq>? <cvqualifierseq>? }
our class PointerOperator::Star does IPointerOperator {
    has NestedNameSpecifier   $.nested-name-specifier;
    has Star                  $.star is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has Cvqualifierseq        $.cvqualifierseq;
}

# rule cvqualifierseq { <cv-qualifier>+ } #-----------------------------
our class Cvqualifierseq { 
    has CvQualifier @.cv-qualifiers;
}

our role ICvQualifier { }

# rule cv-qualifier:sym<const> { <const> }
our class CvQualifier::Const does ICvQualifier {
    has Const $.const is required;
}

# rule cv-qualifier:sym<volatile> { <volatile> } #-----------------------------
our class CvQualifier::Volatile does ICvQualifier { }

our role IRefqualifier { }

# rule refqualifier:sym<and> { <and_> }
our class Refqualifier::And does IRefqualifier {
    has And $.and_ is required;
}

# rule refqualifier:sym<and-and> { <and-and> } #-----------------------------
our class Refqualifier::AndAnd does IRefqualifier { }

# rule declaratorid { <ellipsis>? <id-expression> }
our class Declaratorid { 
    has Bool         $.has-ellipsis  is required;
    has IdExpression $.id-expression is required;
}

# rule the-type-id { <type-specifier-seq> <abstract-declarator>? } #-----------------------------
our class TheTypeId { 
    has TypeSpecifierSeq   $.type-specifier-seq is required;
    has AbstractDeclarator $.abstract-declarator;
}

our role IAbstractDeclarator { }

# rule abstract-declarator:sym<base> { <pointer-abstract-declarator> }
our class AbstractDeclarator::Base does IAbstractDeclarator {
    has PointerAbstractDeclarator $.pointer-abstract-declarator is required;
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

our role IPointerAbstractDeclarator { }

# rule pointer-abstract-declarator:sym<no-ptr> { <no-pointer-abstract-declarator> }
our class PointerAbstractDeclarator::NoPtr does IPointerAbstractDeclarator {
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator is required;
}

# rule pointer-abstract-declarator:sym<ptr> { 
#   <pointer-operator>+ 
#   <no-pointer-abstract-declarator>? 
# } #-----------------------------
our class PointerAbstractDeclarator::Ptr does IPointerAbstractDeclarator {
    has PointerOperator @.pointer-operators is required;
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator;
}

our role INoPointerAbstractDeclaratorBody { }

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
    has NoPointerAbstractDeclaratorBase $.no-pointer-abstract-declarator-base is required;
    has NoPointerAbstractDeclaratorBody @.no-pointer-abstract-declarator-body is required;
}

our role INoPointerAbstractDeclaratorBase { }

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
    has PointerAbstractDeclarator $.pointer-abstract-declarator is required;
}

# rule no-pointer-abstract-declarator-bracketed-base { 
# <.left-bracket> 
# <constant-expression>? 
# <.right-bracket> 
# <attribute-specifier-seq>? }
our class NoPointerAbstractDeclaratorBracketedBase { 
    has ConstantExpression    $.constant-expression;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

# rule abstract-pack-declarator { 
#   <pointer-operator>* 
#   <no-pointer-abstract-pack-declarator> 
# } #-----------------------------
our class AbstractPackDeclarator { 
    has PointerOperator                 @.pointer-operators is required;
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
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

our role INoPointerAbstractPackDeclaratorBody { }

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
    has NoPointerAbstractPackDeclaratorBody @.no-pointer-abstract-pack-declarator-bodies is required;
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

our role IParameterDeclarationBody { }

# rule parameter-declaration-body:sym<decl> { <declarator> }
our class ParameterDeclarationBody::Decl does IParameterDeclarationBody {
    has Declarator $.declarator is required;
}

# rule parameter-declaration-body:sym<abst> { <abstract-declarator>? }
our class ParameterDeclarationBody::Abst does IParameterDeclarationBody {
    has AbstractDeclarator $.abstract-declarator;
}

# rule parameter-declaration { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq> 
#   <parameter-declaration-body> 
#   [ <assign> <initializer-clause> ]? 
# }
our class ParameterDeclaration { 
    has AttributeSpecifierSeq    $.attribute-specifier-seq;
    has DeclSpecifierSeq         $.decl-specifier-seq is required;
    has ParameterDeclarationBody $.parameter-declaration-body is required;
    has InitializerClause        $.initializer-clause;
}

# rule function-definition { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq>? 
#   <declarator> 
#   <virtual-specifier-seq>? 
#   <function-body> 
# } #-----------------------------
our class FunctionDefinition { 
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has DeclSpecifierSeq      $.decl-specifier-seq;
    has Declarator            $.declarator is required;
    has VirtualSpecifierSeq   $.virtual-specifier-seq;
    has FunctionBody          $.function-body is required;
}

our role IFunctionBody { }

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
    has Assign $.assign is required;
    has Default $.default_ is required;
    has Semi $.semi is required;
}

# rule function-body:sym<assign-delete> { <assign> <delete> <semi> }
our class FunctionBody::AssignDelete does IFunctionBody { }

our role IInitializer { }

# rule initializer:sym<brace-or-eq> { <brace-or-equal-initializer> }
our class Initializer::BraceOrEq does IInitializer {
    has BraceOrEqualInitializer $.brace-or-equal-initializer is required;
}

# rule initializer:sym<paren-expr-list> { 
#   <.left-paren> 
#   <expression-list> 
#   <.right-paren> 
# } #-----------------------------
our class Initializer::ParenExprList does IInitializer {
    has ExpressionList $.expression-list is required;
}

our role IBraceOrEqualInitializer { }

# rule brace-or-equal-initializer:sym<assign-init> { <assign> <initializer-clause> }
our class BraceOrEqualInitializer::AssignInit does IBraceOrEqualInitializer {
    has Assign            $.assign is required;
    has InitializerClause $.initializer-clause is required;
}

# rule brace-or-equal-initializer:sym<braced-init-list> { <braced-init-list> }
our class BraceOrEqualInitializer::BracedInitList does IBraceOrEqualInitializer {
    has BracedInitList $.braced-init-list is required;
}

our role IInitializerClause { }

# rule initializer-clause:sym<assignment> { <comment>? <assignment-expression> }
our class InitializerClause::Assignment does IInitializerClause {
    has Comment $.comment;
    has AssignmentExpression $.assignment-expression is required;
}

# rule initializer-clause:sym<braced> { <comment>? <braced-init-list> } #-----------------------------
our class InitializerClause::Braced does IInitializerClause {
    has Comment        $.comment;
    has BracedInitList $.braced-init-list is required;
}

# rule initializer-list { 
#   <initializer-clause> 
#   <ellipsis>? 
#   [ <.comma> <initializer-clause> <ellipsis>? ]* 
# }
our class InitializerList { 
    has InitializerClause $.initializer-clause is required;
    has Bool              $.has-ellipsis is required;
    has InitializerClause @.tail-initializer-clauses
    has Bool              @.tail-has-ellipsis;
}

# rule braced-init-list { 
#   <.left-brace> 
#   [ <initializer-list> <.comma>? ]? 
#   <.right-brace> 
# } #-----------------------------
our class BracedInitList { 
    has InitializerList $.initializer-list;
}

our role IClassName { }

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

our role IClassHead { }

# rule class-head:sym<class> { 
# <.class-key> 
# <attribute-specifier-seq>? 
# [ <class-head-name> <class-virt-specifier>? ]? 
# <base-clause>? }
our class ClassHead::Class does IClassHead {
    has AttributeSpecifierSeq $.attribute-specifier-seq;
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
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has ClassHeadName         $.class-head-name;
    has ClassVirtSpecifier    $.class-virt-specifier;
}

# rule class-head-name { <nested-name-specifier>? <class-name> }
our class ClassHeadName { 
    has NestedNameSpecifier $.nested-name-specifier;
    has ClassName           $.class-name is required;
}

# rule class-virt-specifier { <final> } #-----------------------------
our class ClassVirtSpecifier { }

our role IClassKey { }

# rule class-key:sym<class> { <.class_> }
our class ClassKey::Class does IClassKey { }

# rule class-key:sym<struct> { <.struct> } #-----------------------------
our class ClassKey::Struct does IClassKey { }

our role IMemberSpecificationBase { }

# rule member-specification-base:sym<decl> { <memberdeclaration> }
our class MemberSpecificationBase::Decl does IMemberSpecificationBase {
    has Memberdeclaration $.memberdeclaration is required;
}

# rule member-specification-base:sym<access> { <access-specifier> <colon> }
our class MemberSpecificationBase::Access does IMemberSpecificationBase {
    has AccessSpecifier $.access-specifier is required;
    has Colon $.colon is required;
}

# rule member-specification { <member-specification-base>+ }
our class MemberSpecification { 
    has MemberSpecificationBase @.member-specification-bases is required;
}

our role IMemberdeclaration { }

# rule memberdeclaration:sym<basic> { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq>? 
#   <member-declarator-list>? 
#   <semi> 
# }
our class Memberdeclaration::Basic does IMemberdeclaration {
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has DeclSpecifierSeq      $.decl-specifier-seq;
    has MemberDeclaratorList  $.member-declarator-list;
    has Semi                  $.semi is required;
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
    has MemberDeclarator @.member-declarators is required;
}

our role IMemberDeclarator { }

# rule member-declarator:sym<virt> { <declarator> <virtual-specifier-seq>? <pure-specifier>? }
our class MemberDeclarator::Virt does IMemberDeclarator {
    has Declarator          $.declarator is required;
    has VirtualSpecifierSeq $.virtual-specifier-seq;
    has PureSpecifier       $.pure-specifier;
}

# rule member-declarator:sym<brace-or-eq> { 
#   <declarator> 
#   <brace-or-equal-initializer>? 
# }
our class MemberDeclarator::BraceOrEq does IMemberDeclarator {
    has Declarator              $.declarator is required;
    has BraceOrEqualInitializer $.brace-or-equal-initializer;
}

# rule member-declarator:sym<ident> { 
#   <identifier>? 
#   <attribute-specifier-seq>? 
#   <colon> 
#   <constant-expression> } #-----------------------------
our class MemberDeclarator::Ident does IMemberDeclarator {
    has Identifier            $.identifier;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has ConstantExpression    $.constant-expression is required;
}

# rule virtual-specifier-seq { <virtual-specifier>+ } #-----------------------------
our class VirtualSpecifierSeq { 
    has VirtualSpecifier @.virtual-specifiers is required;
}

our role IVirtualSpecifier { }

# rule virtual-specifier:sym<override> { <override> }
our class VirtualSpecifier::Override does IVirtualSpecifier {
    has Override $.override is required;
}

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
    has BaseSpecifier @.base-specifiers is required;
}

our role IBaseSpecifier { }

# rule base-specifier:sym<base-type> { <attribute-specifier-seq>? <base-type-specifier> }
our class BaseSpecifier::BaseType does IBaseSpecifier {
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has BaseTypeSpecifier $.base-type-specifier is required;
}

# rule base-specifier:sym<virtual> { <attribute-specifier-seq>? <virtual> <access-specifier>? <base-type-specifier> }
our class BaseSpecifier::Virtual does IBaseSpecifier {
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has Virtual $.virtual is required;
    has AccessSpecifier $.access-specifier;
    has BaseTypeSpecifier $.base-type-specifier is required;
}

# rule base-specifier:sym<access> { 
#   <attribute-specifier-seq>? 
#   <access-specifier> 
#   <virtual>? 
#   <base-type-specifier> 
# }
our class BaseSpecifier::Access does IBaseSpecifier {
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has AccessSpecifier       $.access-specifier    is required;
    has Bool                  $.is-virtual          is required;
    has BaseTypeSpecifier     $.base-type-specifier is required;
}

our role IClassOrDeclType { }

# rule class-or-decl-type:sym<class> { <nested-name-specifier>? <class-name> }
our class ClassOrDeclType::Class does IClassOrDeclType {
    has NestedNameSpecifier $.nested-name-specifier;
    has ClassName           $.class-name is required;
}

# rule class-or-decl-type:sym<decltype> { <decltype-specifier> } #-----------------------------
our class ClassOrDeclType::Decltype does IClassOrDeclType {
    has DecltypeSpecifier $.decltype-specifier is required;
}

# rule base-type-specifier { <class-or-decl-type> }
our class BaseTypeSpecifier { 
    has ClassOrDeclType $.class-or-decl-type is required;
}

our role IAccessSpecifier { }

# rule access-specifier:sym<private> { <private> }
our class AccessSpecifier::Private does IAccessSpecifier {
    has Private $.private is required;
}

# rule access-specifier:sym<protected> { <protected> }
our class AccessSpecifier::Protected does IAccessSpecifier {
    has Protected $.protected is required;
}

# rule access-specifier:sym<public> { <public> }
our class AccessSpecifier::Public does IAccessSpecifier {
    has Public $.public is required;
}

# rule conversion-function-id { <operator> <conversion-type-id> }
our class ConversionFunctionId { 
    has Operator         $.operator           is required;
    has ConversionTypeId $.conversion-type-id is required;
}

# rule conversion-type-id { <type-specifier-seq> <conversion-declarator>? }
our class ConversionTypeId { 
    has TypeSpecifierSeq     $.type-specifier-seq is required;
    has ConversionDeclarator $.conversion-declarator;
}

# rule conversion-declarator { <pointer-operator> <conversion-declarator>? }
our class ConversionDeclarator { 
    has PointerOperator      $.pointer-operator is required;
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
    has MemInitializer @.mem-initializers is required;
}

our role IMemInitializer { }

# rule mem-initializer:sym<expr-list> { 
#   <meminitializerid> 
#   <.left-paren> 
#   <expression-list>? 
#   <.right-paren> 
# }
our class MemInitializer::ExprList does IMemInitializer {
    has Meminitializerid $.meminitializerid is required;
    has ExpressionList   $.expression-list;
}

# rule mem-initializer:sym<braced> { 
#   <meminitializerid> 
#   <braced-init-list> 
# } #-----------------------------
our class MemInitializer::Braced does IMemInitializer {
    has Meminitializerid $.meminitializerid is required;
    has BracedInitList   $.braced-init-list   is required;
}

our role IMeminitializerid { }

# rule meminitializerid:sym<class-or-decl> { <class-or-decl-type> }
our class Meminitializerid::ClassOrDecl does IMeminitializerid {
    has ClassOrDeclType $.class-or-decl-type is required;
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
    has Operator    $.operator     is required;
    has TheOperator $.the-operator is required;
}

our role ILiteralOperatorId { }

# rule literal-operator-id:sym<string-lit> { <operator> <string-literal> <identifier> }
our class LiteralOperatorId::StringLit does ILiteralOperatorId {
    has Operator      $.operator       is required;
    has StringLiteral $.string-literal is required;
    has Identifier    $.identifier     is required;
}

# rule literal-operator-id:sym<user-defined> { 
#   <operator> 
#   <user-defined-string-literal> 
# } #-----------------------------
our class LiteralOperatorId::UserDefined does ILiteralOperatorId {
    has Operator                 $.operator                    is required;
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
    has Template              $.template               is required;
    has TemplateparameterList $.templateparameter-list is required;
    has Declaration           $.declaration            is required;
}

# rule templateparameter-list { 
#   <template-parameter> 
#   [ <.comma> <template-parameter> ]* 
# }
our class TemplateparameterList { 
    has TemplateParameter @.template-parameters is required;
}

our role ITemplateParameter { }

# rule template-parameter:sym<type> { <type-parameter> }
our class TemplateParameter::Type does ITemplateParameter {
    has TypeParameter $.type-parameter is required;
}

# rule template-parameter:sym<param> { <parameter-declaration> } #-----------------------------
our class TemplateParameter::Param does ITemplateParameter {
    has ParameterDeclaration $.parameter-declaration is required;
}

our role ITypeParameterBase { }

# rule type-parameter-base:sym<basic> { 
# [ <template> <less> <templateparameter-list> <greater> ]? 
# <class_> 
# }
our class TypeParameterBase::Basic does ITypeParameterBase {
    has TemplateParameterList $.templateparameter-list;
}

# rule type-parameter-base:sym<typename> { <typename_> } #-----------------------------
our class TypeParameterBase::Typename does ITypeParameterBase {
    has Typename $.typename is required;
}

our role ITypeParameterSuffix { }

# rule type-parameter-suffix:sym<maybe-ident> { <ellipsis>? <identifier>? }
our class TypeParameterSuffix::MaybeIdent does ITypeParameterSuffix {
    has Ellipsis $.ellipsis;
    has Identifier $.identifier;
}

# rule type-parameter-suffix:sym<assign-type-id> { <identifier>? <assign> <the-type-id> } #-----------------------------
our class TypeParameterSuffix::AssignTypeId does ITypeParameterSuffix {
    has Identifier $.identifier;
    has TheTypeId  $.the-type-id is required;
}

# rule type-parameter { <type-parameter-base> <type-parameter-suffix> }
our class TypeParameter { 
    has TypeParameterBase   $.type-parameter-base   is required;
    has TypeParameterSuffix $.type-parameter-suffix is required;
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

our role ITemplateId { }

# rule template-id:sym<simple> { <simple-template-id> }
our class TemplateId::Simple does ITemplateId {
    has SimpleTemplateId $.simple-template-id is required;
}

# rule template-id:sym<operator-function-id> { <operator-function-id> <less> <template-argument-list>? <greater> }
our class TemplateId::OperatorFunctionId does ITemplateId {
    has OperatorFunctionId $.operator-function-id is required;
    has Less $.less is required;
    has TemplateArgumentList $.template-argument-list;
    has Greater $.greater is required;
}

# rule template-id:sym<literal-operator-id> { 
# <literal-operator-id> 
# <less> 
# <template-argument-list>? 
# <greater> } #-----------------------------
our class TemplateId::LiteralOperatorId does ITemplateId {
    has LiteralOperatorId    $.literal-operator-id is required;
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
    has TemplateArgument @.template-arguments is required;
}

our role ITemplateArgument { }

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
    has IdExpression $.id-expression is required;
}

our role ITypeNameSpecifier { }

# rule type-name-specifier:sym<ident> { <typename_> <nested-name-specifier> <identifier> }
our class TypeNameSpecifier::Ident does ITypeNameSpecifier {
    has Typename $.typename_ is required;
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
    has Declaration $.declaration is required; 
}

# rule explicit-specialization { <template> <less> <greater> <declaration> }
our class ExplicitSpecialization { 
    has Declaration $.declaration is required;
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
    has ExceptionDeclaration $.exception-declaration is required;
    has CompoundStatement    $.compound-statement is required;
}

our role ISomeDeclarator { }

# rule some-declarator:sym<basic> { <declarator> }
our class SomeDeclarator::Basic does ISomeDeclarator {
    has Declarator $.declarator is required;
}

# rule some-declarator:sym<abstract> { <abstract-declarator> } #---------------------
our class SomeDeclarator::Abstract does ISomeDeclarator {
    has AbstractDeclarator $.abstract-declarator is required;
}

our role IExceptionDeclaration { }

# rule exception-declaration:sym<basic> { <attribute-specifier-seq>? <type-specifier-seq> <some-declarator>? }
our class ExceptionDeclaration::Basic does IExceptionDeclaration {
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has TypeSpecifierSeq $.type-specifier-seq is required;
    has SomeDeclarator $.some-declarator;
}

# rule exception-declaration:sym<ellipsis> { <ellipsis> }
our class ExceptionDeclaration::Ellipsis does IExceptionDeclaration {
    has Ellipsis $.ellipsis is required;
}

# rule throw-expression { <throw> <assignment-expression>? } #---------------------
our class ThrowExpression { 
    has AssignmentExpression $.assignment-expression;
}

our role IExceptionSpecification { }

# token exception-specification:sym<dynamic> { <dynamic-exception-specification> }
our class ExceptionSpecification::Dynamic does IExceptionSpecification {
    has DynamicExceptionSpecification $.dynamic-exception-specification is required;
}

# token exception-specification:sym<noexcept> { <noe-except-specification> } #---------------------
our class ExceptionSpecification::Noexcept does IExceptionSpecification {
    has NoeExceptSpecification $.noe-except-specification is required;
}

# rule dynamic-exception-specification { <throw> <.left-paren> <type-id-list>? <.right-paren> }
our class DynamicExceptionSpecification { 
    has TypeIdList $.type-id-list;
}

# rule type-id-list { <the-type-id> <ellipsis>? [ <.comma> <the-type-id> <ellipsis>? ]* } #---------------------
our class TypeIdList { 
    has TheTypeId @.the-type-ids is required;
}

our role INoeExceptSpecification { }

# token noe-except-specification:sym<full> { <noexcept> <.left-paren> <constant-expression> <.right-paren> }
our class NoeExceptSpecification::Full does INoeExceptSpecification {
    has Noexcept $.noexcept is required;
    has ConstantExpression $.constant-expression is required;
}

# token noe-except-specification:sym<keyword-only> { <noexcept> } #---------------------
our class NoeExceptSpecification::KeywordOnly does INoeExceptSpecification { }

our role ITheOperator { }

# token the-operator:sym<new> { <new_> [ <.left-bracket> <.right-bracket>]? }
our class TheOperator::New does ITheOperator { }

# token the-operator:sym<delete> { <delete> [ <.left-bracket> <.right-bracket>]? }
our class TheOperator::Delete does ITheOperator { }

# token the-operator:sym<plus> { <plus> }
our class TheOperator::Plus does ITheOperator {
    has Plus $.plus is required;
}

# token the-operator:sym<minus> { <minus> }
our class TheOperator::Minus does ITheOperator {
    has Minus $.minus is required;
}

# token the-operator:sym<star> { <star> }
our class TheOperator::Star does ITheOperator {
    has Star $.star is required;
}

# token the-operator:sym<div_> { <div_> }
our class TheOperator::Div does ITheOperator {
    has Div $.div_ is required;
}

# token the-operator:sym<mod_> { <mod_> }
our class TheOperator::Mod does ITheOperator {
    has Mod $.mod_ is required;
}

# token the-operator:sym<caret> { <caret> }
our class TheOperator::Caret does ITheOperator {
    has Caret $.caret is required;
}

# token the-operator:sym<and_> { <and_> <!before <and_>> }
our class TheOperator::And does ITheOperator { }

# token the-operator:sym<or_> { <or_> }
our class TheOperator::Or does ITheOperator {
    has Or $.or_ is required;
}

# token the-operator:sym<tilde> { <tilde> }
our class TheOperator::Tilde does ITheOperator {
    has Tilde $.tilde is required;
}

# token the-operator:sym<not> { <not_> }
our class TheOperator::Not does ITheOperator {
    has Not $.not_ is required;
}

# token the-operator:sym<assign> { <assign> }
our class TheOperator::Assign does ITheOperator {
    has Assign $.assign is required;
}

# token the-operator:sym<greater> { <greater> }
our class TheOperator::Greater does ITheOperator {
    has Greater $.greater is required;
}

# token the-operator:sym<less> { <less> }
our class TheOperator::Less does ITheOperator {
    has Less $.less is required;
}

# token the-operator:sym<greater-equal> { <greater-equal> }
our class TheOperator::GreaterEqual does ITheOperator {
    has GreaterEqual $.greater-equal is required;
}

# token the-operator:sym<plus-assign> { <plus-assign> }
our class TheOperator::PlusAssign does ITheOperator {
    has PlusAssign $.plus-assign is required;
}

# token the-operator:sym<minus-assign> { <minus-assign> }
our class TheOperator::MinusAssign does ITheOperator {
    has MinusAssign $.minus-assign is required;
}

# token the-operator:sym<star-assign> { <star-assign> }
our class TheOperator::StarAssign does ITheOperator {
    has StarAssign $.star-assign is required;
}

# token the-operator:sym<mod-assign> { <mod-assign> }
our class TheOperator::ModAssign does ITheOperator {
    has ModAssign $.mod-assign is required;
}

# token the-operator:sym<xor-assign> { <xor-assign> }
our class TheOperator::XorAssign does ITheOperator {
    has XorAssign $.xor-assign is required;
}

# token the-operator:sym<and-assign> { <and-assign> }
our class TheOperator::AndAssign does ITheOperator {
    has AndAssign $.and-assign is required;
}

# token the-operator:sym<or-assign> { <or-assign> }
our class TheOperator::OrAssign does ITheOperator {
    has OrAssign $.or-assign is required;
}

# token the-operator:sym<LessLess> { <less> <less> }
our class TheOperator::LessLess does ITheOperator {
    has Less $.less is required;
    has Less $.less is required;
}

# token the-operator:sym<GreaterGreater> { <greater> <greater> }
our class TheOperator::GreaterGreater does ITheOperator {
    has Greater $.greater is required;
    has Greater $.greater is required;
}

# token the-operator:sym<right-shift-assign> { <right-shift-assign> }
our class TheOperator::RightShiftAssign does ITheOperator {
    has RightShiftAssign $.right-shift-assign is required;
}

# token the-operator:sym<left-shift-assign> { <left-shift-assign> }
our class TheOperator::LeftShiftAssign does ITheOperator {
    has LeftShiftAssign $.left-shift-assign is required;
}

# token the-operator:sym<equal> { <equal> }
our class TheOperator::Equal does ITheOperator {
    has Equal $.equal is required;
}

# token the-operator:sym<not-equal> { <not-equal> }
our class TheOperator::NotEqual does ITheOperator {
    has NotEqual $.not-equal is required;
}

# token the-operator:sym<less-equal> { <less-equal> }
our class TheOperator::LessEqual does ITheOperator {
    has LessEqual $.less-equal is required;
}

# token the-operator:sym<and-and> { <and-and> }
our class TheOperator::AndAnd does ITheOperator {
    has AndAnd $.and-and is required;
}

# token the-operator:sym<or-or> { <or-or> }
our class TheOperator::OrOr does ITheOperator {
    has OrOr $.or-or is required;
}

# token the-operator:sym<plus-plus> { <plus-plus> }
our class TheOperator::PlusPlus does ITheOperator {
    has PlusPlus $.plus-plus is required;
}

# token the-operator:sym<minus-minus> { <minus-minus> }
our class TheOperator::MinusMinus does ITheOperator {
    has MinusMinus $.minus-minus is required;
}

# token the-operator:sym<comma> { <.comma> }
our class TheOperator::Comma does ITheOperator {

}

# token the-operator:sym<arrow-star> { <arrow-star> }
our class TheOperator::ArrowStar does ITheOperator {
    has ArrowStar $.arrow-star is required;
}

# token the-operator:sym<arrow> { <arrow> }
our class TheOperator::Arrow does ITheOperator {
    has Arrow $.arrow is required;
}

# token the-operator:sym<Parens> { <.left-paren> <.right-paren> }
our class TheOperator::Parens does ITheOperator {

}

# token the-operator:sym<Brak> { <.left-bracket> <.right-bracket> }
our class TheOperator::Brak does ITheOperator {

}

our role ILiteral { }

# token literal:sym<int> { <integer-literal> }
our class Literal::Int does ILiteral {
    has IntegerLiteral $.integer-literal is required;
}

# token literal:sym<char> { <character-literal> }
our class Literal::Char does ILiteral {
    has CharacterLiteral $.character-literal is required;
}

# token literal:sym<float> { <floating-literal> } #Note: are we allowed to have many strings in a row?
our class Literal::Float does ILiteral {
    has FloatingLiteral $.floating-literal is required;
}

# token literal:sym<str> { <string-literal> }
our class Literal::Str does ILiteral {
    has StringLiteral $.string-literal is required;
}

# token literal:sym<bool> { <boolean-literal> }
our class Literal::Bool does ILiteral {
    has BooleanLiteral $.boolean-literal is required;
}

# token literal:sym<ptr> { <pointer-literal> }
our class Literal::Ptr does ILiteral {
    has PointerLiteral $.pointer-literal is required;
}

# token literal:sym<user-defined> { <user-defined-literal> }
our class Literal::UserDefined does ILiteral {
    has UserDefinedLiteral $.user-defined-literal is required;
}


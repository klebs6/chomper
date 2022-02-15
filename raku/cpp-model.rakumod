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
our class PostfixExpressionTail::PpMm does IPostfixExpressionTail {
    #TODO
}

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

# rule postfix-expression-cast { <cast-token> <less> <the-type-id> <greater> <.left-paren> <expression> <.right-paren> }
our class PostfixExpressionCast { 
    #TODO
}

# rule postfix-expression-typeid { <type-id-of-the-type-id> <.left-paren> [ <expression> || <the-type-id>] <.right-paren> } 
our class PostfixExpressionTypeid { 
    #TODO
}

our role IPostListHead { }

# token post-list-head:sym<simple> { <simple-type-specifier> }
our class PostListHead::Simple does IPostListHead {
    has SimpleTypeSpecifier $.simple-type-specifier is required;
}

# token post-list-head:sym<type-name> { <type-name-specifier> } 
our class PostListHead::TypeName does IPostListHead {
    #TODO
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


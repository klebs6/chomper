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
    #TODO: token fractionalconstant:sym<with-tail> { <digitsequence>?  '.' <digitsequence> }
}

our class Fractionalconstant::NoTail does IFractionalconstant {
    #TODO: token fractionalconstant:sym<no-tail>   { <digitsequence> '.' }
}

our class ExponentpartPrefix { 
    #TODO: token exponentpart-prefix {         'e' || 'E'     }
}

our class Exponentpart { 
    #TODO: token exponentpart {         <exponentpart-prefix> <sign>?  <digitsequence>     }
}

our class Sign { 
    #TODO: token sign {         <[ + - ]>     }
}

our class Digitsequence { 
    #TODO: token digitsequence {         <digit> [  '\''?  <digit>]*     }
}

our class Floatingsuffix { 
    #TODO: token floatingsuffix {         <[ f l F L ]>     }      #------------------
}

our role IEncodingprefix { }

our class Encodingprefix::U8 does IEncodingprefix {
    #TODO: token encodingprefix:sym<u8> { 'u8' }
}

our class Encodingprefix::U does IEncodingprefix {
    #TODO: token encodingprefix:sym<u>  { 'u' }
}

our class Encodingprefix::U does IEncodingprefix {
    #TODO: token encodingprefix:sym<U>  { 'U' }
}

our class Encodingprefix::L does IEncodingprefix {
    #TODO: token encodingprefix:sym<L>  { 'L' }      #------------------
}

our role ISchar { }

our class Schar::Basic does ISchar {
    #TODO: token schar:sym<basic>  { <-[ " \\ \r \n ]> }
}

our class Schar::Escape does ISchar {
    has Escapesequence $.escapesequence is required;
}

our class Schar::Ucn does ISchar {
    has Universalcharactername $.universalcharactername is required;
}

our class Rawstring { 
    #TODO: token rawstring {         ||  'R"'             [   ||  [   ||  '\\'                             <[ " ( ) ]>                     ]                 ||  <-[ \r \n   ( ]>             ]             '('             <-[ ) ]>*?             ')'             [   ||  [   ||  '\\'                             <[ " ( ) ]>                     ]                 ||  <-[ \r \n   " ]>             ]             '"'     }
}

our role IUserDefinedIntegerLiteral { }

our class UserDefinedIntegerLiteral::Dec does IUserDefinedIntegerLiteral {
    has DecimalLiteral $.decimal-literal is required;
    has Udsuffix $.udsuffix is required;
}

our class UserDefinedIntegerLiteral::Oct does IUserDefinedIntegerLiteral {
    has OctalLiteral $.octal-literal is required;
    has Udsuffix $.udsuffix is required;
}

our class UserDefinedIntegerLiteral::Hex does IUserDefinedIntegerLiteral {
    has HexadecimalLiteral $.hexadecimal-literal is required;
    has Udsuffix $.udsuffix is required;
}

our class UserDefinedIntegerLiteral::Bin does IUserDefinedIntegerLiteral {
    #TODO: token user-defined-integer-literal:sym<bin> { <binary-literal> <udsuffix> }      #-------------------
}

our role IUserDefinedFloatingLiteral { }

our class UserDefinedFloatingLiteral::Frac does IUserDefinedFloatingLiteral {
    has Fractionalconstant $.fractionalconstant is required;
    has Exponentpart $.exponentpart;
    has Udsuffix $.udsuffix is required;
}

our class UserDefinedFloatingLiteral::Digi does IUserDefinedFloatingLiteral {
    #TODO: token user-defined-floating-literal:sym<digi> { <digitsequence> <exponentpart> <udsuffix> }      #-------------------
}

our class UserDefinedStringLiteral { 
    #TODO: token user-defined-string-literal    { <string-literal> <udsuffix> }
}

our class UserDefinedCharacterLiteral { 
    #TODO: token user-defined-character-literal { <character-literal> <udsuffix> }
}

our class Udsuffix { 
    #TODO: token udsuffix {         <identifier>     }
}

our class Whitespace { 
    #TODO: token whitespace {         <[   \t ]>+     }
}

our class Newline { 
    #TODO: token newline_ {         [                ||  '\r' '\n'?             ||  '\n'         ]     }
}

our class BlockComment { 
    #TODO: token block-comment {         '/*' .*?  '*/'     }
}

our class LineComment { 
    #TODO: token line-comment {         '//' <-[ \r \n ]>*     }
}

our class TOP { 
    #TODO: rule TOP {         <.ws>          <statement-seq>         #<unary-expression>     }
}

our class TranslationUnit { 
    #TODO: token translation-unit {         <declarationseq>?  $     }
}

our role IPrimaryExpression { }

our class PrimaryExpression::Literal does IPrimaryExpression {
    has Literal @.literal is required;
}

our class PrimaryExpression::This does IPrimaryExpression {
    has This $.this is required;
}

our class PrimaryExpression::Expr does IPrimaryExpression {
    has Expression $.expression is required;
}

our class PrimaryExpression::Id does IPrimaryExpression {
    has IdExpression $.id-expression is required;
}

our class PrimaryExpression::Lambda does IPrimaryExpression {
    #TODO: token primary-expression:sym<lambda>  { <lambda-expression> }      #-------------------------------
}

our role IIdExpression { }

our class IdExpression::Qualified does IIdExpression {
    has QualifiedId $.qualified-id is required;
}

our class IdExpression::Unqualified does IIdExpression {
    #TODO: regex id-expression:sym<unqualified> { <unqualified-id> }      #-------------------------------
}

our role IUnqualifiedId { }

our class UnqualifiedId::Ident does IUnqualifiedId {
    has Identifier $.identifier is required;
}

our class UnqualifiedId::OpFuncId does IUnqualifiedId {
    has OperatorFunctionId $.operator-function-id is required;
}

our class UnqualifiedId::ConversionFuncId does IUnqualifiedId {
    has ConversionFunctionId $.conversion-function-id is required;
}

our class UnqualifiedId::LiteralOperatorId does IUnqualifiedId {
    has LiteralOperatorId $.literal-operator-id is required;
}

our class UnqualifiedId::Tilde does IUnqualifiedId {
    #TODO: regex unqualified-id:sym<tilde>               { <tilde> [   <class-name> ||  <decltype-specifier> ] }
}

our class UnqualifiedId::TemplateId does IUnqualifiedId {
    #TODO: regex unqualified-id:sym<template-id>         { <template-id> }      #-------------------------------
}

our class QualifiedId { 
    #TODO: regex qualified-id {         <nested-name-specifier>          <template>?           <unqualified-id>     }      #-------------------------------
}

our role INestedNameSpecifierPrefix { }

our class NestedNameSpecifierPrefix::Null does INestedNameSpecifierPrefix {
    has Doublecolon $.doublecolon is required;
}

our class NestedNameSpecifierPrefix::Type does INestedNameSpecifierPrefix {
    has TheTypeName $.the-type-name is required;
    has Doublecolon $.doublecolon is required;
}

our class NestedNameSpecifierPrefix::Ns does INestedNameSpecifierPrefix {
    has NamespaceName $.namespace-name is required;
    has Doublecolon $.doublecolon is required;
}

our class NestedNameSpecifierPrefix::Decl does INestedNameSpecifierPrefix {
    #TODO: regex nested-name-specifier-prefix:sym<decl> {         <decltype-specifier>         <doublecolon>     }      #-------------------------------
}

our role INestedNameSpecifierSuffix { }

our class NestedNameSpecifierSuffix::Id does INestedNameSpecifierSuffix {
    has Identifier $.identifier is required;
    has Doublecolon $.doublecolon is required;
}

our class NestedNameSpecifierSuffix::Template does INestedNameSpecifierSuffix {
    #TODO: regex nested-name-specifier-suffix:sym<template> {         <template>?          <simple-template-id>         <doublecolon>     }      #-------------------------------
}

our class NestedNameSpecifier { 
    #TODO: regex nested-name-specifier {         <nested-name-specifier-prefix>          <nested-name-specifier-suffix>*     }
}

our class LambdaExpression { 
    #TODO: rule lambda-expression {         <lambda-introducer> <lambda-declarator>?  <compound-statement>     }
}

our class LambdaIntroducer { 
    #TODO: rule lambda-introducer {         <.left-bracket> <lambda-capture>?  <.right-bracket>     }      #-------------------------------
}

our role ILambdaCapture { }

our class LambdaCapture::List does ILambdaCapture {
    has CaptureList $.capture-list is required;
}

our class LambdaCapture::Def does ILambdaCapture {
    #TODO: rule lambda-capture:sym<def>  { <capture-default> [ <comma> <capture-list> ]? }      #-------------------------------
}

our role ICaptureDefault { }

our class CaptureDefault::And does ICaptureDefault {
    has And $.and_ is required;
}

our class CaptureDefault::Assign does ICaptureDefault {
    #TODO: rule capture-default:sym<assign> { <assign> }      #-------------------------------
}

our class CaptureList { 
    #TODO: rule capture-list {         <capture> [ <comma> <capture> ]* <ellipsis>?     }      #-------------------------------
}

our role ICapture { }

our class Capture::Simple does ICapture {
    has SimpleCapture $.simple-capture is required;
}

our class Capture::Init does ICapture {
    #TODO: rule capture:sym<init>   { <initcapture> }      #-------------------------------
}

our role ISimpleCapture { }

our class SimpleCapture::Id does ISimpleCapture {
    has And $.and_;
    has Identifier $.identifier is required;
}

our class SimpleCapture::This does ISimpleCapture {
    #TODO: rule simple-capture:sym<this> { <this> }      #-------------------------------
}

our class Initcapture { 
    #TODO: rule initcapture {         <and_>?  <identifier> <initializer>     }      #-------------------------------
}

our class LambdaDeclarator { 
    #TODO: rule lambda-declarator {         <.left-paren>         <parameter-declaration-clause>?         <.right-paren>         <mutable>?         <exception-specification>?         <attribute-specifier-seq>?         <trailing-return-type>?     }      #-------------------------------------
}

our class PostfixExpression { 
    #TODO: rule postfix-expression {           <postfix-expression-body> <postfix-expression-tail>*     }
}

our role IPostfixExpressionTail { }

our class BracketTail { 
    #TODO: rule bracket-tail {         <.left-bracket>          [ <expression> || <braced-init-list> ]          <.right-bracket>     }
}

our class PostfixExpressionTail::Bracket does IPostfixExpressionTail {
    has BracketTail $.bracket-tail is required;
}

our class PostfixExpressionTail::Parens does IPostfixExpressionTail {
    has ExpressionList $.expression-list;
}

our class PostfixExpressionTail::IndirectionId does IPostfixExpressionTail {
    #TODO: rule postfix-expression-tail:sym<indirection-id> {          [ <dot> ||  <arrow> ]         <template>?  <id-expression>      }
}

our class PostfixExpressionTail::IndirectionPseudoDtor does IPostfixExpressionTail {
    #TODO: rule postfix-expression-tail:sym<indirection-pseudo-dtor> {          [ <dot> ||  <arrow> ]         <pseudo-destructor-name>      }
}

our class PostfixExpressionTail::PpMm does IPostfixExpressionTail {
    #TODO: rule postfix-expression-tail:sym<pp-mm> {          [ <plus-plus> ||  <minus-minus> ]     }      #-------------------------------------     #needs to stay like this for some reason..     #ie, cant be made proto without breaking some     #parses, for example:     #     # uint8_t{format}
}

our class PostfixExpressionBody { 
    #TODO: token postfix-expression-body {          || <postfix-expression-list>         || <postfix-expression-cast>         || <postfix-expression-typeid>         || <primary-expression>     }      #-------------------------------------
}

our role ICastToken { }

our class CastToken::Dyn does ICastToken {
    has Dynamic_cast $.dynamic_cast is required;
}

our class CastToken::Static does ICastToken {
    has Static_cast $.static_cast is required;
}

our class CastToken::Reinterpret does ICastToken {
    has Reinterpret_cast $.reinterpret_cast is required;
}

our class CastToken::Const does ICastToken {
    has Const_cast $.const_cast is required;
}

our class PostfixExpressionCast { 
    #TODO: rule postfix-expression-cast {         <cast-token>         <less>          <the-type-id>          <greater>          <.left-paren>          <expression>          <.right-paren>     }
}

our class PostfixExpressionTypeid { 
    #TODO: rule postfix-expression-typeid {         <type-id-of-the-type-id>          <.left-paren>          [ <expression> ||  <the-type-id>]          <.right-paren>     }      #---------------------
}

our role IPostListHead { }

our class PostListHead::Simple does IPostListHead {
    has SimpleTypeSpecifier $.simple-type-specifier is required;
}

our class PostListHead::TypeName does IPostListHead {
    #TODO: token post-list-head:sym<type-name> { <type-name-specifier> }      #---------------------
}

our role IPostListTail { }

our class PostListTail::Parenthesized does IPostListTail {
    has ExpressionList $.expression-list;
}

our class PostListTail::Braced does IPostListTail {
    has BracedInitList $.braced-init-list is required;
}

our class PostfixExpressionList { 
    #TODO: token postfix-expression-list {         <post-list-head>         <post-list-tail>     }      #-------------------------------------
}

our class TypeIdOfTheTypeId { 
    #TODO: rule type-id-of-the-type-id {         <typeid_>     }
}

our class ExpressionList { 
    #TODO: rule expression-list {         <initializer-list>     }      #-------------------------------------
}

our role IPseudoDestructorName { }

our class PseudoDestructorName::Basic does IPseudoDestructorName {
    #TODO: rule pseudo-destructor-name:sym<basic> {         <nested-name-specifier>?         [ <the-type-name> <doublecolon> ]?         <tilde>         <the-type-name>     }
}

our class PseudoDestructorName::Template does IPseudoDestructorName {
    has NestedNameSpecifier $.nested-name-specifier is required;
    has Template $.template is required;
    has SimpleTemplateId $.simple-template-id is required;
    has Doublecolon $.doublecolon is required;
    has Tilde $.tilde is required;
    has TheTypeName $.the-type-name is required;
}

our class PseudoDestructorName::Decltype does IPseudoDestructorName {
    #TODO: rule pseudo-destructor-name:sym<decltype> {         <tilde>         <decltype-specifier>     }      #-------------------------------------
}

our class UnaryExpression { 
    #TODO: rule unary-expression {          || <new-expression>         || <unary-expression-case>     }
}

our role IUnaryExpressionCase { }

our class UnaryExpressionCase::Postfix does IUnaryExpressionCase {
    has PostfixExpression $.postfix-expression is required;
}

our class UnaryExpressionCase::Pp does IUnaryExpressionCase {
    has PlusPlus $.plus-plus is required;
    has UnaryExpression $.unary-expression is required;
}

our class UnaryExpressionCase::Mm does IUnaryExpressionCase {
    has MinusMinus $.minus-minus is required;
    has UnaryExpression $.unary-expression is required;
}

our class UnaryExpressionCase::UnaryOp does IUnaryExpressionCase {
    has UnaryOperator $.unary-operator is required;
    has UnaryExpression $.unary-expression is required;
}

our class UnaryExpressionCase::Sizeof does IUnaryExpressionCase {
    has Sizeof $.sizeof is required;
    has UnaryExpression $.unary-expression is required;
}

our class UnaryExpressionCase::SizeofTypeid does IUnaryExpressionCase {
    has Sizeof $.sizeof is required;
    has TheTypeId $.the-type-id is required;
}

our class UnaryExpressionCase::SizeofIds does IUnaryExpressionCase {
    has Sizeof $.sizeof is required;
    has Ellipsis $.ellipsis is required;
    has Identifier $.identifier is required;
}

our class UnaryExpressionCase::Alignof does IUnaryExpressionCase {
    has Alignof $.alignof is required;
    has TheTypeId $.the-type-id is required;
}

our class UnaryExpressionCase::Noexcept does IUnaryExpressionCase {
    has NoExceptExpression $.no-except-expression is required;
}

our class UnaryExpressionCase::Delete does IUnaryExpressionCase {
    #TODO: rule unary-expression-case:sym<delete>   { <delete-expression> }      #--------------------------------------
}

our role IUnaryOperator { }

our class UnaryOperator::Or does IUnaryOperator {
    has Or $.or_ is required;
}

our class UnaryOperator::Star does IUnaryOperator {
    has Star $.star is required;
}

our class UnaryOperator::And does IUnaryOperator {
    has And $.and_ is required;
}

our class UnaryOperator::Plus does IUnaryOperator {
    has Plus $.plus is required;
}

our class UnaryOperator::Tilde does IUnaryOperator {
    has Tilde $.tilde is required;
}

our class UnaryOperator::Minus does IUnaryOperator {
    has Minus $.minus is required;
}

our class UnaryOperator::Not does IUnaryOperator {
    #TODO: rule unary-operator:sym<not>   { <not_>  }       #--------------------------------------
}

our class NewExpression { 
    #TODO: rule new-expression {         <doublecolon>?         <new_>         <new-placement>?         [               || <new-type-id>            || [ <.left-paren> <the-type-id> <.right-paren> ]         ]         <new-initializer>?     }
}

our class NewPlacement { 
    #TODO: rule new-placement {         <.left-paren>         <expression-list>         <.right-paren>     }
}

our class NewTypeId { 
    #TODO: rule new-type-id {         <type-specifier-seq> <new-declarator>?     }
}

our class NewDeclarator { 
    #TODO: rule new-declarator {         <pointer-operator>*          <no-pointer-new-declarator>?     }      #applied a transfomation on this rule to     #prevent infinite loops     #     #if we get any bugs downstream come back to     #this
}

our class NoPointerNewDeclarator { 
    #TODO: rule no-pointer-new-declarator {         <.left-bracket>         <expression>         <.right-bracket>         <attribute-specifier-seq>?         [             <.left-bracket>             <constant-expression>             <.right-bracket>             <attribute-specifier-seq>?         ]*     }      #------------------------
}

our role INewInitializer { }

our class NewInitializer::ExprList does INewInitializer {
    has ExpressionList $.expression-list;
}

our class NewInitializer::Braced does INewInitializer {
    #TODO: rule new-initializer:sym<braced>    { <braced-init-list> }      #------------------------
}

our class DeleteExpression { 
    #TODO: rule delete-expression {         <doublecolon>?         <delete>         [ <.left-bracket> <.right-bracket> ]?         <cast-expression>     }
}

our class NoExceptExpression { 
    #TODO: rule no-except-expression {         <noexcept>         <.left-paren>         <expression>         <.right-paren>     }
}

our class CastExpression { 
    #TODO: rule cast-expression {         [ <.left-paren> <the-type-id> <.right-paren> ]* <unary-expression>     }
}

our role IPointerMemberOperator { }

our class PointerMemberOperator::Dot does IPointerMemberOperator {
    has DotStar $.dot-star is required;
}

our class PointerMemberOperator::Arrow does IPointerMemberOperator {
    has ArrowStar $.arrow-star is required;
}

our class PointerMemberExpression { 
    #TODO: rule pointer-member-expression {         <cast-expression>         [             <pointer-member-operator>             <cast-expression>         ]*     }      #-----------------
}

our role IMultiplicativeOperator { }

our class MultiplicativeOperator::* does IMultiplicativeOperator {
    #TODO: token multiplicative-operator:sym<*> { <star> }
}

our class MultiplicativeOperator::/ does IMultiplicativeOperator {
    #TODO: token multiplicative-operator:sym</> { <div_> }
}

our class MultiplicativeOperator::% does IMultiplicativeOperator {
    #TODO: token multiplicative-operator:sym<%> { <mod_> }
}

our class MultiplicativeExpression { 
    #TODO: rule multiplicative-expression {         <pointer-member-expression>         [                <multiplicative-operator>              <pointer-member-expression>         ]*     }      #-----------------
}

our role IAdditiveOperator { }

our class AdditiveOperator::Plus does IAdditiveOperator {
    has Plus $.plus is required;
}

our class AdditiveOperator::Minus does IAdditiveOperator {
    #TODO: token additive-operator:sym<minus> {  <minus> }      #-----------------
}

our class AdditiveExpression { 
    #TODO: rule additive-expression {         <multiplicative-expression>         [                <additive-operator>              <multiplicative-expression>         ]*     }
}

our class ShiftExpression { 
    #TODO: rule shift-expression {         <additive-expression>         [ <shift-operator> <additive-expression> ]*     }      #-----------------------
}

our role IShiftOperator { }

our class ShiftOperator::Right does IShiftOperator {
    has Greater $.greater is required;
    has Greater $.greater is required;
}

our class ShiftOperator::Left does IShiftOperator {
    #TODO: rule shift-operator:sym<left>  { <less> <less> }      #-----------------------
}

our role IRelationalOperator { }

our class RelationalOperator::Less does IRelationalOperator {
    has Less $.less is required;
}

our class RelationalOperator::Greater does IRelationalOperator {
    has Greater $.greater is required;
}

our class RelationalOperator::LessEq does IRelationalOperator {
    has LessEqual $.less-equal is required;
}

our class RelationalOperator::GreaterEq does IRelationalOperator {
    #TODO: rule relational-operator:sym<greater-eq> { <greater-equal> }      #-----------------------
}

our class RelationalExpression { 
    #TODO: regex relational-expression {         <shift-expression>         [               <.ws>             <relational-operator>             <.ws>             <shift-expression>         ]*     }      #-----------------------
}

our role IEqualityOperator { }

our class EqualityOperator::Eq does IEqualityOperator {
    has Equal $.equal is required;
}

our class EqualityOperator::Neq does IEqualityOperator {
    #TODO: token equality-operator:sym<neq> { <not-equal> }      #-----------------------
}

our class EqualityExpression { 
    #TODO: rule equality-expression {         <relational-expression>         [                <equality-operator> <relational-expression>         ]*     }
}

our class AndExpression { 
    #TODO: rule and-expression {         <equality-expression> [ <and_> <equality-expression> ]*     }
}

our class ExclusiveOrExpression { 
    #TODO: rule exclusive-or-expression {         <and-expression> [  <caret> <and-expression> ]*     }
}

our class InclusiveOrExpression { 
    #TODO: rule inclusive-or-expression {         <exclusive-or-expression> [ <or_> <exclusive-or-expression> ]*     }
}

our class LogicalAndExpression { 
    #TODO: rule logical-and-expression {         <inclusive-or-expression> [  <and-and> <inclusive-or-expression>]*     }
}

our class LogicalOrExpression { 
    #TODO: rule logical-or-expression {         <logical-and-expression> [ <or-or> <logical-and-expression> ]*     }
}

our class ConditionalExpression { 
    #TODO: rule conditional-expression {         <logical-or-expression>         [              <question>              <expression>              <colon>              <assignment-expression>          ]?     }      #-----------------------
}

our role IAssignmentExpression { }

our class AssignmentExpression::Throw does IAssignmentExpression {
    has ThrowExpression $.throw-expression is required;
}

our class AssignmentExpression::Basic does IAssignmentExpression {
    has LogicalOrExpression $.logical-or-expression is required;
    has AssignmentOperator $.assignment-operator is required;
    has InitializerClause $.initializer-clause is required;
}

our class AssignmentExpression::Conditional does IAssignmentExpression {
    has ConditionalExpression $.conditional-expression is required;
}

our role IAssignmentOperator { }

our class AssignmentOperator::Assign does IAssignmentOperator {
    has Assign $.assign is required;
}

our class AssignmentOperator::StarAssign does IAssignmentOperator {
    has StarAssign $.star-assign is required;
}

our class AssignmentOperator::DivAssign does IAssignmentOperator {
    has DivAssign $.div-assign is required;
}

our class AssignmentOperator::ModAssign does IAssignmentOperator {
    has ModAssign $.mod-assign is required;
}

our class AssignmentOperator::PlusAssign does IAssignmentOperator {
    has PlusAssign $.plus-assign is required;
}

our class AssignmentOperator::MinusAssign does IAssignmentOperator {
    has MinusAssign $.minus-assign is required;
}

our class AssignmentOperator::RshiftAssign does IAssignmentOperator {
    has RightShiftAssign $.right-shift-assign is required;
}

our class AssignmentOperator::LshiftAssign does IAssignmentOperator {
    has LeftShiftAssign $.left-shift-assign is required;
}

our class AssignmentOperator::AndAssign does IAssignmentOperator {
    has AndAssign $.and-assign is required;
}

our class AssignmentOperator::XorAssign does IAssignmentOperator {
    has XorAssign $.xor-assign is required;
}

our class AssignmentOperator::OrAssign does IAssignmentOperator {
    has OrAssign $.or-assign is required;
}

our class Expression { 
    #TODO: rule expression {         <assignment-expression>+ %% <comma>     }
}

our class ConstantExpression { 
    #TODO: rule constant-expression { <conditional-expression> }
}

our role IComment { }

our class Comment::Line does IComment {
    #TODO: regex comment:sym<line> {         [<line-comment> <.ws>?]+     }
}

our class Comment::Block does IComment {
    #TODO: rule comment:sym<block> {         <block-comment>     }      #-----------------------------
}

our role IStatement { }

our class Statement::Attributed does IStatement {
    has Comment $.comment;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has AttributedStatementBody $.attributed-statement-body is required;
}

our class Statement::Labeled does IStatement {
    has Comment $.comment;
    has LabeledStatement $.labeled-statement is required;
}

our class Statement::Declaration does IStatement {
    has Comment $.comment;
    has DeclarationStatement $.declaration-statement is required;
}

our role IAttributedStatementBody { }

our class AttributedStatementBody::Expression does IAttributedStatementBody {
    has ExpressionStatement $.expression-statement is required;
}

our class AttributedStatementBody::Compound does IAttributedStatementBody {
    has CompoundStatement $.compound-statement is required;
}

our class AttributedStatementBody::Selection does IAttributedStatementBody {
    has SelectionStatement $.selection-statement is required;
}

our class AttributedStatementBody::Iteration does IAttributedStatementBody {
    has IterationStatement $.iteration-statement is required;
}

our class AttributedStatementBody::Jump does IAttributedStatementBody {
    has JumpStatement $.jump-statement is required;
}

our class AttributedStatementBody::Try does IAttributedStatementBody {
    #TODO: rule attributed-statement-body:sym<try>        { <try-block>            }      #-----------------------------
}

our role ILabeledStatementLabelBody { }

our class LabeledStatementLabelBody::Id does ILabeledStatementLabelBody {
    has Identifier $.identifier is required;
}

our class LabeledStatementLabelBody::CaseExpr does ILabeledStatementLabelBody {
    has Case $.case is required;
    has ConstantExpression $.constant-expression is required;
}

our class LabeledStatementLabelBody::Default does ILabeledStatementLabelBody {
    #TODO: rule labeled-statement-label-body:sym<default>   { <default_>                   }      #-----------------------------
}

our class LabeledStatementLabel { 
    #TODO: rule labeled-statement-label {         <attribute-specifier-seq>?         <labeled-statement-label-body>         <colon>     }
}

our class LabeledStatement { 
    #TODO: rule labeled-statement {         <labeled-statement-label>         <statement>     }
}

our class DeclarationStatement { 
    #TODO: rule declaration-statement { <block-declaration> }      #-----------------------------
}

our class ExpressionStatement { 
    #TODO: rule expression-statement {         <expression>?  <semi>     }
}

our class CompoundStatement { 
    #TODO: rule compound-statement {         <.left-brace> <statement-seq>?  <.right-brace>     }
}

our class StatementSeq { 
    #TODO: regex statement-seq {         <statement> [<.ws> <statement>]*     }      #-----------------------------
}

our role ISelectionStatement { }

our class SelectionStatement::If does ISelectionStatement {
    #TODO: rule selection-statement:sym<if> {           <if_>         <.left-paren>         <condition>         <.right-paren>         <statement>         [ <comment>? <else_> <statement> ]?     }
}

our class SelectionStatement::Switch does ISelectionStatement {
    #TODO: rule selection-statement:sym<switch> {           <switch> <.left-paren> <condition> <.right-paren> <statement>     }      #-----------------------------
}

our role ICondition { }

our class Condition::Expr does ICondition {
    #TODO: rule condition:sym<expr> {         <expression>     }      #-----------------------------
}

our role IConditionDeclTail { }

our class ConditionDeclTail::AssignInit does IConditionDeclTail {
    has Assign $.assign is required;
    has InitializerClause $.initializer-clause is required;
}

our class ConditionDeclTail::BracedInit does IConditionDeclTail {
    #TODO: rule condition-decl-tail:sym<braced-init> { <braced-init-list> }      #-----------------------------
}

our class Condition::Decl does ICondition {
    #TODO: rule condition:sym<decl> {         <attribute-specifier-seq>?         <decl-specifier-seq>          <declarator>         <condition-decl-tail>     }      #-----------------------------
}

our role IIterationStatement { }

our class IterationStatement::While does IIterationStatement {
    has While $.while_ is required;
    has Condition $.condition is required;
    has Statement $.statement is required;
}

our class IterationStatement::Do does IIterationStatement {
    has Do $.do_ is required;
    has Statement $.statement is required;
    has While $.while_ is required;
    has Expression $.expression is required;
    has Semi $.semi is required;
}

our class IterationStatement::For does IIterationStatement {
    has For $.for_ is required;
    has ForInitStatement $.for-init-statement is required;
    has Condition $.condition;
    has Semi $.semi is required;
    has Expression $.expression;
    has Statement $.statement is required;
}

our class IterationStatement::ForRange does IIterationStatement {
    #TODO: rule iteration-statement:sym<for-range> {         <.for_>         <.left-paren>         <for-range-declaration>         <.colon>         <for-range-initializer>         <.right-paren>         <statement>     }      #-----------------------------
}

our role IForInitStatement { }

our class ForInitStatement::ExpressionStatement does IForInitStatement {
    has ExpressionStatement $.expression-statement is required;
}

our class ForInitStatement::SimpleDeclaration does IForInitStatement {
    has SimpleDeclaration $.simple-declaration is required;
}

our class ForRangeDeclaration { 
    #TODO: rule for-range-declaration {         <attribute-specifier-seq>?         <decl-specifier-seq>         <declarator>     }
}

our role IForRangeInitializer { }

our class ForRangeInitializer::Expression does IForRangeInitializer {
    has Expression $.expression is required;
}

our class ForRangeInitializer::BracedInitList does IForRangeInitializer {
    #TODO: rule for-range-initializer:sym<braced-init-list> { <braced-init-list> }      #-------------------------------
}

our role IJumpStatement { }

our class JumpStatement::Break does IJumpStatement {
    has Break $.break_ is required;
    has Semi $.semi is required;
}

our class JumpStatement::Continue does IJumpStatement {
    has Continue $.continue_ is required;
    has Semi $.semi is required;
}

our class JumpStatement::Return does IJumpStatement {
    #TODO: rule jump-statement:sym<return>   { <return_> [ <expression> || <braced-init-list> ]? <semi> }
}

our class JumpStatement::Goto does IJumpStatement {
    has Goto $.goto_ is required;
    has Identifier $.identifier is required;
    has Semi $.semi is required;
}

our class Declarationseq { 
    #TODO: rule declarationseq { <declaration>+ }      #-------------------------------
}

our role IDeclaration { }

our class Declaration::BlockDeclaration does IDeclaration {
    has BlockDeclaration $.block-declaration is required;
}

our class Declaration::FunctionDefinition does IDeclaration {
    has FunctionDefinition $.function-definition is required;
}

our class Declaration::TemplateDeclaration does IDeclaration {
    has TemplateDeclaration $.template-declaration is required;
}

our class Declaration::ExplicitInstantiation does IDeclaration {
    has ExplicitInstantiation $.explicit-instantiation is required;
}

our class Declaration::ExplicitSpecialization does IDeclaration {
    has ExplicitSpecialization $.explicit-specialization is required;
}

our class Declaration::LinkageSpecification does IDeclaration {
    has LinkageSpecification $.linkage-specification is required;
}

our class Declaration::NamespaceDefinition does IDeclaration {
    has NamespaceDefinition $.namespace-definition is required;
}

our class Declaration::EmptyDeclaration does IDeclaration {
    has EmptyDeclaration $.empty-declaration is required;
}

our class Declaration::AttributeDeclaration does IDeclaration {
    has AttributeDeclaration $.attribute-declaration is required;
}

our role IBlockDeclaration { }

our class BlockDeclaration::Simple does IBlockDeclaration {
    has SimpleDeclaration $.simple-declaration is required;
}

our class BlockDeclaration::Asm does IBlockDeclaration {
    has AsmDefinition $.asm-definition is required;
}

our class BlockDeclaration::NamespaceAlias does IBlockDeclaration {
    has NamespaceAliasDefinition $.namespace-alias-definition is required;
}

our class BlockDeclaration::UsingDecl does IBlockDeclaration {
    has UsingDeclaration $.using-declaration is required;
}

our class BlockDeclaration::UsingDirective does IBlockDeclaration {
    has UsingDirective $.using-directive is required;
}

our class BlockDeclaration::StaticAssert does IBlockDeclaration {
    has StaticAssertDeclaration $.static-assert-declaration is required;
}

our class BlockDeclaration::Alias does IBlockDeclaration {
    has AliasDeclaration $.alias-declaration is required;
}

our class BlockDeclaration::OpaqueEnumDecl does IBlockDeclaration {
    has OpaqueEnumDeclaration $.opaque-enum-declaration is required;
}

our class AliasDeclaration { 
    #TODO: rule alias-declaration {         <using>         <identifier>         <attribute-specifier-seq>?         <assign>         <the-type-id>         <semi>     }      #---------------------------
}

our role ISimpleDeclaration { }

our class SimpleDeclaration::Basic does ISimpleDeclaration {
    has DeclSpecifierSeq $.decl-specifier-seq;
    has InitDeclaratorList $.init-declarator-list;
    has Semi $.semi is required;
}

our class SimpleDeclaration::InitList does ISimpleDeclaration {
    has AttributeSpecifierSeq $.attribute-specifier-seq is required;
    has DeclSpecifierSeq $.decl-specifier-seq;
    has InitDeclaratorList $.init-declarator-list is required;
    has Semi $.semi is required;
}

our class StaticAssertDeclaration { 
    #TODO: rule static-assert-declaration {         <static_assert>         <.left-paren>         <constant-expression>         <.comma>         <string-literal>         <.right-paren>         <.semi>     }
}

our class EmptyDeclaration { 
    #TODO: rule empty-declaration {         <.semi>     }
}

our class AttributeDeclaration { 
    #TODO: rule attribute-declaration {         <attribute-specifier-seq> <.semi>     }      #---------------------------
}

our role IDeclSpecifier { }

our class DeclSpecifier::StorageClass does IDeclSpecifier {
    has StorageClassSpecifier $.storage-class-specifier is required;
}

our class DeclSpecifier::Type does IDeclSpecifier {
    has TypeSpecifier $.type-specifier is required;
}

our class DeclSpecifier::Func does IDeclSpecifier {
    has FunctionSpecifier $.function-specifier is required;
}

our class DeclSpecifier::Friend does IDeclSpecifier {
    has Friend $.friend is required;
}

our class DeclSpecifier::Typedef does IDeclSpecifier {
    has Typedef $.typedef is required;
}

our class DeclSpecifier::Constexpr does IDeclSpecifier {
    has Constexpr $.constexpr is required;
}

our class DeclSpecifierSeq { 
    #TODO: regex decl-specifier-seq {         <decl-specifier> [<.ws> <decl-specifier>]*?  <attribute-specifier-seq>?       }      #---------------------------
}

our role IStorageClassSpecifier { }

our class StorageClassSpecifier::Register does IStorageClassSpecifier {
    has Register $.register is required;
}

our class StorageClassSpecifier::Static does IStorageClassSpecifier {
    has Static $.static is required;
}

our class StorageClassSpecifier::Thread_local does IStorageClassSpecifier {
    has Thread_local $.thread_local is required;
}

our class StorageClassSpecifier::Extern does IStorageClassSpecifier {
    has Extern $.extern is required;
}

our class StorageClassSpecifier::Mutable does IStorageClassSpecifier {
    #TODO: rule storage-class-specifier:sym<mutable>      { <mutable>      }      #---------------------------
}

our role IFunctionSpecifier { }

our class FunctionSpecifier::Inline does IFunctionSpecifier {
    has Inline $.inline is required;
}

our class FunctionSpecifier::Virtual does IFunctionSpecifier {
    has Virtual $.virtual is required;
}

our class FunctionSpecifier::Explicit does IFunctionSpecifier {
    has Explicit $.explicit is required;
}

our class TypedefName { 
    #TODO: rule typedef-name { <identifier> }      #---------------------------
}

our role ITypeSpecifier { }

our class TypeSpecifier::TrailingTypeSpecifier does ITypeSpecifier {
    has TrailingTypeSpecifier $.trailing-type-specifier is required;
}

our class TypeSpecifier::ClassSpecifier does ITypeSpecifier {
    has ClassSpecifier $.class-specifier is required;
}

our class TypeSpecifier::EnumSpecifier does ITypeSpecifier {
    #TODO: rule type-specifier:sym<enum-specifier>         { <enum-specifier>         }      #---------------------------
}

our role ITrailingTypeSpecifier { }

our class TrailingTypeSpecifier::CvQualifier does ITrailingTypeSpecifier {
    has CvQualifier $.cv-qualifier is required;
    has SimpleTypeSpecifier $.simple-type-specifier is required;
}

our class TrailingTypeSpecifier::Simple does ITrailingTypeSpecifier {
    has SimpleTypeSpecifier $.simple-type-specifier is required;
}

our class TrailingTypeSpecifier::Elaborated does ITrailingTypeSpecifier {
    has ElaboratedTypeSpecifier $.elaborated-type-specifier is required;
}

our class TrailingTypeSpecifier::Typename does ITrailingTypeSpecifier {
    #TODO: rule trailing-type-specifier:sym<typename>     { <type-name-specifier>       }       #---------------------------
}

our class TypeSpecifierSeq { 
    #TODO: rule type-specifier-seq {         <type-specifier>+ <attribute-specifier-seq>?     }
}

our class TrailingTypeSpecifierSeq { 
    #TODO: rule trailing-type-specifier-seq {         <trailing-type-specifier>+ <attribute-specifier-seq>?     }
}

our role ISimpleTypeLengthModifier { }

our class SimpleTypeLengthModifier::Short does ISimpleTypeLengthModifier {
    has Short $.short is required;
}

our class SimpleTypeLengthModifier::Long does ISimpleTypeLengthModifier {
    has Long $.long_ is required;
}

our role ISimpleTypeSignednessModifier { }

our class SimpleTypeSignednessModifier::Unsigned does ISimpleTypeSignednessModifier {
    has Unsigned $.unsigned is required;
}

our class SimpleTypeSignednessModifier::Signed does ISimpleTypeSignednessModifier {
    has Signed $.signed is required;
}

our class FullTypeName { 
    #TODO: rule full-type-name {         <nested-name-specifier>? <the-type-name>     }
}

our class ScopedTemplateId { 
    #TODO: rule scoped-template-id {         <nested-name-specifier> <template> <simple-template-id>     }
}

our class SimpleIntTypeSpecifier { 
    #TODO: rule simple-int-type-specifier {         <simple-type-signedness-modifier>?  <simple-type-length-modifier>* <int_>     }
}

our class SimpleCharTypeSpecifier { 
    #TODO: rule simple-char-type-specifier {         <simple-type-signedness-modifier>?  <char_>     }
}

our class SimpleChar16TypeSpecifier { 
    #TODO: rule simple-char16-type-specifier {         <simple-type-signedness-modifier>?  <char16>     }
}

our class SimpleChar32TypeSpecifier { 
    #TODO: rule simple-char32-type-specifier {         <simple-type-signedness-modifier>?  <char32>     }
}

our class SimpleWcharTypeSpecifier { 
    #TODO: rule simple-wchar-type-specifier {         <simple-type-signedness-modifier>?  <wchar>     }
}

our class SimpleDoubleTypeSpecifier { 
    #TODO: rule simple-double-type-specifier {         <simple-type-length-modifier>?  <double>     }      #------------------------------
}

our role ISimpleTypeSpecifier { }

our class SimpleTypeSpecifier::Int does ISimpleTypeSpecifier {
    has SimpleIntTypeSpecifier $.simple-int-type-specifier is required;
}

our class SimpleTypeSpecifier::Full does ISimpleTypeSpecifier {
    has FullTypeName $.full-type-name is required;
}

our class SimpleTypeSpecifier::Scoped does ISimpleTypeSpecifier {
    has ScopedTemplateId $.scoped-template-id is required;
}

our class SimpleTypeSpecifier::SignednessMod does ISimpleTypeSpecifier {
    has SimpleTypeSignednessModifier $.simple-type-signedness-modifier is required;
}

our class SimpleTypeSpecifier::SignednessModLength does ISimpleTypeSpecifier {
    has SimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has SimpleTypeLengthModifier @.simple-type-length-modifier is required;
}

our class SimpleTypeSpecifier::Char does ISimpleTypeSpecifier {
    has SimpleCharTypeSpecifier $.simple-char-type-specifier is required;
}

our class SimpleTypeSpecifier::Char16 does ISimpleTypeSpecifier {
    has SimpleChar16TypeSpecifier $.simple-char16-type-specifier is required;
}

our class SimpleTypeSpecifier::Char32 does ISimpleTypeSpecifier {
    has SimpleChar32TypeSpecifier $.simple-char32-type-specifier is required;
}

our class SimpleTypeSpecifier::Wchar does ISimpleTypeSpecifier {
    has SimpleWcharTypeSpecifier $.simple-wchar-type-specifier is required;
}

our class SimpleTypeSpecifier::Bool does ISimpleTypeSpecifier {
    has Bool $.bool_ is required;
}

our class SimpleTypeSpecifier::Float does ISimpleTypeSpecifier {
    has Float $.float is required;
}

our class SimpleTypeSpecifier::Double does ISimpleTypeSpecifier {
    has SimpleDoubleTypeSpecifier $.simple-double-type-specifier is required;
}

our class SimpleTypeSpecifier::Void does ISimpleTypeSpecifier {
    has Void $.void_ is required;
}

our class SimpleTypeSpecifier::Auto does ISimpleTypeSpecifier {
    has Auto $.auto is required;
}

our class SimpleTypeSpecifier::Decltype does ISimpleTypeSpecifier {
    #TODO: regex simple-type-specifier:sym<decltype>              { <decltype-specifier>                                          }       #------------------------------
}

our role ITheTypeName { }

our class TheTypeName::SimpleTemplateId does ITheTypeName {
    has SimpleTemplateId $.simple-template-id is required;
}

our class TheTypeName::Class does ITheTypeName {
    has ClassName $.class-name is required;
}

our class TheTypeName::Enum does ITheTypeName {
    has EnumName $.enum-name is required;
}

our class TheTypeName::Typedef does ITheTypeName {
    #TODO: rule the-type-name:sym<typedef>            { <typedef-name> }      #------------------------------
}

our role IDecltypeSpecifierBody { }

our class DecltypeSpecifierBody::Expr does IDecltypeSpecifierBody {
    has Expression $.expression is required;
}

our class DecltypeSpecifierBody::Auto does IDecltypeSpecifierBody {
    has Auto $.auto is required;
}

our class DecltypeSpecifier { 
    #TODO: rule decltype-specifier {         <decltype>         <.left-paren>         <decltype-specifier-body>         <.right-paren>     }      #------------------------------
}

our role IElaboratedTypeSpecifier { }

our class ElaboratedTypeSpecifier::ClassIdent does IElaboratedTypeSpecifier {
    has ClassKey $.class-key is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has NestedNameSpecifier $.nested-name-specifier;
    has Identifier $.identifier is required;
}

our class ElaboratedTypeSpecifier::ClassTemplateId does IElaboratedTypeSpecifier {
    has ClassKey $.class-key is required;
    has SimpleTemplateId $.simple-template-id is required;
}

our class ElaboratedTypeSpecifier::ClassNestedTemplateId does IElaboratedTypeSpecifier {
    has ClassKey $.class-key is required;
    has NestedNameSpecifier $.nested-name-specifier is required;
    has Template $.template;
    has SimpleTemplateId $.simple-template-id is required;
}

our class ElaboratedTypeSpecifier::Enum does IElaboratedTypeSpecifier {
    #TODO: rule elaborated-type-specifier:sym<enum> {         <enum_> <nested-name-specifier>? <identifier>     }      #------------------------------
}

our class EnumName { 
    #TODO: rule enum-name {         <identifier>     }
}

our class EnumSpecifier { 
    #TODO: rule enum-specifier {         <enum-head>         <.left-brace>         [ <enumerator-list> <comma>?  ]?         <.right-brace>     }
}

our class EnumHead { 
    #TODO: rule enum-head {         <enumkey>         <attribute-specifier-seq>?         [ <nested-name-specifier>? <identifier> ]?         <enumbase>?     }
}

our class OpaqueEnumDeclaration { 
    #TODO: rule opaque-enum-declaration {         <enumkey>         <attribute-specifier-seq>?         <identifier>         <enumbase>?         <semi>     }
}

our class Enumkey { 
    #TODO: rule enumkey {         <enum_>         [  <class_> || <struct> ]?     }
}

our class Enumbase { 
    #TODO: rule enumbase {         <colon> <type-specifier-seq>     }
}

our class EnumeratorList { 
    #TODO: rule enumerator-list {         <enumerator-definition>         [ <comma> <enumerator-definition> ]*     }
}

our class EnumeratorDefinition { 
    #TODO: rule enumerator-definition {         <enumerator>         [ <assign> <constant-expression> ]?     }
}

our class Enumerator { 
    #TODO: rule enumerator {         <identifier>     }
}

our role INamespaceName { }

our class NamespaceName::Original does INamespaceName {
    has OriginalNamespaceName $.original-namespace-name is required;
}

our class NamespaceName::Alias does INamespaceName {
    has NamespaceAlias $.namespace-alias is required;
}

our class OriginalNamespaceName { 
    #TODO: rule original-namespace-name {         <identifier>     }      #--------------------
}

our role INamespaceTag { }

our class NamespaceTag::Ident does INamespaceTag {
    has Identifier $.identifier is required;
}

our class NamespaceTag::NsName does INamespaceTag {
    #TODO: rule namespace-tag:sym<ns-name> { <original-namespace-name> }      #--------------------
}

our class NamespaceDefinition { 
    #TODO: rule namespace-definition {         <inline>?         <namespace>         <namespace-tag>?         <.left-brace>         <namespaceBody=declarationseq>?         <.right-brace>     }
}

our class NamespaceAlias { 
    #TODO: rule namespace-alias {         <identifier>     }
}

our class NamespaceAliasDefinition { 
    #TODO: rule namespace-alias-definition {         <namespace>         <identifier>         <assign>         <qualifiednamespacespecifier>         <semi>     }
}

our class Qualifiednamespacespecifier { 
    #TODO: rule qualifiednamespacespecifier {         <nested-name-specifier>?         <namespace-name>     }      #--------------------
}

our role IUsingDeclarationPrefix { }

our class UsingDeclarationPrefix::Nested does IUsingDeclarationPrefix {
    #TODO: rule using-declaration-prefix:sym<nested> { [ <typename_>? <nested-name-specifier> ] }
}

our class UsingDeclarationPrefix::Base does IUsingDeclarationPrefix {
    #TODO: rule using-declaration-prefix:sym<base>   { <doublecolon> }      #--------------------
}

our class UsingDeclaration { 
    #TODO: rule using-declaration {         <using>         <using-declaration-prefix>         <unqualified-id>         <semi>     }
}

our class UsingDirective { 
    #TODO: rule using-directive {         <attribute-specifier-seq>?         <using>         <namespace>         <nested-name-specifier>?         <namespace-name>         <semi>     }
}

our class AsmDefinition { 
    #TODO: rule asm-definition {         <asm>         <.left-paren>         <string-literal>         <.right-paren>         <.semi>     }      #--------------------
}

our role ILinkageSpecificationBody { }

our class LinkageSpecificationBody::Seq does ILinkageSpecificationBody {
    has Declarationseq $.declarationseq;
}

our class LinkageSpecificationBody::Decl does ILinkageSpecificationBody {
    has Declaration $.declaration is required;
}

our class LinkageSpecification { 
    #TODO: rule linkage-specification {         <extern>         <string-literal>         <linkage-specification-body>     }
}

our class AttributeSpecifierSeq { 
    #TODO: rule attribute-specifier-seq {         <attribute-specifier>+     }      #--------------------
}

our role IAttributeSpecifier { }

our class AttributeSpecifier::DoubleBraced does IAttributeSpecifier {
    has AttributeList $.attribute-list;
}

our class AttributeSpecifier::Alignment does IAttributeSpecifier {
    #TODO: rule attribute-specifier:sym<alignment> {         <alignmentspecifier>     }      #--------------------
}

our role IAlignmentspecifierbody { }

our class Alignmentspecifierbody::TypeId does IAlignmentspecifierbody {
    has TheTypeId $.the-type-id is required;
}

our class Alignmentspecifierbody::ConstExpr does IAlignmentspecifierbody {
    #TODO: rule alignmentspecifierbody:sym<const-expr> { <constant-expression> }      #--------------------
}

our class Alignmentspecifier { 
    #TODO: rule alignmentspecifier {         <alignas>         <.left-paren>         <alignmentspecifierbody>         <ellipsis>?         <.right-paren>     }
}

our class AttributeList { 
    #TODO: rule attribute-list {         <attribute>         [ <comma> <attribute> ]*         <ellipsis>?     }
}

our class Attribute { 
    #TODO: rule attribute {         [ <attribute-namespace> <doublecolon> ]?         <identifier>         <attribute-argument-clause>?     }
}

our class AttributeNamespace { 
    #TODO: rule attribute-namespace {         <identifier>     }
}

our class AttributeArgumentClause { 
    #TODO: rule attribute-argument-clause {         <.left-paren> <balanced-token-seq>?  <.right-paren>     }
}

our class BalancedTokenSeq { 
    #TODO: rule balanced-token-seq {         <balancedrule>+     }      #--------------------------
}

our role IBalancedrule { }

our class Balancedrule::Parens does IBalancedrule {
    has BalancedTokenSeq $.balanced-token-seq is required;
}

our class Balancedrule::Brackets does IBalancedrule {
    has BalancedTokenSeq $.balanced-token-seq is required;
}

our class Balancedrule::Braces does IBalancedrule {
    #TODO: rule balancedrule:sym<braces>   { <.left-brace> <balanced-token-seq> <.right-brace> }      #--------------------------
}

our class InitDeclaratorList { 
    #TODO: rule init-declarator-list {         <init-declarator> [ <comma> <init-declarator> ]*     }
}

our class InitDeclarator { 
    #TODO: rule init-declarator {         <declarator> <initializer>?     }      #--------------------------
}

our role IDeclarator { }

our class Declarator::Ptr does IDeclarator {
    has PointerDeclarator $.pointer-declarator is required;
}

our class Declarator::NoPtr does IDeclarator {
    has NoPointerDeclarator $.no-pointer-declarator is required;
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
    has TrailingReturnType $.trailing-return-type is required;
}

our class PointerDeclarator { 
    #TODO: rule pointer-declarator {         [ <pointer-operator> <const>? ]* <no-pointer-declarator>     }      #------------------------------
}

our role INoPointerDeclaratorBase { }

our class NoPointerDeclaratorBase::Base does INoPointerDeclaratorBase {
    has Declaratorid $.declaratorid is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

our class NoPointerDeclaratorBase::Parens does INoPointerDeclaratorBase {
    #TODO: rule no-pointer-declarator-base:sym<parens> { <.left-paren> <pointer-declarator> <.right-paren> }      #------------------------------
}

our role INoPointerDeclaratorTail { }

our class NoPointerDeclaratorTail::Basic does INoPointerDeclaratorTail {
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
}

our class NoPointerDeclaratorTail::Bracketed does INoPointerDeclaratorTail {
    #TODO: rule no-pointer-declarator-tail:sym<bracketed> {          <.left-bracket>          <constant-expression>?           <.right-bracket>          <attribute-specifier-seq>?      }      #------------------------------
}

our class NoPointerDeclarator { 
    #TODO: rule no-pointer-declarator {         <no-pointer-declarator-base>         <no-pointer-declarator-tail>*     }      #------------------------------
}

our class ParametersAndQualifiers { 
    #TODO: rule parameters-and-qualifiers {         <.left-paren>         <parameter-declaration-clause>?         <.right-paren>         <cvqualifierseq>?         <refqualifier>?         <exception-specification>?         <attribute-specifier-seq>?     }
}

our class TrailingReturnType { 
    #TODO: rule trailing-return-type {         <arrow>         <trailing-type-specifier-seq>         <abstract-declarator>?     }      #-----------------------------
}

our role IPointerOperator { }

our class PointerOperator::Ref does IPointerOperator {
    has And $.and_ is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

our class PointerOperator::RefRef does IPointerOperator {
    has AndAnd $.and-and is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

our class PointerOperator::Star does IPointerOperator {
    has NestedNameSpecifier $.nested-name-specifier;
    has Star $.star is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has Cvqualifierseq $.cvqualifierseq;
}

our class Cvqualifierseq { 
    #TODO: rule cvqualifierseq {         <cv-qualifier>+     }      #-----------------------------
}

our role ICvQualifier { }

our class CvQualifier::Const does ICvQualifier {
    has Const $.const is required;
}

our class CvQualifier::Volatile does ICvQualifier {
    #TODO: rule cv-qualifier:sym<volatile> { <volatile> }      #-----------------------------
}

our role IRefqualifier { }

our class Refqualifier::And does IRefqualifier {
    has And $.and_ is required;
}

our class Refqualifier::AndAnd does IRefqualifier {
    #TODO: rule refqualifier:sym<and-and> { <and-and> }      #-----------------------------
}

our class Declaratorid { 
    #TODO: rule declaratorid {         <ellipsis>?  <id-expression>     }
}

our class TheTypeId { 
    #TODO: rule the-type-id {         <type-specifier-seq> <abstract-declarator>?     }      #-----------------------------
}

our role IAbstractDeclarator { }

our class AbstractDeclarator::Base does IAbstractDeclarator {
    has PointerAbstractDeclarator $.pointer-abstract-declarator is required;
}

our class AbstractDeclarator::Aug does IAbstractDeclarator {
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator;
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
    has TrailingReturnType $.trailing-return-type is required;
}

our class AbstractDeclarator::AbstractPack does IAbstractDeclarator {
    #TODO: rule abstract-declarator:sym<abstract-pack> {         <abstract-pack-declarator>     }      #-----------------------------
}

our role IPointerAbstractDeclarator { }

our class PointerAbstractDeclarator::NoPtr does IPointerAbstractDeclarator {
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator is required;
}

our class PointerAbstractDeclarator::Ptr does IPointerAbstractDeclarator {
    #TODO: rule pointer-abstract-declarator:sym<ptr>    { <pointer-operator>+ <no-pointer-abstract-declarator>? }      #-----------------------------
}

our role INoPointerAbstractDeclaratorBody { }

our class NoPointerAbstractDeclaratorBody::Base does INoPointerAbstractDeclaratorBody {
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
}

our class NoPointerAbstractDeclaratorBody::Brack does INoPointerAbstractDeclaratorBody {
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator is required;
    has NoPointerAbstractDeclaratorBracketedBase $.no-pointer-abstract-declarator-bracketed-base is required;
}

our class NoPointerAbstractDeclarator { 
    #TODO: rule no-pointer-abstract-declarator {         <no-pointer-abstract-declarator-base>         <no-pointer-abstract-declarator-body>*     }      #-----------------------------
}

our role INoPointerAbstractDeclaratorBase { }

our class NoPointerAbstractDeclaratorBase::Basic does INoPointerAbstractDeclaratorBase {
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
}

our class NoPointerAbstractDeclaratorBase::Bracketed does INoPointerAbstractDeclaratorBase {
    has NoPointerAbstractDeclaratorBracketedBase $.no-pointer-abstract-declarator-bracketed-base is required;
}

our class NoPointerAbstractDeclaratorBase::Parenthesized does INoPointerAbstractDeclaratorBase {
    has PointerAbstractDeclarator $.pointer-abstract-declarator is required;
}

our class NoPointerAbstractDeclaratorBracketedBase { 
    #TODO: rule no-pointer-abstract-declarator-bracketed-base {         <.left-bracket>          <constant-expression>?           <.right-bracket>          <attribute-specifier-seq>?     }
}

our class AbstractPackDeclarator { 
    #TODO: rule abstract-pack-declarator {         <pointer-operator>*          <no-pointer-abstract-pack-declarator>     }      #-----------------------------
}

our class NoPointerAbstractPackDeclaratorBasic { 
    #TODO: rule no-pointer-abstract-pack-declarator-basic {         <parameters-and-qualifiers>     }
}

our class NoPointerAbstractPackDeclaratorBrackets { 
    #TODO: rule no-pointer-abstract-pack-declarator-brackets {         <.left-bracket>          <constant-expression>?           <.right-bracket>          <attribute-specifier-seq>?     }      #-----------------------------
}

our role INoPointerAbstractPackDeclaratorBody { }

our class NoPointerAbstractPackDeclaratorBody::Basic does INoPointerAbstractPackDeclaratorBody {
    has NoPointerAbstractPackDeclaratorBasic $.no-pointer-abstract-pack-declarator-basic is required;
}

our class NoPointerAbstractPackDeclaratorBody::Brack does INoPointerAbstractPackDeclaratorBody {
    #TODO: rule no-pointer-abstract-pack-declarator-body:sym<brack> { <no-pointer-abstract-pack-declarator-brackets> }      #-----------------------------
}

our class NoPointerAbstractPackDeclarator { 
    #TODO: rule no-pointer-abstract-pack-declarator {         <ellipsis>         <no-pointer-abstract-pack-declarator-body>*     }
}

our class ParameterDeclarationClause { 
    #TODO: rule parameter-declaration-clause {         <parameter-declaration-list> [ <comma>? <ellipsis> ]?     }
}

our class ParameterDeclarationList { 
    #TODO: rule parameter-declaration-list {         <parameter-declaration> [ <comma> <parameter-declaration> ]*     }      #-----------------------------
}

our role IParameterDeclarationBody { }

our class ParameterDeclarationBody::Decl does IParameterDeclarationBody {
    has Declarator $.declarator is required;
}

our class ParameterDeclarationBody::Abst does IParameterDeclarationBody {
    has AbstractDeclarator $.abstract-declarator;
}

our class ParameterDeclaration { 
    #TODO: rule parameter-declaration {         <attribute-specifier-seq>?         <decl-specifier-seq>         <parameter-declaration-body>         [ <assign> <initializer-clause> ]?     }
}

our class FunctionDefinition { 
    #TODO: rule function-definition {         <attribute-specifier-seq>?         <decl-specifier-seq>?         <declarator>         <virtual-specifier-seq>?         <function-body>     }      #-----------------------------
}

our role IFunctionBody { }

our class FunctionBody::Compound does IFunctionBody {
    has ConstructorInitializer $.constructor-initializer;
    has CompoundStatement $.compound-statement is required;
}

our class FunctionBody::Try does IFunctionBody {
    has FunctionTryBlock $.function-try-block is required;
}

our class FunctionBody::AssignDefault does IFunctionBody {
    has Assign $.assign is required;
    has Default $.default_ is required;
    has Semi $.semi is required;
}

our class FunctionBody::AssignDelete does IFunctionBody {
    #TODO: rule function-body:sym<assign-delete> {         <assign> <delete> <semi>     }      #-----------------------------
}

our role IInitializer { }

our class Initializer::BraceOrEq does IInitializer {
    has BraceOrEqualInitializer $.brace-or-equal-initializer is required;
}

our class Initializer::ParenExprList does IInitializer {
    #TODO: rule initializer:sym<paren-expr-list> {         <.left-paren> <expression-list> <.right-paren>     }      #-----------------------------
}

our role IBraceOrEqualInitializer { }

our class BraceOrEqualInitializer::AssignInit does IBraceOrEqualInitializer {
    has Assign $.assign is required;
    has InitializerClause $.initializer-clause is required;
}

our class BraceOrEqualInitializer::BracedInitList does IBraceOrEqualInitializer {
    #TODO: rule brace-or-equal-initializer:sym<braced-init-list> { <braced-init-list> }      #-----------------------------
}

our role IInitializerClause { }

our class InitializerClause::Assignment does IInitializerClause {
    has Comment $.comment;
    has AssignmentExpression $.assignment-expression is required;
}

our class InitializerClause::Braced does IInitializerClause {
    #TODO: rule initializer-clause:sym<braced> {         <comment>?         <braced-init-list>     }      #-----------------------------
}

our class InitializerList { 
    #TODO: rule initializer-list {         <initializer-clause>         <ellipsis>?         [ <comma> <initializer-clause> <ellipsis>? ]*     }
}

our class BracedInitList { 
    #TODO: rule braced-init-list {         <.left-brace> [ <initializer-list> <comma>? ]?  <.right-brace>     }      #-----------------------------
}

our role IClassName { }

our class ClassName::Id does IClassName {
    has Identifier $.identifier is required;
}

our class ClassName::TemplateId does IClassName {
    has SimpleTemplateId $.simple-template-id is required;
}

our class ClassSpecifier { 
    #TODO: rule class-specifier {         <class-head>         <.left-brace>         <member-specification>?         <.right-brace>     }      #-----------------------------
}

our role IClassHead { }

our class ClassHead::Class does IClassHead {
    #TODO: rule class-head:sym<class> {         <class-key>         <attribute-specifier-seq>?         [ <class-head-name> <class-virt-specifier>? ]?         <base-clause>?     }
}

our class ClassHead::Union does IClassHead {
    #TODO: rule class-head:sym<union> {         <union>         <attribute-specifier-seq>?         [ <class-head-name> <class-virt-specifier>? ]?     }      #-----------------------------
}

our class ClassHeadName { 
    #TODO: rule class-head-name {         <nested-name-specifier>?  <class-name>     }
}

our class ClassVirtSpecifier { 
    #TODO: rule class-virt-specifier {         <final>     }      #-----------------------------
}

our role IClassKey { }

our class ClassKey::Class does IClassKey {
    has Class $.class_ is required;
}

our class ClassKey::Struct does IClassKey {
    #TODO: rule class-key:sym<struct> { <struct> }      #-----------------------------
}

our role IMemberSpecificationBase { }

our class MemberSpecificationBase::Decl does IMemberSpecificationBase {
    has Memberdeclaration $.memberdeclaration is required;
}

our class MemberSpecificationBase::Access does IMemberSpecificationBase {
    has AccessSpecifier $.access-specifier is required;
    has Colon $.colon is required;
}

our class MemberSpecification { 
    #TODO: rule member-specification {         <member-specification-base>+     }      #-----------------------------
}

our role IMemberdeclaration { }

our class Memberdeclaration::Basic does IMemberdeclaration {
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has DeclSpecifierSeq $.decl-specifier-seq;
    has MemberDeclaratorList $.member-declarator-list;
    has Semi $.semi is required;
}

our class Memberdeclaration::Func does IMemberdeclaration {
    has FunctionDefinition $.function-definition is required;
}

our class Memberdeclaration::Using does IMemberdeclaration {
    has UsingDeclaration $.using-declaration is required;
}

our class Memberdeclaration::StaticAssert does IMemberdeclaration {
    has StaticAssertDeclaration $.static-assert-declaration is required;
}

our class Memberdeclaration::Template does IMemberdeclaration {
    has TemplateDeclaration $.template-declaration is required;
}

our class Memberdeclaration::Alias does IMemberdeclaration {
    has AliasDeclaration $.alias-declaration is required;
}

our class Memberdeclaration::Empty does IMemberdeclaration {
    #TODO: rule memberdeclaration:sym<empty>         { <empty-declaration> }      #-----------------------------
}

our class MemberDeclaratorList { 
    #TODO: rule member-declarator-list {         <member-declarator> [ <comma> <member-declarator> ]*     }      #-----------------------------
}

our role IMemberDeclarator { }

our class MemberDeclarator::Virt does IMemberDeclarator {
    has Declarator $.declarator is required;
    has VirtualSpecifierSeq $.virtual-specifier-seq;
    has PureSpecifier $.pure-specifier;
}

our class MemberDeclarator::BraceOrEq does IMemberDeclarator {
    has Declarator $.declarator is required;
    has BraceOrEqualInitializer $.brace-or-equal-initializer;
}

our class MemberDeclarator::Ident does IMemberDeclarator {
    #TODO: rule member-declarator:sym<ident> {         <identifier>?         <attribute-specifier-seq>?         <colon>         <constant-expression>     }      #-----------------------------
}

our class VirtualSpecifierSeq { 
    #TODO: rule virtual-specifier-seq {         <virtual-specifier>+     }      #-----------------------------
}

our role IVirtualSpecifier { }

our class VirtualSpecifier::Override does IVirtualSpecifier {
    has Override $.override is required;
}

our class VirtualSpecifier::Final does IVirtualSpecifier {
    #TODO: rule virtual-specifier:sym<final>    { <final> }      #-----------------------------
}

our class PureSpecifier { 
    #TODO: rule pure-specifier {         <assign>         <val=octal-literal>         #|{if($val.text.compareTo("0")!=0) throw new InputMismatchException(this); }     }
}

our class BaseClause { 
    #TODO: rule base-clause {         <colon> <base-specifier-list>     }
}

our class BaseSpecifierList { 
    #TODO: rule base-specifier-list {         <base-specifier> <ellipsis>?  [ <comma> <base-specifier> <ellipsis>?  ]*     }      #-----------------------------
}

our role IBaseSpecifier { }

our class BaseSpecifier::BaseType does IBaseSpecifier {
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has BaseTypeSpecifier $.base-type-specifier is required;
}

our class BaseSpecifier::Virtual does IBaseSpecifier {
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has Virtual $.virtual is required;
    has AccessSpecifier $.access-specifier;
    has BaseTypeSpecifier $.base-type-specifier is required;
}

our class BaseSpecifier::Access does IBaseSpecifier {
    #TODO: rule base-specifier:sym<access> {         <attribute-specifier-seq>?         <access-specifier>          <virtual>?          <base-type-specifier>     }      #-----------------------------
}

our role IClassOrDeclType { }

our class ClassOrDeclType::Class does IClassOrDeclType {
    has NestedNameSpecifier $.nested-name-specifier;
    has ClassName $.class-name is required;
}

our class ClassOrDeclType::Decltype does IClassOrDeclType {
    #TODO: rule class-or-decl-type:sym<decltype> { <decltype-specifier> }      #-----------------------------
}

our class BaseTypeSpecifier { 
    #TODO: rule base-type-specifier {         <class-or-decl-type>     }
}

our role IAccessSpecifier { }

our class AccessSpecifier::Private does IAccessSpecifier {
    has Private $.private is required;
}

our class AccessSpecifier::Protected does IAccessSpecifier {
    has Protected $.protected is required;
}

our class AccessSpecifier::Public does IAccessSpecifier {
    has Public $.public is required;
}

our class ConversionFunctionId { 
    #TODO: rule conversion-function-id {         <operator> <conversion-type-id>     }
}

our class ConversionTypeId { 
    #TODO: rule conversion-type-id {         <type-specifier-seq> <conversion-declarator>?     }
}

our class ConversionDeclarator { 
    #TODO: rule conversion-declarator {         <pointer-operator> <conversion-declarator>?     }
}

our class ConstructorInitializer { 
    #TODO: rule constructor-initializer {         <colon> <mem-initializer-list>     }
}

our class MemInitializerList { 
    #TODO: rule mem-initializer-list {         <mem-initializer>         <ellipsis>?         [ <comma> <mem-initializer> <ellipsis>? ]*     }      #-----------------------------
}

our role IMemInitializer { }

our class MemInitializer::ExprList does IMemInitializer {
    has Meminitializerid $.meminitializerid is required;
    has ExpressionList $.expression-list;
}

our class MemInitializer::Braced does IMemInitializer {
    #TODO: rule mem-initializer:sym<braced> {         <meminitializerid>         <braced-init-list>     }      #-----------------------------
}

our role IMeminitializerid { }

our class Meminitializerid::ClassOrDecl does IMeminitializerid {
    has ClassOrDeclType $.class-or-decl-type is required;
}

our class Meminitializerid::Ident does IMeminitializerid {
    has Identifier $.identifier is required;
}

our class OperatorFunctionId { 
    #TODO: rule operator-function-id {         <operator> <the-operator>     }      #-----------------------------
}

our role ILiteralOperatorId { }

our class LiteralOperatorId::StringLit does ILiteralOperatorId {
    has Operator $.operator is required;
    has StringLiteral $.string-literal is required;
    has Identifier $.identifier is required;
}

our class LiteralOperatorId::UserDefined does ILiteralOperatorId {
    #TODO: rule literal-operator-id:sym<user-defined> {         <operator>         <user-defined-string-literal>     }      #-----------------------------
}

our class TemplateDeclaration { 
    #TODO: rule template-declaration {         <template>         <less>         <templateparameter-list>         <greater>         <declaration>     }
}

our class TemplateparameterList { 
    #TODO: rule templateparameter-list {         <template-parameter>         [ <comma> <template-parameter> ]*     }      #-----------------------------
}

our role ITemplateParameter { }

our class TemplateParameter::Type does ITemplateParameter {
    has TypeParameter $.type-parameter is required;
}

our class TemplateParameter::Param does ITemplateParameter {
    #TODO: rule template-parameter:sym<param> { <parameter-declaration> }      #-----------------------------
}

our role ITypeParameterBase { }

our class TypeParameterBase::Basic does ITypeParameterBase {
    #TODO: rule type-parameter-base:sym<basic> {        [ <template> <less> <templateparameter-list> <greater> ]?         <class_>     }
}

our class TypeParameterBase::Typename does ITypeParameterBase {
    #TODO: rule type-parameter-base:sym<typename> {        <typename_>     }      #-----------------------------
}

our role ITypeParameterSuffix { }

our class TypeParameterSuffix::MaybeIdent does ITypeParameterSuffix {
    has Ellipsis $.ellipsis;
    has Identifier $.identifier;
}

our class TypeParameterSuffix::AssignTypeId does ITypeParameterSuffix {
    #TODO: rule type-parameter-suffix:sym<assign-type-id> { <identifier>? <assign> <the-type-id> }      #-----------------------------
}

our class TypeParameter { 
    #TODO: rule type-parameter {         <type-parameter-base>         <type-parameter-suffix>     }
}

our class SimpleTemplateId { 
    #TODO: rule simple-template-id {         <template-name>         <less>         <template-argument-list>?         <greater>     }      #-----------------------------
}

our role ITemplateId { }

our class TemplateId::Simple does ITemplateId {
    has SimpleTemplateId $.simple-template-id is required;
}

our class TemplateId::OperatorFunctionId does ITemplateId {
    has OperatorFunctionId $.operator-function-id is required;
    has Less $.less is required;
    has TemplateArgumentList $.template-argument-list;
    has Greater $.greater is required;
}

our class TemplateId::LiteralOperatorId does ITemplateId {
    #TODO: rule template-id:sym<literal-operator-id> {         <literal-operator-id>         <less>         <template-argument-list>?         <greater>     }      #-----------------------------
}

our class TemplateName { 
    #TODO: token template-name {         <identifier>     }
}

our class TemplateArgumentList { 
    #TODO: rule template-argument-list {         <template-argument>          <ellipsis>?          [ <comma> <template-argument> <ellipsis>? ]*     }      #---------------------
}

our role ITemplateArgument { }

our class TemplateArgument::TypeId does ITemplateArgument {
    has TheTypeId $.the-type-id is required;
}

our class TemplateArgument::ConstExpr does ITemplateArgument {
    has ConstantExpression $.constant-expression is required;
}

our class TemplateArgument::IdExpr does ITemplateArgument {
    #TODO: token template-argument:sym<id-expr>    { <id-expression> }      #---------------------
}

our role ITypeNameSpecifier { }

our class TypeNameSpecifier::Ident does ITypeNameSpecifier {
    has Typename $.typename_ is required;
    has NestedNameSpecifier $.nested-name-specifier is required;
    has Identifier $.identifier is required;
}

our class TypeNameSpecifier::Template does ITypeNameSpecifier {
    #TODO: rule type-name-specifier:sym<template> {         <typename_>         <nested-name-specifier>         <template>?           <simple-template-id>     }      #---------------------
}

our class ExplicitInstantiation { 
    #TODO: rule explicit-instantiation {         <extern>?         <template>         <declaration>     }
}

our class ExplicitSpecialization { 
    #TODO: rule explicit-specialization {         <template>         <less>         <greater>         <declaration>     }
}

our class TryBlock { 
    #TODO: rule try-block {         <try_>         <compound-statement>         <handler-seq>     }
}

our class FunctionTryBlock { 
    #TODO: rule function-try-block {         <try_>         <constructor-initializer>?         <compound-statement>         <handler-seq>     }
}

our class HandlerSeq { 
    #TODO: rule handler-seq {         <handler>+     }
}

our class Handler { 
    #TODO: rule handler {         <catch>         <.left-paren>         <exception-declaration>         <.right-paren>         <compound-statement>     }
}

our role ISomeDeclarator { }

our class SomeDeclarator::Basic does ISomeDeclarator {
    has Declarator $.declarator is required;
}

our class SomeDeclarator::Abstract does ISomeDeclarator {
    #TODO: rule some-declarator:sym<abstract> { <abstract-declarator> }      #---------------------
}

our role IExceptionDeclaration { }

our class ExceptionDeclaration::Basic does IExceptionDeclaration {
    has AttributeSpecifierSeq $.attribute-specifier-seq;
    has TypeSpecifierSeq $.type-specifier-seq is required;
    has SomeDeclarator $.some-declarator;
}

our class ExceptionDeclaration::Ellipsis does IExceptionDeclaration {
    has Ellipsis $.ellipsis is required;
}

our class ThrowExpression { 
    #TODO: rule throw-expression {         <throw> <assignment-expression>?     }      #---------------------
}

our role IExceptionSpecification { }

our class ExceptionSpecification::Dynamic does IExceptionSpecification {
    has DynamicExceptionSpecification $.dynamic-exception-specification is required;
}

our class ExceptionSpecification::Noexcept does IExceptionSpecification {
    #TODO: token exception-specification:sym<noexcept> { <noe-except-specification> }      #---------------------
}

our class DynamicExceptionSpecification { 
    #TODO: rule dynamic-exception-specification {         <throw> <.left-paren> <type-id-list>?  <.right-paren>     }
}

our class TypeIdList { 
    #TODO: rule type-id-list {          <the-type-id> <ellipsis>? [ <comma> <the-type-id> <ellipsis>? ]*     }      #---------------------
}

our role INoeExceptSpecification { }

our class NoeExceptSpecification::Full does INoeExceptSpecification {
    has Noexcept $.noexcept is required;
    has ConstantExpression $.constant-expression is required;
}

our class NoeExceptSpecification::KeywordOnly does INoeExceptSpecification {
    #TODO: token noe-except-specification:sym<keyword-only> { <noexcept> }      #---------------------
}

our role ITheOperator { }

our class TheOperator::New does ITheOperator {
    #TODO: token the-operator:sym<new>                { <new_>   [ <.left-bracket> <.right-bracket>]? }
}

our class TheOperator::Delete does ITheOperator {
    #TODO: token the-operator:sym<delete>             { <delete> [ <.left-bracket> <.right-bracket>]? }
}

our class TheOperator::Plus does ITheOperator {
    has Plus $.plus is required;
}

our class TheOperator::Minus does ITheOperator {
    has Minus $.minus is required;
}

our class TheOperator::Star does ITheOperator {
    has Star $.star is required;
}

our class TheOperator::Div does ITheOperator {
    has Div $.div_ is required;
}

our class TheOperator::Mod does ITheOperator {
    has Mod $.mod_ is required;
}

our class TheOperator::Caret does ITheOperator {
    has Caret $.caret is required;
}

our class TheOperator::And does ITheOperator {
    #TODO: token the-operator:sym<and_>               { <and_>    <!before <and_>>                  }
}

our class TheOperator::Or does ITheOperator {
    has Or $.or_ is required;
}

our class TheOperator::Tilde does ITheOperator {
    has Tilde $.tilde is required;
}

our class TheOperator::Not does ITheOperator {
    has Not $.not_ is required;
}

our class TheOperator::Assign does ITheOperator {
    has Assign $.assign is required;
}

our class TheOperator::Greater does ITheOperator {
    has Greater $.greater is required;
}

our class TheOperator::Less does ITheOperator {
    has Less $.less is required;
}

our class TheOperator::GreaterEqual does ITheOperator {
    has GreaterEqual $.greater-equal is required;
}

our class TheOperator::PlusAssign does ITheOperator {
    has PlusAssign $.plus-assign is required;
}

our class TheOperator::MinusAssign does ITheOperator {
    has MinusAssign $.minus-assign is required;
}

our class TheOperator::StarAssign does ITheOperator {
    has StarAssign $.star-assign is required;
}

our class TheOperator::ModAssign does ITheOperator {
    has ModAssign $.mod-assign is required;
}

our class TheOperator::XorAssign does ITheOperator {
    has XorAssign $.xor-assign is required;
}

our class TheOperator::AndAssign does ITheOperator {
    has AndAssign $.and-assign is required;
}

our class TheOperator::OrAssign does ITheOperator {
    has OrAssign $.or-assign is required;
}

our class TheOperator::LessLess does ITheOperator {
    has Less $.less is required;
    has Less $.less is required;
}

our class TheOperator::GreaterGreater does ITheOperator {
    has Greater $.greater is required;
    has Greater $.greater is required;
}

our class TheOperator::RightShiftAssign does ITheOperator {
    has RightShiftAssign $.right-shift-assign is required;
}

our class TheOperator::LeftShiftAssign does ITheOperator {
    has LeftShiftAssign $.left-shift-assign is required;
}

our class TheOperator::Equal does ITheOperator {
    has Equal $.equal is required;
}

our class TheOperator::NotEqual does ITheOperator {
    has NotEqual $.not-equal is required;
}

our class TheOperator::LessEqual does ITheOperator {
    has LessEqual $.less-equal is required;
}

our class TheOperator::AndAnd does ITheOperator {
    has AndAnd $.and-and is required;
}

our class TheOperator::OrOr does ITheOperator {
    has OrOr $.or-or is required;
}

our class TheOperator::PlusPlus does ITheOperator {
    has PlusPlus $.plus-plus is required;
}

our class TheOperator::MinusMinus does ITheOperator {
    has MinusMinus $.minus-minus is required;
}

our class TheOperator::Comma does ITheOperator {
    has Comma $.comma is required;
}

our class TheOperator::ArrowStar does ITheOperator {
    has ArrowStar $.arrow-star is required;
}

our class TheOperator::Arrow does ITheOperator {
    has Arrow $.arrow is required;
}

our class TheOperator::Parens does ITheOperator {

}

our class TheOperator::Brak does ITheOperator {

}

our role ILiteral { }

our class Literal::Int does ILiteral {
    has IntegerLiteral $.integer-literal is required;
}

our class Literal::Char does ILiteral {
    has CharacterLiteral $.character-literal is required;
}

our class Literal::Float does ILiteral {
    #TODO: token literal:sym<float>                { <floating-literal> }      #Note: are we allowed to have many strings in a row?
}

our class Literal::Str does ILiteral {
    has StringLiteral $.string-literal is required;
}

our class Literal::Bool does ILiteral {
    has BooleanLiteral $.boolean-literal is required;
}

our class Literal::Ptr does ILiteral {
    has PointerLiteral $.pointer-literal is required;
}

our class Literal::UserDefined does ILiteral {
    has UserDefinedLiteral $.user-defined-literal is required;
}


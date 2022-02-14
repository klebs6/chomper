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
our class Not::Bang does INot { }
our class Not::Not  does INot { has Not $.not is required; }

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
    has DecimalLiteral $.decimal-literal is required;
    has Integersuffix  $.integersuffix;
}

our class IntegerLiteral::Oct does IIntegerLiteral {
    has OctalLiteral  $.octal-literal is required;
    has Integersuffix $.integersuffix;
}

our class IntegerLiteral::Hex does IIntegerLiteral {
    has HexadecimalLiteral $.hexadecimal-literal is required;
    has Integersuffix      $.integersuffix;
}

our class IntegerLiteral::Bin does IIntegerLiteral {
    has BinaryLiteral $.binary-literal is required;
    has Integersuffix $.integersuffix;
}

#-------------------------------
our role ICharacterLiteralPrefix { }

our class CharacterLiteralPrefix::U    does ICharacterLiteralPrefix { }
our class CharacterLiteralPrefix::BigU does ICharacterLiteralPrefix { }
our class CharacterLiteralPrefix::L    does ICharacterLiteralPrefix { }

#-------------------------------
our class CharacterLiteral { 

    #TODO
}

our role IFloatingLiteral { }

our class FloatingLiteral::Frac does IFloatingLiteral {
    has Fractionalconstant $.fractionalconstant is required;
    has Exponentpart       $.exponentpart;
    has Floatingsuffix     $.floatingsuffix;
}

our class FloatingLiteral::Digit does IFloatingLiteral {
    #TODO
}

our class StringLiteralItem { 
    #TODO
}

our class StringLiteral { 
    #TODO
}

our role IBooleanLiteral { }

our class BooleanLiteral::F does IBooleanLiteral {
    has False $.false is required;
}

our class BooleanLiteral::T does IBooleanLiteral {
    has True $.true is required;
}

our class PointerLiteral { 
    #TODO
}

our role IUserDefinedLiteral { }

our class UserDefinedLiteral:syn<int> { 
    #TODO
}

our class UserDefinedLiteral::Float does IUserDefinedLiteral {
    has UserDefinedFloatingLiteral $.user-defined-floating-literal is required;
}

our class UserDefinedLiteral::Str does IUserDefinedLiteral {
    has UserDefinedStringLiteral $.user-defined-string-literal is required;
}

our class UserDefinedLiteral::Char does IUserDefinedLiteral {
    has UserDefinedCharacterLiteral $.user-defined-character-literal is required;
}

our class MultiLineMacro { 
    #TODO
}

our class Directive { 
    #TODO
}

our class Hexquad { 
    #TODO
}

our role IUniversalcharactername { }

our class Universalcharactername::One does IUniversalcharactername {
    #TODO
}

our class Universalcharactername::Two does IUniversalcharactername {
    #TODO
}

our role IIdentifierStart { }

our class IdentifierStart::Nondigit does IIdentifierStart {
    has Nondigit $.nondigit is required;
}

our class IdentifierStart::Ucn does IIdentifierStart {
    #TODO
}

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
    #TODO
}

our class Nondigit { 
    #TODO
}

our class Digit { 
    #TODO
}

our class DecimalLiteral { 
    #TODO
}

our class OctalLiteral { 
    #TODO
}

our class HexadecimalLiteral { 
    #TODO
}

our class BinaryLiteral { 
    #TODO
}

our class Nonzerodigit { 
    #TODO
}

our class Octaldigit { 
    #TODO
}

our class Hexadecimaldigit { 
    #TODO
}

our class Binarydigit { 
    #TODO
}

our role IIntegersuffix { }

our class Integersuffix::Ul does IIntegersuffix {
    has Unsignedsuffix $.unsignedsuffix is required;
    has Longsuffix $.longsuffix;
}

our class Integersuffix::Ull does IIntegersuffix {
    has Unsignedsuffix $.unsignedsuffix is required;
    has Longlongsuffix $.longlongsuffix;
}

our class Integersuffix::Lu does IIntegersuffix {
    has Longsuffix $.longsuffix is required;
    has Unsignedsuffix $.unsignedsuffix;
}

our class Integersuffix::Llu does IIntegersuffix {
    #TODO
}

our class Unsignedsuffix { 
    #TODO
}

our class Longsuffix { 
    #TODO
}

our role ILonglongsuffix { }

our class Longlongsuffix::Ll does ILonglongsuffix {
    #TODO
}

our class Longlongsuffix::LL does ILonglongsuffix {
    #TODO
}

our role ICchar { }

our class Cchar::Basic does ICchar {
    #TODO
}

our class Cchar::Escape does ICchar {
    has Escapesequence $.escapesequence is required;
}

our class Cchar::Universal does ICchar {
    #TODO
}

our role IEscapesequence { }

our class Escapesequence::Simple does IEscapesequence {
    has Simpleescapesequence $.simpleescapesequence is required;
}

our class Escapesequence::Octal does IEscapesequence {
    has Octalescapesequence $.octalescapesequence is required;
}

our class Escapesequence::Hex does IEscapesequence {
    #TODO
}

our role ISimpleescapesequence { }

our class Simpleescapesequence::Slash does ISimpleescapesequence {
    #TODO
}

our class Simpleescapesequence::Quote does ISimpleescapesequence {
    #TODO
}

our class Simpleescapesequence::Question does ISimpleescapesequence {
    #TODO
}

our class Simpleescapesequence::DoubleSlash does ISimpleescapesequence {
    #TODO
}

our class Simpleescapesequence::A does ISimpleescapesequence {
    #TODO
}

our class Simpleescapesequence::B does ISimpleescapesequence {
    #TODO
}

our class Simpleescapesequence::F does ISimpleescapesequence {
    #TODO
}

our class Simpleescapesequence::N does ISimpleescapesequence {
    #TODO
}

our class Simpleescapesequence::R does ISimpleescapesequence {
    #TODO
}

our class Simpleescapesequence::T does ISimpleescapesequence {
    #TODO
}

our class Simpleescapesequence::V does ISimpleescapesequence {
    #TODO
}

our class Simpleescapesequence::RnN does ISimpleescapesequence {
    #TODO
}

our class Octalescapesequence { 
    #TODO
}

our class Hexadecimalescapesequence { 
    #TODO
}

our role IFractionalconstant { }

our class Fractionalconstant::WithTail does IFractionalconstant {
    #TODO
}

our class Fractionalconstant::NoTail does IFractionalconstant {
    #TODO
}

our class ExponentpartPrefix { 
    #TODO
}

our class Exponentpart { 
    #TODO
}

our class Sign { 
    #TODO
}

our class Digitsequence { 
    #TODO
}

our class Floatingsuffix { 
    #TODO
}

our role IEncodingprefix { }

our class Encodingprefix::U8 does IEncodingprefix {
    #TODO
}

our class Encodingprefix::U does IEncodingprefix {
    #TODO
}

our class Encodingprefix::U does IEncodingprefix {
    #TODO
}

our class Encodingprefix::L does IEncodingprefix {
    #TODO
}

our role ISchar { }

our class Schar::Basic does ISchar {
    #TODO
}

our class Schar::Escape does ISchar {
    has Escapesequence $.escapesequence is required;
}

our class Schar::Ucn does ISchar {
    has Universalcharactername $.universalcharactername is required;
}

our class Rawstring { 
    #TODO
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
    #TODO
}

our role IUserDefinedFloatingLiteral { }

our class UserDefinedFloatingLiteral::Frac does IUserDefinedFloatingLiteral {
    has Fractionalconstant $.fractionalconstant is required;
    has Exponentpart $.exponentpart;
    has Udsuffix $.udsuffix is required;
}

our class UserDefinedFloatingLiteral::Digi does IUserDefinedFloatingLiteral {
    #TODO
}

our class UserDefinedStringLiteral { 
    #TODO
}

our class UserDefinedCharacterLiteral { 
    #TODO
}

our class Udsuffix { 
    #TODO
}

our class Whitespace { 
    #TODO
}

our class Newline { 
    #TODO
}

our class BlockComment { 
    #TODO
}

our class LineComment { 
    #TODO
}

our class TOP { 
    #TODO
}

our class TranslationUnit { 
    #TODO
}

#-----------------------
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
    #TODO
}

#-----------------------
our role IIdExpression { }

our class IdExpression::Qualified does IIdExpression {
    has QualifiedId $.qualified-id is required;
}

our class IdExpression::Unqualified does IIdExpression {
    #TODO
}

#-----------------------
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
    #TODO
}

our class UnqualifiedId::TemplateId does IUnqualifiedId {
    #TODO
}

our class QualifiedId { 
    #TODO
}

#-----------------------
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
    #TODO
}

#-----------------------
our role INestedNameSpecifierSuffix { }

our class NestedNameSpecifierSuffix::Id does INestedNameSpecifierSuffix {
    has Identifier $.identifier is required;
    has Doublecolon $.doublecolon is required;
}

our class NestedNameSpecifierSuffix::Template does INestedNameSpecifierSuffix {
    #TODO
}

our class NestedNameSpecifier { 
    #TODO
}

our class LambdaExpression { 
    #TODO
}

our class LambdaIntroducer { 
    #TODO
}

#-----------------------
our role ILambdaCapture { }

our class LambdaCapture::List does ILambdaCapture {
    has CaptureList $.capture-list is required;
}

our class LambdaCapture::Def does ILambdaCapture {
    #TODO
}

#-----------------------
our role ICaptureDefault { }

our class CaptureDefault::And does ICaptureDefault {
    has And $.and is required;
}

our class CaptureDefault::Assign does ICaptureDefault {
    #TODO
}

our class CaptureList { 
    #TODO
}

#-----------------------
our role ICapture { }

our class Capture::Simple does ICapture {
    has SimpleCapture $.simple-capture is required;
}

our class Capture::Init does ICapture {
    #TODO
}

#-----------------------
our role ISimpleCapture { }

our class SimpleCapture::Id does ISimpleCapture {
    has And $.and;
    has Identifier $.identifier is required;
}

our class SimpleCapture::This does ISimpleCapture {
    #TODO
}

our class Initcapture { 
    #TODO
}

our class LambdaDeclarator { 
    #TODO
}

our class PostfixExpression { 
    #TODO
}

#-----------------------
our role IPostfixExpressionTail { }

our class BracketTail { 
    #TODO
}

our class PostfixExpressionTail::Bracket does IPostfixExpressionTail {
    has BracketTail $.bracket-tail is required;
}

our class PostfixExpressionTail::Parens does IPostfixExpressionTail {
    has ExpressionList $.expression-list;
}

our class PostfixExpressionTail::IndirectionId does IPostfixExpressionTail {
    #TODO
}

our class PostfixExpressionTail::IndirectionPseudoDtor does IPostfixExpressionTail {
    #TODO
}

our class PostfixExpressionTail::PpMm does IPostfixExpressionTail {
    #TODO
}

our class PostfixExpressionBody { 
    #TODO
}

#-----------------------
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
    #TODO
}

our class PostfixExpressionTypeid { 
    #TODO
}

#-----------------------
our role IPostListHead { }

our class PostListHead::Simple does IPostListHead {
    has SimpleTypeSpecifier $.simple-type-specifier is required;
}

our class PostListHead::TypeName does IPostListHead {
    #TODO
}

#-----------------------
our role IPostListTail { }

our class PostListTail::Parenthesized does IPostListTail {
    has ExpressionList $.expression-list;
}

our class PostListTail::Braced does IPostListTail {
    has BracedInitList $.braced-init-list is required;
}

our class PostfixExpressionList { 
    #TODO
}

our class TypeIdOfTheTypeId { 
    #TODO
}

our class ExpressionList { 
    #TODO
}

#-----------------------
our role IPseudoDestructorName { }

our class PseudoDestructorName::Basic does IPseudoDestructorName {
    #TODO
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
    #TODO
}

our class UnaryExpression { 
    #TODO
}

#-----------------------
our role IUnaryExpressionCase { }

our class UnaryExpressionCase::Postfix does IUnaryExpressionCase {
    has PostfixExpression $.postfix-expression is required;
}

our class UnaryExpressionCase::Pp does IUnaryExpressionCase {
    has PlusPlus        $.plus-plus        is required;
    has UnaryExpression $.unary-expression is required;
}

our class UnaryExpressionCase::Mm does IUnaryExpressionCase {
    has MinusMinus      $.minus-minus      is required;
    has UnaryExpression $.unary-expression is required;
}

our class UnaryExpressionCase::UnaryOp does IUnaryExpressionCase {
    has UnaryOperator   $.unary-operator   is required;
    has UnaryExpression $.unary-expression is required;
}

our class UnaryExpressionCase::Sizeof does IUnaryExpressionCase {
    has Sizeof          $.sizeof           is required;
    has UnaryExpression $.unary-expression is required;
}

our class UnaryExpressionCase::SizeofTypeid does IUnaryExpressionCase {
    has Sizeof    $.sizeof      is required;
    has TheTypeId $.the-type-id is required;
}

our class UnaryExpressionCase::SizeofIds does IUnaryExpressionCase {
    has Sizeof     $.sizeof     is required;
    has Ellipsis   $.ellipsis   is required;
    has Identifier $.identifier is required;
}

our class UnaryExpressionCase::Alignof does IUnaryExpressionCase {
    has Alignof   $.alignof     is required;
    has TheTypeId $.the-type-id is required;
}

our class UnaryExpressionCase::Noexcept does IUnaryExpressionCase {
    has NoExceptExpression $.no-except-expression is required;
}

our class UnaryExpressionCase::Delete does IUnaryExpressionCase {
    #TODO
}

#-----------------------
our role IUnaryOperator { }

our class UnaryOperator::Or does IUnaryOperator {
    has Or $.or is required;
}

our class UnaryOperator::Star does IUnaryOperator {
    has Star $.star is required;
}

our class UnaryOperator::And does IUnaryOperator {
    has And $.and is required;
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
    #TODO
}

our class NewExpression { 
    #TODO
}

our class NewPlacement { 
    #TODO
}

our class NewTypeId { 
    #TODO
}

our class NewDeclarator { 
    #TODO
}

our class NoPointerNewDeclarator { 
    #TODO
}

#-----------------------
our role INewInitializer { }

our class NewInitializer::ExprList does INewInitializer {
    has ExpressionList $.expression-list;
}

our class NewInitializer::Braced does INewInitializer {
    #TODO
}

our class DeleteExpression { 
    #TODO
}

our class NoExceptExpression { 
    #TODO
}

our class CastExpression { 
    #TODO
}

#-----------------------
our role IPointerMemberOperator { }

our class PointerMemberOperator::Dot does IPointerMemberOperator {
    has DotStar $.dot-star is required;
}

our class PointerMemberOperator::Arrow does IPointerMemberOperator {
    has ArrowStar $.arrow-star is required;
}

our class PointerMemberExpression { 
    #TODO
}

#-----------------------
our role IMultiplicativeOperator { }

our class MultiplicativeOperator::Star  does IMultiplicativeOperator { }
our class MultiplicativeOperator::Slash does IMultiplicativeOperator { }
our class MultiplicativeOperator::Mod   does IMultiplicativeOperator { }

our class MultiplicativeExpression { 
    #TODO
}

#-----------------------
our role IAdditiveOperator { }

our class AdditiveOperator::Plus does IAdditiveOperator {
    has Plus $.plus is required;
}

our class AdditiveOperator::Minus does IAdditiveOperator {
    #TODO
}

our class AdditiveExpression { 
    #TODO
}

our class ShiftExpression { 
    #TODO
}

#-----------------------
our role IShiftOperator { }

our class ShiftOperator::Right does IShiftOperator {
    has Greater $.greater is required;
    has Greater $.greater is required;
}

our class ShiftOperator::Left does IShiftOperator {
    #TODO
}

#-----------------------
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
    #TODO
}

our class RelationalExpression { 
    #TODO
}

#-----------------------
our role IEqualityOperator { }

our class EqualityOperator::Eq does IEqualityOperator {
    has Equal $.equal is required;
}

our class EqualityOperator::Neq does IEqualityOperator {
    #TODO
}

our class EqualityExpression { 
    #TODO
}

our class AndExpression { 
    #TODO
}

our class ExclusiveOrExpression { 
    #TODO
}

our class InclusiveOrExpression { 
    #TODO
}

our class LogicalAndExpression { 
    #TODO
}

our class LogicalOrExpression { 
    #TODO
}

our class ConditionalExpression { 
    #TODO
}

#-----------------------
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

#-----------------------
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
    #TODO
}

our class ConstantExpression { 
    #TODO
}

#-----------------------
our role IComment { }

our class Comment::Line does IComment {
    #TODO
}

our class Comment::Block does IComment {
    #TODO
}

#-----------------------
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

#-----------------------
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
    #TODO
}

#-----------------------
our role ILabeledStatementLabelBody { }

our class LabeledStatementLabelBody::Id does ILabeledStatementLabelBody {
    has Identifier $.identifier is required;
}

our class LabeledStatementLabelBody::CaseExpr does ILabeledStatementLabelBody {
    has Case $.case is required;
    has ConstantExpression $.constant-expression is required;
}

our class LabeledStatementLabelBody::Default does ILabeledStatementLabelBody {
    #TODO
}

our class LabeledStatementLabel { 
    #TODO
}

our class LabeledStatement { 
    #TODO
}

our class DeclarationStatement { 
    #TODO
}

our class ExpressionStatement { 
    #TODO
}

our class CompoundStatement { 
    #TODO
}

our class StatementSeq { 
    #TODO
}

#-----------------------
our role ISelectionStatement { }

our class SelectionStatement::If does ISelectionStatement {
    #TODO
}

our class SelectionStatement::Switch does ISelectionStatement {
    #TODO
}

#-----------------------
our role ICondition { }

our class Condition::Expr does ICondition {
    #TODO
}

#-----------------------
our role IConditionDeclTail { }

our class ConditionDeclTail::AssignInit does IConditionDeclTail {
    has Assign $.assign is required;
    has InitializerClause $.initializer-clause is required;
}

our class ConditionDeclTail::BracedInit does IConditionDeclTail {
    #TODO
}

our class Condition::Decl does ICondition {
    #TODO
}

#-----------------------
our role IIterationStatement { }

our class IterationStatement::While does IIterationStatement {
    has While $.while is required;
    has Condition $.condition is required;
    has Statement $.statement is required;
}

our class IterationStatement::Do does IIterationStatement {
    has Do $.do is required;
    has Statement $.statement is required;
    has While $.while is required;
    has Expression $.expression is required;
    has Semi $.semi is required;
}

our class IterationStatement::For does IIterationStatement {
    has For $.for is required;
    has ForInitStatement $.for-init-statement is required;
    has Condition $.condition;
    has Semi $.semi is required;
    has Expression $.expression;
    has Statement $.statement is required;
}

our class IterationStatement::ForRange does IIterationStatement {
    #TODO
}

#-----------------------
our role IForInitStatement { }

our class ForInitStatement::ExpressionStatement does IForInitStatement {
    has ExpressionStatement $.expression-statement is required;
}

our class ForInitStatement::SimpleDeclaration does IForInitStatement {
    has SimpleDeclaration $.simple-declaration is required;
}

our class ForRangeDeclaration { 
    #TODO
}

#-----------------------
our role IForRangeInitializer { }

our class ForRangeInitializer::Expression does IForRangeInitializer {
    has Expression $.expression is required;
}

our class ForRangeInitializer::BracedInitList does IForRangeInitializer {
    #TODO
}

#-----------------------
our role IJumpStatement { }

our class JumpStatement::Break does IJumpStatement {
    has Break $.break is required;
    has Semi $.semi is required;
}

our class JumpStatement::Continue does IJumpStatement {
    has Continue $.continue is required;
    has Semi $.semi is required;
}

our class JumpStatement::Return does IJumpStatement {
    #TODO
}

our class JumpStatement::Goto does IJumpStatement {
    has Goto $.goto is required;
    has Identifier $.identifier is required;
    has Semi $.semi is required;
}

our class Declarationseq { 
    #TODO
}

#-----------------------
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

#-----------------------
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
    #TODO
}

#-----------------------
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
    #TODO
}

our class EmptyDeclaration { 
    #TODO
}

our class AttributeDeclaration { 
    #TODO
}

#-----------------------
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
    #TODO
}

#-----------------------
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
    #TODO
}

#-----------------------
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
    #TODO
}

#-----------------------
our role ITypeSpecifier { }

our class TypeSpecifier::TrailingTypeSpecifier does ITypeSpecifier {
    has TrailingTypeSpecifier $.trailing-type-specifier is required;
}

our class TypeSpecifier::ClassSpecifier does ITypeSpecifier {
    has ClassSpecifier $.class-specifier is required;
}

our class TypeSpecifier::EnumSpecifier does ITypeSpecifier {
    #TODO
}

#-----------------------
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
    #TODO
}

our class TypeSpecifierSeq { 
    #TODO
}

our class TrailingTypeSpecifierSeq { 
    #TODO
}

#-----------------------
our role ISimpleTypeLengthModifier { }

our class SimpleTypeLengthModifier::Short does ISimpleTypeLengthModifier {
    has Short $.short is required;
}

our class SimpleTypeLengthModifier::Long does ISimpleTypeLengthModifier {
    has Long $.long is required;
}

#-----------------------
our role ISimpleTypeSignednessModifier { }

our class SimpleTypeSignednessModifier::Unsigned does ISimpleTypeSignednessModifier {
    has Unsigned $.unsigned is required;
}

our class SimpleTypeSignednessModifier::Signed does ISimpleTypeSignednessModifier {
    has Signed $.signed is required;
}

our class FullTypeName { 
    #TODO
}

our class ScopedTemplateId { 
    #TODO
}

our class SimpleIntTypeSpecifier { 
    #TODO
}

our class SimpleCharTypeSpecifier { 
    #TODO
}

our class SimpleChar16TypeSpecifier { 
    #TODO
}

our class SimpleChar32TypeSpecifier { 
    #TODO
}

our class SimpleWcharTypeSpecifier { 
    #TODO
}

our class SimpleDoubleTypeSpecifier { 
    #TODO
}

#-----------------------
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
    has Bool $.bool is required;
}

our class SimpleTypeSpecifier::Float does ISimpleTypeSpecifier {
    has Float $.float is required;
}

our class SimpleTypeSpecifier::Double does ISimpleTypeSpecifier {
    has SimpleDoubleTypeSpecifier $.simple-double-type-specifier is required;
}

our class SimpleTypeSpecifier::Void does ISimpleTypeSpecifier {
    has Void $.void is required;
}

our class SimpleTypeSpecifier::Auto does ISimpleTypeSpecifier {
    has Auto $.auto is required;
}

our class SimpleTypeSpecifier::Decltype does ISimpleTypeSpecifier {
    #TODO
}

#-----------------------
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
    #TODO
}

#-----------------------
our role IDecltypeSpecifierBody { }

our class DecltypeSpecifierBody::Expr does IDecltypeSpecifierBody {
    has Expression $.expression is required;
}

our class DecltypeSpecifierBody::Auto does IDecltypeSpecifierBody {
    has Auto $.auto is required;
}

our class DecltypeSpecifier { 
    #TODO
}

#-----------------------
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
    #TODO
}

our class EnumName { 
    #TODO
}

our class EnumSpecifier { 
    #TODO
}

our class EnumHead { 
    #TODO
}

our class OpaqueEnumDeclaration { 
    #TODO
}

our class Enumkey { 
    #TODO
}

our class Enumbase { 
    #TODO
}

our class EnumeratorList { 
    #TODO
}

our class EnumeratorDefinition { 
    #TODO
}

our class Enumerator { 
    #TODO
}

#-----------------------
our role INamespaceName { }

our class NamespaceName::Original does INamespaceName {
    has OriginalNamespaceName $.original-namespace-name is required;
}

our class NamespaceName::Alias does INamespaceName {
    has NamespaceAlias $.namespace-alias is required;
}

our class OriginalNamespaceName { 
    #TODO
}

#-----------------------
our role INamespaceTag { }

our class NamespaceTag::Ident does INamespaceTag {
    has Identifier $.identifier is required;
}

our class NamespaceTag::NsName does INamespaceTag {
    #TODO
}

our class NamespaceDefinition { 
    #TODO
}

our class NamespaceAlias { 
    #TODO
}

our class NamespaceAliasDefinition { 
    #TODO
}

our class Qualifiednamespacespecifier { 
    #TODO
}

#-----------------------
our role IUsingDeclarationPrefix { }

our class UsingDeclarationPrefix::Nested does IUsingDeclarationPrefix {
    #TODO
}

our class UsingDeclarationPrefix::Base does IUsingDeclarationPrefix {
    #TODO
}

our class UsingDeclaration { 
    #TODO
}

our class UsingDirective { 
    #TODO
}

our class AsmDefinition { 
    #TODO
}

#-----------------------
our role ILinkageSpecificationBody { }

our class LinkageSpecificationBody::Seq does ILinkageSpecificationBody {
    has Declarationseq $.declarationseq;
}

our class LinkageSpecificationBody::Decl does ILinkageSpecificationBody {
    has Declaration $.declaration is required;
}

our class LinkageSpecification { 
    #TODO
}

our class AttributeSpecifierSeq { 
    #TODO
}

#-----------------------
our role IAttributeSpecifier { }

our class AttributeSpecifier::DoubleBraced does IAttributeSpecifier {
    has AttributeList $.attribute-list;
}

our class AttributeSpecifier::Alignment does IAttributeSpecifier {
    #TODO
}

#-----------------------
our role IAlignmentspecifierbody { }

our class Alignmentspecifierbody::TypeId does IAlignmentspecifierbody {
    has TheTypeId $.the-type-id is required;
}

our class Alignmentspecifierbody::ConstExpr does IAlignmentspecifierbody {
    #TODO
}

our class Alignmentspecifier { 
    #TODO
}

our class AttributeList { 
    #TODO
}

our class Attribute { 
    #TODO
}

our class AttributeNamespace { 
    #TODO
}

our class AttributeArgumentClause { 
    #TODO
}

our class BalancedTokenSeq { 
    #TODO
}

#-----------------------
our role IBalancedrule { }

our class Balancedrule::Parens does IBalancedrule {
    has BalancedTokenSeq $.balanced-token-seq is required;
}

our class Balancedrule::Brackets does IBalancedrule {
    has BalancedTokenSeq $.balanced-token-seq is required;
}

our class Balancedrule::Braces does IBalancedrule {
    #TODO
}

our class InitDeclaratorList { 
    #TODO
}

our class InitDeclarator { 
    #TODO
}

#-----------------------
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
    #TODO
}

#-----------------------
our role INoPointerDeclaratorBase { }

our class NoPointerDeclaratorBase::Base does INoPointerDeclaratorBase {
    has Declaratorid $.declaratorid is required;
    has AttributeSpecifierSeq $.attribute-specifier-seq;
}

our class NoPointerDeclaratorBase::Parens does INoPointerDeclaratorBase {
    #TODO
}

#-----------------------
our role INoPointerDeclaratorTail { }

our class NoPointerDeclaratorTail::Basic does INoPointerDeclaratorTail {
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
}

our class NoPointerDeclaratorTail::Bracketed does INoPointerDeclaratorTail {
    #TODO
}

our class NoPointerDeclarator { 
    #TODO
}

our class ParametersAndQualifiers { 
    #TODO
}

our class TrailingReturnType { 
    #TODO
}

#-----------------------
our role IPointerOperator { }

our class PointerOperator::Ref does IPointerOperator {
    has And $.and is required;
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
    #TODO
}

#-----------------------
our role ICvQualifier { }

our class CvQualifier::Const does ICvQualifier {
    has Const $.const is required;
}

our class CvQualifier::Volatile does ICvQualifier {
    #TODO
}

#-----------------------
our role IRefqualifier { }

our class Refqualifier::And does IRefqualifier {
    has And $.and is required;
}

our class Refqualifier::AndAnd does IRefqualifier {
    #TODO
}

our class Declaratorid { 
    #TODO
}

our class TheTypeId { 
    #TODO
}

#-----------------------
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
    #TODO
}

#-----------------------
our role IPointerAbstractDeclarator { }

our class PointerAbstractDeclarator::NoPtr does IPointerAbstractDeclarator {
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator is required;
}

our class PointerAbstractDeclarator::Ptr does IPointerAbstractDeclarator {
    #TODO
}

#-----------------------
our role INoPointerAbstractDeclaratorBody { }

our class NoPointerAbstractDeclaratorBody::Base does INoPointerAbstractDeclaratorBody {
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
}

our class NoPointerAbstractDeclaratorBody::Brack does INoPointerAbstractDeclaratorBody {
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator is required;
    has NoPointerAbstractDeclaratorBracketedBase $.no-pointer-abstract-declarator-bracketed-base is required;
}

our class NoPointerAbstractDeclarator { 
    #TODO
}

#-----------------------
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
    #TODO
}

our class AbstractPackDeclarator { 
    #TODO
}

our class NoPointerAbstractPackDeclaratorBasic { 
    #TODO
}

our class NoPointerAbstractPackDeclaratorBrackets { 
    #TODO
}

#-----------------------
our role INoPointerAbstractPackDeclaratorBody { }

our class NoPointerAbstractPackDeclaratorBody::Basic does INoPointerAbstractPackDeclaratorBody {
    has NoPointerAbstractPackDeclaratorBasic $.no-pointer-abstract-pack-declarator-basic is required;
}

our class NoPointerAbstractPackDeclaratorBody::Brack does INoPointerAbstractPackDeclaratorBody {
    #TODO
}

our class NoPointerAbstractPackDeclarator { 
    #TODO
}

our class ParameterDeclarationClause { 
    #TODO
}

our class ParameterDeclarationList { 
    #TODO
}

#-----------------------
our role IParameterDeclarationBody { }

our class ParameterDeclarationBody::Decl does IParameterDeclarationBody {
    has Declarator $.declarator is required;
}

our class ParameterDeclarationBody::Abst does IParameterDeclarationBody {
    has AbstractDeclarator $.abstract-declarator;
}

our class ParameterDeclaration { 
    #TODO
}

our class FunctionDefinition { 
    #TODO
}

#-----------------------
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
    has Default $.default is required;
    has Semi $.semi is required;
}

our class FunctionBody::AssignDelete does IFunctionBody {
    #TODO
}

#-----------------------
our role IInitializer { }

our class Initializer::BraceOrEq does IInitializer {
    has BraceOrEqualInitializer $.brace-or-equal-initializer is required;
}

our class Initializer::ParenExprList does IInitializer {
    #TODO
}

#-----------------------
our role IBraceOrEqualInitializer { }

our class BraceOrEqualInitializer::AssignInit does IBraceOrEqualInitializer {
    has Assign $.assign is required;
    has InitializerClause $.initializer-clause is required;
}

our class BraceOrEqualInitializer::BracedInitList does IBraceOrEqualInitializer {
    #TODO
}

#-----------------------
our role IInitializerClause { }

our class InitializerClause::Assignment does IInitializerClause {
    has Comment $.comment;
    has AssignmentExpression $.assignment-expression is required;
}

our class InitializerClause::Braced does IInitializerClause {
    #TODO
}

our class InitializerList { 
    #TODO
}

our class BracedInitList { 
    #TODO
}

#-----------------------
our role IClassName { }

our class ClassName::Id does IClassName {
    has Identifier $.identifier is required;
}

our class ClassName::TemplateId does IClassName {
    has SimpleTemplateId $.simple-template-id is required;
}

our class ClassSpecifier { 
    #TODO
}

#-----------------------
our role IClassHead { }

our class ClassHead::Class does IClassHead {
    #TODO
}

our class ClassHead::Union does IClassHead {
    #TODO
}

our class ClassHeadName { 
    #TODO
}

our class ClassVirtSpecifier { 
    #TODO
}

#-----------------------
our role IClassKey { }

our class ClassKey::Class does IClassKey {
    has Class $.class is required;
}

our class ClassKey::Struct does IClassKey {
    #TODO
}

#-----------------------
our role IMemberSpecificationBase { }

our class MemberSpecificationBase::Decl does IMemberSpecificationBase {
    has Memberdeclaration $.memberdeclaration is required;
}

our class MemberSpecificationBase::Access does IMemberSpecificationBase {
    has AccessSpecifier $.access-specifier is required;
    has Colon $.colon is required;
}

our class MemberSpecification { 
    #TODO
}

#-----------------------
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
    #TODO
}

our class MemberDeclaratorList { 
    #TODO
}

#-----------------------
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
    #TODO
}

our class VirtualSpecifierSeq { 
    #TODO
}

#-----------------------
our role IVirtualSpecifier { }

our class VirtualSpecifier::Override does IVirtualSpecifier {
    has Override $.override is required;
}

our class VirtualSpecifier::Final does IVirtualSpecifier {
    #TODO
}

our class PureSpecifier { 
    #TODO
}

our class BaseClause { 
    #TODO
}

our class BaseSpecifierList { 
    #TODO
}

#-----------------------
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
    #TODO
}

#-----------------------
our role IClassOrDeclType { }

our class ClassOrDeclType::Class does IClassOrDeclType {
    has NestedNameSpecifier $.nested-name-specifier;
    has ClassName $.class-name is required;
}

our class ClassOrDeclType::Decltype does IClassOrDeclType {
    #TODO
}

our class BaseTypeSpecifier { 
    #TODO
}

#-----------------------
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
    #TODO
}

our class ConversionTypeId { 
    #TODO
}

our class ConversionDeclarator { 
    #TODO
}

our class ConstructorInitializer { 
    #TODO
}

our class MemInitializerList { 
    #TODO
}

#-----------------------
our role IMemInitializer { }

our class MemInitializer::ExprList does IMemInitializer {
    has Meminitializerid $.meminitializerid is required;
    has ExpressionList $.expression-list;
}

our class MemInitializer::Braced does IMemInitializer {
    #TODO
}

#-----------------------
our role IMeminitializerid { }

our class Meminitializerid::ClassOrDecl does IMeminitializerid {
    has ClassOrDeclType $.class-or-decl-type is required;
}

our class Meminitializerid::Ident does IMeminitializerid {
    has Identifier $.identifier is required;
}

our class OperatorFunctionId { 
    #TODO
}

#-----------------------
our role ILiteralOperatorId { }

our class LiteralOperatorId::StringLit does ILiteralOperatorId {
    has Operator $.operator is required;
    has StringLiteral $.string-literal is required;
    has Identifier $.identifier is required;
}

our class LiteralOperatorId::UserDefined does ILiteralOperatorId {
    #TODO
}

our class TemplateDeclaration { 
    #TODO
}

our class TemplateparameterList { 
    #TODO
}

#-----------------------
our role ITemplateParameter { }

our class TemplateParameter::Type does ITemplateParameter {
    has TypeParameter $.type-parameter is required;
}

our class TemplateParameter::Param does ITemplateParameter {
    #TODO
}

#-----------------------
our role ITypeParameterBase { }

our class TypeParameterBase::Basic does ITypeParameterBase {
    #TODO
}

our class TypeParameterBase::Typename does ITypeParameterBase {
    #TODO
}

#-----------------------
our role ITypeParameterSuffix { }

our class TypeParameterSuffix::MaybeIdent does ITypeParameterSuffix {
    has Ellipsis $.ellipsis;
    has Identifier $.identifier;
}

our class TypeParameterSuffix::AssignTypeId does ITypeParameterSuffix {
    #TODO
}

our class TypeParameter { 
    #TODO
}

our class SimpleTemplateId { 
    #TODO
}

#-----------------------
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
    #TODO
}

our class TemplateName { 
    #TODO
}

our class TemplateArgumentList { 
    #TODO
}

#-----------------------
our role ITemplateArgument { }

our class TemplateArgument::TypeId does ITemplateArgument {
    has TheTypeId $.the-type-id is required;
}

our class TemplateArgument::ConstExpr does ITemplateArgument {
    has ConstantExpression $.constant-expression is required;
}

our class TemplateArgument::IdExpr does ITemplateArgument {
    #TODO
}

#-----------------------
our role ITypeNameSpecifier { }

our class TypeNameSpecifier::Ident does ITypeNameSpecifier {
    has Typename $.typename is required;
    has NestedNameSpecifier $.nested-name-specifier is required;
    has Identifier $.identifier is required;
}

our class TypeNameSpecifier::Template does ITypeNameSpecifier {
    #TODO
}

our class ExplicitInstantiation { 
    #TODO
}

our class ExplicitSpecialization { 
    #TODO
}

our class TryBlock { 
    #TODO
}

our class FunctionTryBlock { 
    #TODO
}

our class HandlerSeq { 
    #TODO
}

our class Handler { 
    #TODO
}

#-----------------------
our role ISomeDeclarator { }

our class SomeDeclarator::Basic does ISomeDeclarator {
    has Declarator $.declarator is required;
}

our class SomeDeclarator::Abstract does ISomeDeclarator {
    #TODO
}

#-----------------------
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
    #TODO
}

#-----------------------
our role IExceptionSpecification { }

our class ExceptionSpecification::Dynamic does IExceptionSpecification {
    has DynamicExceptionSpecification $.dynamic-exception-specification is required;
}

our class ExceptionSpecification::Noexcept does IExceptionSpecification {
    #TODO
}

our class DynamicExceptionSpecification { 
    #TODO
}

our class TypeIdList { 
    #TODO
}

#-----------------------
our role INoeExceptSpecification { }

our class NoeExceptSpecification::Full does INoeExceptSpecification {
    has Noexcept $.noexcept is required;
    has ConstantExpression $.constant-expression is required;
}

our class NoeExceptSpecification::KeywordOnly does INoeExceptSpecification {
    #TODO
}

#-----------------------
our role ITheOperator { }

our class TheOperator::New does ITheOperator {
    #TODO
}

our class TheOperator::Delete does ITheOperator {
    #TODO
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
    has Div $.div is required;
}

our class TheOperator::Mod does ITheOperator {
    has Mod $.mod is required;
}

our class TheOperator::Caret does ITheOperator {
    has Caret $.caret is required;
}

our class TheOperator::And does ITheOperator {
    #TODO
}

our class TheOperator::Or does ITheOperator {
    has Or $.or is required;
}

our class TheOperator::Tilde does ITheOperator {
    has Tilde $.tilde is required;
}

our class TheOperator::Not does ITheOperator {
    has Not $.not is required;
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

#-----------------------
our role ILiteral { }

our class Literal::Int does ILiteral {
    has IntegerLiteral $.integer-literal is required;
}

our class Literal::Char does ILiteral {
    has CharacterLiteral $.character-literal is required;
}

our class Literal::Float does ILiteral {
    #TODO
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

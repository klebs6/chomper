our class ArrayExpression {
    has $.maybe-array-elements;
}

our class ArrayElementsItemQuantity {
    has $.expression;
    has $.quantifier;
}

our class ArrayElementsList {
    has @.expressions;
}

our class TupleExpression {
    has $.maybe-tuple-elements;
}

our class TupleElements {
    has @.expressions;
}

our class TupleIndex {
    has Int $.value;
}

our class Ascii {
    has Str $.value;
}

our class AssociatedItem {
    has $.maybe-comment;
    has @.outer-attributes;
    has $.variant;
}

our class AssociatedItemMacro {
    has $.macro-invocation;
}

our class AssociatedItemTypeAlias {
    has $.visibility
    has $.type-alias;
}

our class AssociatedItemConstantItem {
    has $.visibility
    has $.constant-item;
}

our class AssociatedItemFunction {
    has $.visibility
    has $.function;
}

our class BlockExpression {
    has @.inner-attributes;
    has $.statements;
}

our class AsyncBlockExpression {
    has Bool $.mode;
    has $.block-expression;
}

our class UnsafeBlockExpression {
    has $.block-expression;
}

our class BooleanLiteral {
    has Bool $.value;
}

our class ByteLiteral {
    has $.value;
}

our class ByteStringLiteral {
    has $.value;
}

our class CfgAttribute {
    has $.configuration-predicate
}

our class CfgAttrAttribute {
    has $.configuration-predicate
    has $.cfg-attrs
}

our class CfgAttrs {
    has @.attrs;
}

our class InnerAttribute {
    has $.attr;
}

our class OuterAttribute {
    has $.attr;
}

our class Attr {
    has $.simple-path;
    has $.attr-input;
}

our class AttrInputTokenTree {
    has $.delim-token-tree;
}

our class AttrInputEqExpr {
    has $.expr;
}

our class CharLiteral {
    has $.value;
}

our class ClosureExpression {
    has Bool $.move;
    has $.maybe-parameters;
    has $.body;
}

our class ClosureBody {
    has $.expression;
}

our class ClosureBodyWithReturnTypeAndBlock {
    has $.return-type;
    has $.block-expression;
}

our class ClosureParameters {
    has @.closure-params;
}

our class ClosureParam {
    has @.outer-attributes;
    has $.pattern;
    has $.maybe-type;
}

our class Comment {
    has $.text;
}

our class ConfigurationPredicateOption {
    has $.identifier;
    has $.maybe-str-literal;
}

our class ConfigurationPredicateAll {
    has @.predicates;
}

our class ConfigurationPredicateAny {
    has @.predicates;
}

our class ConfigurationPredicateNot {
    has $.predicate;
}

our class Crate {
    has @.inner-attributes;
    has @.crate-items;
}

our class AsClause {
    has $.identifier-or-underscore;
}

our class ExternCrate {
    has $.crate-ref;
    has $.maybe-as-clause;
}

our class CrateRefIdent {
    has $.identifier;
}

our class CrateRefSelf { }

our class ModuleSemi {
    has Bool $.unsafe;
    has $.identifier;
}

our class ModuleBlock {
    has Bool $.unsafe;
    has $.identifier;
    has @.inner-attributes;
    has @.crate-items;
}

our class Enumeration {
    has $.identifier;
    has $.maybe-generic-params;
    has $.maybe-where-clause;
    has @.maybe-enum-items;
}

our class EnumItem {
    has @.outer-attributes;
    has @.maybe-visibility;
    has $.identifier;
    has $.maybe-enum-variant;
}

our class EnumVariantTuple {
    has @.maybe-tuple-fields;
}

our class EnumVariantStruct {
    has @.maybe-struct-fields;
}

our class EnumVariantDiscriminant {
    has $.eq-expression;
}

our class BaseExpression {
    has @.outer-attributes;
    has $.expression-item;
}

our class MethodCallExpressionSuffix {
    has $.path-expr-segment;
    has @.maybe-call-params;
}

our class IndexExpressionSuffix {
    has $.expression;
}

our class FieldExpressionSuffix {
    has $.identifier;
}

our class CallExpressionSuffix {
    has @.maybe-call-params;
}

our class AwaitExpressionSuffix { }

our class TupleIndexExpressionSuffix {
    has $.tuple-index;
}

our class ErrorPropagationExpressionSuffix { }

our class SuffixedExpression {
    has $.base-expression;
    has @.suffixed-expression-suffix;
}

our class UnaryPrefixBang  { }
our class UnaryPrefixMinus { }
our class UnaryPrefixStar  { }

our class UnaryExpression {
    has @.unary-prefixes;
    has $.suffixed-expression;
}

our class BorrowExpressionPrefix {
    has Int $.borrow-count;
    has Bool $.mutable;
}

our class BorrowExpression {
    has @.borrow-expression-prefixes;
    has $.unary-expression;
}

our class CastExpression {
    has $.borrow-expression;
    has @.cast-targets;
}

our class CastTarget {
    has $.type-no-bounds;
}

our class ModuloExpression {
    has @.cast-expressions;
}

our class DivisionExpression {
    has @.modulo-expressions;
}

our class MultiplicativeExpression {
    has @.division-expressions;
}

our class SubtractiveExpression {
    has @.multiplicative-expressions;
}

our class AdditiveExpression {
    has @.subtractive-expressions;
}

our class BinaryShrExpression {
    has @.additive-expressions;
}

our class BinaryShlExpression {
    has @.binary-shr-expressions;
}

our class BinaryAndExpression {
    has @.binary-shl-expressions;
}

our class BinaryXorExpression {
    has @.binary-and-expressions;
}

our class BinaryOrExpression {
    has @.binary-xor-expressions;
}

our class BinaryLeExpression {
    has @.binary-or-expressions;
}

our class BinaryGeExpression {
    has @.binary-le-expressions;
}

our class BinaryLtExpression {
    has @.binary-ge-expressions;
}

our class BinaryGtExpression {
    has @.binary-lt-expressions;
}

our class BinaryNeExpression {
    has @.binary-gt-expressions;
}

our class BinaryEqEqExpression {
    has @.binary-ne-expression;
}

our class BinaryAndAndExpression {
    has @.binary-eqeq-expressions;
}

our class BinaryOrOrExpression {
    has @.binary-andand-expressions;
}

our class RangeExpressionFullEq {
    has @.binary-oror-expressions;
}

our class RangeExpressionFull {
    has @.binary-oror-expressions;
}

our class RangeExpressionTo {
    has $.binary-oror-expression;
}

our class RangeExpressionToEq {
    has $.binary-oror-expression;
}

our class RangeExpressionFrom {
    has $.binary-oror-expression;
}

our class RangeExpressionOpen {

}

our class ShreqExpression {
    has @.range-expressions;
}

our class ShleqExpression {
    has @.shreq-expressions;
}

our class XoreqExpression {
    has @.shleq-expressions;
}

our class OreqExpression {
    has @.xoreq-expressions;
}

our class AndeqExpression {
    has @.oreq-expressions;
}

our class ModeqExpression {
    has @.andeq-expressions;
}

our class SlasheqExpression {
    has @.modeq-expressions;
}

our class StareqExpression {
    has @.slasheq-expressions;
}

our class MinuseqExpression {
    has @.stareq-expressions;
}

our class AddeqExpression {
    has @.minuseq-expressions;
}

our class AssignExpression {
    has @.addeq-expressions;
}

our class Expression {
    has $.assign-expression;
}

our class GroupedExpression {
    has $.expression;
}

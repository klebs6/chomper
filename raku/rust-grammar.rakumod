use grust-array-expression;
use grust-ascii;
use grust-assoc-items;
use grust-comment;
use grust-block-expressions;
use grust-boolean-literal;
use grust-byte-literal;
use grust-byte-string-literal;
use grust-cfg-attr;
use grust-char-literal;
use grust-closure-expressions;
use grust-configuration;
use grust-crate;
use grust-delimiters;
use grust-enumerations;
use grust-expressions;
use grust-external-blocks;
use grust-float-literal;
use grust-function-pointer-types;
use grust-functions;
use grust-generic-args;
use grust-generic-parameters;
use grust-identifiers;
use grust-if-expressions;
use grust-impl-trait;
use grust-int-literal;
use grust-item;
use grust-jump-expressions;
use grust-lifetimes;
use grust-literal-pattern;
use grust-literal;
use grust-loop-expression;
use grust-macros;
use grust-match-expressions;
use grust-meta-item;
use grust-path-expressions;
use grust-paths;
use grust-pattern-expressions;
use grust-punctuation;
use grust-range-patterns;
use grust-reference-patterns;
use grust-reserved-keywords;
use grust-statements;
use grust-strict-keywords;
use grust-string-literal;
use grust-struct-expressions;
use grust-struct-patterns;
use grust-structs;
use grust-tokens;
use grust-trait-and-lifetime;
use grust-trait-objects;
use grust-traits;
use grust-tuple-struct-patterns;
use grust-type-alias;
use grust-type-path;
use grust-types;
use grust-unions;
use grust-use-declaration;
use grust-visibility;
use grust-weak-keywords;
use grust-where-clause;
use grust-whitespace;
use grust-xid;

our role Rust::Grammar::Role
does ArrayExpression::Rules 
does AssociatedItem::Rules 
does BareFunctionType::Rules 
does Comment::Rules 
does LineComment::Rules 
does BlockComment::Rules 
does DocComment::Rules 
does BlockExpression::Rules 
does CfgAttr::Rules 
does ClosureExpression::Rules 
does ConfigurationPredicate::Rules 
does Crate::Rules 
does Enumeration::Rules 
does Expression::Rules 
does ExternBlock::Rules 
does Function::Rules 
does GenericArgs::Rules 
does GenericParams::Rules 
does Identifiers::Rules 
does IfExpressions::Rules 
does ImplTraitType::Rules 
does Item::Rules 
does JumpExpression::Rules 
does Lifetimes::Rules 
does LiteralExpression::Rules 
does LiteralPattern::Rules 
does LoopExpression::Rules 
does MacroInvocation::Rules 
does MatchExpression::Rules 
does MetaItem::Rules 
does PathExpression::Rules 
does Pattern::Rules 
does Punctuation::Rules 
does RangePattern::Rules 
does ReferencePattern::Rules 
does ReservedKeywords::Rules 
does SimplePath::Rules 
does Statement::Rules 
does StrictKeywords::Rules 
does Struct::Rules 
does StructExpression::Rules 
does StructPattern::Rules 
does Tokens::Rules 
does Trait::Rules 
does TraitObjectType::Rules 
does TupleExpression::Rules 
does TupleStructPattern::Rules 
does Type::Rules 
does TypeAlias::Rules 
does TypeBounds::Rules 
does TypePath::Rules 
does Union::Rules 
does UseDeclaration::Rules 
does Visibility::Rules 
does WeakKeywords::Rules 
does WhereClause::Rules 
does Whitespace::Rules 
does Xid::Rules 
does Ascii::Rules
does BooleanLiteral::Rules
does ByteLiteral::Rules
does ByteStringLiteral::Rules
does CharLiteral::Rules
does Delimiters::Rules
does FloatLiteral::Rules
does IntLiteral::Rules
does StringLiteral::Rules
{
    rule TOP {
        <.ws> 
        <statement>+
    }
}

our role Rust::Actions::Role
    does ArrayExpression::Actions 
    does AssociatedItem::Actions 
    does BareFunctionType::Actions 
    does Comment::Actions 
    does BlockExpression::Actions 
    does CfgAttr::Actions 
    does ClosureExpression::Actions 
    does ConfigurationPredicate::Actions 
    does Crate::Actions 
    does Enumeration::Actions 
    does Expression::Actions 
    does ExternBlock::Actions 
    does Function::Actions 
    does GenericArgs::Actions 
    does GenericParams::Actions 
    does Identifiers::Actions 
    does IfExpressions::Actions 
    does ImplTraitType::Actions 
    does Item::Actions 
    does Lifetimes::Actions 
    does LiteralExpression::Actions 
    does LiteralPattern::Actions 
    does LoopExpression::Actions 
    does MacroInvocation::Actions 
    does MatchExpression::Actions 
    does MetaItem::Actions 
    does PathExpression::Actions 
    does Pattern::Actions 
    does Punctuation::Actions 
    does RangePattern::Actions 
    does ReferencePattern::Actions 
    does ReservedKeywords::Actions 
    does JumpExpression::Actions 
    does SimplePath::Actions 
    does Statement::Actions 
    does StrictKeywords::Actions 
    does Struct::Actions 
    does StructExpression::Actions 
    does StructPattern::Actions 
    does Tokens::Actions 
    does Trait::Actions 
    does TraitObjectType::Actions 
    does TupleExpression::Actions 
    does TupleStructPattern::Actions 
    does Type::Actions 
    does TypeAlias::Actions 
    does TypeBounds::Actions 
    does TypePath::Actions 
    does Union::Actions 
    does UseDeclaration::Actions 
    does Visibility::Actions 
    does WeakKeywords::Actions 
    does WhereClause::Actions {}

our grammar Rust::Grammar does Rust::Grammar::Role {}
our class Rust::Actions does Rust::Actions::Role {}

use Grammar::Tracer;
our grammar Rust::GrammarD does Rust::Grammar::Role {}

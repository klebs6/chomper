our class ForLifetimes {
    has $.lifetimes;
}

our class TypeWithDefault {
    has $.ty;
    has $.default;
}

our class Expr {
    has @.prefix;
    has $.base;
    has @.tail;
}

our class NonBlockExpr {
    has $.comment;
    has $.base;
    has @.tail;
}

our class As {
    has $.ident;
}

our class Label {
    has $.value;
}

our class ExprAgain {
    has $.lifetime;
    has $.ident;
}

our class ExprAssignMul {
    has $.nonblock-expr;
    has $.expr;
    has $.expr-nostruct;
}

our class ExprAssignSub {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
}

our class ExprBinary {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
}

our class ExprBreak {
    has $.ident;
    has $.lifetime;
}

our class ExprCall {
    has $.block-expr;
    has $.block-expr-dot;
    has $.expr;
    has $.expr-nostruct;
    has $.maybe-exprs;
    has $.nonblock-expr;
    has $.path-generic-args-with-colons;
}

our class ExprLit {
    has $.lit;
}

our class AnonParam {
    has $.named-arg;
    has $.ty;
}

our class AnonParams {
    has Bool $.variadic-tail;
    has @.anon-params;
}

our class AsTraitRef {
    has $.trait-ref;
}

our class AttrsAndVis {
    has $.maybe-outer-attrs;
    has $.visibility;
}

our class BindByRef {
    has Bool $.mut;
}

our class BindByValue {
    has Bool $.mut;
}

our class Binding {
    has $.ty;
    has $.ident;
}

our class Macro {
    has $.braces-delimited-token-trees;
    has $.path-expr;
    has $.maybe-ident;
}

our class UnsafeBlock {
    has $.block;
}

our class BlockExprDotTail {
    has $.path-generic-args-with-colons;
    has @.maybe-exprs;
    has $.lit-integer;
}

our class BlockExprDot {
    has @.block-exprs;
    has $.block-expr-dot-tail;
}

our class ItemForeignMod {
    has $.inner-attrs;
    has $.item-foreign-mod;
    has $.maybe-foreign-items;
}

our class ExprBlock {
    has $.maybe-stmts;
    has $.maybe-inner-attrs;
    has $.comment;
}

our class Bounds {
    has $.bound;
}

our class ConstDefault {
    has $.expr;
}

our class Crate {
    has $.maybe-mod-items;
    has $.inner-attrs;
}

our class ExprForLoop {
    has $.expr-nostruct;
    has $.block;
    has $.pat;
    has $.maybe-label;
}

our class ExprIfLet {
    has $.expr-nostruct;
    has $.block;
    has $.pat;
    has $.block-or-if;
}

our class ExprIf {
    has $.block-or-if;
    has $.block;
    has $.expr-nostruct;
}

our class ExprLoop {
    has $.block;
    has $.maybe-label;
}

our class ExprAssignShr {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
}

our class ExprCast {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
    has $.ty;
}

our class ExprQualifiedPath {
    has $.ty-sum;
    has $.maybe-as-trait-ref0;

    has $.identA;
    has $.generic-argsA;
    has $.maybe-as-trait-ref1;

    has $.identB;
    has $.generic-argsB;

    has $.maybe-qpath-params;
}

our class ExprWhileLet {
    has $.expr-nostruct;
    has $.pat;
    has $.block;
    has $.maybe-label;
}

our class ExprWhile {
    has $.expr-nostruct;
    has $.block;
    has $.maybe-label;
}

our class Exprs {
    has $.expr;
}

our class ViewItemExternFn {
    has $.item-fn;
    has $.maybe-abi;
}

our class FnDecl {
    has $.fn-anon-params-with-self;
    has $.fn-params;
    has $.fn-params-allow-variadic;
    has $.fn-params-with-self;
    has $.ret-ty;
}

our class SelfLower {
    has $.maybe-ty-ascription;
    has $.maybe-comma-anon-params;
    has $.maybe-comma-params;
    has $.maybe-mut;
}

our class SelfRegion {
    has $.maybe-comma-anon-params;
    has $.maybe-comma-params;
    has $.lifetime;
    has $.maybe-mut;
    has $.maybe-ty-ascription;
}

our class SelfStatic {
    has $.maybe-params;
    has $.maybe-anon-params;
}

our class ForInType {
    has $.for-in-type-suffix;
    has $.maybe-lifetimes;
}

our class ForSized {
    has $.ident;
}

our class ForeignFn {
    has $.maybe-where-clause;
    has $.fn-decl-allow-variadic;
    has $.ident;
    has $.generic-params;
}

our class ForeignItem {
    has $.item-foreign-fn;
    has $.attrs-and-vis;
    has $.item-foreign-static;
}

our class ForeignItemStatic {
    has $.attrs-and-vis;
    has $.item-foreign-static;
}

our class ForeignItemUnsafe {
    has $.item-foreign-fn;
    has $.attrs-and-vis;
}

our class ForeignItems {
    has $.foreign-items;
}

our class Guard {
    has $.expr-nostruct;
}

our class StaticItem {
    has $.maybe-mut;
    has $.ident;
    has $.ty;
}

our class GenericValues {
    has $.maybe-bindings;
    has $.maybe-ty-sums-and-or-bindings;
}

our class Generics {
    has $.ty-params;
    has $.lifetimes;
}

our class IdentsOrSelf {
    has $.idents-or-self;
    has $.ident-or-self;
    has $.ident;
}

our class ImplConst {
    has $.maybe-default;
    has $.attrs-and-vis;
    has $.item-const;
}

our class ImplType {
    has $.generic-params;
    has $.attrs-and-vis;
    has $.ty-sum;
    has $.ident;
    has $.maybe-default;
}

our class InferrableParam {
    has $.pat;
    has $.maybe-ty-ascription;
}

our class InferrableParams {
    has $.inferrable-param;
}

our class InnerAttr {
    has $.meta-item;
}

our class InnerAttrs {
    has $.inner-attr;
}

our class ItemConst {
    has $.ty;
    has $.ident;
    has $.expr;
}

our class EnumArgs {
    has $.struct-decl-fields;
    has $.maybe-ty-sums;
    has $.expr;
}

our class EnumDef {
    has $.attrs-and-vis;
    has $.enum-args;
    has $.ident;
}

our class EnumDefs {
    has $.enum-def;
}

our class Fn {
    has $.fn-decl;
    has $.inner-attrs-and-block;
    has $.ident;
    has $.generic-params;
    has $.maybe-where-clause;
}

our class UnsafeFn {
    has $.maybe-abi;
    has $.generic-params;
    has $.fn-decl;
    has $.ident;
    has $.maybe-where-clause;
    has $.inner-attrs-and-block;
}

#------------------------------
# There are two forms of impl:
#
# impl (<...>)? TY { ... }
# impl (<...>)? TRAIT for TY { ... }
#
# Unfortunately since TY can begin with '<' itself
# -- as part of a TyQualifiedPath type -- there's
# an s/r conflict when we see '<' after IMPL:
#
# should we reduce one of the early rules of TY
# (such as maybe-once) or shall we continue
# shifting into the generic-params list for the
# impl?
#
# The production parser disambiguates a different
# case here by permitting / requiring the user to
# provide parens around types when they are
# ambiguous with traits. We do the same here,
# regrettably, by splitting ty into ty and
# ty-prim.
our class ImplItems {
    has $.impl-items;
    has $.comment;
}

our class InitExpr {
    has $.expr;
}

our class ImplItem {
    has $.value;
    has $.comment;
}

our class ImplMacroItem {
    has $.item-macro;
    has $.attrs-and-vis;
}

our class ItemImpl {
    has $.trait-ref;
    has $.ty-prim-sum;
    has $.maybe-default-maybe-unsafe;
    has $.maybe-where-clause;
    has $.ty;
    has $.maybe-impl-items;
    has $.ty-sum;
    has $.generic-params;
    has $.maybe-inner-attrs;
}

our class ItemImplDefault {
    has $.maybe-default-maybe-unsafe;
    has $.generic-params;
    has $.trait-ref;
}

our class ItemImplDefaultNeg {
    has $.trait-ref;
    has $.maybe-default-maybe-unsafe;
    has $.generic-params;
}

our class ItemImplNeg {
    has $.maybe-default-maybe-unsafe;
    has $.maybe-inner-attrs;
    has $.trait-ref;
    has $.maybe-impl-items;
    has $.maybe-where-clause;
    has $.ty-sum;
    has $.generic-params;
}

our class ItemMacro {
    has $.braces-delimited-token-trees;
    has $.parens-delimited-token-trees;
    has $.maybe-ident;
    has $.path-expr;
    has $.brackets-delimited-token-trees;
}

our class ItemMod {
    has $.ident;
    has $.maybe-mod-items;
    has $.inner-attrs;
}

our class ItemStatic {
    has Bool $.mut;
    has $.ty;
    has $.expr;
    has $.ident;
}

our class ItemStruct {
    has $.struct-tuple-args;
    has $.struct-decl-args;
    has $.maybe-where-clause;
    has $.ident;
    has $.generic-params;
}

our class StructField {
    has $.comment;
    has $.attrs-and-vis;
    has $.ty-sum;
    has $.ident;
}

our class StructFields {
    has $.struct-decl-field;
    has $.struct-tuple-field;
}

our class ItemTrait {
    has $.maybe-where-clause;
    has $.maybe-unsafe;
    has $.generic-params;
    has $.for-sized;
    has $.maybe-ty-param-bounds;
    has $.maybe-trait-items;
    has $.ident;
}

our class ItemTraitAlias {
    has Bool $.unsafe;
    has $.ident;
    has $.ty-sum;
}

our class TraitItems {
    has $.trait-item;
}

our class TraitItem {
    has $.value;
    has $.comment;
}

our class MatchClause {
    has $.clause;
    has $.comment;
}

our class TraitMacroItem {
    has $.maybe-outer-attrs;
    has $.item-macro;
}

our class ItemTy {
    has $.generic-params;
    has $.maybe-where-clause;
    has $.ty-sum;
    has $.ident;
}

our class ExprFnBlock {
    has $.ret-ty;
    has $.expr;
    has $.inferrable-params;
    has $.lambda-expr-nostruct-no-first-bar;
    has $.lambda-expr-no-first-bar;
    has $.expr-nostruct;
}

our class DeclLocal {
    has $.pat;
    has $.maybe-init-expr;
    has $.maybe-ty-ascription;
}

our class Lifetimes {
    has $.lifetime-and-bounds;
}

our class Lifetime {
    has $.maybe-ltbounds;
}

our class StaticLifetime { }

our class PatLit {
    has $.lit;
    has $.path-expr;
}

our class Ltbounds {
    has $.lifetime;
}

#-------------------------------------
# the braces-delimited macro is a block-expr so it
# doesn't appear here
our class MacroExpr {
    has $.path-expr;
    has $.parens-delimited-token-trees;
    has $.maybe-ident;
    has $.brackets-delimited-token-trees;
}

our class ArmBlock {
    has $.block-expr;
    has $.block;
    has $.pats-or;
    has $.maybe-guard;
    has $.maybe-outer-attrs;
}

our class ArmNonblock {
    has $.nonblock-expr;
    has $.maybe-outer-attrs;
    has $.block-expr-dot;
    has $.maybe-guard;
    has $.pats-or;
}

our class Arms {
    has $.match-clause;
}

our class ExprMatch {
    has $.match-clauses;
    has $.nonblock-match-clause;
    has $.expr-nostruct;
}

our class MetaList {
    has $.ident;
    has $.meta-seq;
}

our class MetaNameValue {
    has $.lit;
    has $.ident;
}

our class MetaWord {
    has $.ident;
}

our class MetaItems {
    has $.meta-item;
}

our class Method {
    has $.ident;
    has $.fn-decl-with-self;
    has $.maybe-outer-attrs;
    has $.maybe-abi;
    has $.generic-params;
    has $.maybe-where-clause;
    has $.attrs-and-vis;
    has $.fn-decl-with-self-allow-anon-params;
    has $.maybe-unsafe;
    has $.maybe-default;
    has $.inner-attrs-and-block;
}

our class Provided {
    has $.method;
}

our class Required {
    has $.type-method;
}

our class TypeMethod {
    has $.fn-decl-with-self-allow-anon-params;
    has $.maybe-abi;
    has $.maybe-outer-attrs;
    has $.maybe-where-clause;
    has $.generic-params;
    has $.maybe-unsafe;
    has $.ident;
}

our class Items {
    has $.mod-item;
}

our class Item {
    has $.item;
    has $.attrs-and-vis;
}

our class ExprAssign {
    has $.expr;
    has $.nonblock-expr;
    has $.expr-nostruct;
}

our class ExprAssignAdd {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
}

our class ExprAssignBitAnd {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
}

our class ExprAssignBitOr {
    has $.nonblock-expr;
    has $.expr;
    has $.expr-nostruct;
}

our class ExprAssignBitXor {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
}

our class ExprAssignDiv {
    has $.expr;
    has $.nonblock-expr;
    has $.expr-nostruct;
}

our class ExprAssignRem {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
}

our class ExprAssignShl {
    has $.nonblock-expr;
    has $.expr;
    has $.expr-nostruct;
}

our class ExprBox {
    has $.expr;
}

our class ExprField {
    has $.block-expr;
    has $.block-expr-dot;
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
    has $.path-generic-args-with-colons;
}

our class ExprIndex {
    has $.block-expr;
    has $.block-expr-dot;
    has $.expr;
    has $.expr-nostruct;
    has $.maybe-expr;
    has $.nonblock-expr;
    has $.path-generic-args-with-colons;
}

our class ExprMac {
    has $.macro-expr;
}

our class ExprParen {
    has $.maybe-exprs;
}

our class ExprPath {
    has $.path-expr;
}

our class ExprRange {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
}

our class ExprRet {
    has $.expr;
}

our class ExprStruct {
    has $.path-expr;
    has $.struct-expr-fields;
}

our class ExprTry {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
}

our class ExprTupleIndex {
    has $.block-expr;
    has $.block-expr-dot;
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
    has $.lit-int;
}

our class ExprTypeAscr {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
    has $.ty;
}

our class ExprVec {
    has $.vec-expr;
}

our class ExprYield {
    has $.expr;
}

our class ExprAddrOf {
    has $.expr-nostruct;
    has $.maybe-mut;
    has $.expr;
}

our class ExprUnary {
    has $.expr;
    has $.expr-nostruct;
}

our class OuterAttrs {
    has $.outer-attr;
}

our class Arg {
    has $.ty-sum;
    has $.pat;
}

our class Args {
    has $.param;
}

our class PatField {
    has $.ident;
    has $.pat;
    has $.binding-mode;
}

our class PatFields {
    has $.items;
}

our class PatTupElts {
    has $.pat;
}

our class PatVecElts {
    has $.pat;
}

our class PatEnum {
    has $.path-expr;
    has $.pat-tup;
}

our class Ident {
    has $.value;
}

our class PatIdent {
    has $.pat;
    has $.ident;
    has $.binding-mode;
}

our class PatMac {
    has $.maybe-ident;
    has $.path-expr;
    has $.delimited-token-trees;
}

our class PatQualifiedPath {
    has $.maybe-as-trait-ref;
    has $.ident;
    has $.ty-sum;
}

our class PatRange {
    has $.lit-or-pathA;
    has $.lit-or-pathB;
}

our class PatRegion {
    has $.pat;
}

our class PatStruct {
    has $.pat-fields;
    has $.pat-struct;
    has $.path-expr;
}

our class PatTup {
    has $.pat-tup;
    has $.pat-tup-elts;
}

our class PatUniq {
    has $.pat;
}

our class PatUnit { }

our class PatVec {
    has $.pat-vec;
    has $.pat-vec-elts;
}

our class Pats {
    has $.pat;
}

our class SelfPath {
    has $.path-generic-args-with-colons;
}

#--------------------------
# A path with no type parameters;
# e.g. `foo::bar::Baz`
#
# These show up in 'use' view-items, because these
# are processed without respect to types.
our class ViewPath {
    has $.base is required;
    has Ident @.tail;
}

#--------------------------
# A path with a lifetime and type parameters, with
# no double colons before the type parameters;
# e.g. `foo::bar<'a>::Baz<t>`
#
# These show up in "trait references", the
# components of type-parameter bounds lists, as
# well as in the prefix of the
# path-generic-args-and-bounds rule, which is the
# full form of a named typed expression.
#
# They do not have (nor need) an extra '::' before
# '<' because unlike in expr context, there are no
# "less-than" type exprs to be ambiguous with.
our class Components {
    has $.maybe-ty-sums;
    has $.generic-args;
    has $.ret-ty;
    has $.ident;
}

our class RetTy {
    has $.ty;
    has $.panic;
}

#---------------------------------
# There are two sub-grammars within a "stmts:
# exprs" derivation depending on whether each
# stmt-expr is a block-expr form; this is to
# handle the "semicolon rule" for stmt sequencing
# that permits writing
#
#     if foo { bar } 10
#
# as a sequence of two stmts (one if-expr stmt,
# one lit-10-expr stmt). Unfortunately by
# permitting juxtaposition of exprs in sequence
# like that, the non-block expr grammar has to
# have a second limited sub-grammar that excludes
# the prefix exprs that are ambiguous with
# binops. That is to say:
#
#     {10} - 1
#
# should parse as (progn (progn 10) (- 1)) not (-
# (progn 10) 1), that is to say, two statements
# rather than one, at least according to the
# mainline rust parser.
#
# So we wind up with a 3-way split in exprs that
# occur in stmt lists: block, nonblock-prefix, and
# nonblock-nonprefix.
#
# In non-stmts contexts, expr can relax this
# trichotomy.
our class Stmts {
    has @.stmts;
    has $.nonblock-expr;
}

our class Self {}

our class Stmt {
    has $.value;
    has $.comment;
}

our class DefaultFieldInit {
    has $.expr;
}

our class FieldInit {
    has $.ident;
    has $.expr;
}

our class FieldInits {
    has $.field-init;
}

our class TTDelim {
    has $.token-trees;
}

our class TTTok {
    has $.unpaired-token;
}

our class ConstTraitItem {
    has $.maybe-ty-ascription;
    has $.maybe-const-default;
    has $.ident;
    has $.maybe-outer-attrs;
}

our class ConstGeneric {
    has $.name is required;
    has $.ty   is required;
}

our class TyClosure {
    has $.anon-params;
    has $.ret-ty;
    has $.maybe-bounds;
}

our class TyDefault {
    has $.ty-sum;
}

our class TyFnDecl {
    has $.fn-anon-params;
    has $.ret-ty;
    has $.generic-params;
}

our class PolyBound {
    has $.maybe-lifetimes;
    has $.bound;
}

our class TyParam {
    has $.maybe-ty-param-bounds;
    has $.maybe-ty-default;
    has $.ident;
}

our class TyParams {
    has $.ty-param;
}

our class TyBox {
    has $.ty;
}

our class TyFixedLengthVec {
    has $.expr;
    has $.ty;
}

our class TyMacro {
    has $.path-generic-args-without-colons;
    has $.delimited-token-trees;
    has $.maybe-ident;
}

our class TyPath {
    has $.path-generic-args-without-colons;
}

our class TyPtr {
    has $.maybe-mut-or-const;
    has $.ty;
}

our class TyRptr {
    has $.ty;
    has $.maybe-mut;
    has $.lifetime;
}

our class TyTypeof {
    has $.expr;
}

our class TyVec {
    has $.ty;
}

our class TySum {
    has @.ty-sum-elts;
}

our class TySumsAndBindings {
    has $.bindings;
    has $.ty-sums;
}

our class TyQualifiedPath {
    has $.ident;
    has $.maybe-as-trait-ref;
    has $.trait-ref;
    has $.ty-sum;
}

our class TyTup {
    has $.ty-sums;
}

our class TypeTraitItem {
    has $.maybe-outer-attrs;
    has $.ty-param;
}

our class ViewItemUse {
    has $.view-path;
}

our class VecRepeat {
    has $.expr;
    has $.exprs;
}

our class ViewItemExternCrate {
    has $.ident;
}

our class ViewPathGlob {
    has $.path-no-types-allowed;
}

our class ViewPathList {
    has $.idents-or-self;
    has $.path-no-types-allowed;
}

our class ViewPathSimple {
    has $.path-no-types-allowed;
    has $.ident;
}

our class WhereClause {
    has $.where-predicates;
}

our class WherePredicate {
    has $.maybe-for-lifetimes;
    has $.bounds;
    has $.lifetime;
    has $.ty-param-bounds;
    has $.ty;
}

our class WherePredicates {
    has $.where-predicate;
}

our class ItemFn {
    has $.ident;
    has $.generic-params;
    has $.fn-decl;
    has $.maybe-where-clause;
    has $.inner-attrs-and-block;
}

our class ItemUnsafeFn {
    has $.ident;
    has $.generic-params;
    has $.fn-decl;
    has $.maybe-where-clause;
    has $.inner-attrs-and-block;
}

our class LitByte    { has $.val; }
our class LitStr     { has $.val; }
our class LitByteStr { has $.val; }
our class LitChar    { has $.val; }
our class LitInteger { has $.val; }
our class LitFloat   { has $.val; }
our class LitBool    { has $.val; }

our class MutMutable        { }
our class MutImmutable      { }
our class PatWild           { }
our class DocComment        { }
our class Super             { }
our class TyInfer           { }
our class Default           { }
our class DefaultUnsafe     { }
our class Unsafe            { }
our class TyNil             { }
our class ViewPathListEmpty { }
our class Public            { }
our class Inherited         { }

our class StructExprFields {
    has $.maybe-field-inits;
    has $.default-field-init;
}

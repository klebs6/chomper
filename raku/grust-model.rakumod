our class ForLifetimes {
    has $.lifetimes;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TypeWithDefault {
    has $.ty;
    has $.default;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Expr {
    has @.prefix;
    has $.base;
    has @.tail;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprNoStruct {
    has $.base;
    has @.tail;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class NonBlockExpr {
    has $.comment;
    has $.base;
    has @.tail;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class As {
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Label {
    has $.value;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprAgain {
    has $.lifetime;
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprAssignMul {
    has $.nonblock-expr;
    has $.expr;
    has $.expr-nostruct;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprAssignSub {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprBinary {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprBreak {
    has $.ident;
    has $.lifetime;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprCall {
    has $.block-expr;
    has $.block-expr-dot;
    has $.expr;
    has $.expr-nostruct;
    has $.maybe-exprs;
    has $.nonblock-expr;
    has $.path-generic-args-with-colons;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprLit {
    has $.lit;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class AnonParam {
    has $.named-arg;
    has $.ty;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class AnonParams {
    has Bool $.variadic-tail;
    has @.anon-params;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class AsTraitRef {
    has $.trait-ref;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyAscription {
    has $.value;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyBareFn {
    has Bool $.unsafe = False;
    has Bool $.extern = False;
    has $.decl;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TraitRef {
    has $.value;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class AttrsAndVis {
    has $.maybe-outer-attrs;
    has $.visibility;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class BindByRef {
    has Bool $.mut;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class BindByValue {
    has Bool $.mut;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Binding {
    has $.ty;
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Macro {
    has $.braces-delimited-token-trees;
    has $.path-expr;
    has $.maybe-ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class UnsafeBlock {
    has $.block;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class BlockExprDotTail {
    has $.path-generic-args-with-colons;
    has @.maybe-exprs;
    has $.lit-integer;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class BlockExprDot {
    has @.block-exprs;
    has $.block-expr-dot-tail;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemForeignMod {
    has $.inner-attrs;
    has $.item-foreign-mod;
    has $.maybe-foreign-items;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprBlock {
    has $.maybe-stmts;
    has $.maybe-inner-attrs;
    has $.comment;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Bounds {
    has $.bound;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ConstDefault {
    has $.expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Crate {
    has $.maybe-mod-items;
    has $.inner-attrs;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprForLoop {
    has $.expr-nostruct;
    has $.block;
    has $.pat;
    has $.maybe-label;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprIfLet {
    has $.expr-nostruct;
    has $.block;
    has $.pat;
    has $.block-or-if;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprIf {
    has $.block-or-if;
    has $.block;
    has $.expr-nostruct;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprLoop {
    has $.block;
    has $.maybe-label;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprAssignShr {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprCast {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
    has $.ty;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
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

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprWhileLet {
    has $.expr-nostruct;
    has $.pat;
    has $.block;
    has $.maybe-label;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprWhile {
    has $.expr-nostruct;
    has $.block;
    has $.maybe-label;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Exprs {
    has $.expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ViewItemExternFn {
    has $.item-fn;
    has $.maybe-abi;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class FnDecl {
    has $.fn-anon-params-with-self;
    has $.fn-params;
    has $.fn-params-allow-variadic;
    has $.fn-params-with-self;
    has $.ret-ty;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class SelfLower {
    has $.maybe-ty-ascription;
    has $.maybe-comma-anon-params;
    has $.maybe-comma-params;
    has $.maybe-mut;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class SelfRegion {
    has $.maybe-comma-anon-params;
    has $.maybe-comma-params;
    has $.lifetime;
    has $.maybe-mut;
    has $.maybe-ty-ascription;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class SelfStatic {
    has $.maybe-params;
    has $.maybe-anon-params;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ForInType {
    has $.for-in-type-suffix;
    has $.maybe-lifetimes;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ForSized {
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ForeignFn {
    has $.maybe-where-clause;
    has $.fn-decl-allow-variadic;
    has $.ident;
    has $.generic-params;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ForeignItem {
    has $.item-foreign-fn;
    has $.attrs-and-vis;
    has $.item-foreign-static;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ForeignItemStatic {
    has $.attrs-and-vis;
    has $.item-foreign-static;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ForeignItemUnsafe {
    has $.item-foreign-fn;
    has $.attrs-and-vis;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ForeignItems {
    has $.foreign-items;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Guard {
    has $.expr-nostruct;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StaticItem {
    has $.maybe-mut;
    has $.ident;
    has $.ty;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class GenericValues {
    has $.ty-qualified-path;
    has $.maybe-bindings;
    has $.maybe-ty-sums-and-or-bindings;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Generics {
    has $.ty-params;
    has $.lifetimes;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class IdentsOrSelf {
    has $.idents-or-self;
    has $.ident-or-self;
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ImplConst {
    has $.maybe-default;
    has $.attrs-and-vis;
    has $.item-const;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ImplType {
    has $.generic-params;
    has $.attrs-and-vis;
    has $.ty-sum;
    has $.ident;
    has $.maybe-default;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class InferrableParam {
    has $.pat;
    has $.maybe-ty-ascription;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class InferrableParams {
    has $.inferrable-param;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class InnerAttr {
    has $.meta-item;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class InnerAttrs {
    has $.inner-attr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemConst {
    has $.ty;
    has $.ident;
    has $.expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class EnumArgs {
    has $.struct-decl-fields;
    has $.maybe-ty-sums;
    has $.expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class EnumDef {
    has $.attrs-and-vis;
    has $.enum-args;
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class EnumDefs {
    has $.enum-def;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Fn {
    has $.fn-decl;
    has $.inner-attrs-and-block;
    has $.ident;
    has $.generic-params;
    has $.maybe-where-clause;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class UnsafeFn {
    has $.maybe-abi;
    has $.generic-params;
    has $.fn-decl;
    has $.ident;
    has $.maybe-where-clause;
    has $.inner-attrs-and-block;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
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

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class InitExpr {
    has $.expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ImplItem {
    has $.value;
    has $.comment;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ImplMacroItem {
    has $.item-macro;
    has $.attrs-and-vis;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
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

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemImplDefault {
    has $.maybe-default-maybe-unsafe;
    has $.generic-params;
    has $.trait-ref;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemImplDefaultNeg {
    has $.trait-ref;
    has $.maybe-default-maybe-unsafe;
    has $.generic-params;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemImplNeg {
    has $.maybe-default-maybe-unsafe;
    has $.maybe-inner-attrs;
    has $.trait-ref;
    has $.maybe-impl-items;
    has $.maybe-where-clause;
    has $.ty-sum;
    has $.generic-params;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemMacro {
    has $.braces-delimited-token-trees;
    has $.parens-delimited-token-trees;
    has $.maybe-ident;
    has $.path-expr;
    has $.brackets-delimited-token-trees;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemMod {
    has $.ident;
    has $.maybe-mod-items;
    has $.inner-attrs;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemStatic {
    has Bool $.mut;
    has $.ty;
    has $.expr;
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemStruct {
    has $.struct-tuple-args;
    has $.struct-decl-args;
    has $.maybe-where-clause;
    has $.ident;
    has $.generic-params;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StructField {
    has $.comment;
    has $.attrs-and-vis;
    has $.ty-sum;
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StructFields {
    has $.struct-decl-field;
    has $.struct-tuple-field;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemTrait {
    has $.maybe-where-clause;
    has $.maybe-unsafe;
    has $.generic-params;
    has $.for-sized;
    has $.maybe-ty-param-bounds;
    has $.maybe-trait-items;
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemTraitAlias {
    has Bool $.unsafe;
    has $.ident;
    has $.ty-sum;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TraitItems {
    has $.trait-item;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TraitItem {
    has $.value;
    has $.comment;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MatchClause {
    has $.clause;
    has $.comment;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TraitMacroItem {
    has $.maybe-outer-attrs;
    has $.item-macro;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemTy {
    has $.generic-params;
    has $.maybe-where-clause;
    has $.ty-sum;
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprFnBlock {
    has $.ret-ty;
    has $.expr;
    has $.inferrable-params;
    has $.lambda-expr-nostruct-no-first-bar;
    has $.lambda-expr-no-first-bar;
    has $.expr-nostruct;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class DeclLocal {
    has $.pat;
    has $.maybe-init-expr;
    has $.maybe-ty-ascription;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Lifetimes {
    has $.lifetime-and-bounds;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Lifetime {
    has $.maybe-ltbounds;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}


has $.text is required;

method gist {
    say "need to write gist!";
    say $.text;
    ddt self;
    exit;
}
our class StaticLifetime { }

our class PatLit {
    has $.lit;
    has $.path-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Ltbounds {
    has $.lifetime;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

#-------------------------------------
# the braces-delimited macro is a block-expr so it
# doesn't appear here
our class MacroExpr {
    has $.path-expr;
    has $.parens-delimited-token-trees;
    has $.maybe-ident;
    has $.brackets-delimited-token-trees;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ArmBlock {
    has $.block-expr;
    has $.block;
    has $.pats-or;
    has $.maybe-guard;
    has $.maybe-outer-attrs;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ArmNonblock {
    has $.nonblock-expr;
    has $.maybe-outer-attrs;
    has $.block-expr-dot;
    has $.maybe-guard;
    has $.pats-or;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Arms {
    has $.match-clause;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprMatch {
    has $.match-clauses;
    has $.nonblock-match-clause;
    has $.expr-nostruct;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MetaList {
    has $.ident;
    has $.meta-seq;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MetaNameValue {
    has $.lit;
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MetaWord {
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MetaItems {
    has $.meta-item;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
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

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Provided {
    has $.method;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Required {
    has $.type-method;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TypeMethod {
    has $.fn-decl-with-self-allow-anon-params;
    has $.maybe-abi;
    has $.maybe-outer-attrs;
    has $.maybe-where-clause;
    has $.generic-params;
    has $.maybe-unsafe;
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Items {
    has $.mod-item;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Item {
    has $.comment;
    has $.item;
    has $.attrs-and-vis;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprAssign {
    has $.expr;
    has $.nonblock-expr;
    has $.expr-nostruct;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprAssignAdd {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprAssignBitAnd {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprAssignBitOr {
    has $.nonblock-expr;
    has $.expr;
    has $.expr-nostruct;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprAssignBitXor {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprAssignDiv {
    has $.expr;
    has $.nonblock-expr;
    has $.expr-nostruct;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprAssignRem {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprAssignShl {
    has $.nonblock-expr;
    has $.expr;
    has $.expr-nostruct;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprBox {
    has $.expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprField {
    has $.block-expr;
    has $.block-expr-dot;
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
    has $.path-generic-args-with-colons;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprIndex {
    has $.block-expr;
    has $.block-expr-dot;
    has $.expr;
    has $.expr-nostruct;
    has $.maybe-expr;
    has $.nonblock-expr;
    has $.path-generic-args-with-colons;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprMac {
    has $.macro-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprParen {
    has $.maybe-exprs;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprPath {
    has $.path-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprRange {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprRet {
    has $.expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprStruct {
    has $.path-expr;
    has $.struct-expr-fields;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprTry {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprTupleIndex {
    has $.block-expr;
    has $.block-expr-dot;
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
    has $.lit-int;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprTypeAscr {
    has $.expr;
    has $.expr-nostruct;
    has $.nonblock-expr;
    has $.ty;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprVec {
    has $.vec-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprYield {
    has $.expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprAddrOf {
    has $.expr-nostruct;
    has $.maybe-mut;
    has $.expr;
    has $.count = 1;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprUnary {
    has $.expr;
    has $.expr-nostruct;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprUnaryMinus {
    has $.expr;
    has $.expr-nostruct;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprUnaryNot {
    has $.expr;
    has $.expr-nostruct;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExprUnaryStar {
    has $.expr;
    has $.expr-nostruct;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class OuterAttrs {
    has $.outer-attr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Arg {
    has $.ty-sum;
    has $.pat;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Args {
    has $.param;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatField {
    has $.ident;
    has $.pat;
    has $.binding-mode;
    has $.lit-int;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatTupElts {
    has $.pat;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatVecElts {
    has $.pat;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatEnum {
    has $.path-expr;
    has $.pat-tup;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Ident {
    has $.value;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatIdent {
    has $.pat;
    has $.ident;
    has $.binding-mode;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatMac {
    has $.maybe-ident;
    has $.path-expr;
    has $.delimited-token-trees;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatQualifiedPath {
    has $.ty-sum;
    has $.maybe-as-trait-refA;
    has $.identA;
    has $.maybe-as-trait-refB;
    has $.identB;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatRange {
    has $.lit-or-pathA;
    has $.lit-or-pathB;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatRegion {
    has Bool $.mut = False;
    has $.pat;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatRegionRefRef {
    has $.pat;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatStruct {
    has $.pat-fields;
    has $.pat-struct;
    has $.path-expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatTup {
    has $.pat-tup;
    has $.pat-tup-elts;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatUniq {
    has $.pat;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}


has $.text is required;

method gist {
    say "need to write gist!";
    say $.text;
    ddt self;
    exit;
}
our class PatUnit { }

our class PatVec {
    has $.pat-vec;
    has $.pat-vec-elts;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Pats {
    has $.pat;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class SelfPath {
    has $.path-generic-args-with-colons;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
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

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
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

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class RetTy {
    has $.ty;
    has $.panic;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
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

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Self {

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Stmt {
    has $.value;
    has $.comment;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class DefaultFieldInit {
    has $.expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class FieldInit {
    has $.comment;
    has $.item;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class FieldInitItem {
    has $.ident;
    has $.expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class FieldInits {
    has $.field-init;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TTDelim {
    has $.token-trees;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TTTok {
    has $.unpaired-token;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ConstTraitItem {
    has $.maybe-ty-ascription;
    has $.maybe-const-default;
    has $.ident;
    has $.maybe-outer-attrs;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ConstGeneric {
    has $.name is required;
    has $.ty   is required;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyClosure {
    has $.anon-params;
    has $.ret-ty;
    has $.maybe-bounds;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyDefault {
    has $.ty-sum;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyFnDecl {
    has $.fn-anon-params;
    has $.ret-ty;
    has $.generic-params;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PolyBound {
    has $.maybe-lifetimes;
    has $.bound;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyParam {
    has $.maybe-ty-param-bounds;
    has $.maybe-ty-default;
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyParams {
    has $.ty-param;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyBox {
    has $.ty;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyFixedLengthVec {
    has $.expr;
    has $.ty;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyMacro {
    has $.path-generic-args-without-colons;
    has $.delimited-token-trees;
    has $.maybe-ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyPath {
    has $.path-generic-args-without-colons;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyPtr {
    has $.maybe-mut-or-const;
    has $.ty;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyRptr {
    has $.ty;
    has $.mut;
    has $.lifetime;
    has $.count = 1;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyTypeof {
    has $.expr;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyVec {
    has $.ty;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TySum {
    has @.ty-sum-elts;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class DynTyPrim {
    has $.ty;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TySumsAndBindings {
    has $.bindings;
    has $.ty-sums;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyQualifiedPath {
    has $.ty-sum;
    has $.trait-ref;
    has $.ident;
    has $.maybe-as-trait-ref;
    has $.ty-param-bounds;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyTup {
    has $.ty-sums;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TypeTraitItem {
    has $.maybe-outer-attrs;
    has $.ty-param;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ViewItemUse {
    has $.view-path;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class VecRepeat {
    has $.expr;
    has $.exprs;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ViewItemExternCrate {
    has $.ident;
    has $.as-ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ViewPathGlob {
    has $.path-no-types-allowed;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ViewPathList {
    has $.idents-or-self;
    has $.path-no-types-allowed;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ViewPathSimple {
    has $.path-no-types-allowed;
    has $.ident;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class WhereClause {
    has $.where-predicates;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class WherePredicate {
    has $.maybe-for-lifetimes;
    has $.bounds;
    has $.lifetime;
    has $.ty-param-bounds;
    has $.ty;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class WherePredicates {
    has $.where-predicate;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemFn {
    has $.ident;
    has $.generic-params;
    has $.fn-decl;
    has $.maybe-where-clause;
    has $.inner-attrs-and-block;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemUnsafeFn {
    has $.ident;
    has $.generic-params;
    has $.fn-decl;
    has $.maybe-where-clause;
    has $.inner-attrs-and-block;

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class LitByte    { 
    has $.val; 

    method gist {
        say "need to write gist!";
        ddt self;
        exit;
    }
}

our class LitStr     { 
    has $.val; 

    method gist {
        say "need to write gist!";
        ddt self;
        exit;
    }
}

our class LitByteStr { 
    has $.val; 

    method gist {
        say "need to write gist!";
        ddt self;
        exit;
    }
}

our class LitChar    { 
    has $.val; 

    method gist {
        say "need to write gist!";
        ddt self;
        exit;
    }
}

our class LitInteger { 
    has $.val; 

    method gist {
        say "need to write gist!";
        ddt self;
        exit;
    }
}

our class LitFloat { 
    has $.val; 

    method gist {
        say "need to write gist!";
        ddt self;
        exit;
    }
}

our class LitBool { 
    has $.val; 

    method gist {
        say "need to write gist!";
        ddt self;
        exit;
    }
}

our class MutMutable { 

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MutImmutable { 

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class PatWild { 

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class DocComment { 

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Super { 

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyInfer { 

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Default { 

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class DefaultUnsafe { 

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Unsafe { 

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TyNil { 

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ViewPathListEmpty { 

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Public { 

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Inherited { 

    has $.text is required;

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StructExprFields {
    has $.maybe-field-inits;
    has $.default-field-init;
}

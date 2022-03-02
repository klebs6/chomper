use Grammar::Tracer;
use grust-anon-params;
use grust-as-trait-ref;
use grust-attr-and-vis;
use grust-binding-mode;
use grust-binding;
use grust-block-expr;
use grust-block-item;
use grust-block-or-if;
use grust-block;
use grust-bounds;
use grust-const-default;
use grust-crate;
use grust-comment;
use grust-default;
use grust-expr-for;
use grust-expr-if-let;
use grust-expr-if;
use grust-expr-loop;
use grust-expr-no-struct;
use grust-expr-qualified-path;
use grust-expr-while-let;
use grust-expr-while;
use grust-expr;
use grust-exprs;
use grust-extern-fn-item;
use grust-fn-decl-with-self;
use grust-fn-params;
use grust-for-in-type;
use grust-for-lifetimes;
use grust-for-sized;
use grust-foreign-fn;
use grust-foreign-items;
use grust-foreign-static;
use grust-generic-args;
use grust-generic-params;
use grust-guard;
use grust-ident;
use grust-idents-or-self;
use grust-impl-const;
use grust-impl-type;
use grust-inferrable-parms;
use grust-init-expr;
use grust-inner-attr;
use grust-item-const;
use grust-item-enum;
use grust-item-fn;
use grust-item-impl;
use grust-item-macro;
use grust-item-mod;
use grust-item-static;
use grust-item-struct;
use grust-item-trait;
use grust-item-ty;
use grust-item-union;
use grust-items;
use grust-keyword;
use grust-label;
use grust-lambda-expr;
use grust-let;
use grust-lifetimes;
use grust-lit;
use grust-lit-str;
use grust-lit-float;
use grust-lit-int;
use grust-lit-or-path;
use grust-lt-bounds;
use grust-macro-expr;
use grust-match;
use grust-meta-item;
use grust-meta-seq;
use grust-method;
use grust-mod-items;
use grust-mut-or-const;
use grust-named-arg;
use grust-non-block-expr;
use grust-nonblock-prefix-expr;
use grust-outer-attr;
use grust-operator;
use grust-params;
use grust-pat-field;
use grust-pat-struct;
use grust-pat-tup;
use grust-pat-vec;
use grust-pat;
use grust-path-expr;
use grust-path-generic-args-with-colons;
use grust-path-no-types-allowed;
use grust-qpath-params;
use grust-ret-ty;
use grust-shebang;
use grust-stmts;
use grust-str;
use grust-struct-expr;
use grust-symbol;
use grust-token-tree;
use grust-trait-const;
use grust-trait-ref;
use grust-ty-ascription;
use grust-ty-bare-fn;
use grust-ty-closure;
use grust-ty-default;
use grust-ty-fn-decl;
use grust-ty-param-bounds;
use grust-ty-param;
use grust-ty-params;
use grust-ty-prim;
use grust-ty-qualified-path;
use grust-ty-sum;
use grust-ty-sums-and-bindings;
use grust-ty;
use grust-type-trait;
use grust-unpaired-token;
use grust-unsafe;
use grust-use-item;
use grust-vec-expr;
use grust-view-item;
use grust-view-path;
use grust-visibility;
use grust-where-clause;
use grust-where-predicates;

use grust-lex;

grammar Rust::Grammar 

#-----------------------------
does Lex::DocBlock
does Lex::DocLine
does Lex::LifetimeOrChar
does Lex::ByteStr
does Lex::RawByteStrNoHash
does Lex::RawByteStr
does Lex::Byte
does Lex::RawStr
does Lex::Pound
does Lex::RawStrEsc
does Lex::Str_
does Lex::Suffix

does Rust::Comments
does Lex::LineComment
does Lex::BlockComment
does Lex::DocComment

#-----------------------------
does Rust::Keyword
does Rust::Operator
does AnonParams::Rules
does AsTraitRef::Rules
does AttrsAndVis::Rules
does Binding::Rules
does BindingMode::Rules
does Block::Rules
does BlockExpr::Rules
does BlockItem::Rules
does BlockOrIf::Rules
does Bounds::Rules
does ConstDefault::Rules
does Crate::Rules
does Default::Rules
does Expr::Rules
does ExprFor::Rules
does ExprIf::Rules
does ExprIfLet::Rules
does ExprLoop::Rules
does ExprMatch::Rules
does ExprNoStruct::Rules
does ExprQualifiedPath::Rules
does ExprWhile::Rules
does ExprWhileLet::Rules
does Exprs::Rules
does ExternFnItem::Rules
does Fn::Rules
does FnDeclWithSelf::Rules
does FnParams::Rules
does ForInType::Rules
does ForLifetimes::Rules
does ForSized::Rules
does ForeignFn::Rules
does ForeignItems::Rules
does ForeignStatic::Rules
does GenericArgs::Rules
does GenericParams::Rules
does Guard::Rules
does Ident::Rules
does IdentsOrSelf::Rules
does ImplConst::Rules
does ImplType::Rules
does InferrableParams::Rules
does InitExpr::Rules
does InnerAttrs::Rules
does InnerAttrsAndBlock::Rules
does Item::Rules
does ItemConst::Rules
does ItemEnum::Rules
does ItemImpl::Rules
does ItemMacro::Rules
does ItemMod::Rules
does ItemStatic::Rules
does ItemStruct::Rules
does ItemTrait::Rules
does ItemType::Rules
does ItemUnion::Rules
does Label::Rules
does LambdaExpr::Rules
does Let::Rules
does Lifetimes::Rules
does Lit::Rules
does LitInt::Rules
does LitFloat::Rules
does LitStr::Rules
does LitOrPath::Rules
does LtBounds::Rules
does MacroExpr::Rules
does MetaItem::Rules
does MetaSeq::Rules
does Method::Rules
does ModItem::Rules
does ModItems::Rules
does MutOrConst::Rules
does NamedArg::Rules
does NonBlockExpr::Rules
does NonblockPrefixExpr::Rules
does OuterAttrs::Rules
does Params::Rules
does Pat::Rules
does PatField::Rules
does PatStruct::Rules
does PatTup::Rules
does PatVec::Rules
does PathExpr::Rules
does PathGenericArgsWithColons::Rules
does PathGenericArgsWithoutColons::Rules
does PathNoTypesAllowed::Rules
does QPathParams::Rules
does RetTy::Rules
does StmtItem::Rules
does Stmts::Rules
does String::Rules
does StructExpr::Rules
does TokenTree::Rules
does TraitConst::Rules
does TraitRef::Rules
does TraitType::Rules
does Ty::Rules
does TyAscription::Rules
does TyBareFn::Rules
does TyClosure::Rules
does TyFnDecl::Rules
does TyParam::Rules
does TyParamBounds::Rules
does TyParams::Rules
does TyPrim::Rules
does TyQualifiedPath::Rules
does TySums::Rules
does TySumsAndBindings::Rules
does UnpairedToken::Rules
does Unsafe::Rules
does UseItem::Rules
does VecExpr::Rules
does ViewItem::Rules
does ViewPath::Rules
does Visibility::Rules
does WhereClause::Rules
does WherePredicates::Rules {
    rule TOP {
        <.ws> <stmts>
    }
}

our class Rust::Actions 
does AnonParams::Actions
does AsTraitRef::Actions
does AttrsAndVis::Actions
does Binding::Actions
does BindingMode::Actions
does Block::Actions
does BlockExpr::Actions
does BlockItem::Actions
does BlockOrIf::Actions
does Bounds::Actions
does ConstDefault::Actions
does Crate::Actions
does Default::Actions
does Expr::Actions
does ExprFor::Actions
does ExprIf::Actions
does ExprIfLet::Actions
does ExprLoop::Actions
does ExprMatch::Actions
does ExprNoStruct::Actions
does ExprQualifiedPath::Actions
does ExprWhile::Actions
does ExprWhileLet::Actions
does Exprs::Actions
does ExternFnItem::Actions
does Fn::Actions
does FnDeclWithSelf::Actions
does FnParams::Actions
does ForInType::Actions
does ForLifetimes::Actions
does ForSized::Actions
does ForeignFn::Actions
does ForeignItems::Actions
does ForeignStatic::Actions
does GenericArgs::Actions
does GenericParams::Actions
does Guard::Actions
does Ident::Actions
does IdentsOrSelf::Actions
does ImplConst::Actions
does ImplType::Actions
does InferrableParams::Actions
does InitExpr::Actions
does InnerAttrs::Actions
does InnerAttrsAndBlock::Actions
does Item::Actions
does ItemConst::Actions
does ItemEnum::Actions
does ItemImpl::Actions
does ItemMacro::Actions
does ItemMod::Actions
does ItemStatic::Actions
does ItemStruct::Actions
does ItemTrait::Actions
does ItemType::Actions
does ItemUnion::Actions
does Label::Actions
does LambdaExpr::Actions
does Let::Actions
does Lifetimes::Actions
does Lit::Actions
does LitOrPath::Actions
does LtBounds::Actions
does MacroExpr::Actions
does MetaItem::Actions
does MetaSeq::Actions
does Method::Actions
does ModItem::Actions
does ModItems::Actions
does MutOrConst::Actions
does NamedArg::Actions
does NonBlockExpr::Actions
does NonblockPrefixExpr::Actions
does OuterAttrs::Actions
does Params::Actions
does Pat::Actions
does PatField::Actions
does PatStruct::Actions
does PatTup::Actions
does PatVec::Actions
does PathExpr::Actions
does PathGenericArgsWithColons::Actions
does PathGenericArgsWithoutColons::Actions
does PathNoTypesAllowed::Actions
does QPathParams::Actions
does RetTy::Actions
does StmtItem::Actions
does Stmts::Actions
does String::Actions
does StructExpr::Actions
does TokenTree::Actions
does TraitConst::Actions
does TraitRef::Actions
does TraitType::Actions
does Ty::Actions
does TyAscription::Actions
does TyBareFn::Actions
does TyClosure::Actions
does TyFnDecl::Actions
does TyParam::Actions
does TyParamBounds::Actions
does TyParams::Actions
does TyPrim::Actions
does TyQualifiedPath::Actions
does TySums::Actions
does TySumsAndBindings::Actions
does UnpairedToken::Actions
does Unsafe::Actions
does UseItem::Actions
does VecExpr::Actions
does ViewItem::Actions
does ViewPath::Actions
does Visibility::Actions
does WhereClause::Actions
does WherePredicates::Actions {}

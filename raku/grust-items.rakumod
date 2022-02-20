our class Crate {
    has $.maybe_mod_items;
    has $.inner_attrs;
}

our class Crate::G {

    proto rule crate { * }

    rule crate:sym<a> {
        <maybe-shebang> <inner-attrs> <maybe-mod_items>
    }

    rule crate:sym<b> {
        <maybe-shebang> <maybe-mod_items>
    }

    proto rule maybe-shebang { * }

    rule maybe-shebang:sym<a> {
        <SHEBANG-LINE>
    }

    rule maybe-shebang:sym<b> {

    }
}

our class Crate::A {

    method crate:sym<a>($/) {
        make crate.new(
            inner-attrs     =>  $<inner-attrs>.made,
            maybe-mod_items =>  $<maybe-mod_items>.made,
        )
    }

    method crate:sym<b>($/) {
        make crate.new(
            maybe-mod_items =>  $<maybe-mod_items>.made,
        )
    }

    method maybe-shebang:sym<a>($/) {
        make $<SHEBANG-LINE>.made
    }

    method maybe-shebang:sym<b>($/) {

    }
}

#------------------------------
our class InnerAttr {
    has $.meta_item;
}

our class InnerAttrs {
    has $.inner_attr;
}

our class InnerAttrs::G {

    proto rule maybe-inner_attrs { * }

    rule maybe-inner_attrs:sym<a> {
        <inner-attrs>
    }

    rule maybe-inner_attrs:sym<b> {

    }

    proto rule inner-attrs { * }

    rule inner-attrs:sym<a> {
        <inner-attr>
    }

    rule inner-attrs:sym<b> {
        <inner-attrs> <inner-attr>
    }

    proto rule inner-attr { * }

    rule inner-attr:sym<a> {
        <SHEBANG> '[' <meta-item> ']'
    }

    rule inner-attr:sym<b> {
        <INNER-DOC_COMMENT>
    }
}

our class InnerAttrs::A {

    method maybe-inner_attrs:sym<a>($/) {
        make $<inner-attrs>.made
    }

    method maybe-inner_attrs:sym<b>($/) {
        MkNone<140465736753184>
    }

    method inner-attrs:sym<a>($/) {
        make InnerAttrs.new(
            inner-attr =>  $<inner-attr>.made,
        )
    }

    method inner-attrs:sym<b>($/) {
        ExtNode<140465182492136>
    }

    method inner-attr:sym<a>($/) {
        make InnerAttr.new(
            meta-item =>  $<meta-item>.made,
        )
    }

    method inner-attr:sym<b>($/) {
        make InnerAttr.new(

        )
    }
}

#------------------------------
our class OuterAttrs {
    has $.outer_attr;
}

our class OuterAttrs::G {

    proto rule maybe-outer_attrs { * }

    rule maybe-outer_attrs:sym<a> {
        <outer-attrs>
    }

    rule maybe-outer_attrs:sym<b> {

    }

    proto rule outer-attrs { * }

    rule outer-attrs:sym<a> {
        <outer-attr>
    }

    rule outer-attrs:sym<b> {
        <outer-attrs> <outer-attr>
    }

    proto rule outer-attr { * }

    rule outer-attr:sym<a> {
        '#' '[' <meta-item> ']'
    }

    rule outer-attr:sym<b> {
        <OUTER-DOC_COMMENT>
    }
}

our class OuterAttrs::A {

    method maybe-outer_attrs:sym<a>($/) {
        make $<outer-attrs>.made
    }

    method maybe-outer_attrs:sym<b>($/) {
        MkNone<140662032925984>
    }

    method outer-attrs:sym<a>($/) {
        make OuterAttrs.new(
            outer-attr =>  $<outer-attr>.made,
        )
    }

    method outer-attrs:sym<b>($/) {
        ExtNode<140662815349104>
    }

    method outer-attr:sym<a>($/) {
        make $<meta_item>.made
    }

    method outer-attr:sym<b>($/) {
        make doc-comment.new(

        )
    }
}

#------------------------------
our class MetaList {
    has $.ident;
    has $.meta_seq;
}

our class MetaNameValue {
    has $.lit;
    has $.ident;
}

our class MetaWord {
    has $.ident;
}

our class MetaItem::G {

    proto rule meta-item { * }

    rule meta-item:sym<a> {
        <ident>
    }

    rule meta-item:sym<b> {
        <ident> '=' <lit>
    }

    rule meta-item:sym<c> {
        <ident> '(' <meta-seq> ')'
    }

    rule meta-item:sym<d> {
        <ident> '(' <meta-seq> ',' ')'
    }
}

our class MetaItem::A {

    method meta-item:sym<a>($/) {
        make MetaWord.new(
            ident =>  $<ident>.made,
        )
    }

    method meta-item:sym<b>($/) {
        make MetaNameValue.new(
            ident =>  $<ident>.made,
            lit   =>  $<lit>.made,
        )
    }

    method meta-item:sym<c>($/) {
        make MetaList.new(
            ident    =>  $<ident>.made,
            meta-seq =>  $<meta-seq>.made,
        )
    }

    method meta-item:sym<d>($/) {
        make MetaList.new(
            ident    =>  $<ident>.made,
            meta-seq =>  $<meta-seq>.made,
        )
    }
}

#------------------------------
our class MetaItems {
    has $.meta_item;
}

our class MetaSeq::G {

    proto rule meta-seq { * }

    rule meta-seq:sym<a> {

    }

    rule meta-seq:sym<b> {
        <meta-item>
    }

    rule meta-seq:sym<c> {
        <meta-seq> ',' <meta-item>
    }
}

our class MetaSeq::A {

    method meta-seq:sym<a>($/) {
        MkNone<140671732528704>
    }

    method meta-seq:sym<b>($/) {
        make MetaItems.new(
            meta-item =>  $<meta-item>.made,
        )
    }

    method meta-seq:sym<c>($/) {
        ExtNode<140671998965976>
    }
}

#------------------------------
our class Items {
    has $.mod_item;
}

our class ModItems::G {

    proto rule maybe-mod_items { * }

    rule maybe-mod_items:sym<a> {
        <mod-items>
    }

    rule maybe-mod_items:sym<b> {

    }

    proto rule mod-items { * }

    rule mod-items:sym<a> {
        <mod-item>
    }

    rule mod-items:sym<b> {
        <mod-items> <mod-item>
    }
}

our class ModItems::A {

    method maybe-mod_items:sym<a>($/) {
        make $<mod-items>.made
    }

    method maybe-mod_items:sym<b>($/) {
        MkNone<140677866772384>
    }

    method mod-items:sym<a>($/) {
        make Items.new(
            mod-item =>  $<mod-item>.made,
        )
    }

    method mod-items:sym<b>($/) {
        ExtNode<140679773399960>
    }
}

#------------------------------
our class AttrsAndVis {
    has $.maybe_outer_attrs;
    has $.visibility;
}

our class AttrsAndVis::G {

    rule attrs-and_vis {
        <maybe-outer_attrs> <visibility>
    }
}

our class AttrsAndVis::A {

    method attrs-and_vis($/) {
        make AttrsAndVis.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            visibility        =>  $<visibility>.made,
        )
    }
}

#------------------------------
our class Item {
    has $.item;
    has $.attrs_and_vis;
}

our class ModItem::G {

    rule mod-item {
        <attrs-and_vis> <item>
    }
}

our class ModItem::A {

    method mod-item($/) {
        make Item.new(
            attrs-and_vis =>  $<attrs-and_vis>.made,
            item          =>  $<item>.made,
        )
    }
}

#------------------------------
# items that can appear outside of a fn block
our class Item::G {

    proto rule item { * }

    rule item:sym<a> {
        <stmt-item>
    }

    rule item:sym<b> {
        <item-macro>
    }
}

our class Item::A {

    method item:sym<a>($/) {
        make $<stmt-item>.made
    }

    method item:sym<b>($/) {
        make $<item-macro>.made
    }
}

#------------------------------
# items that can appear in "stmts"
our class StmtItem::G {

    proto rule stmt-item { * }

    rule stmt-item:sym<a> {
        <item-static>
    }

    rule stmt-item:sym<b> {
        <item-const>
    }

    rule stmt-item:sym<c> {
        <item-type>
    }

    rule stmt-item:sym<d> {
        <block-item>
    }

    rule stmt-item:sym<e> {
        <view-item>
    }
}

our class StmtItem::A {

    method stmt-item:sym<a>($/) {
        make $<item-static>.made
    }

    method stmt-item:sym<b>($/) {
        make $<item-const>.made
    }

    method stmt-item:sym<c>($/) {
        make $<item-type>.made
    }

    method stmt-item:sym<d>($/) {
        make $<block-item>.made
    }

    method stmt-item:sym<e>($/) {
        make $<view-item>.made
    }
}

#------------------------------
our class ItemStatic {
    has $.ty;
    has $.expr;
    has $.ident;
}

our class ItemStatic::G {

    proto rule item-static { * }

    rule item-static:sym<a> {
        <STATIC> <ident> ':' <ty> '=' <expr> ';'
    }

    rule item-static:sym<b> {
        <STATIC> <MUT> <ident> ':' <ty> '=' <expr> ';'
    }
}

our class ItemStatic::A {

    method item-static:sym<a>($/) {
        make ItemStatic.new(
            ident =>  $<ident>.made,
            ty    =>  $<ty>.made,
            expr  =>  $<expr>.made,
        )
    }

    method item-static:sym<b>($/) {
        make ItemStatic.new(
            ident =>  $<ident>.made,
            ty    =>  $<ty>.made,
            expr  =>  $<expr>.made,
        )
    }
}

#------------------------------
our class ItemConst {
    has $.ty;
    has $.ident;
    has $.expr;
}

our class ItemConst::G {

    rule item-const {
        <CONST> <ident> ':' <ty> '=' <expr> ';'
    }
}

our class ItemConst::A {

    method item-const($/) {
        make ItemConst.new(
            ident =>  $<ident>.made,
            ty    =>  $<ty>.made,
            expr  =>  $<expr>.made,
        )
    }
}

#------------------------------
our class ItemMacro {
    has $.braces_delimited_token_trees;
    has $.parens_delimited_token_trees;
    has $.maybe_ident;
    has $.path_expr;
    has $.brackets_delimited_token_trees;
}

our class ItemMacro::G {

    proto rule item-macro { * }

    rule item-macro:sym<a> {
        <path-expr> '!' <maybe-ident> <parens-delimited_token_trees> ';'
    }

    rule item-macro:sym<b> {
        <path-expr> '!' <maybe-ident> <braces-delimited_token_trees>
    }

    rule item-macro:sym<c> {
        <path-expr> '!' <maybe-ident> <brackets-delimited_token_trees> ';'
    }
}

our class ItemMacro::A {

    method item-macro:sym<a>($/) {
        make ItemMacro.new(
            path-expr                    =>  $<path-expr>.made,
            maybe-ident                  =>  $<maybe-ident>.made,
            parens-delimited_token_trees =>  $<parens-delimited_token_trees>.made,
        )
    }

    method item-macro:sym<b>($/) {
        make ItemMacro.new(
            path-expr                    =>  $<path-expr>.made,
            maybe-ident                  =>  $<maybe-ident>.made,
            braces-delimited_token_trees =>  $<braces-delimited_token_trees>.made,
        )
    }

    method item-macro:sym<c>($/) {
        make ItemMacro.new(
            path-expr                      =>  $<path-expr>.made,
            maybe-ident                    =>  $<maybe-ident>.made,
            brackets-delimited_token_trees =>  $<brackets-delimited_token_trees>.made,
        )
    }
}

#------------------------------
our class ViewItemExternCrate {
    has $.ident;
}

our class ViewItem::G {

    proto rule view-item { * }

    rule view-item:sym<a> {
        <use-item>
    }

    rule view-item:sym<b> {
        <extern-fn_item>
    }

    rule view-item:sym<c> {
        <EXTERN> <CRATE> <ident> ';'
    }

    rule view-item:sym<d> {
        <EXTERN> <CRATE> <ident> <AS> <ident> ';'
    }
}

our class ViewItem::A {

    method view-item:sym<a>($/) {
        make $<use-item>.made
    }

    method view-item:sym<b>($/) {
        make $<extern-fn_item>.made
    }

    method view-item:sym<c>($/) {
        make ViewItemExternCrate.new(
            ident =>  $<ident>.made,
        )
    }

    method view-item:sym<d>($/) {
        make ViewItemExternCrate.new(
            ident =>  $<ident>.made,
            ident =>  $<ident>.made,
        )
    }
}

#------------------------------
our class ViewItemExternFn {
    has $.item_fn;
    has $.maybe_abi;
}

our class ExternFnItem::G {

    rule extern-fn_item {
        <EXTERN> <maybe-abi> <item-fn>
    }
}

our class ExternFnItem::A {

    method extern-fn_item($/) {
        make ViewItemExternFn.new(
            maybe-abi =>  $<maybe-abi>.made,
            item-fn   =>  $<item-fn>.made,
        )
    }
}

#------------------------------
our class ViewItemUse {
    has $.view_path;
}

our class UseItem::G {

    rule use-item {
        <USE> <view-path> ';'
    }
}

our class UseItem::A {

    method use-item($/) {
        make ViewItemUse.new(
            view-path =>  $<view-path>.made,
        )
    }
}

#------------------------------
our class ViewPathGlob {
    has $.path_no_types_allowed;
}

our class ViewPathList {
    has $.idents_or_self;
    has $.path_no_types_allowed;
}

our class ViewPathSimple {
    has $.path_no_types_allowed;
    has $.ident;
}

our class ViewPath::G {

    proto rule view-path { * }

    rule view-path:sym<a> {
        <path-no_types_allowed>
    }

    rule view-path:sym<b> {
        <path-no_types_allowed> <MOD-SEP> '{' '}'
    }

    rule view-path:sym<c> {
        <MOD-SEP> '{' '}'
    }

    rule view-path:sym<d> {
        <path-no_types_allowed> <MOD-SEP> '{' <idents-or_self> '}'
    }

    rule view-path:sym<e> {
        <MOD-SEP> '{' <idents-or_self> '}'
    }

    rule view-path:sym<f> {
        <path-no_types_allowed> <MOD-SEP> '{' <idents-or_self> ',' '}'
    }

    rule view-path:sym<g> {
        <MOD-SEP> '{' <idents-or_self> ',' '}'
    }

    rule view-path:sym<h> {
        <path-no_types_allowed> <MOD-SEP> '*'
    }

    rule view-path:sym<i> {
        <MOD-SEP> '*'
    }

    rule view-path:sym<j> {
        '*'
    }

    rule view-path:sym<k> {
        '{' '}'
    }

    rule view-path:sym<l> {
        '{' <idents-or_self> '}'
    }

    rule view-path:sym<m> {
        '{' <idents-or_self> ',' '}'
    }

    rule view-path:sym<n> {
        <path-no_types_allowed> <AS> <ident>
    }
}

our class ViewPath::A {

    method view-path:sym<a>($/) {
        make ViewPathSimple.new(
            path-no_types_allowed =>  $<path-no_types_allowed>.made,
        )
    }

    method view-path:sym<b>($/) {
        make ViewPathList.new(
            path-no_types_allowed =>  $<path-no_types_allowed>.made,
        )
    }

    method view-path:sym<c>($/) {
        make ViewPathList.new(

        )
    }

    method view-path:sym<d>($/) {
        make ViewPathList.new(
            path-no_types_allowed =>  $<path-no_types_allowed>.made,
            idents-or_self        =>  $<idents-or_self>.made,
        )
    }

    method view-path:sym<e>($/) {
        make ViewPathList.new(
            idents-or_self =>  $<idents-or_self>.made,
        )
    }

    method view-path:sym<f>($/) {
        make ViewPathList.new(
            path-no_types_allowed =>  $<path-no_types_allowed>.made,
            idents-or_self        =>  $<idents-or_self>.made,
        )
    }

    method view-path:sym<g>($/) {
        make ViewPathList.new(
            idents-or_self =>  $<idents-or_self>.made,
        )
    }

    method view-path:sym<h>($/) {
        make ViewPathGlob.new(
            path-no_types_allowed =>  $<path-no_types_allowed>.made,
        )
    }

    method view-path:sym<i>($/) {
        make ViewPathGlob.new
    }

    method view-path:sym<j>($/) {
        make ViewPathGlob.new
    }

    method view-path:sym<k>($/) {
        make ViewPathListEmpty.new
    }

    method view-path:sym<l>($/) {
        make ViewPathList.new(
            idents-or_self =>  $<idents-or_self>.made,
        )
    }

    method view-path:sym<m>($/) {
        make ViewPathList.new(
            idents-or_self =>  $<idents-or_self>.made,
        )
    }

    method view-path:sym<n>($/) {
        make ViewPathSimple.new(
            path-no_types_allowed =>  $<path-no_types_allowed>.made,
            ident                 =>  $<ident>.made,
        )
    }
}

#------------------------------
our class ItemForeignMod {
    has $.item_foreign_mod;
}

our class BlockItem::G {

    proto rule block-item { * }

    rule block-item:sym<a> {
        <item-fn>
    }

    rule block-item:sym<b> {
        <item-unsafe_fn>
    }

    rule block-item:sym<c> {
        <item-mod>
    }

    rule block-item:sym<d> {
        <item-foreign_mod>
    }

    rule block-item:sym<e> {
        <item-struct>
    }

    rule block-item:sym<f> {
        <item-enum>
    }

    rule block-item:sym<g> {
        <item-union>
    }

    rule block-item:sym<h> {
        <item-trait>
    }

    rule block-item:sym<i> {
        <item-impl>
    }
}

our class BlockItem::A {

    method block-item:sym<a>($/) {
        make $<item-fn>.made
    }

    method block-item:sym<b>($/) {
        make $<item-unsafe_fn>.made
    }

    method block-item:sym<c>($/) {
        make $<item-mod>.made
    }

    method block-item:sym<d>($/) {
        make ItemForeignMod.new(
            item-foreign_mod =>  $<item-foreign_mod>.made,
        )
    }

    method block-item:sym<e>($/) {
        make $<item-struct>.made
    }

    method block-item:sym<f>($/) {
        make $<item-enum>.made
    }

    method block-item:sym<g>($/) {
        make $<item-union>.made
    }

    method block-item:sym<h>($/) {
        make $<item-trait>.made
    }

    method block-item:sym<i>($/) {
        make $<item-impl>.made
    }
}

#------------------------------
our class TyAscription::G {

    proto rule maybe-ty_ascription { * }

    rule maybe-ty_ascription:sym<a> {
        ':' <ty-sum>
    }

    rule maybe-ty_ascription:sym<b> {

    }
}

our class TyAscription::A {

    method maybe-ty_ascription:sym<a>($/) {
        make $<ty_sum>.made
    }

    method maybe-ty_ascription:sym<b>($/) {
        MkNone<140492181301024>
    }
}

#------------------------------
our class InitExpr::G {

    proto rule maybe-init_expr { * }

    rule maybe-init_expr:sym<a> {
        '=' <expr>
    }

    rule maybe-init_expr:sym<b> {

    }
}

our class InitExpr::A {

    method maybe-init_expr:sym<a>($/) {
        make $<expr>.made
    }

    method maybe-init_expr:sym<b>($/) {
        MkNone<140530961453856>
    }
}

#------------------------------
our class ItemStruct {
    has $.struct_tuple_args;
    has $.struct_decl_args;
    has $.maybe_where_clause;
    has $.ident;
    has $.generic_params;
}

our class StructField {
    has $.attrs_and_vis;
    has $.ty_sum;
    has $.ident;
}

our class StructFields {
    has $.struct_decl_field;
    has $.struct_tuple_field;
}

our class ItemStruct::G {

    proto rule item-struct { * }

    rule item-struct:sym<a> {
        <STRUCT> <ident> <generic-params> <maybe-where_clause> <struct-decl_args>
    }

    rule item-struct:sym<b> {
        <STRUCT> <ident> <generic-params> <struct-tuple_args> <maybe-where_clause> ';'
    }

    rule item-struct:sym<c> {
        <STRUCT> <ident> <generic-params> <maybe-where_clause> ';'
    }

    proto rule struct-decl_args { * }

    rule struct-decl_args:sym<a> {
        '{' <struct-decl_fields> '}'
    }

    rule struct-decl_args:sym<b> {
        '{' <struct-decl_fields> ',' '}'
    }

    proto rule struct-tuple_args { * }

    rule struct-tuple_args:sym<a> {
        '(' <struct-tuple_fields> ')'
    }

    rule struct-tuple_args:sym<b> {
        '(' <struct-tuple_fields> ',' ')'
    }

    proto rule struct-decl_fields { * }

    rule struct-decl_fields:sym<a> {
        <struct-decl_field>
    }

    rule struct-decl_fields:sym<b> {
        <struct-decl_fields> ',' <struct-decl_field>
    }

    rule struct-decl_fields:sym<c> {

    }

    rule struct-decl_field {
        <attrs-and_vis> <ident> ':' <ty-sum>
    }

    proto rule struct-tuple_fields { * }

    rule struct-tuple_fields:sym<a> {
        <struct-tuple_field>
    }

    rule struct-tuple_fields:sym<b> {
        <struct-tuple_fields> ',' <struct-tuple_field>
    }

    rule struct-tuple_fields:sym<c> {

    }

    rule struct-tuple_field {
        <attrs-and_vis> <ty-sum>
    }
}

our class ItemStruct::A {

    method item-struct:sym<a>($/) {
        make ItemStruct.new(
            ident              =>  $<ident>.made,
            generic-params     =>  $<generic-params>.made,
            maybe-where_clause =>  $<maybe-where_clause>.made,
            struct-decl_args   =>  $<struct-decl_args>.made,
        )
    }

    method item-struct:sym<b>($/) {
        make ItemStruct.new(
            ident              =>  $<ident>.made,
            generic-params     =>  $<generic-params>.made,
            struct-tuple_args  =>  $<struct-tuple_args>.made,
            maybe-where_clause =>  $<maybe-where_clause>.made,
        )
    }

    method item-struct:sym<c>($/) {
        make ItemStruct.new(
            ident              =>  $<ident>.made,
            generic-params     =>  $<generic-params>.made,
            maybe-where_clause =>  $<maybe-where_clause>.made,
        )
    }

    method struct-decl_args:sym<a>($/) {
        make $<struct_decl_fields>.made
    }

    method struct-decl_args:sym<b>($/) {
        make $<struct_decl_fields>.made
    }

    method struct-tuple_args:sym<a>($/) {
        make $<struct_tuple_fields>.made
    }

    method struct-tuple_args:sym<b>($/) {
        make $<struct_tuple_fields>.made
    }

    method struct-decl_fields:sym<a>($/) {
        make StructFields.new(
            struct-decl_field =>  $<struct-decl_field>.made,
        )
    }

    method struct-decl_fields:sym<b>($/) {
        ExtNode<140604918384136>
    }

    method struct-decl_fields:sym<c>($/) {
        MkNone<140604948239904>
    }

    method struct-decl_field($/) {
        make StructField.new(
            attrs-and_vis =>  $<attrs-and_vis>.made,
            ident         =>  $<ident>.made,
            ty-sum        =>  $<ty-sum>.made,
        )
    }

    method struct-tuple_fields:sym<a>($/) {
        make StructFields.new(
            struct-tuple_field =>  $<struct-tuple_field>.made,
        )
    }

    method struct-tuple_fields:sym<b>($/) {
        ExtNode<140604918384176>
    }

    method struct-tuple_fields:sym<c>($/) {
        MkNone<140604948239936>
    }

    method struct-tuple_field($/) {
        make StructField.new(
            attrs-and_vis =>  $<attrs-and_vis>.made,
            ty-sum        =>  $<ty-sum>.made,
        )
    }
}

#------------------------------
our class EnumArgs {
    has $.struct_decl_fields;
    has $.maybe_ty_sums;
    has $.expr;
}

our class EnumDef {
    has $.attrs_and_vis;
    has $.enum_args;
    has $.ident;
}

our class EnumDefs {
    has $.enum_def;
}

our class ItemEnum::G {

    proto rule item-enum { * }

    rule item-enum:sym<a> {
        <ENUM> <ident> <generic-params> <maybe-where_clause> '{' <enum-defs> '}'
    }

    rule item-enum:sym<b> {
        <ENUM> <ident> <generic-params> <maybe-where_clause> '{' <enum-defs> ',' '}'
    }

    proto rule enum-defs { * }

    rule enum-defs:sym<a> {
        <enum-def>
    }

    rule enum-defs:sym<b> {
        <enum-defs> ',' <enum-def>
    }

    rule enum-defs:sym<c> {

    }

    rule enum-def {
        <attrs-and_vis> <ident> <enum-args>
    }

    proto rule enum-args { * }

    rule enum-args:sym<a> {
        '{' <struct-decl_fields> '}'
    }

    rule enum-args:sym<b> {
        '{' <struct-decl_fields> ',' '}'
    }

    rule enum-args:sym<c> {
        '(' <maybe-ty_sums> ')'
    }

    rule enum-args:sym<d> {
        '=' <expr>
    }

    rule enum-args:sym<e> {

    }
}

our class ItemEnum::A {

    method item-enum:sym<a>($/) {
        make ItemEnum.new(

        )
    }

    method item-enum:sym<b>($/) {
        make ItemEnum.new(

        )
    }

    method enum-defs:sym<a>($/) {
        make EnumDefs.new(
            enum-def =>  $<enum-def>.made,
        )
    }

    method enum-defs:sym<b>($/) {
        ExtNode<140467083015800>
    }

    method enum-defs:sym<c>($/) {
        MkNone<140468669847744>
    }

    method enum-def($/) {
        make EnumDef.new(
            attrs-and_vis =>  $<attrs-and_vis>.made,
            ident         =>  $<ident>.made,
            enum-args     =>  $<enum-args>.made,
        )
    }

    method enum-args:sym<a>($/) {
        make EnumArgs.new(
            struct-decl_fields =>  $<struct-decl_fields>.made,
        )
    }

    method enum-args:sym<b>($/) {
        make EnumArgs.new(
            struct-decl_fields =>  $<struct-decl_fields>.made,
        )
    }

    method enum-args:sym<c>($/) {
        make EnumArgs.new(
            maybe-ty_sums =>  $<maybe-ty_sums>.made,
        )
    }

    method enum-args:sym<d>($/) {
        make EnumArgs.new(
            expr =>  $<expr>.made,
        )
    }

    method enum-args:sym<e>($/) {
        MkNone<140468669847776>
    }
}

#------------------------------
our class ItemUnion::G {

    proto rule item-union { * }

    rule item-union:sym<a> {
        <UNION> <ident> <generic-params> <maybe-where_clause> '{' <struct-decl_fields> '}'
    }

    rule item-union:sym<b> {
        <UNION> <ident> <generic-params> <maybe-where_clause> '{' <struct-decl_fields> ',' '}'
    }
}

our class ItemUnion::A {

    method item-union:sym<a>($/) {
        make ItemUnion.new(

        )
    }

    method item-union:sym<b>($/) {
        make ItemUnion.new(

        )
    }
}

#------------------------------
our class ItemForeignMod {
    has $.inner_attrs;
    has $.maybe_foreign_items;
}

our class ItemMod {
    has $.ident;
    has $.maybe_mod_items;
    has $.inner_attrs;
}

our class ItemMod::G {

    proto rule item-mod { * }

    rule item-mod:sym<a> {
        <MOD> <ident> ';'
    }

    rule item-mod:sym<b> {
        <MOD> <ident> '{' <maybe-mod_items> '}'
    }

    rule item-mod:sym<c> {
        <MOD> <ident> '{' <inner-attrs> <maybe-mod_items> '}'
    }

    proto rule item-foreign_mod { * }

    rule item-foreign_mod:sym<a> {
        <EXTERN> <maybe-abi> '{' <maybe-foreign_items> '}'
    }

    rule item-foreign_mod:sym<b> {
        <EXTERN> <maybe-abi> '{' <inner-attrs> <maybe-foreign_items> '}'
    }

    proto rule maybe-abi { * }

    rule maybe-abi:sym<a> {
        <str>
    }

    rule maybe-abi:sym<b> {

    }
}

our class ItemMod::A {

    method item-mod:sym<a>($/) {
        make ItemMod.new(
            ident =>  $<ident>.made,
        )
    }

    method item-mod:sym<b>($/) {
        make ItemMod.new(
            ident           =>  $<ident>.made,
            maybe-mod_items =>  $<maybe-mod_items>.made,
        )
    }

    method item-mod:sym<c>($/) {
        make ItemMod.new(
            ident           =>  $<ident>.made,
            inner-attrs     =>  $<inner-attrs>.made,
            maybe-mod_items =>  $<maybe-mod_items>.made,
        )
    }

    method item-foreign_mod:sym<a>($/) {
        make ItemForeignMod.new(
            maybe-foreign_items =>  $<maybe-foreign_items>.made,
        )
    }

    method item-foreign_mod:sym<b>($/) {
        make ItemForeignMod.new(
            inner-attrs         =>  $<inner-attrs>.made,
            maybe-foreign_items =>  $<maybe-foreign_items>.made,
        )
    }

    method maybe-abi:sym<a>($/) {
        make $<str>.made
    }

    method maybe-abi:sym<b>($/) {
        MkNone<140304314189184>
    }
}

#------------------------------
our class ForeignItem {
    has $.item_foreign_fn;
    has $.attrs_and_vis;
    has $.item_foreign_static;
}

our class ForeignItems {
    has $.foreign_item;
}

our class ForeignItems::G {

    proto rule maybe-foreign_items { * }

    rule maybe-foreign_items:sym<a> {
        <foreign-items>
    }

    rule maybe-foreign_items:sym<b> {

    }

    proto rule foreign-items { * }

    rule foreign-items:sym<a> {
        <foreign-item>
    }

    rule foreign-items:sym<b> {
        <foreign-items> <foreign-item>
    }

    proto rule foreign-item { * }

    rule foreign-item:sym<a> {
        <attrs-and_vis> <STATIC> <item-foreign_static>
    }

    rule foreign-item:sym<b> {
        <attrs-and_vis> <item-foreign_fn>
    }

    rule foreign-item:sym<c> {
        <attrs-and_vis> <UNSAFE> <item-foreign_fn>
    }
}

our class ForeignItems::A {

    method maybe-foreign_items:sym<a>($/) {
        make $<foreign-items>.made
    }

    method maybe-foreign_items:sym<b>($/) {
        MkNone<140372880377344>
    }

    method foreign-items:sym<a>($/) {
        make ForeignItems.new(
            foreign-item =>  $<foreign-item>.made,
        )
    }

    method foreign-items:sym<b>($/) {
        ExtNode<140373133060288>
    }

    method foreign-item:sym<a>($/) {
        make ForeignItem.new(
            attrs-and_vis       =>  $<attrs-and_vis>.made,
            item-foreign_static =>  $<item-foreign_static>.made,
        )
    }

    method foreign-item:sym<b>($/) {
        make ForeignItem.new(
            attrs-and_vis   =>  $<attrs-and_vis>.made,
            item-foreign_fn =>  $<item-foreign_fn>.made,
        )
    }

    method foreign-item:sym<c>($/) {
        make ForeignItem.new(
            attrs-and_vis   =>  $<attrs-and_vis>.made,
            item-foreign_fn =>  $<item-foreign_fn>.made,
        )
    }
}

#------------------------------

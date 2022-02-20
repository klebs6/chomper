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
our class StaticItem {
    has $.maybe_mut;
    has $.ident;
    has $.ty;
}

our class ForeignStatic::G {

    rule item-foreign_static {
        <maybe-mut> <ident> ':' <ty> ';'
    }
}

our class ForeignStatic::A {

    method item-foreign_static($/) {
        make StaticItem.new(
            maybe-mut =>  $<maybe-mut>.made,
            ident     =>  $<ident>.made,
            ty        =>  $<ty>.made,
        )
    }
}

#------------------------------
our class ForeignFn {
    has $.maybe_where_clause;
    has $.fn_decl_allow_variadic;
    has $.ident;
    has $.generic_params;
}

our class ForeignFn::G {

    rule item-foreign_fn {
        <FN> <ident> <generic-params> <fn-decl_allow_variadic> <maybe-where_clause> ';'
    }
}

our class ForeignFn::A {

    method item-foreign_fn($/) {
        make ForeignFn.new(
            ident                  =>  $<ident>.made,
            generic-params         =>  $<generic-params>.made,
            fn-decl_allow_variadic =>  $<fn-decl_allow_variadic>.made,
            maybe-where_clause     =>  $<maybe-where_clause>.made,
        )
    }
}

#------------------------------
our class FnDecl {
    has $.fn_params_allow_variadic;
    has $.ret_ty;
}

our class FnParams::G {

    rule fn-decl_allow_variadic {
        <fn-params_allow_variadic> <ret-ty>
    }

    proto rule fn-params_allow_variadic { * }

    rule fn-params_allow_variadic:sym<a> {
        '(' ')'
    }

    rule fn-params_allow_variadic:sym<b> {
        '(' <params> ')'
    }

    rule fn-params_allow_variadic:sym<c> {
        '(' <params> ',' ')'
    }

    rule fn-params_allow_variadic:sym<d> {
        '(' <params> ',' <DOTDOTDOT> ')'
    }
}

our class FnParams::A {

    method fn-decl_allow_variadic($/) {
        make FnDecl.new(
            fn-params_allow_variadic =>  $<fn-params_allow_variadic>.made,
            ret-ty                   =>  $<ret-ty>.made,
        )
    }

    method fn-params_allow_variadic:sym<a>($/) {
        MkNone<140402526985760>
    }

    method fn-params_allow_variadic:sym<b>($/) {
        make $<params>.made
    }

    method fn-params_allow_variadic:sym<c>($/) {
        make $<params>.made
    }

    method fn-params_allow_variadic:sym<d>($/) {
        make $<params>.made
    }
}


#------------------------------
our class Visibility::G {

    proto rule visibility { * }

    rule visibility:sym<a> {
        <PUB>
    }

    rule visibility:sym<b> {

    }
}

our class Visibility::A {

    method visibility:sym<a>($/) {
        make Public.new
    }

    method visibility:sym<b>($/) {
        make Inherited.new
    }
}

#------------------------------
our class IdentsOrSelf {
    has $.idents_or_self;
    has $.ident_or_self;
    has $.ident;
}

our class IdentsOrSelf::G {

    proto rule idents-or_self { * }

    rule idents-or_self:sym<a> {
        <ident-or_self>
    }

    rule idents-or_self:sym<b> {
        <idents-or_self> <AS> <ident>
    }

    rule idents-or_self:sym<c> {
        <idents-or_self> ',' <ident-or_self>
    }

    proto rule ident-or_self { * }

    rule ident-or_self:sym<a> {
        <ident>
    }

    rule ident-or_self:sym<b> {
        <SELF>
    }
}

our class IdentsOrSelf::A {

    method idents-or_self:sym<a>($/) {
        make IdentsOrSelf.new(
            ident-or_self =>  $<ident-or_self>.made,
        )
    }

    method idents-or_self:sym<b>($/) {
        make IdentsOrSelf.new(
            idents-or_self =>  $<idents-or_self>.made,
            ident          =>  $<ident>.made,
        )
    }

    method idents-or_self:sym<c>($/) {
        ExtNode<140683188573432>
    }

    method ident-or_self:sym<a>($/) {
        make $<ident>.made
    }

    method ident-or_self:sym<b>($/) {
        make yytext.new
    }
}

#------------------------------
our class ItemTy {
    has $.generic_params;
    has $.maybe_where_clause;
    has $.ty_sum;
    has $.ident;
}

our class ItemType::G {

    rule item-type {
        <TYPE> <ident> <generic-params> <maybe-where_clause> '=' <ty-sum> ';'
    }
}

our class ItemType::A {

    method item-type($/) {
        make ItemTy.new(
            ident              =>  $<ident>.made,
            generic-params     =>  $<generic-params>.made,
            maybe-where_clause =>  $<maybe-where_clause>.made,
            ty-sum             =>  $<ty-sum>.made,
        )
    }
}

#------------------------------
our class ForSized {
    has $.ident;
}

our class ForSized::G {

    proto rule for-sized { * }

    rule for-sized:sym<a> {
        <FOR> '?' <ident>
    }

    rule for-sized:sym<b> {
        <FOR> <ident> '?'
    }

    rule for-sized:sym<c> {

    }
}

our class ForSized::A {

    method for-sized:sym<a>($/) {
        make ForSized.new(
            ident =>  $<ident>.made,
        )
    }

    method for-sized:sym<b>($/) {
        make ForSized.new(
            ident =>  $<ident>.made,
        )
    }

    method for-sized:sym<c>($/) {
        MkNone<140458176013312>
    }
}

#------------------------------
our class ItemTrait {
    has $.maybe_where_clause;
    has $.maybe_unsafe;
    has $.generic_params;
    has $.for_sized;
    has $.maybe_ty_param_bounds;
    has $.maybe_trait_items;
    has $.ident;
}

our class TraitItems {
    has $.trait_item;
}

our class TraitMacroItem {
    has $.maybe_outer_attrs;
    has $.item_macro;
}

our class ItemTrait::G {

    rule item-trait {
        <maybe-unsafe> <TRAIT> <ident> <generic-params> <for-sized> <maybe-ty_param_bounds> <maybe-where_clause> '{' <maybe-trait_items> '}'
    }

    proto rule maybe-trait_items { * }

    rule maybe-trait_items:sym<a> {
        <trait-items>
    }

    rule maybe-trait_items:sym<b> {

    }

    proto rule trait-items { * }

    rule trait-items:sym<a> {
        <trait-item>
    }

    rule trait-items:sym<b> {
        <trait-items> <trait-item>
    }

    proto rule trait-item { * }

    rule trait-item:sym<a> {
        <trait-const>
    }

    rule trait-item:sym<b> {
        <trait-type>
    }

    rule trait-item:sym<c> {
        <trait-method>
    }

    rule trait-item:sym<d> {
        <maybe-outer_attrs> <item-macro>
    }
}

our class ItemTrait::A {

    method item-trait($/) {
        make ItemTrait.new(
            maybe-unsafe          =>  $<maybe-unsafe>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            for-sized             =>  $<for-sized>.made,
            maybe-ty_param_bounds =>  $<maybe-ty_param_bounds>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            maybe-trait_items     =>  $<maybe-trait_items>.made,
        )
    }

    method maybe-trait_items:sym<a>($/) {
        make $<trait-items>.made
    }

    method maybe-trait_items:sym<b>($/) {
        MkNone<140215433189312>
    }

    method trait-items:sym<a>($/) {
        make TraitItems.new(
            trait-item =>  $<trait-item>.made,
        )
    }

    method trait-items:sym<b>($/) {
        ExtNode<140215424168608>
    }

    method trait-item:sym<a>($/) {
        make $<trait-const>.made
    }

    method trait-item:sym<b>($/) {
        make $<trait-type>.made
    }

    method trait-item:sym<c>($/) {
        make $<trait-method>.made
    }

    method trait-item:sym<d>($/) {
        make TraitMacroItem.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            item-macro        =>  $<item-macro>.made,
        )
    }
}

#------------------------------
our class ConstTraitItem {
    has $.maybe_ty_ascription;
    has $.maybe_const_default;
    has $.ident;
    has $.maybe_outer_attrs;
}

our class TraitConst::G {

    rule trait-const {
        <maybe-outer_attrs> <CONST> <ident> <maybe-ty_ascription> <maybe-const_default> ';'
    }
}

our class TraitConst::A {

    method trait-const($/) {
        make ConstTraitItem.new(
            maybe-outer_attrs   =>  $<maybe-outer_attrs>.made,
            ident               =>  $<ident>.made,
            maybe-ty_ascription =>  $<maybe-ty_ascription>.made,
            maybe-const_default =>  $<maybe-const_default>.made,
        )
    }
}

#------------------------------
our class ConstDefault {
    has $.expr;
}

our class ConstDefault::G {

    proto rule maybe-const_default { * }

    rule maybe-const_default:sym<a> {
        '=' <expr>
    }

    rule maybe-const_default:sym<b> {

    }
}

our class ConstDefault::A {

    method maybe-const_default:sym<a>($/) {
        make ConstDefault.new(
            expr =>  $<expr>.made,
        )
    }

    method maybe-const_default:sym<b>($/) {
        MkNone<140324429464512>
    }
}

#------------------------------
our class TypeTraitItem {
    has $.maybe_outer_attrs;
    has $.ty_param;
}

our class TraitType::G {

    rule trait-type {
        <maybe-outer_attrs> <TYPE> <ty-param> ';'
    }
}

our class TraitType::A {

    method trait-type($/) {
        make TypeTraitItem.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            ty-param          =>  $<ty-param>.made,
        )
    }
}

#------------------------------
our class Unsafe::G {

    proto rule maybe-unsafe { * }

    rule maybe-unsafe:sym<a> {
        <UNSAFE>
    }

    rule maybe-unsafe:sym<b> {

    }

    proto rule maybe-default_maybe_unsafe { * }

    rule maybe-default_maybe_unsafe:sym<a> {
        <DEFAULT> <UNSAFE>
    }

    rule maybe-default_maybe_unsafe:sym<b> {
        <DEFAULT>
    }

    rule maybe-default_maybe_unsafe:sym<c> {
        <UNSAFE>
    }

    rule maybe-default_maybe_unsafe:sym<d> {

    }
}

our class Unsafe::A {

    method maybe-unsafe:sym<a>($/) {
        make Unsafe.new
    }

    method maybe-unsafe:sym<b>($/) {
        MkNone<140540184096768>
    }

    method maybe-default_maybe_unsafe:sym<a>($/) {
        make DefaultUnsafe.new
    }

    method maybe-default_maybe_unsafe:sym<b>($/) {
        make Default.new
    }

    method maybe-default_maybe_unsafe:sym<c>($/) {
        make Unsafe.new
    }

    method maybe-default_maybe_unsafe:sym<d>($/) {
        MkNone<140540184096800>
    }
}

#------------------------------
our class Method {
    has $.ident;
    has $.fn_decl_with_self;
    has $.maybe_outer_attrs;
    has $.maybe_abi;
    has $.generic_params;
    has $.maybe_where_clause;
    has $.attrs_and_vis;
    has $.fn_decl_with_self_allow_anon_params;
    has $.maybe_unsafe;
    has $.maybe_default;
    has $.inner_attrs_and_block;
}

our class Provided {
    has $.method;
}

our class Required {
    has $.type_method;
}

our class TypeMethod {
    has $.fn_decl_with_self_allow_anon_params;
    has $.maybe_abi;
    has $.maybe_outer_attrs;
    has $.maybe_where_clause;
    has $.generic_params;
    has $.maybe_unsafe;
    has $.ident;
}

our class Method::G {

    proto rule trait-method { * }

    rule trait-method:sym<a> {
        <type-method>
    }

    rule trait-method:sym<b> {
        <method>
    }

    proto rule type-method { * }

    rule type-method:sym<a> {
        <maybe-outer_attrs> <maybe-unsafe> <FN> <ident> <generic-params> <fn-decl_with_self_allow_anon_params> <maybe-where_clause> ';'
    }

    rule type-method:sym<b> {
        <maybe-outer_attrs> <CONST> <maybe-unsafe> <FN> <ident> <generic-params> <fn-decl_with_self_allow_anon_params> <maybe-where_clause> ';'
    }

    rule type-method:sym<c> {
        <maybe-outer_attrs> <maybe-unsafe> <EXTERN> <maybe-abi> <FN> <ident> <generic-params> <fn-decl_with_self_allow_anon_params> <maybe-where_clause> ';'
    }

    proto rule method { * }

    rule method:sym<a> {
        <maybe-outer_attrs> <maybe-unsafe> <FN> <ident> <generic-params> <fn-decl_with_self_allow_anon_params> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule method:sym<b> {
        <maybe-outer_attrs> <CONST> <maybe-unsafe> <FN> <ident> <generic-params> <fn-decl_with_self_allow_anon_params> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule method:sym<c> {
        <maybe-outer_attrs> <maybe-unsafe> <EXTERN> <maybe-abi> <FN> <ident> <generic-params> <fn-decl_with_self_allow_anon_params> <maybe-where_clause> <inner-attrs_and_block>
    }

    proto rule impl-method { * }

    rule impl-method:sym<a> {
        <attrs-and_vis> <maybe-default> <maybe-unsafe> <FN> <ident> <generic-params> <fn-decl_with_self> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule impl-method:sym<b> {
        <attrs-and_vis> <maybe-default> <CONST> <maybe-unsafe> <FN> <ident> <generic-params> <fn-decl_with_self> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule impl-method:sym<c> {
        <attrs-and_vis> <maybe-default> <maybe-unsafe> <EXTERN> <maybe-abi> <FN> <ident> <generic-params> <fn-decl_with_self> <maybe-where_clause> <inner-attrs_and_block>
    }
}

our class Method::A {

    method trait-method:sym<a>($/) {
        make Required.new(
            type-method =>  $<type-method>.made,
        )
    }

    method trait-method:sym<b>($/) {
        make Provided.new(
            method =>  $<method>.made,
        )
    }

    method type-method:sym<a>($/) {
        make TypeMethod.new(
            maybe-outer_attrs                   =>  $<maybe-outer_attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl_with_self_allow_anon_params =>  $<fn-decl_with_self_allow_anon_params>.made,
            maybe-where_clause                  =>  $<maybe-where_clause>.made,
        )
    }

    method type-method:sym<b>($/) {
        make TypeMethod.new(
            maybe-outer_attrs                   =>  $<maybe-outer_attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl_with_self_allow_anon_params =>  $<fn-decl_with_self_allow_anon_params>.made,
            maybe-where_clause                  =>  $<maybe-where_clause>.made,
        )
    }

    method type-method:sym<c>($/) {
        make TypeMethod.new(
            maybe-outer_attrs                   =>  $<maybe-outer_attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            maybe-abi                           =>  $<maybe-abi>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl_with_self_allow_anon_params =>  $<fn-decl_with_self_allow_anon_params>.made,
            maybe-where_clause                  =>  $<maybe-where_clause>.made,
        )
    }

    method method:sym<a>($/) {
        make Method.new(
            maybe-outer_attrs                   =>  $<maybe-outer_attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl_with_self_allow_anon_params =>  $<fn-decl_with_self_allow_anon_params>.made,
            maybe-where_clause                  =>  $<maybe-where_clause>.made,
            inner-attrs_and_block               =>  $<inner-attrs_and_block>.made,
        )
    }

    method method:sym<b>($/) {
        make Method.new(
            maybe-outer_attrs                   =>  $<maybe-outer_attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl_with_self_allow_anon_params =>  $<fn-decl_with_self_allow_anon_params>.made,
            maybe-where_clause                  =>  $<maybe-where_clause>.made,
            inner-attrs_and_block               =>  $<inner-attrs_and_block>.made,
        )
    }

    method method:sym<c>($/) {
        make Method.new(
            maybe-outer_attrs                   =>  $<maybe-outer_attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            maybe-abi                           =>  $<maybe-abi>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl_with_self_allow_anon_params =>  $<fn-decl_with_self_allow_anon_params>.made,
            maybe-where_clause                  =>  $<maybe-where_clause>.made,
            inner-attrs_and_block               =>  $<inner-attrs_and_block>.made,
        )
    }

    method impl-method:sym<a>($/) {
        make Method.new(
            attrs-and_vis         =>  $<attrs-and_vis>.made,
            maybe-default         =>  $<maybe-default>.made,
            maybe-unsafe          =>  $<maybe-unsafe>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl_with_self     =>  $<fn-decl_with_self>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }

    method impl-method:sym<b>($/) {
        make Method.new(
            attrs-and_vis         =>  $<attrs-and_vis>.made,
            maybe-default         =>  $<maybe-default>.made,
            maybe-unsafe          =>  $<maybe-unsafe>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl_with_self     =>  $<fn-decl_with_self>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }

    method impl-method:sym<c>($/) {
        make Method.new(
            attrs-and_vis         =>  $<attrs-and_vis>.made,
            maybe-default         =>  $<maybe-default>.made,
            maybe-unsafe          =>  $<maybe-unsafe>.made,
            maybe-abi             =>  $<maybe-abi>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl_with_self     =>  $<fn-decl_with_self>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
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
# (such as maybe_once) or shall we continue
# shifting into the generic_params list for the
# impl?
#
# The production parser disambiguates a different
# case here by permitting / requiring the user to
# provide parens around types when they are
# ambiguous with traits. We do the same here,
# regrettably, by splitting ty into ty and
# ty_prim.
our class ImplItems {
    has $.impl_item;
}

our class ImplMacroItem {
    has $.item_macro;
    has $.attrs_and_vis;
}

our class ItemImpl {
    has $.trait_ref;
    has $.ty_prim_sum;
    has $.maybe_default_maybe_unsafe;
    has $.maybe_where_clause;
    has $.ty;
    has $.maybe_impl_items;
    has $.ty_sum;
    has $.generic_params;
    has $.maybe_inner_attrs;
}

our class ItemImplDefault {
    has $.maybe_default_maybe_unsafe;
    has $.generic_params;
    has $.trait_ref;
}

our class ItemImplDefaultNeg {
    has $.trait_ref;
    has $.maybe_default_maybe_unsafe;
    has $.generic_params;
}

our class ItemImplNeg {
    has $.maybe_default_maybe_unsafe;
    has $.maybe_inner_attrs;
    has $.trait_ref;
    has $.maybe_impl_items;
    has $.maybe_where_clause;
    has $.ty_sum;
    has $.generic_params;
}

our class ItemImpl::G {

    proto rule item-impl { * }

    rule item-impl:sym<a> {
        <maybe-default_maybe_unsafe> <IMPL> <generic-params> <ty-prim_sum> <maybe-where_clause> '{' <maybe-inner_attrs> <maybe-impl_items> '}'
    }

    rule item-impl:sym<b> {
        <maybe-default_maybe_unsafe> <IMPL> <generic-params> '(' <ty> ')' <maybe-where_clause> '{' <maybe-inner_attrs> <maybe-impl_items> '}'
    }

    rule item-impl:sym<c> {
        <maybe-default_maybe_unsafe> <IMPL> <generic-params> <trait-ref> <FOR> <ty-sum> <maybe-where_clause> '{' <maybe-inner_attrs> <maybe-impl_items> '}'
    }

    rule item-impl:sym<d> {
        <maybe-default_maybe_unsafe> <IMPL> <generic-params> '!' <trait-ref> <FOR> <ty-sum> <maybe-where_clause> '{' <maybe-inner_attrs> <maybe-impl_items> '}'
    }

    rule item-impl:sym<e> {
        <maybe-default_maybe_unsafe> <IMPL> <generic-params> <trait-ref> <FOR> <DOTDOT> '{' '}'
    }

    rule item-impl:sym<f> {
        <maybe-default_maybe_unsafe> <IMPL> <generic-params> '!' <trait-ref> <FOR> <DOTDOT> '{' '}'
    }

    proto rule maybe-impl_items { * }

    rule maybe-impl_items:sym<a> {
        <impl-items>
    }

    rule maybe-impl_items:sym<b> {

    }

    proto rule impl-items { * }

    rule impl-items:sym<a> {
        <impl-item>
    }

    rule impl-items:sym<b> {
        <impl-item> <impl-items>
    }

    proto rule impl-item { * }

    rule impl-item:sym<a> {
        <impl-method>
    }

    rule impl-item:sym<b> {
        <attrs-and_vis> <item-macro>
    }

    rule impl-item:sym<c> {
        <impl-const>
    }

    rule impl-item:sym<d> {
        <impl-type>
    }
}

our class ItemImpl::A {

    method item-impl:sym<a>($/) {
        make ItemImpl.new(
            maybe-default_maybe_unsafe =>  $<maybe-default_maybe_unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            ty-prim_sum                =>  $<ty-prim_sum>.made,
            maybe-where_clause         =>  $<maybe-where_clause>.made,
            maybe-inner_attrs          =>  $<maybe-inner_attrs>.made,
            maybe-impl_items           =>  $<maybe-impl_items>.made,
        )
    }

    method item-impl:sym<b>($/) {
        make ItemImpl.new(
            maybe-default_maybe_unsafe =>  $<maybe-default_maybe_unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            ty                         =>  $<ty>.made,
            maybe-where_clause         =>  $<maybe-where_clause>.made,
            maybe-inner_attrs          =>  $<maybe-inner_attrs>.made,
            maybe-impl_items           =>  $<maybe-impl_items>.made,
        )
    }

    method item-impl:sym<c>($/) {
        make ItemImpl.new(
            generic-params     =>  $<generic-params>.made,
            trait-ref          =>  $<trait-ref>.made,
            ty-sum             =>  $<ty-sum>.made,
            maybe-where_clause =>  $<maybe-where_clause>.made,
            maybe-inner_attrs  =>  $<maybe-inner_attrs>.made,
            maybe-impl_items   =>  $<maybe-impl_items>.made,
        )
    }

    method item-impl:sym<d>($/) {
        make ItemImplNeg.new(
            maybe-default_maybe_unsafe =>  $<maybe-default_maybe_unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            trait-ref                  =>  $<trait-ref>.made,
            ty-sum                     =>  $<ty-sum>.made,
            maybe-where_clause         =>  $<maybe-where_clause>.made,
            maybe-inner_attrs          =>  $<maybe-inner_attrs>.made,
            maybe-impl_items           =>  $<maybe-impl_items>.made,
        )
    }

    method item-impl:sym<e>($/) {
        make ItemImplDefault.new(
            maybe-default_maybe_unsafe =>  $<maybe-default_maybe_unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            trait-ref                  =>  $<trait-ref>.made,
        )
    }

    method item-impl:sym<f>($/) {
        make ItemImplDefaultNeg.new(
            maybe-default_maybe_unsafe =>  $<maybe-default_maybe_unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            trait-ref                  =>  $<trait-ref>.made,
        )
    }

    method maybe-impl_items:sym<a>($/) {
        make $<impl-items>.made
    }

    method maybe-impl_items:sym<b>($/) {
        MkNone<140235326792160>
    }

    method impl-items:sym<a>($/) {
        make ImplItems.new(
            impl-item =>  $<impl-item>.made,
        )
    }

    method impl-items:sym<b>($/) {
        ExtNode<140235329240080>
    }

    method impl-item:sym<a>($/) {
        make $<impl-method>.made
    }

    method impl-item:sym<b>($/) {
        make ImplMacroItem.new(
            attrs-and_vis =>  $<attrs-and_vis>.made,
            item-macro    =>  $<item-macro>.made,
        )
    }

    method impl-item:sym<c>($/) {
        make $<impl-const>.made
    }

    method impl-item:sym<d>($/) {
        make $<impl-type>.made
    }
}

#--------------------------
our class Default::G {

    proto rule maybe-default { * }

    rule maybe-default:sym<a> {
        <DEFAULT>
    }

    rule maybe-default:sym<b> {

    }
}

our class Default::A {

    method maybe-default:sym<a>($/) {
        make Default.new
    }

    method maybe-default:sym<b>($/) {
        MkNone<140252405044640>
    }
}

#--------------------------
our class ImplConst {
    has $.maybe_default;
    has $.attrs_and_vis;
    has $.item_const;
}

our class ImplConst::G {

    rule impl-const {
        <attrs-and_vis> <maybe-default> <item-const>
    }
}

our class ImplConst::A {

    method impl-const($/) {
        make ImplConst.new(
            attrs-and_vis =>  $<attrs-and_vis>.made,
            maybe-default =>  $<maybe-default>.made,
            item-const    =>  $<item-const>.made,
        )
    }
}

#--------------------------
our class ImplType {
    has $.generic_params;
    has $.attrs_and_vis;
    has $.ty_sum;
    has $.ident;
    has $.maybe_default;
}

our class ImplType::G {

    rule impl-type {
        <attrs-and_vis> <maybe-default> <TYPE> <ident> <generic-params> '=' <ty-sum> ';'
    }
}

our class ImplType::A {

    method impl-type($/) {
        make ImplType.new(
            attrs-and_vis  =>  $<attrs-and_vis>.made,
            maybe-default  =>  $<maybe-default>.made,
            ident          =>  $<ident>.made,
            generic-params =>  $<generic-params>.made,
            ty-sum         =>  $<ty-sum>.made,
        )
    }
}

#--------------------------
our class ItemFn {
    has $.fn_decl;
    has $.inner_attrs_and_block;
    has $.ident;
    has $.generic_params;
    has $.maybe_where_clause;
}

our class ItemUnsafeFn {
    has $.maybe_abi;
    has $.generic_params;
    has $.fn_decl;
    has $.ident;
    has $.maybe_where_clause;
    has $.inner_attrs_and_block;
}

our class ItemFn::G {

    proto rule item-fn { * }

    rule item-fn:sym<a> {
        <FN> <ident> <generic-params> <fn-decl> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule item-fn:sym<b> {
        <CONST> <FN> <ident> <generic-params> <fn-decl> <maybe-where_clause> <inner-attrs_and_block>
    }

    proto rule item-unsafe_fn { * }

    rule item-unsafe_fn:sym<a> {
        <UNSAFE> <FN> <ident> <generic-params> <fn-decl> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule item-unsafe_fn:sym<b> {
        <CONST> <UNSAFE> <FN> <ident> <generic-params> <fn-decl> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule item-unsafe_fn:sym<c> {
        <UNSAFE> <EXTERN> <maybe-abi> <FN> <ident> <generic-params> <fn-decl> <maybe-where_clause> <inner-attrs_and_block>
    }
}

our class ItemFn::A {

    method item-fn:sym<a>($/) {
        make ItemFn.new(
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }

    method item-fn:sym<b>($/) {
        make ItemFn.new(
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }

    method item-unsafe_fn:sym<a>($/) {
        make ItemUnsafeFn.new(
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }

    method item-unsafe_fn:sym<b>($/) {
        make ItemUnsafeFn.new(
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }

    method item-unsafe_fn:sym<c>($/) {
        make ItemUnsafeFn.new(
            maybe-abi             =>  $<maybe-abi>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }
}

#--------------------------
our class FnDecl {
    has $.ret_ty;
    has $.fn_params;
    has $.fn_params_with_self;
    has $.fn_anon_params_with_self;
}

our class FnDeclWithSelf::G {

    rule fn-decl {
        <fn-params> <ret-ty>
    }

    rule fn-decl_with_self {
        <fn-params_with_self> <ret-ty>
    }

    rule fn-decl_with_self_allow_anon_params {
        <fn-anon_params_with_self> <ret-ty>
    }
}

our class FnDeclWithSelf::A {

    method fn-decl($/) {
        make FnDecl.new(
            fn-params =>  $<fn-params>.made,
            ret-ty    =>  $<ret-ty>.made,
        )
    }

    method fn-decl_with_self($/) {
        make FnDecl.new(
            fn-params_with_self =>  $<fn-params_with_self>.made,
            ret-ty              =>  $<ret-ty>.made,
        )
    }

    method fn-decl_with_self_allow_anon_params($/) {
        make FnDecl.new(
            fn-anon_params_with_self =>  $<fn-anon_params_with_self>.made,
            ret-ty                   =>  $<ret-ty>.made,
        )
    }
}

#--------------------------
our class SelfLower {
    has $.maybe_ty_ascription;
    has $.maybe_comma_anon_params;
    has $.maybe_comma_params;
    has $.maybe_mut;
}

our class SelfRegion {
    has $.maybe_comma_anon_params;
    has $.maybe_comma_params;
    has $.lifetime;
    has $.maybe_mut;
    has $.maybe_ty_ascription;
}

our class SelfStatic {
    has $.maybe_params;
    has $.maybe_anon_params;
}

our class FnParams::G {

    rule fn-params {
        '(' <maybe-params> ')'
    }

    proto rule fn-anon_params { * }

    rule fn-anon_params:sym<a> {
        '(' <anon-param> <anon-params_allow_variadic_tail> ')'
    }

    rule fn-anon_params:sym<b> {
        '(' ')'
    }

    proto rule fn-params_with_self { * }

    rule fn-params_with_self:sym<a> {
        '(' <maybe-mut> <SELF> <maybe-ty_ascription> <maybe-comma_params> ')'
    }

    rule fn-params_with_self:sym<b> {
        '(' '&' <maybe-mut> <SELF> <maybe-ty_ascription> <maybe-comma_params> ')'
    }

    rule fn-params_with_self:sym<c> {
        '(' '&' <lifetime> <maybe-mut> <SELF> <maybe-ty_ascription> <maybe-comma_params> ')'
    }

    rule fn-params_with_self:sym<d> {
        '(' <maybe-params> ')'
    }

    proto rule fn-anon_params_with_self { * }

    rule fn-anon_params_with_self:sym<a> {
        '(' <maybe-mut> <SELF> <maybe-ty_ascription> <maybe-comma_anon_params> ')'
    }

    rule fn-anon_params_with_self:sym<b> {
        '(' '&' <maybe-mut> <SELF> <maybe-ty_ascription> <maybe-comma_anon_params> ')'
    }

    rule fn-anon_params_with_self:sym<c> {
        '(' '&' <lifetime> <maybe-mut> <SELF> <maybe-ty_ascription> <maybe-comma_anon_params> ')'
    }

    rule fn-anon_params_with_self:sym<d> {
        '(' <maybe-anon_params> ')'
    }
}

our class FnParams::A {

    method fn-params($/) {
        make $<maybe_params>.made
    }

    method fn-anon_params:sym<a>($/) {
        ExtNode<140218049450816>
    }

    method fn-anon_params:sym<b>($/) {
        MkNone<140218049468352>
    }

    method fn-params_with_self:sym<a>($/) {
        make SelfLower.new(
            maybe-mut           =>  $<maybe-mut>.made,
            maybe-ty_ascription =>  $<maybe-ty_ascription>.made,
            maybe-comma_params  =>  $<maybe-comma_params>.made,
        )
    }

    method fn-params_with_self:sym<b>($/) {
        make SelfRegion.new(
            maybe-mut           =>  $<maybe-mut>.made,
            maybe-ty_ascription =>  $<maybe-ty_ascription>.made,
            maybe-comma_params  =>  $<maybe-comma_params>.made,
        )
    }

    method fn-params_with_self:sym<c>($/) {
        make SelfRegion.new(
            lifetime            =>  $<lifetime>.made,
            maybe-mut           =>  $<maybe-mut>.made,
            maybe-ty_ascription =>  $<maybe-ty_ascription>.made,
            maybe-comma_params  =>  $<maybe-comma_params>.made,
        )
    }

    method fn-params_with_self:sym<d>($/) {
        make SelfStatic.new(
            maybe-params =>  $<maybe-params>.made,
        )
    }

    method fn-anon_params_with_self:sym<a>($/) {
        make SelfLower.new(
            maybe-mut               =>  $<maybe-mut>.made,
            maybe-ty_ascription     =>  $<maybe-ty_ascription>.made,
            maybe-comma_anon_params =>  $<maybe-comma_anon_params>.made,
        )
    }

    method fn-anon_params_with_self:sym<b>($/) {
        make SelfRegion.new(
            maybe-mut               =>  $<maybe-mut>.made,
            maybe-ty_ascription     =>  $<maybe-ty_ascription>.made,
            maybe-comma_anon_params =>  $<maybe-comma_anon_params>.made,
        )
    }

    method fn-anon_params_with_self:sym<c>($/) {
        make SelfRegion.new(
            lifetime                =>  $<lifetime>.made,
            maybe-mut               =>  $<maybe-mut>.made,
            maybe-ty_ascription     =>  $<maybe-ty_ascription>.made,
            maybe-comma_anon_params =>  $<maybe-comma_anon_params>.made,
        )
    }

    method fn-anon_params_with_self:sym<d>($/) {
        make SelfStatic.new(
            maybe-anon_params =>  $<maybe-anon_params>.made,
        )
    }
}

#--------------------------
our class Arg {
    has $.ty_sum;
    has $.pat;
}

our class Args {
    has $.param;
}

our class Params::G {

    proto rule maybe-params { * }

    rule maybe-params:sym<a> {
        <params>
    }

    rule maybe-params:sym<b> {
        <params> ','
    }

    rule maybe-params:sym<c> {

    }

    proto rule params { * }

    rule params:sym<a> {
        <param>
    }

    rule params:sym<b> {
        <params> ',' <param>
    }

    rule param {
        <pat> ':' <ty-sum>
    }

    proto rule maybe-comma_params { * }

    rule maybe-comma_params:sym<a> {
        ','
    }

    rule maybe-comma_params:sym<b> {
        ',' <params>
    }

    rule maybe-comma_params:sym<c> {
        ',' <params> ','
    }

    rule maybe-comma_params:sym<d> {

    }
}

our class Params::A {

    method maybe-params:sym<a>($/) {
        make $<params>.made
    }

    method maybe-params:sym<b>($/) {

    }

    method maybe-params:sym<c>($/) {
        MkNone<140389581740544>
    }

    method params:sym<a>($/) {
        make Args.new(
            param =>  $<param>.made,
        )
    }

    method params:sym<b>($/) {
        ExtNode<140389582675544>
    }

    method param($/) {
        make Arg.new(
            pat    =>  $<pat>.made,
            ty-sum =>  $<ty-sum>.made,
        )
    }

    method maybe-comma_params:sym<a>($/) {
        MkNone<140389582707232>
    }

    method maybe-comma_params:sym<b>($/) {
        make $<params>.made
    }

    method maybe-comma_params:sym<c>($/) {
        make $<params>.made
    }

    method maybe-comma_params:sym<d>($/) {
        MkNone<140389582707264>
    }
}

#--------------------------
our class InferrableParam {
    has $.pat;
    has $.maybe_ty_ascription;
}

our class InferrableParams {
    has $.inferrable_param;
}

our class InferrableParams::G {

    proto rule inferrable-params { * }

    rule inferrable-params:sym<a> {
        <inferrable-param>
    }

    rule inferrable-params:sym<b> {
        <inferrable-params> ',' <inferrable-param>
    }

    rule inferrable-param {
        <pat> <maybe-ty_ascription>
    }
}

our class InferrableParams::A {

    method inferrable-params:sym<a>($/) {
        make InferrableParams.new(
            inferrable-param =>  $<inferrable-param>.made,
        )
    }

    method inferrable-params:sym<b>($/) {
        ExtNode<140499837100840>
    }

    method inferrable-param($/) {
        make InferrableParam.new(
            pat                 =>  $<pat>.made,
            maybe-ty_ascription =>  $<maybe-ty_ascription>.made,
        )
    }
}

#--------------------------
our class Arg {
    has $.named_arg;
    has $.ty;
}

our class Args {
    has $.anon_params_allow_variadic_tail;
    has $.anon_param;
}

# anon means it's allowed to be anonymous
# (type-only), but it can still have a name
our class AnonParams::G {

    proto rule maybe-comma_anon_params { * }

    rule maybe-comma_anon_params:sym<a> {
        ','
    }

    rule maybe-comma_anon_params:sym<b> {
        ',' <anon-params>
    }

    rule maybe-comma_anon_params:sym<c> {
        ',' <anon-params> ','
    }

    rule maybe-comma_anon_params:sym<d> {

    }

    proto rule maybe-anon_params { * }

    rule maybe-anon_params:sym<a> {
        <anon-params>
    }

    rule maybe-anon_params:sym<b> {
        <anon-params> ','
    }

    rule maybe-anon_params:sym<c> {

    }

    proto rule anon-params { * }

    rule anon-params:sym<a> {
        <anon-param>
    }

    rule anon-params:sym<b> {
        <anon-params> ',' <anon-param>
    }

    proto rule anon-param { * }

    rule anon-param:sym<a> {
        <named-arg> ':' <ty>
    }

    rule anon-param:sym<b> {
        <ty>
    }

    proto rule anon-params_allow_variadic_tail { * }

    rule anon-params_allow_variadic_tail:sym<a> {
        ',' <DOTDOTDOT>
    }

    rule anon-params_allow_variadic_tail:sym<b> {
        ',' <anon-param> <anon-params_allow_variadic_tail>
    }

    rule anon-params_allow_variadic_tail:sym<c> {

    }
}

our class AnonParams::A {

    method maybe-comma_anon_params:sym<a>($/) {
        MkNone<140355664378144>
    }

    method maybe-comma_anon_params:sym<b>($/) {
        make $<anon_params>.made
    }

    method maybe-comma_anon_params:sym<c>($/) {
        make $<anon_params>.made
    }

    method maybe-comma_anon_params:sym<d>($/) {
        MkNone<140355664378176>
    }

    method maybe-anon_params:sym<a>($/) {
        make $<anon-params>.made
    }

    method maybe-anon_params:sym<b>($/) {

    }

    method maybe-anon_params:sym<c>($/) {
        MkNone<140355664378208>
    }

    method anon-params:sym<a>($/) {
        make Args.new(
            anon-param =>  $<anon-param>.made,
        )
    }

    method anon-params:sym<b>($/) {
        ExtNode<140357023572960>
    }

    method anon-param:sym<a>($/) {
        make Arg.new(
            named-arg =>  $<named-arg>.made,
            ty        =>  $<ty>.made,
        )
    }

    method anon-param:sym<b>($/) {
        make $<ty>.made
    }

    method anon-params_allow_variadic_tail:sym<a>($/) {
        MkNone<140356205527168>
    }

    method anon-params_allow_variadic_tail:sym<b>($/) {
        make Args.new(
            anon-param                      =>  $<anon-param>.made,
            anon-params_allow_variadic_tail =>  $<anon-params_allow_variadic_tail>.made,
        )
    }

    method anon-params_allow_variadic_tail:sym<c>($/) {
        MkNone<140356205527200>
    }
}

#--------------------------
our class NamedArg::G {

    proto rule named-arg { * }

    rule named-arg:sym<a> {
        <ident>
    }

    rule named-arg:sym<b> {
        <UNDERSCORE>
    }

    rule named-arg:sym<c> {
        '&' <ident>
    }

    rule named-arg:sym<d> {
        '&' <UNDERSCORE>
    }

    rule named-arg:sym<e> {
        <ANDAND> <ident>
    }

    rule named-arg:sym<f> {
        <ANDAND> <UNDERSCORE>
    }

    rule named-arg:sym<g> {
        <MUT> <ident>
    }
}

our class NamedArg::A {

    method named-arg:sym<a>($/) {
        make $<ident>.made
    }

    method named-arg:sym<b>($/) {
        make PatWild.new
    }

    method named-arg:sym<c>($/) {
        make $<ident>.made
    }

    method named-arg:sym<d>($/) {
        make PatWild.new
    }

    method named-arg:sym<e>($/) {
        make $<ident>.made
    }

    method named-arg:sym<f>($/) {
        make PatWild.new
    }

    method named-arg:sym<g>($/) {
        make $<ident>.made
    }
}

#--------------------------
our class Ret-ty {
    has $.ty;
}

our class RetTy::G {

    proto rule ret-ty { * }

    rule ret-ty:sym<a> {
        <RARROW> '!'
    }

    rule ret-ty:sym<b> {
        <RARROW> <ty>
    }

    rule ret-ty:sym<c> {
        #%prec IDENT 
    }
}

our class RetTy::A {

    method ret-ty:sym<a>($/) {
        MkNone<140295749868448>
    }

    method ret-ty:sym<b>($/) {
        make ret-ty.new(
            ty =>  $<ty>.made,
        )
    }

    method ret-ty:sym<c>($/) {
        MkNone<140295749870336>
    }
}

#--------------------------
our class Generics {
    has $.ty_params;
    has $.lifetimes;
}

our class GenericParams::G {

    proto rule generic-params { * }

    rule generic-params:sym<a> {
        '<' '>'
    }

    rule generic-params:sym<b> {
        '<' <lifetimes> '>'
    }

    rule generic-params:sym<c> {
        '<' <lifetimes> ',' '>'
    }

    rule generic-params:sym<f> {
        '<' <lifetimes> ',' <ty-params> '>'
    }

    rule generic-params:sym<g> {
        '<' <lifetimes> ',' <ty-params> ',' '>'
    }

    rule generic-params:sym<j> {
        '<' <ty-params> '>'
    }

    rule generic-params:sym<k> {
        '<' <ty-params> ',' '>'
    }

    rule generic-params:sym<n> {

    }
}

our class GenericParams::A {

    method generic-params:sym<a>($/) {
        make Generics.new(

        )
    }

    method generic-params:sym<b>($/) {
        make Generics.new(
            lifetimes =>  $<lifetimes>.made,
        )
    }

    method generic-params:sym<c>($/) {
        make Generics.new(
            lifetimes =>  $<lifetimes>.made,
        )
    }

    method generic-params:sym<f>($/) {
        make Generics.new(
            lifetimes =>  $<lifetimes>.made,
            ty-params =>  $<ty-params>.made,
        )
    }

    method generic-params:sym<g>($/) {
        make Generics.new(
            lifetimes =>  $<lifetimes>.made,
            ty-params =>  $<ty-params>.made,
        )
    }

    method generic-params:sym<j>($/) {
        make Generics.new(
            ty-params =>  $<ty-params>.made,
        )
    }

    method generic-params:sym<k>($/) {
        make Generics.new(
            ty-params =>  $<ty-params>.made,
        )
    }

    method generic-params:sym<n>($/) {
        MkNone<140527400197696>
    }
}

#--------------------------
our class WhereClause {
    has $.where_predicates;
}

our class WhereClause::G {

    proto rule maybe-where_clause { * }

    rule maybe-where_clause:sym<a> {

    }

    rule maybe-where_clause:sym<b> {
        <where-clause>
    }

    proto rule where-clause { * }

    rule where-clause:sym<a> {
        <WHERE> <where-predicates>
    }

    rule where-clause:sym<b> {
        <WHERE> <where-predicates> ','
    }
}

our class WhereClause::A {

    method maybe-where_clause:sym<a>($/) {
        MkNone<140613549527104>
    }

    method maybe-where_clause:sym<b>($/) {
        make $<where-clause>.made
    }

    method where-clause:sym<a>($/) {
        make WhereClause.new(
            where-predicates =>  $<where-predicates>.made,
        )
    }

    method where-clause:sym<b>($/) {
        make WhereClause.new(
            where-predicates =>  $<where-predicates>.made,
        )
    }
}

#--------------------------
our class WherePredicate {
    has $.maybe_for_lifetimes;
    has $.bounds;
    has $.lifetime;
    has $.ty_param_bounds;
    has $.ty;
}

our class WherePredicates {
    has $.where_predicate;
}

our class WherePredicates::G {

    proto rule where-predicates { * }

    rule where-predicates:sym<a> {
        <where-predicate>
    }

    rule where-predicates:sym<b> {
        <where-predicates> ',' <where-predicate>
    }

    proto rule where-predicate { * }

    rule where-predicate:sym<a> {
        <maybe-for_lifetimes> <lifetime> ':' <bounds>
    }

    rule where-predicate:sym<b> {
        <maybe-for_lifetimes> <ty> ':' <ty-param_bounds>
    }
}

our class WherePredicates::A {

    method where-predicates:sym<a>($/) {
        make WherePredicates.new(
            where-predicate =>  $<where-predicate>.made,
        )
    }

    method where-predicates:sym<b>($/) {
        ExtNode<140202784484832>
    }

    method where-predicate:sym<a>($/) {
        make WherePredicate.new(
            maybe-for_lifetimes =>  $<maybe-for_lifetimes>.made,
            lifetime            =>  $<lifetime>.made,
            bounds              =>  $<bounds>.made,
        )
    }

    method where-predicate:sym<b>($/) {
        make WherePredicate.new(
            maybe-for_lifetimes =>  $<maybe-for_lifetimes>.made,
            ty                  =>  $<ty>.made,
            ty-param_bounds     =>  $<ty-param_bounds>.made,
        )
    }
}

#--------------------------
our class ForLifetimes::G {

    proto rule maybe-for_lifetimes { * }

    rule maybe-for_lifetimes:sym<a> {
        <FOR> '<' <lifetimes> '>'
    }

    rule maybe-for_lifetimes:sym<b> {
        # %prec FORTYPE 
    }
}

our class ForLifetimes::A {

    method maybe-for_lifetimes:sym<a>($/) {
        MkNone<140569789206720>
    }

    method maybe-for_lifetimes:sym<b>($/) {
        MkNone<140569789206752>
    }
}

#--------------------------
our class TyParams {
    has $.ty_param;
}

our class TyParams::G {

    proto rule ty-params { * }

    rule ty-params:sym<a> {
        <ty-param>
    }

    rule ty-params:sym<b> {
        <ty-params> ',' <ty-param>
    }
}

our class TyParams::A {

    method ty-params:sym<a>($/) {
        make TyParams.new(
            ty-param =>  $<ty-param>.made,
        )
    }

    method ty-params:sym<b>($/) {
        ExtNode<140699547191112>
    }
}

#--------------------------
# A path with no type parameters;
# e.g. `foo::bar::Baz`
#
# These show up in 'use' view-items, because these
# are processed without respect to types.
our class ViewPath {
    has $.ident;
}

our class PathNoTypesAllowed::G {

    proto rule path-no_types_allowed { * }

    rule path-no_types_allowed:sym<a> {
        <ident>
    }

    rule path-no_types_allowed:sym<b> {
        <MOD-SEP> <ident>
    }

    rule path-no_types_allowed:sym<c> {
        <SELF>
    }

    rule path-no_types_allowed:sym<d> {
        <MOD-SEP> <SELF>
    }

    rule path-no_types_allowed:sym<e> {
        <SUPER>
    }

    rule path-no_types_allowed:sym<f> {
        <MOD-SEP> <SUPER>
    }

    rule path-no_types_allowed:sym<g> {
        <path-no_types_allowed> <MOD-SEP> <ident>
    }
}

our class PathNoTypesAllowed::A {

    method path-no_types_allowed:sym<a>($/) {
        make ViewPath.new(
            ident =>  $<ident>.made,
        )
    }

    method path-no_types_allowed:sym<b>($/) {
        make ViewPath.new(
            ident =>  $<ident>.made,
        )
    }

    method path-no_types_allowed:sym<c>($/) {
        make ViewPath.new(

        )
    }

    method path-no_types_allowed:sym<d>($/) {
        make ViewPath.new(

        )
    }

    method path-no_types_allowed:sym<e>($/) {
        make ViewPath.new(

        )
    }

    method path-no_types_allowed:sym<f>($/) {
        make ViewPath.new(

        )
    }

    method path-no_types_allowed:sym<g>($/) {
        ExtNode<140417223175656>
    }
}

#--------------------------
# A path with a lifetime and type parameters, with
# no double colons before the type parameters;
# e.g. `foo::bar<'a>::Baz<T>`
#
# These show up in "trait references", the
# components of type-parameter bounds lists, as
# well as in the prefix of the
# path_generic_args_and_bounds rule, which is the
# full form of a named typed expression.
#
# They do not have (nor need) an extra '::' before
# '<' because unlike in expr context, there are no
# "less-than" type exprs to be ambiguous with.
our class Components {
    has $.maybe_ty_sums;
    has $.generic_args;
    has $.ident;
}

our class PathNoTypesAllowed::G {

    proto rule path-generic_args_without_colons { * }

    rule path-generic_args_without_colons:sym<a> {
        {self.set-prec(IDENT)} <ident>
    }

    rule path-generic_args_without_colons:sym<b> {
        {self.set-prec(IDENT)} <ident> <generic-args>
    }

    rule path-generic_args_without_colons:sym<c> {
        {self.set-prec(IDENT)} <ident> '(' <maybe-ty_sums> ')' <ret-ty>
    }

    rule path-generic_args_without_colons:sym<d> {
        {self.set-prec(IDENT)} <path-generic_args_without_colons> <MOD-SEP> <ident>
    }

    rule path-generic_args_without_colons:sym<e> {
        {self.set-prec(IDENT)} <path-generic_args_without_colons> <MOD-SEP> <ident> <generic-args>
    }

    rule path-generic_args_without_colons:sym<f> {
        {self.set-prec(IDENT)} <path-generic_args_without_colons> <MOD-SEP> <ident> '(' <maybe-ty_sums> ')' <ret-ty>
    }
}

our class PathNoTypesAllowed::A {

    method path-generic_args_without_colons:sym<a>($/) {
        make components.new(
            ident =>  $<ident>.made,
        )
    }

    method path-generic_args_without_colons:sym<b>($/) {
        make components.new(
            ident        =>  $<ident>.made,
            generic-args =>  $<generic-args>.made,
        )
    }

    method path-generic_args_without_colons:sym<c>($/) {
        make components.new(
            ident         =>  $<ident>.made,
            maybe-ty_sums =>  $<maybe-ty_sums>.made,
        )
    }

    method path-generic_args_without_colons:sym<d>($/) {
        ExtNode<140204309020904>
    }

    method path-generic_args_without_colons:sym<e>($/) {
        ExtNode<140204309020944>
    }

    method path-generic_args_without_colons:sym<f>($/) {
        ExtNode<140204309020984>
    }
}

#--------------------------
our class GenericValues {
    has $.maybe_ty_sums_and_or_bindings;
}

our class GenericArgs::G {

    proto rule generic-args { * }

    rule generic-args:sym<a> {
        '<' <generic-values> '>'
    }

    # If generic_args starts with "<<", the first
    # arg must be a TyQualifiedPath because that's
    # the only type that can start with
    # a '<'. This rule parses that as the first
    # ty_sum and then continues with the rest of
    # generic_values.
    rule generic-args:sym<b> {
        <SHL> <ty-qualified_path_and_generic_values> '>'
    }

    rule generic-values {
        <maybe-ty_sums_and_or_bindings>
    }
}

our class GenericArgs::A {

    method generic-args:sym<a>($/) {
        make $<generic_values>.made
    }

    method generic-args:sym<b>($/) {
        make $<ty_qualified_path_and_generic_values>.made
    }

    method generic-values($/) {
        make GenericValues.new(
            maybe-ty_sums_and_or_bindings =>  $<maybe-ty_sums_and_or_bindings>.made,
        )
    }
}

#--------------------------
our class TySumsAndBindings {
    has $.bindings;
    has $.ty_sums;
}

our class TySumsAndBindings::G {

    proto rule maybe-ty_sums_and_or_bindings { * }

    rule maybe-ty_sums_and_or_bindings:sym<a> {
        <ty-sums>
    }

    rule maybe-ty_sums_and_or_bindings:sym<b> {
        <ty-sums> ','
    }

    rule maybe-ty_sums_and_or_bindings:sym<c> {
        <ty-sums> ',' <bindings>
    }

    rule maybe-ty_sums_and_or_bindings:sym<d> {
        <bindings>
    }

    rule maybe-ty_sums_and_or_bindings:sym<e> {
        <bindings> ','
    }

    rule maybe-ty_sums_and_or_bindings:sym<f> {

    }

    proto rule maybe-bindings { * }

    rule maybe-bindings:sym<a> {
        ',' <bindings>
    }

    rule maybe-bindings:sym<b> {

    }
}

our class TySumsAndBindings::A {

    method maybe-ty_sums_and_or_bindings:sym<a>($/) {
        make $<ty-sums>.made
    }

    method maybe-ty_sums_and_or_bindings:sym<b>($/) {

    }

    method maybe-ty_sums_and_or_bindings:sym<c>($/) {
        make TySumsAndBindings.new(
            ty-sums  =>  $<ty-sums>.made,
            bindings =>  $<bindings>.made,
        )
    }

    method maybe-ty_sums_and_or_bindings:sym<d>($/) {
        make $<bindings>.made
    }

    method maybe-ty_sums_and_or_bindings:sym<e>($/) {

    }

    method maybe-ty_sums_and_or_bindings:sym<f>($/) {
        MkNone<140698413986528>
    }

    method maybe-bindings:sym<a>($/) {
        make $<bindings>.made
    }

    method maybe-bindings:sym<b>($/) {
        MkNone<140698413986560>
    }
}

#////////////////////////////////////////////////////////////////////
# Part 2: Patterns
#////////////////////////////////////////////////////////////////////
our class PatEnum {
    has $.path_expr;
    has $.pat_tup;
}

our class PatIdent {
    has $.pat;
    has $.ident;
    has $.binding_mode;
}

our class PatMac {
    has $.maybe_ident;
    has $.path_expr;
    has $.delimited_token_trees;
}

our class PatQualifiedPath {
    has $.maybe_as_trait_ref;
    has $.ident;
    has $.ty_sum;
}

our class PatRange {
    has $.lit_or_path;
}

our class PatRegion {
    has $.pat;
}

our class PatStruct {
    has $.path_expr;
    has $.pat_struct;
}

our class PatTup {
    has $.pat_tup;
}

our class PatUniq {
    has $.pat;
}

our class PatVec {
    has $.pat_vec;
}

our class Pats {
    has $.pat;
}

our class Pat::G {

    proto rule pat { * }

    rule pat:sym<a> {
        <UNDERSCORE>
    }

    rule pat:sym<b> {
        '&' <pat>
    }

    rule pat:sym<c> {
        '&' <MUT> <pat>
    }

    rule pat:sym<d> {
        <ANDAND> <pat>
    }

    rule pat:sym<e> {
        '(' ')'
    }

    rule pat:sym<f> {
        '(' <pat-tup> ')'
    }

    rule pat:sym<g> {
        '[' <pat-vec> ']'
    }

    rule pat:sym<h> {
        <lit-or_path>
    }

    rule pat:sym<i> {
        <lit-or_path> <DOTDOTDOT> <lit-or_path>
    }

    rule pat:sym<j> {
        <path-expr> '{' <pat-struct> '}'
    }

    rule pat:sym<k> {
        <path-expr> '(' ')'
    }

    rule pat:sym<l> {
        <path-expr> '(' <pat-tup> ')'
    }

    rule pat:sym<m> {
        <path-expr> '!' <maybe-ident> <delimited-token_trees>
    }

    rule pat:sym<n> {
        <binding-mode> <ident>
    }

    rule pat:sym<o> {
        <ident> '@' <pat>
    }

    rule pat:sym<p> {
        <binding-mode> <ident> '@' <pat>
    }

    rule pat:sym<q> {
        <BOX> <pat>
    }

    rule pat:sym<r> {
        '<' <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident>
    }

    rule pat:sym<s> {
        <SHL> <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <maybe-as_trait_ref> '>' <MOD-SEP> <ident>
    }

    proto rule pats-or { * }

    rule pats-or:sym<a> {
        <pat>
    }

    rule pats-or:sym<b> {
        <pats-or> '|' <pat>
    }
}

our class Pat::A {

    method pat:sym<a>($/) {
        make PatWild.new
    }

    method pat:sym<b>($/) {
        make PatRegion.new(
            pat =>  $<pat>.made,
        )
    }

    method pat:sym<c>($/) {
        make PatRegion.new(
            pat =>  $<pat>.made,
        )
    }

    method pat:sym<d>($/) {
        make PatRegion.new(

        )
    }

    method pat:sym<e>($/) {
        make PatUnit.new
    }

    method pat:sym<f>($/) {
        make PatTup.new(
            pat-tup =>  $<pat-tup>.made,
        )
    }

    method pat:sym<g>($/) {
        make PatVec.new(
            pat-vec =>  $<pat-vec>.made,
        )
    }

    method pat:sym<h>($/) {
        make $<lit-or_path>.made
    }

    method pat:sym<i>($/) {
        make PatRange.new(
            lit-or_path =>  $<lit-or_path>.made,
            lit-or_path =>  $<lit-or_path>.made,
        )
    }

    method pat:sym<j>($/) {
        make PatStruct.new(
            path-expr  =>  $<path-expr>.made,
            pat-struct =>  $<pat-struct>.made,
        )
    }

    method pat:sym<k>($/) {
        make PatEnum.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method pat:sym<l>($/) {
        make PatEnum.new(
            path-expr =>  $<path-expr>.made,
            pat-tup   =>  $<pat-tup>.made,
        )
    }

    method pat:sym<m>($/) {
        make PatMac.new(
            path-expr             =>  $<path-expr>.made,
            maybe-ident           =>  $<maybe-ident>.made,
            delimited-token_trees =>  $<delimited-token_trees>.made,
        )
    }

    method pat:sym<n>($/) {
        make PatIdent.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
        )
    }

    method pat:sym<o>($/) {
        make PatIdent.new(
            ident =>  $<ident>.made,
            pat   =>  $<pat>.made,
        )
    }

    method pat:sym<p>($/) {
        make PatIdent.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
            pat          =>  $<pat>.made,
        )
    }

    method pat:sym<q>($/) {
        make PatUniq.new(
            pat =>  $<pat>.made,
        )
    }

    method pat:sym<r>($/) {
        make PatQualifiedPath.new(
            ty-sum             =>  $<ty-sum>.made,
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method pat:sym<s>($/) {
        make PatQualifiedPath.new(
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method pats-or:sym<a>($/) {
        make Pats.new(
            pat =>  $<pat>.made,
        )
    }

    method pats-or:sym<b>($/) {
        ExtNode<140665525299992>
    }
}

#-----------------------------------
our class BindingMode::G {

    proto rule binding-mode { * }

    rule binding-mode:sym<a> {
        <REF>
    }

    rule binding-mode:sym<b> {
        <REF> <MUT>
    }

    rule binding-mode:sym<c> {
        <MUT>
    }
}

our class BindingMode::A {

    method binding-mode:sym<a>($/) {
        make BindByRef.new(

        )
    }

    method binding-mode:sym<b>($/) {
        make BindByRef.new(

        )
    }

    method binding-mode:sym<c>($/) {
        make BindByValue.new(

        )
    }
}

#-----------------------------------
our class PatLit {
    has $.lit;
    has $.path_expr;
}

our class LitOrPath::G {

    proto rule lit-or_path { * }

    rule lit-or_path:sym<a> {
        <path-expr>
    }

    rule lit-or_path:sym<b> {
        <lit>
    }

    rule lit-or_path:sym<c> {
        '-' <lit>
    }
}

our class LitOrPath::A {

    method lit-or_path:sym<a>($/) {
        make PatLit.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method lit-or_path:sym<b>($/) {
        make PatLit.new(
            lit =>  $<lit>.made,
        )
    }

    method lit-or_path:sym<c>($/) {
        make PatLit.new(
            lit =>  $<lit>.made,
        )
    }
}

#-----------------------------------
our class PatField {
    has $.ident;
    has $.pat;
    has $.binding_mode;
}

our class PatFields {
    has $.pat_field;
}

our class PatField::G {

    proto rule pat-field { * }

    rule pat-field:sym<a> {
        <ident>
    }

    rule pat-field:sym<b> {
        <binding-mode> <ident>
    }

    rule pat-field:sym<c> {
        <BOX> <ident>
    }

    rule pat-field:sym<d> {
        <BOX> <binding-mode> <ident>
    }

    rule pat-field:sym<e> {
        <ident> ':' <pat>
    }

    rule pat-field:sym<f> {
        <binding-mode> <ident> ':' <pat>
    }

    rule pat-field:sym<g> {
        <LIT-INTEGER> ':' <pat>
    }

    proto rule pat-fields { * }

    rule pat-fields:sym<a> {
        <pat-field>
    }

    rule pat-fields:sym<b> {
        <pat-fields> ',' <pat-field>
    }
}

our class PatField::A {

    method pat-field:sym<a>($/) {
        make PatField.new(
            ident =>  $<ident>.made,
        )
    }

    method pat-field:sym<b>($/) {
        make PatField.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
        )
    }

    method pat-field:sym<c>($/) {
        make PatField.new(
            ident =>  $<ident>.made,
        )
    }

    method pat-field:sym<d>($/) {
        make PatField.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
        )
    }

    method pat-field:sym<e>($/) {
        make PatField.new(
            ident =>  $<ident>.made,
            pat   =>  $<pat>.made,
        )
    }

    method pat-field:sym<f>($/) {
        make PatField.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
            pat          =>  $<pat>.made,
        )
    }

    method pat-field:sym<g>($/) {
        make PatField.new(
            pat =>  $<pat>.made,
        )
    }

    method pat-fields:sym<a>($/) {
        make PatFields.new(
            pat-field =>  $<pat-field>.made,
        )
    }

    method pat-fields:sym<b>($/) {
        ExtNode<140414857521552>
    }
}

#-----------------------------------
our class PatStruct {
    has $.pat_fields;
}

our class PatStruct::G {

    proto rule pat-struct { * }

    rule pat-struct:sym<a> {
        <pat-fields>
    }

    rule pat-struct:sym<b> {
        <pat-fields> ','
    }

    rule pat-struct:sym<c> {
        <pat-fields> ',' <DOTDOT>
    }

    rule pat-struct:sym<d> {
        <DOTDOT>
    }

    rule pat-struct:sym<e> {

    }
}

our class PatStruct::A {

    method pat-struct:sym<a>($/) {
        make PatStruct.new(
            pat-fields =>  $<pat-fields>.made,
        )
    }

    method pat-struct:sym<b>($/) {
        make PatStruct.new(
            pat-fields =>  $<pat-fields>.made,
        )
    }

    method pat-struct:sym<c>($/) {
        make PatStruct.new(
            pat-fields =>  $<pat-fields>.made,
        )
    }

    method pat-struct:sym<d>($/) {
        make PatStruct.new(

        )
    }

    method pat-struct:sym<e>($/) {
        make PatStruct.new(

        )
    }
}

#-----------------------------------
our class PatTup {
    has $.pat_tup_elts;
}

our class PatTupElts {
    has $.pat;
}

our class PatTup::G {

    proto rule pat-tup { * }

    rule pat-tup:sym<a> {
        <pat-tup_elts>
    }

    rule pat-tup:sym<b> {
        <pat-tup_elts> ','
    }

    rule pat-tup:sym<c> {
        <pat-tup_elts> <DOTDOT>
    }

    rule pat-tup:sym<d> {
        <pat-tup_elts> ',' <DOTDOT>
    }

    rule pat-tup:sym<e> {
        <pat-tup_elts> <DOTDOT> ',' <pat-tup_elts>
    }

    rule pat-tup:sym<f> {
        <pat-tup_elts> <DOTDOT> ',' <pat-tup_elts> ','
    }

    rule pat-tup:sym<g> {
        <pat-tup_elts> ',' <DOTDOT> ',' <pat-tup_elts>
    }

    rule pat-tup:sym<h> {
        <pat-tup_elts> ',' <DOTDOT> ',' <pat-tup_elts> ','
    }

    rule pat-tup:sym<i> {
        <DOTDOT> ',' <pat-tup_elts>
    }

    rule pat-tup:sym<j> {
        <DOTDOT> ',' <pat-tup_elts> ','
    }

    rule pat-tup:sym<k> {
        <DOTDOT>
    }

    proto rule pat-tup_elts { * }

    rule pat-tup_elts:sym<a> {
        <pat>
    }

    rule pat-tup_elts:sym<b> {
        <pat-tup_elts> ',' <pat>
    }
}

our class PatTup::A {

    method pat-tup:sym<a>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<b>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<c>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<d>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<e>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<f>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<g>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<h>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<i>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<j>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<k>($/) {
        make PatTup.new(

        )
    }

    method pat-tup_elts:sym<a>($/) {
        make PatTupElts.new(
            pat =>  $<pat>.made,
        )
    }

    method pat-tup_elts:sym<b>($/) {
        ExtNode<140176894415400>
    }
}

#-----------------------------------
our class PatVec {
    has $.pat_vec_elts;
}

our class PatVecElts {
    has $.pat;
}

our class PatVec::G {

    proto rule pat-vec { * }

    rule pat-vec:sym<a> {
        <pat-vec_elts>
    }

    rule pat-vec:sym<b> {
        <pat-vec_elts> ','
    }

    rule pat-vec:sym<c> {
        <pat-vec_elts> <DOTDOT>
    }

    rule pat-vec:sym<d> {
        <pat-vec_elts> ',' <DOTDOT>
    }

    rule pat-vec:sym<e> {
        <pat-vec_elts> <DOTDOT> ',' <pat-vec_elts>
    }

    rule pat-vec:sym<f> {
        <pat-vec_elts> <DOTDOT> ',' <pat-vec_elts> ','
    }

    rule pat-vec:sym<g> {
        <pat-vec_elts> ',' <DOTDOT> ',' <pat-vec_elts>
    }

    rule pat-vec:sym<h> {
        <pat-vec_elts> ',' <DOTDOT> ',' <pat-vec_elts> ','
    }

    rule pat-vec:sym<i> {
        <DOTDOT> ',' <pat-vec_elts>
    }

    rule pat-vec:sym<j> {
        <DOTDOT> ',' <pat-vec_elts> ','
    }

    rule pat-vec:sym<k> {
        <DOTDOT>
    }

    rule pat-vec:sym<l> {

    }

    proto rule pat-vec_elts { * }

    rule pat-vec_elts:sym<a> {
        <pat>
    }

    rule pat-vec_elts:sym<b> {
        <pat-vec_elts> ',' <pat>
    }
}

our class PatVec::A {

    method pat-vec:sym<a>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<b>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<c>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<d>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<e>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<f>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<g>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<h>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<i>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<j>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<k>($/) {
        make PatVec.new(

        )
    }

    method pat-vec:sym<l>($/) {
        make PatVec.new(

        )
    }

    method pat-vec_elts:sym<a>($/) {
        make PatVecElts.new(
            pat =>  $<pat>.made,
        )
    }

    method pat-vec_elts:sym<b>($/) {
        ExtNode<140470254776616>
    }
}

#//////////////////////////////////////////////////////////////////////
# Part 3: Types
#//////////////////////////////////////////////////////////////////////
our class TyQualifiedPath {
    has $.ty_sum;
    has $.maybe_as_trait_ref;
    has $.ident;
}

our class TyTup {
    has $.ty_sums;
}

our class Ty::G {

    proto rule ty { * }

    rule ty:sym<a> {
        <ty-prim>
    }

    rule ty:sym<b> {
        <ty-closure>
    }

    rule ty:sym<c> {
        '<' <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident>
    }

    rule ty:sym<d> {
        <SHL> <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <maybe-as_trait_ref> '>' <MOD-SEP> <ident>
    }

    rule ty:sym<e> {
        '(' <ty-sums> ')'
    }

    rule ty:sym<f> {
        '(' <ty-sums> ',' ')'
    }

    rule ty:sym<g> {
        '(' ')'
    }
}

our class Ty::A {

    method ty:sym<a>($/) {
        make $<ty-prim>.made
    }

    method ty:sym<b>($/) {
        make $<ty-closure>.made
    }

    method ty:sym<c>($/) {
        make TyQualifiedPath.new(
            ty-sum             =>  $<ty-sum>.made,
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method ty:sym<d>($/) {
        make TyQualifiedPath.new(
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method ty:sym<e>($/) {
        make TyTup.new(
            ty-sums =>  $<ty-sums>.made,
        )
    }

    method ty:sym<f>($/) {
        make TyTup.new(
            ty-sums =>  $<ty-sums>.made,
        )
    }

    method ty:sym<g>($/) {
        make TyNil.new
    }
}


#---------------------------------
our class TyBox {
    has $.ty;
}

our class TyFixedLengthVec {
    has $.expr;
    has $.ty;
}

our class TyMacro {
    has $.path_generic_args_without_colons;
    has $.delimited_token_trees;
    has $.maybe_ident;
}

our class TyPath {
    has $.path_generic_args_without_colons;
}

our class TyPtr {
    has $.maybe_mut_or_const;
    has $.ty;
}

our class TyRptr {
    has $.ty;
    has $.maybe_mut;
    has $.lifetime;
}

our class TyTypeof {
    has $.expr;
}

our class TyVec {
    has $.ty;
}

our class TyPrim::G {

    proto rule ty-prim { * }

    rule ty-prim:sym<a> {
        {self.set-prec(IDENT)} <path-generic_args_without_colons>
    }

    rule ty-prim:sym<b> {
        {self.set-prec(IDENT)} <MOD-SEP> <path-generic_args_without_colons>
    }

    rule ty-prim:sym<c> {
        {self.set-prec(IDENT)} <SELF> <MOD-SEP> <path-generic_args_without_colons>
    }

    rule ty-prim:sym<d> {
        {self.set-prec(IDENT)} <path-generic_args_without_colons> '!' <maybe-ident> <delimited-token_trees>
    }

    rule ty-prim:sym<e> {
        {self.set-prec(IDENT)} <MOD-SEP> <path-generic_args_without_colons> '!' <maybe-ident> <delimited-token_trees>
    }

    rule ty-prim:sym<f> {
        <BOX> <ty>
    }

    rule ty-prim:sym<g> {
        '*' <maybe-mut_or_const> <ty>
    }

    rule ty-prim:sym<h> {
        '&' <ty>
    }

    rule ty-prim:sym<i> {
        '&' <MUT> <ty>
    }

    rule ty-prim:sym<j> {
        <ANDAND> <ty>
    }

    rule ty-prim:sym<k> {
        <ANDAND> <MUT> <ty>
    }

    rule ty-prim:sym<l> {
        '&' <lifetime> <maybe-mut> <ty>
    }

    rule ty-prim:sym<m> {
        <ANDAND> <lifetime> <maybe-mut> <ty>
    }

    rule ty-prim:sym<n> {
        '[' <ty> ']'
    }

    rule ty-prim:sym<o> {
        '[' <ty> ',' <DOTDOT> <expr> ']'
    }

    rule ty-prim:sym<p> {
        '[' <ty> ';' <expr> ']'
    }

    rule ty-prim:sym<q> {
        <TYPEOF> '(' <expr> ')'
    }

    rule ty-prim:sym<r> {
        <UNDERSCORE>
    }

    rule ty-prim:sym<s> {
        <ty-bare_fn>
    }

    rule ty-prim:sym<t> {
        <for-in_type>
    }
}

our class TyPrim::A {

    method ty-prim:sym<a>($/) {
        make TyPath.new(
            path-generic_args_without_colons =>  $<path-generic_args_without_colons>.made,
        )
    }

    method ty-prim:sym<b>($/) {
        make TyPath.new(
            path-generic_args_without_colons =>  $<path-generic_args_without_colons>.made,
        )
    }

    method ty-prim:sym<c>($/) {
        make TyPath.new(
            path-generic_args_without_colons =>  $<path-generic_args_without_colons>.made,
        )
    }

    method ty-prim:sym<d>($/) {
        make TyMacro.new(
            path-generic_args_without_colons =>  $<path-generic_args_without_colons>.made,
            maybe-ident                      =>  $<maybe-ident>.made,
            delimited-token_trees            =>  $<delimited-token_trees>.made,
        )
    }

    method ty-prim:sym<e>($/) {
        make TyMacro.new(
            path-generic_args_without_colons =>  $<path-generic_args_without_colons>.made,
            maybe-ident                      =>  $<maybe-ident>.made,
            delimited-token_trees            =>  $<delimited-token_trees>.made,
        )
    }

    method ty-prim:sym<f>($/) {
        make TyBox.new(
            ty =>  $<ty>.made,
        )
    }

    method ty-prim:sym<g>($/) {
        make TyPtr.new(
            maybe-mut_or_const =>  $<maybe-mut_or_const>.made,
            ty                 =>  $<ty>.made,
        )
    }

    method ty-prim:sym<h>($/) {
        make TyRptr.new(
            ty =>  $<ty>.made,
        )
    }

    method ty-prim:sym<i>($/) {
        make TyRptr.new(
            ty =>  $<ty>.made,
        )
    }

    method ty-prim:sym<j>($/) {
        make TyRptr.new(

        )
    }

    method ty-prim:sym<k>($/) {
        make TyRptr.new(

        )
    }

    method ty-prim:sym<l>($/) {
        make TyRptr.new(
            lifetime  =>  $<lifetime>.made,
            maybe-mut =>  $<maybe-mut>.made,
            ty        =>  $<ty>.made,
        )
    }

    method ty-prim:sym<m>($/) {
        make TyRptr.new(

        )
    }

    method ty-prim:sym<n>($/) {
        make TyVec.new(
            ty =>  $<ty>.made,
        )
    }

    method ty-prim:sym<o>($/) {
        make TyFixedLengthVec.new(
            ty   =>  $<ty>.made,
            expr =>  $<expr>.made,
        )
    }

    method ty-prim:sym<p>($/) {
        make TyFixedLengthVec.new(
            ty   =>  $<ty>.made,
            expr =>  $<expr>.made,
        )
    }

    method ty-prim:sym<q>($/) {
        make TyTypeof.new(
            expr =>  $<expr>.made,
        )
    }

    method ty-prim:sym<r>($/) {
        make TyInfer.new
    }

    method ty-prim:sym<s>($/) {
        make $<ty-bare_fn>.made
    }

    method ty-prim:sym<t>($/) {
        make $<for-in_type>.made
    }
}

#---------------------------------
our class TyBareFn::G {

    proto rule ty-bare_fn { * }

    rule ty-bare_fn:sym<a> {
        <FN> <ty-fn_decl>
    }

    rule ty-bare_fn:sym<b> {
        <UNSAFE> <FN> <ty-fn_decl>
    }

    rule ty-bare_fn:sym<c> {
        <EXTERN> <maybe-abi> <FN> <ty-fn_decl>
    }

    rule ty-bare_fn:sym<d> {
        <UNSAFE> <EXTERN> <maybe-abi> <FN> <ty-fn_decl>
    }
}

our class TyBareFn::A {

    method ty-bare_fn:sym<a>($/) {
        make $<ty_fn_decl>.made
    }

    method ty-bare_fn:sym<b>($/) {
        make $<ty_fn_decl>.made
    }

    method ty-bare_fn:sym<c>($/) {
        make $<ty_fn_decl>.made
    }

    method ty-bare_fn:sym<d>($/) {
        make $<ty_fn_decl>.made
    }
}

#---------------------------------
our class TyFnDecl {
    has $.fn_anon_params;
    has $.ret_ty;
    has $.generic_params;
}

our class TyFnDecl::G {

    rule ty-fn_decl {
        <generic-params> <fn-anon_params> <ret-ty>
    }
}

our class TyFnDecl::A {

    method ty-fn_decl($/) {
        make TyFnDecl.new(
            generic-params =>  $<generic-params>.made,
            fn-anon_params =>  $<fn-anon_params>.made,
            ret-ty         =>  $<ret-ty>.made,
        )
    }
}

#---------------------------------
our class TyClosure {
    has $.anon_params;
    has $.ret_ty;
    has $.maybe_bounds;
}

our class TyClosure::G {

    proto rule ty-closure { * }

    rule ty-closure:sym<a> {
        <UNSAFE> '|' <anon-params> '|' <maybe-bounds> <ret-ty>
    }

    rule ty-closure:sym<b> {
        '|' <anon-params> '|' <maybe-bounds> <ret-ty>
    }

    rule ty-closure:sym<c> {
        <UNSAFE> <OROR> <maybe-bounds> <ret-ty>
    }

    rule ty-closure:sym<d> {
        <OROR> <maybe-bounds> <ret-ty>
    }
}

our class TyClosure::A {

    method ty-closure:sym<a>($/) {
        make TyClosure.new(
            anon-params  =>  $<anon-params>.made,
            maybe-bounds =>  $<maybe-bounds>.made,
            ret-ty       =>  $<ret-ty>.made,
        )
    }

    method ty-closure:sym<b>($/) {
        make TyClosure.new(
            anon-params  =>  $<anon-params>.made,
            maybe-bounds =>  $<maybe-bounds>.made,
            ret-ty       =>  $<ret-ty>.made,
        )
    }

    method ty-closure:sym<c>($/) {
        make TyClosure.new(
            maybe-bounds =>  $<maybe-bounds>.made,
            ret-ty       =>  $<ret-ty>.made,
        )
    }

    method ty-closure:sym<d>($/) {
        make TyClosure.new(
            maybe-bounds =>  $<maybe-bounds>.made,
            ret-ty       =>  $<ret-ty>.made,
        )
    }
}

#---------------------------------
our class ForInType {
    has $.for_in_type_suffix;
    has $.maybe_lifetimes;
}

our class ForInType::G {

    rule for-in_type {
        <FOR> '<' <maybe-lifetimes> '>' <for-in_type_suffix>
    }

    proto rule for-in_type_suffix { * }

    rule for-in_type_suffix:sym<a> {
        <ty-bare_fn>
    }

    rule for-in_type_suffix:sym<b> {
        <trait-ref>
    }

    rule for-in_type_suffix:sym<c> {
        <ty-closure>
    }
}

our class ForInType::A {

    method for-in_type($/) {
        make ForInType.new(
            maybe-lifetimes    =>  $<maybe-lifetimes>.made,
            for-in_type_suffix =>  $<for-in_type_suffix>.made,
        )
    }

    method for-in_type_suffix:sym<a>($/) {
        make $<ty-bare_fn>.made
    }

    method for-in_type_suffix:sym<b>($/) {
        make $<trait-ref>.made
    }

    method for-in_type_suffix:sym<c>($/) {
        make $<ty-closure>.made
    }
}

#---------------------------------
our class MutOrConst::G {

    proto rule maybe-mut { * }

    rule maybe-mut:sym<a> {
        <MUT>
    }

    rule maybe-mut:sym<b> {
        # %prec MUT 
    }

    proto rule maybe-mut_or_const { * }

    rule maybe-mut_or_const:sym<a> {
        <MUT>
    }

    rule maybe-mut_or_const:sym<b> {
        <CONST>
    }

    rule maybe-mut_or_const:sym<c> {

    }
}

our class MutOrConst::A {

    method maybe-mut:sym<a>($/) {
        make MutMutable.new
    }

    method maybe-mut:sym<b>($/) {
        make MutImmutable.new
    }

    method maybe-mut_or_const:sym<a>($/) {
        make MutMutable.new
    }

    method maybe-mut_or_const:sym<b>($/) {
        make MutImmutable.new
    }

    method maybe-mut_or_const:sym<c>($/) {
        make MutImmutable.new
    }
}

#---------------------------------
our class GenericValues {
    has $.maybe_bindings;
}

our class TyQualifiedPath {
    has $.ident;
    has $.ty_sum;
    has $.trait_ref;
}

our class TyQualifiedPath::G {

    proto rule ty-qualified_path_and_generic_values { * }

    rule ty-qualified_path_and_generic_values:sym<a> {
        <ty-qualified_path> <maybe-bindings>
    }

    rule ty-qualified_path_and_generic_values:sym<b> {
        <ty-qualified_path> ',' <ty-sums> <maybe-bindings>
    }

    proto rule ty-qualified_path { * }

    rule ty-qualified_path:sym<a> {
        <ty-sum> <AS> <trait-ref> '>' <MOD-SEP> <ident>
    }

    rule ty-qualified_path:sym<b> {
        <ty-sum> <AS> <trait-ref> '>' <MOD-SEP> <ident> '+' <ty-param_bounds>
    }
}

our class TyQualifiedPath::A {

    method ty-qualified_path_and_generic_values:sym<a>($/) {
        make GenericValues.new(
            maybe-bindings =>  $<maybe-bindings>.made,
        )
    }

    method ty-qualified_path_and_generic_values:sym<b>($/) {
        make GenericValues.new(
            maybe-bindings =>  $<maybe-bindings>.made,
        )
    }

    method ty-qualified_path:sym<a>($/) {
        make TyQualifiedPath.new(
            ty-sum    =>  $<ty-sum>.made,
            trait-ref =>  $<trait-ref>.made,
            ident     =>  $<ident>.made,
        )
    }

    method ty-qualified_path:sym<b>($/) {
        make TyQualifiedPath.new(
            ty-sum    =>  $<ty-sum>.made,
            trait-ref =>  $<trait-ref>.made,
            ident     =>  $<ident>.made,
        )
    }
}

#---------------------------------
our class TySum {
    has $.ty_sum_elt;
    has $.ty_prim_sum_elt;
}

our class TySums {
    has $.ty_sum;
}

our class TySums::G {

    proto rule maybe-ty_sums { * }

    rule maybe-ty_sums:sym<a> {
        <ty-sums>
    }

    rule maybe-ty_sums:sym<b> {
        <ty-sums> ','
    }

    rule maybe-ty_sums:sym<c> {

    }

    proto rule ty-sums { * }

    rule ty-sums:sym<a> {
        <ty-sum>
    }

    rule ty-sums:sym<b> {
        <ty-sums> ',' <ty-sum>
    }

    proto rule ty-sum { * }

    rule ty-sum:sym<a> {
        <ty-sum_elt>
    }

    rule ty-sum:sym<b> {
        <ty-sum> '+' <ty-sum_elt>
    }

    proto rule ty-sum_elt { * }

    rule ty-sum_elt:sym<a> {
        <ty>
    }

    rule ty-sum_elt:sym<b> {
        <lifetime>
    }

    proto rule ty-prim_sum { * }

    rule ty-prim_sum:sym<a> {
        <ty-prim_sum_elt>
    }

    rule ty-prim_sum:sym<b> {
        <ty-prim_sum> '+' <ty-prim_sum_elt>
    }

    proto rule ty-prim_sum_elt { * }

    rule ty-prim_sum_elt:sym<a> {
        <ty-prim>
    }

    rule ty-prim_sum_elt:sym<b> {
        <lifetime>
    }
}

our class TySums::A {

    method maybe-ty_sums:sym<a>($/) {
        make $<ty-sums>.made
    }

    method maybe-ty_sums:sym<b>($/) {

    }

    method maybe-ty_sums:sym<c>($/) {
        MkNone<140616559392320>
    }

    method ty-sums:sym<a>($/) {
        make TySums.new(
            ty-sum =>  $<ty-sum>.made,
        )
    }

    method ty-sums:sym<b>($/) {
        ExtNode<140615535303640>
    }

    method ty-sum:sym<a>($/) {
        make TySum.new(
            ty-sum_elt =>  $<ty-sum_elt>.made,
        )
    }

    method ty-sum:sym<b>($/) {
        ExtNode<140615535303680>
    }

    method ty-sum_elt:sym<a>($/) {
        make $<ty>.made
    }

    method ty-sum_elt:sym<b>($/) {
        make $<lifetime>.made
    }

    method ty-prim_sum:sym<a>($/) {
        make TySum.new(
            ty-prim_sum_elt =>  $<ty-prim_sum_elt>.made,
        )
    }

    method ty-prim_sum:sym<b>($/) {
        ExtNode<140615535303720>
    }

    method ty-prim_sum_elt:sym<a>($/) {
        make $<ty-prim>.made
    }

    method ty-prim_sum_elt:sym<b>($/) {
        make $<lifetime>.made
    }
}

#---------------------------------
our class PolyBound {
    has $.maybe_lifetimes;
    has $.bound;
}

our class TyParamBounds::G {

    proto rule maybe-ty_param_bounds { * }

    rule maybe-ty_param_bounds:sym<a> {
        ':' <ty-param_bounds>
    }

    rule maybe-ty_param_bounds:sym<b> {

    }

    proto rule ty-param_bounds { * }

    rule ty-param_bounds:sym<a> {
        <boundseq>
    }

    rule ty-param_bounds:sym<b> {

    }

    proto rule boundseq { * }

    rule boundseq:sym<a> {
        <polybound>
    }

    rule boundseq:sym<b> {
        <boundseq> '+' <polybound>
    }

    proto rule polybound { * }

    rule polybound:sym<a> {
        <FOR> '<' <maybe-lifetimes> '>' <bound>
    }

    rule polybound:sym<b> {
        <bound>
    }

    rule polybound:sym<c> {
        '?' <FOR> '<' <maybe-lifetimes> '>' <bound>
    }

    rule polybound:sym<d> {
        '?' <bound>
    }
}

our class TyParamBounds::A {

    method maybe-ty_param_bounds:sym<a>($/) {
        make $<ty_param_bounds>.made
    }

    method maybe-ty_param_bounds:sym<b>($/) {
        MkNone<140367527828480>
    }

    method ty-param_bounds:sym<a>($/) {
        make $<boundseq>.made
    }

    method ty-param_bounds:sym<b>($/) {
        MkNone<140367527828512>
    }

    method boundseq:sym<a>($/) {
        make $<polybound>.made
    }

    method boundseq:sym<b>($/) {
        ExtNode<140367770100832>
    }

    method polybound:sym<a>($/) {
        make PolyBound.new(
            maybe-lifetimes =>  $<maybe-lifetimes>.made,
            bound           =>  $<bound>.made,
        )
    }

    method polybound:sym<b>($/) {
        make $<bound>.made
    }

    method polybound:sym<c>($/) {
        make PolyBound.new(
            maybe-lifetimes =>  $<maybe-lifetimes>.made,
            bound           =>  $<bound>.made,
        )
    }

    method polybound:sym<d>($/) {
        make $<bound>.made
    }
}

#---------------------------------

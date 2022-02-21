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
    has $.inner_attrs;
    has $.item_foreign_mod;
    has $.maybe_foreign_items;
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
    has $.fn_anon_params_with_self;
    has $.fn_params;
    has $.fn_params_allow_variadic;
    has $.fn_params_with_self;
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
our class AnonArg {
    has $.named_arg;
    has $.ty;
}

our class AnonArgs {
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
        make AnonArgs.new(
            anon-param =>  $<anon-param>.made,
        )
    }

    method anon-params:sym<b>($/) {
        ExtNode<140357023572960>
    }

    method anon-param:sym<a>($/) {
        make AnonArg.new(
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
        make AnonArgs.new(
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
    has $.maybe_bindings;
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
    has $.pat_fields;
    has $.pat_struct;
    has $.path_expr;
}

our class PatTup {
    has $.pat_tup;
    has $.pat_tup_elts;
}

our class PatUniq {
    has $.pat;
}

our class PatVec {
    has $.pat_vec;
    has $.pat_vec_elts;
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
    has $.ident;
    has $.maybe_as_trait_ref;
    has $.trait_ref;
    has $.ty_sum;
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
our class Binding {
    has $.ty;
    has $.ident;
}

our class Bindings {
    has $.binding;
}

our class Binding::G {

    proto rule bindings { * }

    rule bindings:sym<a> {
        <binding>
    }

    rule bindings:sym<b> {
        <bindings> ',' <binding>
    }

    rule binding {
        <ident> '=' <ty>
    }
}

our class Binding::A {

    method bindings:sym<a>($/) {
        make Bindings.new(
            binding =>  $<binding>.made,
        )
    }

    method bindings:sym<b>($/) {
        ExtNode<140351397766456>
    }

    method binding($/) {
        make Binding.new(
            ident =>  $<ident>.made,
            ty    =>  $<ty>.made,
        )
    }
}

#---------------------------------
our class TyParam {
    has $.maybe_ty_param_bounds;
    has $.maybe_ty_default;
    has $.ident;
}

our class TyParam::G {

    proto rule ty-param { * }

    rule ty-param:sym<a> {
        <ident> <maybe-ty_param_bounds> <maybe-ty_default>
    }

    rule ty-param:sym<b> {
        <ident> '?' <ident> <maybe-ty_param_bounds> <maybe-ty_default>
    }
}

our class TyParam::A {

    method ty-param:sym<a>($/) {
        make TyParam.new(
            ident                 =>  $<ident>.made,
            maybe-ty_param_bounds =>  $<maybe-ty_param_bounds>.made,
            maybe-ty_default      =>  $<maybe-ty_default>.made,
        )
    }

    method ty-param:sym<b>($/) {
        make TyParam.new(
            ident                 =>  $<ident>.made,
            ident                 =>  $<ident>.made,
            maybe-ty_param_bounds =>  $<maybe-ty_param_bounds>.made,
            maybe-ty_default      =>  $<maybe-ty_default>.made,
        )
    }
}

#---------------------------------
our class Bounds {
    has $.bound;
}

our class Bounds::G {

    proto rule maybe-bounds { * }

    rule maybe-bounds:sym<a> {
        {self.set-prec(SHIFTPLUS)} ':' <bounds>
    }

    rule maybe-bounds:sym<b> {
        # %prec SHIFTPLUS 
    }

    proto rule bounds { * }

    rule bounds:sym<a> {
        <bound>
    }

    rule bounds:sym<b> {
        <bounds> '+' <bound>
    }

    proto rule bound { * }

    rule bound:sym<a> {
        <lifetime>
    }

    rule bound:sym<b> {
        <trait-ref>
    }
}

our class Bounds::A {

    method maybe-bounds:sym<a>($/) {
        make $<bounds>.made
    }

    method maybe-bounds:sym<b>($/) {
        MkNone<140424370458624>
    }

    method bounds:sym<a>($/) {
        make bounds.new(
            bound =>  $<bound>.made,
        )
    }

    method bounds:sym<b>($/) {
        ExtNode<140424375574320>
    }

    method bound:sym<a>($/) {
        make $<lifetime>.made
    }

    method bound:sym<b>($/) {
        make $<trait-ref>.made
    }
}

#---------------------------------
our class Ltbounds {
    has $.lifetime;
}

our class LtBounds::G {

    proto rule maybe-ltbounds { * }

    rule maybe-ltbounds:sym<a> {
        {self.set-prec(SHIFTPLUS)} ':' <ltbounds>
    }

    rule maybe-ltbounds:sym<b> {

    }

    proto rule ltbounds { * }

    rule ltbounds:sym<a> {
        <lifetime>
    }

    rule ltbounds:sym<b> {
        <ltbounds> '+' <lifetime>
    }
}

our class LtBounds::A {

    method maybe-ltbounds:sym<a>($/) {
        make $<ltbounds>.made
    }

    method maybe-ltbounds:sym<b>($/) {
        MkNone<140308387816480>
    }

    method ltbounds:sym<a>($/) {
        make ltbounds.new(
            lifetime =>  $<lifetime>.made,
        )
    }

    method ltbounds:sym<b>($/) {
        ExtNode<140310419243344>
    }
}

#---------------------------------
our class TyDefault {
    has $.ty_sum;
}

our class TyDefault::G {

    proto rule maybe-ty_default { * }

    rule maybe-ty_default:sym<a> {
        '=' <ty-sum>
    }

    rule maybe-ty_default:sym<b> {

    }
}

our class TyDefault::A {

    method maybe-ty_default:sym<a>($/) {
        make TyDefault.new(
            ty-sum =>  $<ty-sum>.made,
        )
    }

    method maybe-ty_default:sym<b>($/) {
        MkNone<140350942994944>
    }
}

#---------------------------------
our class Lifetimes {
    has $.lifetime_and_bounds;
}

our class Lifetime {
    has $.maybe_ltbounds;
}

our class Lifetimes::G {

    proto rule maybe-lifetimes { * }

    rule maybe-lifetimes:sym<a> {
        <lifetimes>
    }

    rule maybe-lifetimes:sym<b> {
        <lifetimes> ','
    }

    rule maybe-lifetimes:sym<c> {

    }

    proto rule lifetimes { * }

    rule lifetimes:sym<a> {
        <lifetime-and_bounds>
    }

    rule lifetimes:sym<b> {
        <lifetimes> ',' <lifetime-and_bounds>
    }

    proto rule lifetime-and_bounds { * }

    rule lifetime-and_bounds:sym<a> {
        <LIFETIME> <maybe-ltbounds>
    }

    rule lifetime-and_bounds:sym<b> {
        <STATIC-LIFETIME>
    }

    proto rule lifetime { * }

    rule lifetime:sym<a> {
        <LIFETIME>
    }

    rule lifetime:sym<b> {
        <STATIC-LIFETIME>
    }
}

our class Lifetimes::A {

    method maybe-lifetimes:sym<a>($/) {
        make $<lifetimes>.made
    }

    method maybe-lifetimes:sym<b>($/) {

    }

    method maybe-lifetimes:sym<c>($/) {
        MkNone<140203792891008>
    }

    method lifetimes:sym<a>($/) {
        make Lifetimes.new(
            lifetime-and_bounds =>  $<lifetime-and_bounds>.made,
        )
    }

    method lifetimes:sym<b>($/) {
        ExtNode<140203790912376>
    }

    method lifetime-and_bounds:sym<a>($/) {
        make lifetime.new(
            maybe-ltbounds =>  $<maybe-ltbounds>.made,
        )
    }

    method lifetime-and_bounds:sym<b>($/) {
        make static_lifetime.new
    }

    method lifetime:sym<a>($/) {
        make lifetime.new(

        )
    }

    method lifetime:sym<b>($/) {
        make static_lifetime.new
    }
}

#---------------------------------
our class TraitRef::G {

    proto rule trait-ref { * }

    rule trait-ref:sym<a> {
        {self.set-prec(IDENT)} <path-generic_args_without_colons>
    }

    rule trait-ref:sym<b> {
        {self.set-prec(IDENT)} <MOD-SEP> <path-generic_args_without_colons>
    }
}

our class TraitRef::A {

    method trait-ref:sym<a>($/) {

    }

    method trait-ref:sym<b>($/) {
        make $<path_generic_args_without_colons>.made
    }
}

#////////////////////////////////////////////////////////////////////////
#// Part 4: Blocks, statements, and expressions
#////////////////////////////////////////////////////////////////////////
our class ExprBlock {
    has $.maybe_stmts;
    has $.maybe_inner_attrs;
}

our class InnerAttrsAndBlock::G {

    rule inner-attrs_and_block {
        '{' <maybe-inner_attrs> <maybe-stmts> '}'
    }
}

our class InnerAttrsAndBlock::A {

    method inner-attrs_and_block($/) {
        make ExprBlock.new(
            maybe-inner_attrs =>  $<maybe-inner_attrs>.made,
            maybe-stmts       =>  $<maybe-stmts>.made,
        )
    }
}

#---------------------------------

our class Block::G {

    rule block {
        '{' <maybe-stmts> '}'
    }
}

our class Block::A {

    method block($/) {
        make ExprBlock.new(
            maybe-stmts =>  $<maybe-stmts>.made,
        )
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
    has $.stmt;
}

our class Stmts::G {

    proto rule maybe-stmts { * }

    rule maybe-stmts:sym<a> {
        <stmts>
    }

    rule maybe-stmts:sym<b> {
        <stmts> <nonblock-expr>
    }

    rule maybe-stmts:sym<c> {
        <nonblock-expr>
    }

    rule maybe-stmts:sym<d> {

    }

    proto rule stmts { * }

    rule stmts:sym<a> {
        <stmt>
    }

    rule stmts:sym<b> {
        <stmts> <stmt>
    }

    proto rule stmt { * }

    rule stmt:sym<a> {
        <maybe-outer_attrs> <let>
    }

    rule stmt:sym<b> {
        <stmt-item>
    }

    rule stmt:sym<c> {
        <PUB> <stmt-item>
    }

    rule stmt:sym<d> {
        <outer-attrs> <stmt-item>
    }

    rule stmt:sym<e> {
        <outer-attrs> <PUB> <stmt-item>
    }

    rule stmt:sym<f> {
        <full-block_expr>
    }

    rule stmt:sym<g> {
        <maybe-outer_attrs> <block>
    }

    rule stmt:sym<h> {
        <nonblock-expr> ';'
    }

    rule stmt:sym<i> {
        <outer-attrs> <nonblock-expr> ';'
    }

    rule stmt:sym<j> {
        ';'
    }
}

our class Stmts::A {

    method maybe-stmts:sym<a>($/) {
        make $<stmts>.made
    }

    method maybe-stmts:sym<b>($/) {
        ExtNode<140397158386760>
    }

    method maybe-stmts:sym<c>($/) {
        make $<nonblock-expr>.made
    }

    method maybe-stmts:sym<d>($/) {
        MkNone<140397971049472>
    }

    method stmts:sym<a>($/) {
        make stmts.new(
            stmt =>  $<stmt>.made,
        )
    }

    method stmts:sym<b>($/) {
        ExtNode<140397158387120>
    }

    method stmt:sym<a>($/) {
        make $<let>.made
    }

    method stmt:sym<b>($/) {
        make $<stmt-item>.made
    }

    method stmt:sym<c>($/) {
        make $<stmt_item>.made
    }

    method stmt:sym<d>($/) {
        make $<stmt_item>.made
    }

    method stmt:sym<e>($/) {
        make $<stmt_item>.made
    }

    method stmt:sym<f>($/) {
        make $<full-block_expr>.made
    }

    method stmt:sym<g>($/) {
        make $<block>.made
    }

    method stmt:sym<h>($/) {

    }

    method stmt:sym<i>($/) {
        make $<nonblock_expr>.made
    }

    method stmt:sym<j>($/) {
        MkNone<140397971051360>
    }
}

#-------------------------------------
our class Exprs {
    has $.expr;
}

our class Exprs::G {

    proto rule maybe-exprs { * }

    rule maybe-exprs:sym<a> {
        <exprs>
    }

    rule maybe-exprs:sym<b> {
        <exprs> ','
    }

    rule maybe-exprs:sym<c> {

    }

    proto rule maybe-expr { * }

    rule maybe-expr:sym<a> {
        <expr>
    }

    rule maybe-expr:sym<b> {

    }

    proto rule exprs { * }

    rule exprs:sym<a> {
        <expr>
    }

    rule exprs:sym<b> {
        <exprs> ',' <expr>
    }
}

our class Exprs::A {

    method maybe-exprs:sym<a>($/) {
        make $<exprs>.made
    }

    method maybe-exprs:sym<b>($/) {

    }

    method maybe-exprs:sym<c>($/) {
        MkNone<140567541982240>
    }

    method maybe-expr:sym<a>($/) {
        make $<expr>.made
    }

    method maybe-expr:sym<b>($/) {
        MkNone<140567541982272>
    }

    method exprs:sym<a>($/) {
        make exprs.new(
            expr =>  $<expr>.made,
        )
    }

    method exprs:sym<b>($/) {
        ExtNode<140567166887600>
    }
}

#-------------------------------------
our class SelfPath {
    has $.path_generic_args_with_colons;
}

our class PathExpr::G {

    proto rule path-expr { * }

    rule path-expr:sym<a> {
        <path-generic_args_with_colons>
    }

    rule path-expr:sym<b> {
        <MOD-SEP> <path-generic_args_with_colons>
    }

    rule path-expr:sym<c> {
        <SELF> <MOD-SEP> <path-generic_args_with_colons>
    }
}

our class PathExpr::A {

    method path-expr:sym<a>($/) {
        make $<path-generic_args_with_colons>.made
    }

    method path-expr:sym<b>($/) {
        make $<path_generic_args_with_colons>.made
    }

    method path-expr:sym<c>($/) {
        make SelfPath.new(
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
        )
    }
}

#-------------------------------------
# A path with a lifetime and type parameters with
# double colons before the type parameters;
# e.g. `foo::bar::<'a>::Baz::<T>`
#
# These show up in expr context, in order to
# disambiguate from "less-than" expressions.
our class PathGenericArgsWithColons::G {

    proto rule path-generic_args_with_colons { * }

    rule path-generic_args_with_colons:sym<a> {
        <ident>
    }

    rule path-generic_args_with_colons:sym<b> {
        <SUPER>
    }

    rule path-generic_args_with_colons:sym<c> {
        <path-generic_args_with_colons> <MOD-SEP> <ident>
    }

    rule path-generic_args_with_colons:sym<d> {
        <path-generic_args_with_colons> <MOD-SEP> <SUPER>
    }

    rule path-generic_args_with_colons:sym<e> {
        <path-generic_args_with_colons> <MOD-SEP> <generic-args>
    }
}

our class PathGenericArgsWithColons::A {

    method path-generic_args_with_colons:sym<a>($/) {
        make components.new(
            ident =>  $<ident>.made,
        )
    }

    method path-generic_args_with_colons:sym<b>($/) {
        make Super.new
    }

    method path-generic_args_with_colons:sym<c>($/) {
        ExtNode<140425165463024>
    }

    method path-generic_args_with_colons:sym<d>($/) {
        ExtNode<140425165463064>
    }

    method path-generic_args_with_colons:sym<e>($/) {
        ExtNode<140425165463104>
    }
}

#-------------------------------------
# the braces-delimited macro is a block_expr so it
# doesn't appear here
our class MacroExpr {
    has $.path_expr;
    has $.parens_delimited_token_trees;
    has $.maybe_ident;
    has $.brackets_delimited_token_trees;
}

our class MacroExpr::G {

    proto rule macro-expr { * }

    rule macro-expr:sym<a> {
        <path-expr> '!' <maybe-ident> <parens-delimited_token_trees>
    }

    rule macro-expr:sym<b> {
        <path-expr> '!' <maybe-ident> <brackets-delimited_token_trees>
    }
}

our class MacroExpr::A {

    method macro-expr:sym<a>($/) {
        make MacroExpr.new(
            path-expr                    =>  $<path-expr>.made,
            maybe-ident                  =>  $<maybe-ident>.made,
            parens-delimited_token_trees =>  $<parens-delimited_token_trees>.made,
        )
    }

    method macro-expr:sym<b>($/) {
        make MacroExpr.new(
            path-expr                      =>  $<path-expr>.made,
            maybe-ident                    =>  $<maybe-ident>.made,
            brackets-delimited_token_trees =>  $<brackets-delimited_token_trees>.made,
        )
    }
}

#-------------------------------------

our class ExprAssign {
    has $.expr;
    has $.nonblock_expr;
    has $.expr_nostruct;
}

our class ExprAssignAdd {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprAssignBitAnd {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprAssignBitOr {
    has $.nonblock_expr;
    has $.expr;
    has $.expr_nostruct;
}

our class ExprAssignBitXor {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprAssignDiv {
    has $.expr;
    has $.nonblock_expr;
    has $.expr_nostruct;
}

our class ExprAssignRem {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprAssignShl {
    has $.nonblock_expr;
    has $.expr;
    has $.expr_nostruct;
}

our class ExprBox {
    has $.expr;
}

our class ExprBreak {
    has $.lifetime;
}

our class ExprField {
    has $.block_expr;
    has $.block_expr_dot;
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
    has $.path_generic_args_with_colons;
}

our class ExprIndex {
    has $.block_expr;
    has $.block_expr_dot;
    has $.expr;
    has $.expr_nostruct;
    has $.maybe_expr;
    has $.nonblock_expr;
    has $.path_generic_args_with_colons;
}

our class ExprMac {
    has $.macro_expr;
}

our class ExprParen {
    has $.maybe_exprs;
}

our class ExprPath {
    has $.path_expr;
}

our class ExprRange {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprRet {
    has $.expr;
}

our class ExprStruct {
    has $.path_expr;
    has $.struct_expr_fields;
}

our class ExprTry {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprTupleIndex {
    has $.block_expr;
    has $.block_expr_dot;
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprTypeAscr {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
    has $.ty;
}

our class ExprVec {
    has $.vec_expr;
}

our class ExprYield {
    has $.expr;
}

our class NonBlockExpr::G {

    proto rule nonblock-expr { * }

    rule nonblock-expr:sym<a> {
        <lit>
    }

    rule nonblock-expr:sym<b> {
        {self.set-prec(IDENT)} <path-expr>
    }

    rule nonblock-expr:sym<c> {
        <SELF>
    }

    rule nonblock-expr:sym<d> {
        <macro-expr>
    }

    rule nonblock-expr:sym<e> {
        <path-expr> '{' <struct-expr_fields> '}'
    }

    rule nonblock-expr:sym<f> {
        <nonblock-expr> '?'
    }

    rule nonblock-expr:sym<g> {
        <nonblock-expr> '.' <path-generic_args_with_colons>
    }

    rule nonblock-expr:sym<h> {
        <nonblock-expr> '.' <LIT-INTEGER>
    }

    rule nonblock-expr:sym<i> {
        <nonblock-expr> '[' <maybe-expr> ']'
    }

    rule nonblock-expr:sym<j> {
        <nonblock-expr> '(' <maybe-exprs> ')'
    }

    rule nonblock-expr:sym<k> {
        '[' <vec-expr> ']'
    }

    rule nonblock-expr:sym<l> {
        '(' <maybe-exprs> ')'
    }

    rule nonblock-expr:sym<m> {
        <CONTINUE>
    }

    rule nonblock-expr:sym<n> {
        <CONTINUE> <lifetime>
    }

    rule nonblock-expr:sym<o> {
        <RETURN>
    }

    rule nonblock-expr:sym<p> {
        <RETURN> <expr>
    }

    rule nonblock-expr:sym<q> {
        <BREAK>
    }

    rule nonblock-expr:sym<r> {
        <BREAK> <lifetime>
    }

    rule nonblock-expr:sym<s> {
        <YIELD>
    }

    rule nonblock-expr:sym<t> {
        <YIELD> <expr>
    }

    rule nonblock-expr:sym<u> {
        <nonblock-expr> '=' <expr>
    }

    rule nonblock-expr:sym<v> {
        <nonblock-expr> <SHLEQ> <expr>
    }

    rule nonblock-expr:sym<w> {
        <nonblock-expr> <SHREQ> <expr>
    }

    rule nonblock-expr:sym<x> {
        <nonblock-expr> <MINUSEQ> <expr>
    }

    rule nonblock-expr:sym<y> {
        <nonblock-expr> <ANDEQ> <expr>
    }

    rule nonblock-expr:sym<z> {
        <nonblock-expr> <OREQ> <expr>
    }

    rule nonblock-expr:sym<aa> {
        <nonblock-expr> <PLUSEQ> <expr>
    }

    rule nonblock-expr:sym<ab> {
        <nonblock-expr> <STAREQ> <expr>
    }

    rule nonblock-expr:sym<ac> {
        <nonblock-expr> <SLASHEQ> <expr>
    }

    rule nonblock-expr:sym<ad> {
        <nonblock-expr> <CARETEQ> <expr>
    }

    rule nonblock-expr:sym<ae> {
        <nonblock-expr> <PERCENTEQ> <expr>
    }

    rule nonblock-expr:sym<af> {
        <nonblock-expr> <OROR> <expr>
    }

    rule nonblock-expr:sym<ag> {
        <nonblock-expr> <ANDAND> <expr>
    }

    rule nonblock-expr:sym<ah> {
        <nonblock-expr> <EQEQ> <expr>
    }

    rule nonblock-expr:sym<ai> {
        <nonblock-expr> <NE> <expr>
    }

    rule nonblock-expr:sym<aj> {
        <nonblock-expr> '<' <expr>
    }

    rule nonblock-expr:sym<ak> {
        <nonblock-expr> '>' <expr>
    }

    rule nonblock-expr:sym<al> {
        <nonblock-expr> <LE> <expr>
    }

    rule nonblock-expr:sym<am> {
        <nonblock-expr> <GE> <expr>
    }

    rule nonblock-expr:sym<an> {
        <nonblock-expr> '|' <expr>
    }

    rule nonblock-expr:sym<ao> {
        <nonblock-expr> '^' <expr>
    }

    rule nonblock-expr:sym<ap> {
        <nonblock-expr> '&' <expr>
    }

    rule nonblock-expr:sym<aq> {
        <nonblock-expr> <SHL> <expr>
    }

    rule nonblock-expr:sym<ar> {
        <nonblock-expr> <SHR> <expr>
    }

    rule nonblock-expr:sym<as> {
        <nonblock-expr> '+' <expr>
    }

    rule nonblock-expr:sym<at> {
        <nonblock-expr> '-' <expr>
    }

    rule nonblock-expr:sym<au> {
        <nonblock-expr> '*' <expr>
    }

    rule nonblock-expr:sym<av> {
        <nonblock-expr> '/' <expr>
    }

    rule nonblock-expr:sym<aw> {
        <nonblock-expr> '%' <expr>
    }

    rule nonblock-expr:sym<ax> {
        <nonblock-expr> <DOTDOT>
    }

    rule nonblock-expr:sym<ay> {
        <nonblock-expr> <DOTDOT> <expr>
    }

    rule nonblock-expr:sym<az> {
        <DOTDOT> <expr>
    }

    rule nonblock-expr:sym<ba> {
        <DOTDOT>
    }

    rule nonblock-expr:sym<bb> {
        <nonblock-expr> <AS> <ty>
    }

    rule nonblock-expr:sym<bc> {
        <nonblock-expr> ':' <ty>
    }

    rule nonblock-expr:sym<bd> {
        <BOX> <expr>
    }

    rule nonblock-expr:sym<be> {
        <expr-qualified_path>
    }

    rule nonblock-expr:sym<bf> {
        <nonblock-prefix_expr>
    }
}

our class NonBlockExpr::A {

    method nonblock-expr:sym<a>($/) {
        make ExprLit.new(
            lit =>  $<lit>.made,
        )
    }

    method nonblock-expr:sym<b>($/) {
        make ExprPath.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method nonblock-expr:sym<c>($/) {
        make ExprPath.new(

        )
    }

    method nonblock-expr:sym<d>($/) {
        make ExprMac.new(
            macro-expr =>  $<macro-expr>.made,
        )
    }

    method nonblock-expr:sym<e>($/) {
        make ExprStruct.new(
            path-expr          =>  $<path-expr>.made,
            struct-expr_fields =>  $<struct-expr_fields>.made,
        )
    }

    method nonblock-expr:sym<f>($/) {
        make ExprTry.new(
            nonblock-expr =>  $<nonblock-expr>.made,
        )
    }

    method nonblock-expr:sym<g>($/) {
        make ExprField.new(
            nonblock-expr                 =>  $<nonblock-expr>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
        )
    }

    method nonblock-expr:sym<h>($/) {
        make ExprTupleIndex.new(
            nonblock-expr =>  $<nonblock-expr>.made,
        )
    }

    method nonblock-expr:sym<i>($/) {
        make ExprIndex.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            maybe-expr    =>  $<maybe-expr>.made,
        )
    }

    method nonblock-expr:sym<j>($/) {
        make ExprCall.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            maybe-exprs   =>  $<maybe-exprs>.made,
        )
    }

    method nonblock-expr:sym<k>($/) {
        make ExprVec.new(
            vec-expr =>  $<vec-expr>.made,
        )
    }

    method nonblock-expr:sym<l>($/) {
        make ExprParen.new(
            maybe-exprs =>  $<maybe-exprs>.made,
        )
    }

    method nonblock-expr:sym<m>($/) {
        make ExprAgain.new(

        )
    }

    method nonblock-expr:sym<n>($/) {
        make ExprAgain.new(
            lifetime =>  $<lifetime>.made,
        )
    }

    method nonblock-expr:sym<o>($/) {
        make ExprRet.new(

        )
    }

    method nonblock-expr:sym<p>($/) {
        make ExprRet.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<q>($/) {
        make ExprBreak.new(

        )
    }

    method nonblock-expr:sym<r>($/) {
        make ExprBreak.new(
            lifetime =>  $<lifetime>.made,
        )
    }

    method nonblock-expr:sym<s>($/) {
        make ExprYield.new(

        )
    }

    method nonblock-expr:sym<t>($/) {
        make ExprYield.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<u>($/) {
        make ExprAssign.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<v>($/) {
        make ExprAssignShl.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<w>($/) {
        make ExprAssignShr.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<x>($/) {
        make ExprAssignSub.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<y>($/) {
        make ExprAssignBitAnd.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<z>($/) {
        make ExprAssignBitOr.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<aa>($/) {
        make ExprAssignAdd.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ab>($/) {
        make ExprAssignMul.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ac>($/) {
        make ExprAssignDiv.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ad>($/) {
        make ExprAssignBitXor.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ae>($/) {
        make ExprAssignRem.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<af>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ag>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ah>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ai>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<aj>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ak>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<al>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<am>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<an>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ao>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ap>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<aq>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ar>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<as>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<at>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<au>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<av>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<aw>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ax>($/) {
        make ExprRange.new(
            nonblock-expr =>  $<nonblock-expr>.made,
        )
    }

    method nonblock-expr:sym<ay>($/) {
        make ExprRange.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<az>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ba>($/) {
        make ExprRange.new(

        )
    }

    method nonblock-expr:sym<bb>($/) {
        make ExprCast.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            ty            =>  $<ty>.made,
        )
    }

    method nonblock-expr:sym<bc>($/) {
        make ExprTypeAscr.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            ty            =>  $<ty>.made,
        )
    }

    method nonblock-expr:sym<bd>($/) {
        make ExprBox.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<be>($/) {
        make $<expr-qualified_path>.made
    }

    method nonblock-expr:sym<bf>($/) {
        make $<nonblock-prefix_expr>.made
    }
}

#-------------------------------------
our class ExprAgain {
    has $.lifetime;
    has $.ident;
}

our class ExprAssignMul {
    has $.nonblock_expr;
    has $.expr;
    has $.expr_nostruct;
}

our class ExprAssignSub {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprBinary {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprBreak {
    has $.ident;
}

our class ExprCall {
    has $.block_expr;
    has $.block_expr_dot;
    has $.expr;
    has $.expr_nostruct;
    has $.maybe_exprs;
    has $.nonblock_expr;
    has $.path_generic_args_with_colons;
}

our class ExprLit {
    has $.lit;
}

our class Expr::G {

    proto rule expr { * }

    rule expr:sym<a> {
        <lit>
    }

    rule expr:sym<b> {
        {self.set-prec(IDENT)} <path-expr>
    }

    rule expr:sym<c> {
        <SELF>
    }

    rule expr:sym<d> {
        <macro-expr>
    }

    rule expr:sym<e> {
        <path-expr> '{' <struct-expr_fields> '}'
    }

    rule expr:sym<f> {
        <expr> '?'
    }

    rule expr:sym<g> {
        <expr> '.' <path-generic_args_with_colons>
    }

    rule expr:sym<h> {
        <expr> '.' <LIT-INTEGER>
    }

    rule expr:sym<i> {
        <expr> '[' <maybe-expr> ']'
    }

    rule expr:sym<j> {
        <expr> '(' <maybe-exprs> ')'
    }

    rule expr:sym<k> {
        '(' <maybe-exprs> ')'
    }

    rule expr:sym<l> {
        '[' <vec-expr> ']'
    }

    rule expr:sym<m> {
        <CONTINUE>
    }

    rule expr:sym<n> {
        <CONTINUE> <ident>
    }

    rule expr:sym<o> {
        <RETURN>
    }

    rule expr:sym<p> {
        <RETURN> <expr>
    }

    rule expr:sym<q> {
        <BREAK>
    }

    rule expr:sym<r> {
        <BREAK> <ident>
    }

    rule expr:sym<s> {
        <YIELD>
    }

    rule expr:sym<t> {
        <YIELD> <expr>
    }

    rule expr:sym<u> {
        <expr> '=' <expr>
    }

    rule expr:sym<v> {
        <expr> <SHLEQ> <expr>
    }

    rule expr:sym<w> {
        <expr> <SHREQ> <expr>
    }

    rule expr:sym<x> {
        <expr> <MINUSEQ> <expr>
    }

    rule expr:sym<y> {
        <expr> <ANDEQ> <expr>
    }

    rule expr:sym<z> {
        <expr> <OREQ> <expr>
    }

    rule expr:sym<aa> {
        <expr> <PLUSEQ> <expr>
    }

    rule expr:sym<ab> {
        <expr> <STAREQ> <expr>
    }

    rule expr:sym<ac> {
        <expr> <SLASHEQ> <expr>
    }

    rule expr:sym<ad> {
        <expr> <CARETEQ> <expr>
    }

    rule expr:sym<ae> {
        <expr> <PERCENTEQ> <expr>
    }

    rule expr:sym<af> {
        <expr> <OROR> <expr>
    }

    rule expr:sym<ag> {
        <expr> <ANDAND> <expr>
    }

    rule expr:sym<ah> {
        <expr> <EQEQ> <expr>
    }

    rule expr:sym<ai> {
        <expr> <NE> <expr>
    }

    rule expr:sym<aj> {
        <expr> '<' <expr>
    }

    rule expr:sym<ak> {
        <expr> '>' <expr>
    }

    rule expr:sym<al> {
        <expr> <LE> <expr>
    }

    rule expr:sym<am> {
        <expr> <GE> <expr>
    }

    rule expr:sym<an> {
        <expr> '|' <expr>
    }

    rule expr:sym<ao> {
        <expr> '^' <expr>
    }

    rule expr:sym<ap> {
        <expr> '&' <expr>
    }

    rule expr:sym<aq> {
        <expr> <SHL> <expr>
    }

    rule expr:sym<ar> {
        <expr> <SHR> <expr>
    }

    rule expr:sym<as> {
        <expr> '+' <expr>
    }

    rule expr:sym<at> {
        <expr> '-' <expr>
    }

    rule expr:sym<au> {
        <expr> '*' <expr>
    }

    rule expr:sym<av> {
        <expr> '/' <expr>
    }

    rule expr:sym<aw> {
        <expr> '%' <expr>
    }

    rule expr:sym<ax> {
        <expr> <DOTDOT>
    }

    rule expr:sym<ay> {
        <expr> <DOTDOT> <expr>
    }

    rule expr:sym<az> {
        <DOTDOT> <expr>
    }

    rule expr:sym<ba> {
        <DOTDOT>
    }

    rule expr:sym<bb> {
        <expr> <AS> <ty>
    }

    rule expr:sym<bc> {
        <expr> ':' <ty>
    }

    rule expr:sym<bd> {
        <BOX> <expr>
    }

    rule expr:sym<be> {
        <expr-qualified_path>
    }

    rule expr:sym<bf> {
        <block-expr>
    }

    rule expr:sym<bg> {
        <block>
    }

    rule expr:sym<bh> {
        <nonblock-prefix_expr>
    }
}

our class Expr::A {

    method expr:sym<a>($/) {
        make ExprLit.new(
            lit =>  $<lit>.made,
        )
    }

    method expr:sym<b>($/) {
        make ExprPath.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method expr:sym<c>($/) {
        make ExprPath.new(

        )
    }

    method expr:sym<d>($/) {
        make ExprMac.new(
            macro-expr =>  $<macro-expr>.made,
        )
    }

    method expr:sym<e>($/) {
        make ExprStruct.new(
            path-expr          =>  $<path-expr>.made,
            struct-expr_fields =>  $<struct-expr_fields>.made,
        )
    }

    method expr:sym<f>($/) {
        make ExprTry.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<g>($/) {
        make ExprField.new(
            expr                          =>  $<expr>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
        )
    }

    method expr:sym<h>($/) {
        make ExprTupleIndex.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<i>($/) {
        make ExprIndex.new(
            expr       =>  $<expr>.made,
            maybe-expr =>  $<maybe-expr>.made,
        )
    }

    method expr:sym<j>($/) {
        make ExprCall.new(
            expr        =>  $<expr>.made,
            maybe-exprs =>  $<maybe-exprs>.made,
        )
    }

    method expr:sym<k>($/) {
        make ExprParen.new(
            maybe-exprs =>  $<maybe-exprs>.made,
        )
    }

    method expr:sym<l>($/) {
        make ExprVec.new(
            vec-expr =>  $<vec-expr>.made,
        )
    }

    method expr:sym<m>($/) {
        make ExprAgain.new(

        )
    }

    method expr:sym<n>($/) {
        make ExprAgain.new(
            ident =>  $<ident>.made,
        )
    }

    method expr:sym<o>($/) {
        make ExprRet.new(

        )
    }

    method expr:sym<p>($/) {
        make ExprRet.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<q>($/) {
        make ExprBreak.new(

        )
    }

    method expr:sym<r>($/) {
        make ExprBreak.new(
            ident =>  $<ident>.made,
        )
    }

    method expr:sym<s>($/) {
        make ExprYield.new(

        )
    }

    method expr:sym<t>($/) {
        make ExprYield.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<u>($/) {
        make ExprAssign.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<v>($/) {
        make ExprAssignShl.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<w>($/) {
        make ExprAssignShr.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<x>($/) {
        make ExprAssignSub.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<y>($/) {
        make ExprAssignBitAnd.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<z>($/) {
        make ExprAssignBitOr.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<aa>($/) {
        make ExprAssignAdd.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ab>($/) {
        make ExprAssignMul.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ac>($/) {
        make ExprAssignDiv.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ad>($/) {
        make ExprAssignBitXor.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ae>($/) {
        make ExprAssignRem.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<af>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ag>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ah>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ai>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<aj>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ak>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<al>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<am>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<an>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ao>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ap>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<aq>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ar>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<as>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<at>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<au>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<av>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<aw>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ax>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ay>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<az>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ba>($/) {
        make ExprRange.new(

        )
    }

    method expr:sym<bb>($/) {
        make ExprCast.new(
            expr =>  $<expr>.made,
            ty   =>  $<ty>.made,
        )
    }

    method expr:sym<bc>($/) {
        make ExprTypeAscr.new(
            expr =>  $<expr>.made,
            ty   =>  $<ty>.made,
        )
    }

    method expr:sym<bd>($/) {
        make ExprBox.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<be>($/) {
        make $<expr-qualified_path>.made
    }

    method expr:sym<bf>($/) {
        make $<block-expr>.made
    }

    method expr:sym<bg>($/) {
        make $<block>.made
    }

    method expr:sym<bh>($/) {
        make $<nonblock-prefix_expr>.made
    }
}

#-------------------------------------
our class ExprAssignShr {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprCast {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
    has $.ty;
}

our class ExprNoStruct::G {

    proto rule expr-nostruct { * }

    rule expr-nostruct:sym<a> {
        <lit>
    }

    rule expr-nostruct:sym<b> {
        {self.set-prec(IDENT)} <path-expr>
    }

    rule expr-nostruct:sym<c> {
        <SELF>
    }

    rule expr-nostruct:sym<d> {
        <macro-expr>
    }

    rule expr-nostruct:sym<e> {
        <expr-nostruct> '?'
    }

    rule expr-nostruct:sym<f> {
        <expr-nostruct> '.' <path-generic_args_with_colons>
    }

    rule expr-nostruct:sym<g> {
        <expr-nostruct> '.' <LIT-INTEGER>
    }

    rule expr-nostruct:sym<h> {
        <expr-nostruct> '[' <maybe-expr> ']'
    }

    rule expr-nostruct:sym<i> {
        <expr-nostruct> '(' <maybe-exprs> ')'
    }

    rule expr-nostruct:sym<j> {
        '[' <vec-expr> ']'
    }

    rule expr-nostruct:sym<k> {
        '(' <maybe-exprs> ')'
    }

    rule expr-nostruct:sym<l> {
        <CONTINUE>
    }

    rule expr-nostruct:sym<m> {
        <CONTINUE> <ident>
    }

    rule expr-nostruct:sym<n> {
        <RETURN>
    }

    rule expr-nostruct:sym<o> {
        <RETURN> <expr>
    }

    rule expr-nostruct:sym<p> {
        <BREAK>
    }

    rule expr-nostruct:sym<q> {
        <BREAK> <ident>
    }

    rule expr-nostruct:sym<r> {
        <YIELD>
    }

    rule expr-nostruct:sym<s> {
        <YIELD> <expr>
    }

    rule expr-nostruct:sym<t> {
        <expr-nostruct> '=' <expr-nostruct>
    }

    rule expr-nostruct:sym<u> {
        <expr-nostruct> <SHLEQ> <expr-nostruct>
    }

    rule expr-nostruct:sym<v> {
        <expr-nostruct> <SHREQ> <expr-nostruct>
    }

    rule expr-nostruct:sym<w> {
        <expr-nostruct> <MINUSEQ> <expr-nostruct>
    }

    rule expr-nostruct:sym<x> {
        <expr-nostruct> <ANDEQ> <expr-nostruct>
    }

    rule expr-nostruct:sym<y> {
        <expr-nostruct> <OREQ> <expr-nostruct>
    }

    rule expr-nostruct:sym<z> {
        <expr-nostruct> <PLUSEQ> <expr-nostruct>
    }

    rule expr-nostruct:sym<aa> {
        <expr-nostruct> <STAREQ> <expr-nostruct>
    }

    rule expr-nostruct:sym<ab> {
        <expr-nostruct> <SLASHEQ> <expr-nostruct>
    }

    rule expr-nostruct:sym<ac> {
        <expr-nostruct> <CARETEQ> <expr-nostruct>
    }

    rule expr-nostruct:sym<ad> {
        <expr-nostruct> <PERCENTEQ> <expr-nostruct>
    }

    rule expr-nostruct:sym<ae> {
        <expr-nostruct> <OROR> <expr-nostruct>
    }

    rule expr-nostruct:sym<af> {
        <expr-nostruct> <ANDAND> <expr-nostruct>
    }

    rule expr-nostruct:sym<ag> {
        <expr-nostruct> <EQEQ> <expr-nostruct>
    }

    rule expr-nostruct:sym<ah> {
        <expr-nostruct> <NE> <expr-nostruct>
    }

    rule expr-nostruct:sym<ai> {
        <expr-nostruct> '<' <expr-nostruct>
    }

    rule expr-nostruct:sym<aj> {
        <expr-nostruct> '>' <expr-nostruct>
    }

    rule expr-nostruct:sym<ak> {
        <expr-nostruct> <LE> <expr-nostruct>
    }

    rule expr-nostruct:sym<al> {
        <expr-nostruct> <GE> <expr-nostruct>
    }

    rule expr-nostruct:sym<am> {
        <expr-nostruct> '|' <expr-nostruct>
    }

    rule expr-nostruct:sym<an> {
        <expr-nostruct> '^' <expr-nostruct>
    }

    rule expr-nostruct:sym<ao> {
        <expr-nostruct> '&' <expr-nostruct>
    }

    rule expr-nostruct:sym<ap> {
        <expr-nostruct> <SHL> <expr-nostruct>
    }

    rule expr-nostruct:sym<aq> {
        <expr-nostruct> <SHR> <expr-nostruct>
    }

    rule expr-nostruct:sym<ar> {
        <expr-nostruct> '+' <expr-nostruct>
    }

    rule expr-nostruct:sym<as> {
        <expr-nostruct> '-' <expr-nostruct>
    }

    rule expr-nostruct:sym<at> {
        <expr-nostruct> '*' <expr-nostruct>
    }

    rule expr-nostruct:sym<au> {
        <expr-nostruct> '/' <expr-nostruct>
    }

    rule expr-nostruct:sym<av> {
        <expr-nostruct> '%' <expr-nostruct>
    }

    rule expr-nostruct:sym<aw> {
        <expr-nostruct> <DOTDOT> {self.set-prec(RANGE)}
    }

    rule expr-nostruct:sym<ax> {
        <expr-nostruct> <DOTDOT> <expr-nostruct>
    }

    rule expr-nostruct:sym<ay> {
        <DOTDOT> <expr-nostruct>
    }

    rule expr-nostruct:sym<az> {
        <DOTDOT>
    }

    rule expr-nostruct:sym<ba> {
        <expr-nostruct> <AS> <ty>
    }

    rule expr-nostruct:sym<bb> {
        <expr-nostruct> ':' <ty>
    }

    rule expr-nostruct:sym<bc> {
        <BOX> <expr>
    }

    rule expr-nostruct:sym<bd> {
        <expr-qualified_path>
    }

    rule expr-nostruct:sym<be> {
        <block-expr>
    }

    rule expr-nostruct:sym<bf> {
        <block>
    }

    rule expr-nostruct:sym<bg> {
        <nonblock-prefix_expr_nostruct>
    }
}

our class ExprNoStruct::A {

    method expr-nostruct:sym<a>($/) {
        make ExprLit.new(
            lit =>  $<lit>.made,
        )
    }

    method expr-nostruct:sym<b>($/) {
        make ExprPath.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method expr-nostruct:sym<c>($/) {
        make ExprPath.new(

        )
    }

    method expr-nostruct:sym<d>($/) {
        make ExprMac.new(
            macro-expr =>  $<macro-expr>.made,
        )
    }

    method expr-nostruct:sym<e>($/) {
        make ExprTry.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<f>($/) {
        make ExprField.new(
            expr-nostruct                 =>  $<expr-nostruct>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
        )
    }

    method expr-nostruct:sym<g>($/) {
        make ExprTupleIndex.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<h>($/) {
        make ExprIndex.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            maybe-expr    =>  $<maybe-expr>.made,
        )
    }

    method expr-nostruct:sym<i>($/) {
        make ExprCall.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            maybe-exprs   =>  $<maybe-exprs>.made,
        )
    }

    method expr-nostruct:sym<j>($/) {
        make ExprVec.new(
            vec-expr =>  $<vec-expr>.made,
        )
    }

    method expr-nostruct:sym<k>($/) {
        make ExprParen.new(
            maybe-exprs =>  $<maybe-exprs>.made,
        )
    }

    method expr-nostruct:sym<l>($/) {
        make ExprAgain.new(

        )
    }

    method expr-nostruct:sym<m>($/) {
        make ExprAgain.new(
            ident =>  $<ident>.made,
        )
    }

    method expr-nostruct:sym<n>($/) {
        make ExprRet.new(

        )
    }

    method expr-nostruct:sym<o>($/) {
        make ExprRet.new(
            expr =>  $<expr>.made,
        )
    }

    method expr-nostruct:sym<p>($/) {
        make ExprBreak.new(

        )
    }

    method expr-nostruct:sym<q>($/) {
        make ExprBreak.new(
            ident =>  $<ident>.made,
        )
    }

    method expr-nostruct:sym<r>($/) {
        make ExprYield.new(

        )
    }

    method expr-nostruct:sym<s>($/) {
        make ExprYield.new(
            expr =>  $<expr>.made,
        )
    }

    method expr-nostruct:sym<t>($/) {
        make ExprAssign.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<u>($/) {
        make ExprAssignShl.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<v>($/) {
        make ExprAssignShr.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<w>($/) {
        make ExprAssignSub.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<x>($/) {
        make ExprAssignBitAnd.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<y>($/) {
        make ExprAssignBitOr.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<z>($/) {
        make ExprAssignAdd.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<aa>($/) {
        make ExprAssignMul.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ab>($/) {
        make ExprAssignDiv.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ac>($/) {
        make ExprAssignBitXor.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ad>($/) {
        make ExprAssignRem.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ae>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<af>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ag>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ah>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ai>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<aj>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ak>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<al>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<am>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<an>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ao>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ap>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<aq>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ar>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<as>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<at>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<au>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<av>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<aw>($/) {
        make ExprRange.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ax>($/) {
        make ExprRange.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ay>($/) {
        make ExprRange.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<az>($/) {
        make ExprRange.new(

        )
    }

    method expr-nostruct:sym<ba>($/) {
        make ExprCast.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            ty            =>  $<ty>.made,
        )
    }

    method expr-nostruct:sym<bb>($/) {
        make ExprTypeAscr.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            ty            =>  $<ty>.made,
        )
    }

    method expr-nostruct:sym<bc>($/) {
        make ExprBox.new(
            expr =>  $<expr>.made,
        )
    }

    method expr-nostruct:sym<bd>($/) {
        make $<expr-qualified_path>.made
    }

    method expr-nostruct:sym<be>($/) {
        make $<block-expr>.made
    }

    method expr-nostruct:sym<bf>($/) {
        make $<block>.made
    }

    method expr-nostruct:sym<bg>($/) {
        make $<nonblock-prefix_expr_nostruct>.made
    }
}

#-------------------------------------
our class ExprAddrOf {
    has $.expr_nostruct;
    has $.maybe_mut;
    has $.expr;
}

our class ExprUnary {
    has $.expr;
    has $.expr_nostruct;
}

our class NonblockPrefixExpr::G {

    proto rule nonblock-prefix_expr_nostruct { * }

    rule nonblock-prefix_expr_nostruct:sym<a> {
        '-' <expr-nostruct>
    }

    rule nonblock-prefix_expr_nostruct:sym<b> {
        '!' <expr-nostruct>
    }

    rule nonblock-prefix_expr_nostruct:sym<c> {
        '*' <expr-nostruct>
    }

    rule nonblock-prefix_expr_nostruct:sym<d> {
        '&' <maybe-mut> <expr-nostruct>
    }

    rule nonblock-prefix_expr_nostruct:sym<e> {
        <ANDAND> <maybe-mut> <expr-nostruct>
    }

    rule nonblock-prefix_expr_nostruct:sym<f> {
        <lambda-expr_nostruct>
    }

    rule nonblock-prefix_expr_nostruct:sym<g> {
        <MOVE> <lambda-expr_nostruct>
    }

    proto rule nonblock-prefix_expr { * }

    rule nonblock-prefix_expr:sym<a> {
        '-' <expr>
    }

    rule nonblock-prefix_expr:sym<b> {
        '!' <expr>
    }

    rule nonblock-prefix_expr:sym<c> {
        '*' <expr>
    }

    rule nonblock-prefix_expr:sym<d> {
        '&' <maybe-mut> <expr>
    }

    rule nonblock-prefix_expr:sym<e> {
        <ANDAND> <maybe-mut> <expr>
    }

    rule nonblock-prefix_expr:sym<f> {
        <lambda-expr>
    }

    rule nonblock-prefix_expr:sym<g> {
        <MOVE> <lambda-expr>
    }
}

our class NonblockPrefixExpr::A {

    method nonblock-prefix_expr_nostruct:sym<a>($/) {
        make ExprUnary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method nonblock-prefix_expr_nostruct:sym<b>($/) {
        make ExprUnary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method nonblock-prefix_expr_nostruct:sym<c>($/) {
        make ExprUnary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method nonblock-prefix_expr_nostruct:sym<d>($/) {
        make ExprAddrOf.new(
            maybe-mut     =>  $<maybe-mut>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method nonblock-prefix_expr_nostruct:sym<e>($/) {
        make ExprAddrOf.new(

        )
    }

    method nonblock-prefix_expr_nostruct:sym<f>($/) {
        make $<lambda-expr_nostruct>.made
    }

    method nonblock-prefix_expr_nostruct:sym<g>($/) {
        make $<lambda_expr_nostruct>.made
    }

    method nonblock-prefix_expr:sym<a>($/) {
        make ExprUnary.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-prefix_expr:sym<b>($/) {
        make ExprUnary.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-prefix_expr:sym<c>($/) {
        make ExprUnary.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-prefix_expr:sym<d>($/) {
        make ExprAddrOf.new(
            maybe-mut =>  $<maybe-mut>.made,
            expr      =>  $<expr>.made,
        )
    }

    method nonblock-prefix_expr:sym<e>($/) {
        make ExprAddrOf.new(

        )
    }

    method nonblock-prefix_expr:sym<f>($/) {
        make $<lambda-expr>.made
    }

    method nonblock-prefix_expr:sym<g>($/) {
        make $<lambda_expr>.made
    }
}

#-------------------------------------
our class ExprQualifiedPath {
    has $.ty_sum;
    has $.maybe_qpath_params;
    has $.generic_args;
    has $.maybe_as_trait_ref;
    has $.ident;
}

our class ExprQualifiedPath::G {

    proto rule expr-qualified_path { * }

    rule expr-qualified_path:sym<a> {
        '<' <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <maybe-qpath_params>
    }

    rule expr-qualified_path:sym<b> {
        <SHL> <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <maybe-as_trait_ref> '>' <MOD-SEP> <ident>
    }

    rule expr-qualified_path:sym<c> {
        <SHL> <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <generic-args> <maybe-as_trait_ref> '>' <MOD-SEP> <ident>
    }

    rule expr-qualified_path:sym<d> {
        <SHL> <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <generic-args>
    }

    rule expr-qualified_path:sym<e> {
        <SHL> <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <generic-args> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <generic-args>
    }
}

our class ExprQualifiedPath::A {

    method expr-qualified_path:sym<a>($/) {
        make ExprQualifiedPath.new(
            ty-sum             =>  $<ty-sum>.made,
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
            maybe-qpath_params =>  $<maybe-qpath_params>.made,
        )
    }

    method expr-qualified_path:sym<b>($/) {
        make ExprQualifiedPath.new(
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method expr-qualified_path:sym<c>($/) {
        make ExprQualifiedPath.new(
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method expr-qualified_path:sym<d>($/) {
        make ExprQualifiedPath.new(
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
            generic-args       =>  $<generic-args>.made,
        )
    }

    method expr-qualified_path:sym<e>($/) {
        make ExprQualifiedPath.new(
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
            generic-args       =>  $<generic-args>.made,
        )
    }
}

#-------------------------------------
our class QPathParams::G {

    proto rule maybe-qpath_params { * }

    rule maybe-qpath_params:sym<a> {
        <MOD-SEP> <generic-args>
    }

    rule maybe-qpath_params:sym<b> {

    }
}

our class QPathParams::A {

    method maybe-qpath_params:sym<a>($/) {
        make $<generic_args>.made
    }

    method maybe-qpath_params:sym<b>($/) {
        MkNone<140654400390368>
    }
}

#-------------------------------------
our class AsTraitRef::G {

    proto rule maybe-as_trait_ref { * }

    rule maybe-as_trait_ref:sym<a> {
        <AS> <trait-ref>
    }

    rule maybe-as_trait_ref:sym<b> {

    }
}

our class AsTraitRef::A {

    method maybe-as_trait_ref:sym<a>($/) {
        make $<trait_ref>.made
    }

    method maybe-as_trait_ref:sym<b>($/) {
        MkNone<140417796742176>
    }
}

#-------------------------------------
our class ExprFnBlock {
    has $.ret_ty;
    has $.expr;
    has $.inferrable_params;
    has $.lambda_expr_nostruct_no_first_bar;
    has $.lambda_expr_no_first_bar;
    has $.expr_nostruct;
}

our class LambdaExpr::G {

    proto rule lambda-expr { * }

    rule lambda-expr:sym<a> {
        {self.set-prec(LAMBDA)} <OROR> <ret-ty> <expr>
    }

    rule lambda-expr:sym<b> {
        {self.set-prec(LAMBDA)} '|' '|' <ret-ty> <expr>
    }

    rule lambda-expr:sym<c> {
        {self.set-prec(LAMBDA)} '|' <inferrable-params> '|' <ret-ty> <expr>
    }

    rule lambda-expr:sym<d> {
        {self.set-prec(LAMBDA)} '|' <inferrable-params> <OROR> <lambda-expr_no_first_bar>
    }

    proto rule lambda-expr_no_first_bar { * }

    rule lambda-expr_no_first_bar:sym<a> {
        {self.set-prec(LAMBDA)} '|' <ret-ty> <expr>
    }

    rule lambda-expr_no_first_bar:sym<b> {
        {self.set-prec(LAMBDA)} <inferrable-params> '|' <ret-ty> <expr>
    }

    rule lambda-expr_no_first_bar:sym<c> {
        {self.set-prec(LAMBDA)} <inferrable-params> <OROR> <lambda-expr_no_first_bar>
    }

    proto rule lambda-expr_nostruct { * }

    rule lambda-expr_nostruct:sym<a> {
        {self.set-prec(LAMBDA)} <OROR> <expr-nostruct>
    }

    rule lambda-expr_nostruct:sym<b> {
        {self.set-prec(LAMBDA)} '|' '|' <ret-ty> <expr-nostruct>
    }

    rule lambda-expr_nostruct:sym<c> {
        {self.set-prec(LAMBDA)} '|' <inferrable-params> '|' <expr-nostruct>
    }

    rule lambda-expr_nostruct:sym<d> {
        {self.set-prec(LAMBDA)} '|' <inferrable-params> <OROR> <lambda-expr_nostruct_no_first_bar>
    }

    proto rule lambda-expr_nostruct_no_first_bar { * }

    rule lambda-expr_nostruct_no_first_bar:sym<a> {
        {self.set-prec(LAMBDA)} '|' <ret-ty> <expr-nostruct>
    }

    rule lambda-expr_nostruct_no_first_bar:sym<b> {
        {self.set-prec(LAMBDA)} <inferrable-params> '|' <ret-ty> <expr-nostruct>
    }

    rule lambda-expr_nostruct_no_first_bar:sym<c> {
        {self.set-prec(LAMBDA)} <inferrable-params> <OROR> <lambda-expr_nostruct_no_first_bar>
    }
}

our class LambdaExpr::A {

    method lambda-expr:sym<a>($/) {
        make ExprFnBlock.new(
            ret-ty =>  $<ret-ty>.made,
            expr   =>  $<expr>.made,
        )
    }

    method lambda-expr:sym<b>($/) {
        make ExprFnBlock.new(
            ret-ty =>  $<ret-ty>.made,
            expr   =>  $<expr>.made,
        )
    }

    method lambda-expr:sym<c>($/) {
        make ExprFnBlock.new(
            inferrable-params =>  $<inferrable-params>.made,
            ret-ty            =>  $<ret-ty>.made,
            expr              =>  $<expr>.made,
        )
    }

    method lambda-expr:sym<d>($/) {
        make ExprFnBlock.new(
            inferrable-params        =>  $<inferrable-params>.made,
            lambda-expr_no_first_bar =>  $<lambda-expr_no_first_bar>.made,
        )
    }

    method lambda-expr_no_first_bar:sym<a>($/) {
        make ExprFnBlock.new(
            ret-ty =>  $<ret-ty>.made,
            expr   =>  $<expr>.made,
        )
    }

    method lambda-expr_no_first_bar:sym<b>($/) {
        make ExprFnBlock.new(
            inferrable-params =>  $<inferrable-params>.made,
            ret-ty            =>  $<ret-ty>.made,
            expr              =>  $<expr>.made,
        )
    }

    method lambda-expr_no_first_bar:sym<c>($/) {
        make ExprFnBlock.new(
            inferrable-params        =>  $<inferrable-params>.made,
            lambda-expr_no_first_bar =>  $<lambda-expr_no_first_bar>.made,
        )
    }

    method lambda-expr_nostruct:sym<a>($/) {
        make ExprFnBlock.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr_nostruct:sym<b>($/) {
        make ExprFnBlock.new(
            ret-ty        =>  $<ret-ty>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr_nostruct:sym<c>($/) {
        make ExprFnBlock.new(
            inferrable-params =>  $<inferrable-params>.made,
            expr-nostruct     =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr_nostruct:sym<d>($/) {
        make ExprFnBlock.new(
            inferrable-params                 =>  $<inferrable-params>.made,
            lambda-expr_nostruct_no_first_bar =>  $<lambda-expr_nostruct_no_first_bar>.made,
        )
    }

    method lambda-expr_nostruct_no_first_bar:sym<a>($/) {
        make ExprFnBlock.new(
            ret-ty        =>  $<ret-ty>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr_nostruct_no_first_bar:sym<b>($/) {
        make ExprFnBlock.new(
            inferrable-params =>  $<inferrable-params>.made,
            ret-ty            =>  $<ret-ty>.made,
            expr-nostruct     =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr_nostruct_no_first_bar:sym<c>($/) {
        make ExprFnBlock.new(
            inferrable-params                 =>  $<inferrable-params>.made,
            lambda-expr_nostruct_no_first_bar =>  $<lambda-expr_nostruct_no_first_bar>.made,
        )
    }
}

#-------------------------------------
our class VecRepeat {
    has $.expr;
    has $.exprs;
}

our class VecExpr::G {

    proto rule vec-expr { * }

    rule vec-expr:sym<a> {
        <maybe-exprs>
    }

    rule vec-expr:sym<b> {
        <exprs> ';' <expr>
    }
}

our class VecExpr::A {

    method vec-expr:sym<a>($/) {
        make $<maybe-exprs>.made
    }

    method vec-expr:sym<b>($/) {
        make VecRepeat.new(
            exprs =>  $<exprs>.made,
            expr  =>  $<expr>.made,
        )
    }
}

#-------------------------------------
our class DefaultFieldInit {
    has $.expr;
}

our class FieldInit {
    has $.ident;
    has $.expr;
}

our class FieldInits {
    has $.field_init;
}

our class StructExpr::G {

    proto rule struct-expr_fields { * }

    rule struct-expr_fields:sym<a> {
        <field-inits>
    }

    rule struct-expr_fields:sym<b> {
        <field-inits> ','
    }

    rule struct-expr_fields:sym<c> {
        <maybe-field_inits> <default-field_init>
    }

    rule struct-expr_fields:sym<d> {

    }

    proto rule maybe-field_inits { * }

    rule maybe-field_inits:sym<a> {
        <field-inits>
    }

    rule maybe-field_inits:sym<b> {
        <field-inits> ','
    }

    rule maybe-field_inits:sym<c> {

    }

    proto rule field-inits { * }

    rule field-inits:sym<a> {
        <field-init>
    }

    rule field-inits:sym<b> {
        <field-inits> ',' <field-init>
    }

    proto rule field-init { * }

    rule field-init:sym<a> {
        <ident>
    }

    rule field-init:sym<b> {
        <ident> ':' <expr>
    }

    rule field-init:sym<c> {
        <LIT-INTEGER> ':' <expr>
    }

    rule default-field_init {
        <DOTDOT> <expr>
    }
}

our class StructExpr::A {

    method struct-expr_fields:sym<a>($/) {
        make $<field-inits>.made
    }

    method struct-expr_fields:sym<b>($/) {

    }

    method struct-expr_fields:sym<c>($/) {
        ExtNode<140520912503920>
    }

    method struct-expr_fields:sym<d>($/) {
        MkNone<140520354460832>
    }

    method maybe-field_inits:sym<a>($/) {
        make $<field-inits>.made
    }

    method maybe-field_inits:sym<b>($/) {

    }

    method maybe-field_inits:sym<c>($/) {
        MkNone<140520354460864>
    }

    method field-inits:sym<a>($/) {
        make FieldInits.new(
            field-init =>  $<field-init>.made,
        )
    }

    method field-inits:sym<b>($/) {
        ExtNode<140520912504200>
    }

    method field-init:sym<a>($/) {
        make FieldInit.new(
            ident =>  $<ident>.made,
        )
    }

    method field-init:sym<b>($/) {
        make FieldInit.new(
            ident =>  $<ident>.made,
            expr  =>  $<expr>.made,
        )
    }

    method field-init:sym<c>($/) {
        make FieldInit.new(
            expr =>  $<expr>.made,
        )
    }

    method default-field_init($/) {
        make DefaultFieldInit.new(
            expr =>  $<expr>.made,
        )
    }
}

#---------------------------------------------
our class Macro {
    has $.braces_delimited_token_trees;
    has $.path_expr;
    has $.maybe_ident;
}

our class UnsafeBlock {
    has $.block;
}

our class BlockExpr::G {

    proto rule block-expr { * }

    rule block-expr:sym<a> {
        <expr-match>
    }

    rule block-expr:sym<b> {
        <expr-if>
    }

    rule block-expr:sym<c> {
        <expr-if_let>
    }

    rule block-expr:sym<d> {
        <expr-while>
    }

    rule block-expr:sym<e> {
        <expr-while_let>
    }

    rule block-expr:sym<f> {
        <expr-loop>
    }

    rule block-expr:sym<g> {
        <expr-for>
    }

    rule block-expr:sym<h> {
        <UNSAFE> <block>
    }

    rule block-expr:sym<i> {
        <path-expr> '!' <maybe-ident> <braces-delimited_token_trees>
    }

    proto rule full-block_expr { * }

    rule full-block_expr:sym<a> {
        <block-expr>
    }

    rule full-block_expr:sym<b> {
        <block-expr_dot>
    }

    proto rule block-expr_dot { * }

    rule block-expr_dot:sym<a> {
        <block-expr> '.' <path-generic_args_with_colons> {self.set-prec(IDENT)}
    }

    rule block-expr_dot:sym<b> {
        <block-expr_dot> '.' <path-generic_args_with_colons> {self.set-prec(IDENT)}
    }

    rule block-expr_dot:sym<c> {
        <block-expr> '.' <path-generic_args_with_colons> '[' <maybe-expr> ']'
    }

    rule block-expr_dot:sym<d> {
        <block-expr_dot> '.' <path-generic_args_with_colons> '[' <maybe-expr> ']'
    }

    rule block-expr_dot:sym<e> {
        <block-expr> '.' <path-generic_args_with_colons> '(' <maybe-exprs> ')'
    }

    rule block-expr_dot:sym<f> {
        <block-expr_dot> '.' <path-generic_args_with_colons> '(' <maybe-exprs> ')'
    }

    rule block-expr_dot:sym<g> {
        <block-expr> '.' <LIT-INTEGER>
    }

    rule block-expr_dot:sym<h> {
        <block-expr_dot> '.' <LIT-INTEGER>
    }
}

our class BlockExpr::A {

    method block-expr:sym<a>($/) {
        make $<expr-match>.made
    }

    method block-expr:sym<b>($/) {
        make $<expr-if>.made
    }

    method block-expr:sym<c>($/) {
        make $<expr-if_let>.made
    }

    method block-expr:sym<d>($/) {
        make $<expr-while>.made
    }

    method block-expr:sym<e>($/) {
        make $<expr-while_let>.made
    }

    method block-expr:sym<f>($/) {
        make $<expr-loop>.made
    }

    method block-expr:sym<g>($/) {
        make $<expr-for>.made
    }

    method block-expr:sym<h>($/) {
        make UnsafeBlock.new(
            block =>  $<block>.made,
        )
    }

    method block-expr:sym<i>($/) {
        make Macro.new(
            path-expr                    =>  $<path-expr>.made,
            maybe-ident                  =>  $<maybe-ident>.made,
            braces-delimited_token_trees =>  $<braces-delimited_token_trees>.made,
        )
    }

    method full-block_expr:sym<a>($/) {
        make $<block-expr>.made
    }

    method full-block_expr:sym<b>($/) {
        make $<block-expr_dot>.made
    }

    method block-expr_dot:sym<a>($/) {
        make ExprField.new(
            block-expr                    =>  $<block-expr>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
        )
    }

    method block-expr_dot:sym<b>($/) {
        make ExprField.new(
            block-expr_dot                =>  $<block-expr_dot>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
        )
    }

    method block-expr_dot:sym<c>($/) {
        make ExprIndex.new(
            block-expr                    =>  $<block-expr>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
            maybe-expr                    =>  $<maybe-expr>.made,
        )
    }

    method block-expr_dot:sym<d>($/) {
        make ExprIndex.new(
            block-expr_dot                =>  $<block-expr_dot>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
            maybe-expr                    =>  $<maybe-expr>.made,
        )
    }

    method block-expr_dot:sym<e>($/) {
        make ExprCall.new(
            block-expr                    =>  $<block-expr>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
            maybe-exprs                   =>  $<maybe-exprs>.made,
        )
    }

    method block-expr_dot:sym<f>($/) {
        make ExprCall.new(
            block-expr_dot                =>  $<block-expr_dot>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
            maybe-exprs                   =>  $<maybe-exprs>.made,
        )
    }

    method block-expr_dot:sym<g>($/) {
        make ExprTupleIndex.new(
            block-expr =>  $<block-expr>.made,
        )
    }

    method block-expr_dot:sym<h>($/) {
        make ExprTupleIndex.new(
            block-expr_dot =>  $<block-expr_dot>.made,
        )
    }
}

#---------------------------------------------
our class BlockOrIf::G {

    proto rule block-or_if { * }

    rule block-or_if:sym<a> {
        <block>
    }

    rule block-or_if:sym<b> {
        <expr-if>
    }

    rule block-or_if:sym<c> {
        <expr-if_let>
    }
}

our class BlockOrIf::A {

    method block-or_if:sym<a>($/) {
        make $<block>.made
    }

    method block-or_if:sym<b>($/) {
        make $<expr-if>.made
    }

    method block-or_if:sym<c>($/) {
        make $<expr-if_let>.made
    }
}

#------------------------------
our class ExprForLoop {
    has $.expr_nostruct;
    has $.block;
    has $.pat;
    has $.maybe_label;
}

our class ExprFor::G {

    rule expr-for {
        <maybe-label> <FOR> <pat> <IN> <expr-nostruct> <block>
    }
}

our class ExprFor::A {

    method expr-for($/) {
        make ExprForLoop.new(
            maybe-label   =>  $<maybe-label>.made,
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }
}

#-----------------------------------------
our class ExprIfLet {
    has $.expr_nostruct;
    has $.block;
    has $.pat;
    has $.block_or_if;
}

our class ExprIfLet::G {

    proto rule expr-if_let { * }

    rule expr-if_let:sym<a> {
        <IF> <LET> <pat> '=' <expr-nostruct> <block>
    }

    rule expr-if_let:sym<b> {
        <IF> <LET> <pat> '=' <expr-nostruct> <block> <ELSE> <block-or_if>
    }
}

our class ExprIfLet::A {

    method expr-if_let:sym<a>($/) {
        make ExprIfLet.new(
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }

    method expr-if_let:sym<b>($/) {
        make ExprIfLet.new(
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
            block-or_if   =>  $<block-or_if>.made,
        )
    }
}


#----------------------------------
our class ExprIf {
    has $.block_or_if;
    has $.block;
    has $.expr_nostruct;
}

our class ExprIf::G {

    proto rule expr-if { * }

    rule expr-if:sym<a> {
        <IF> <expr-nostruct> <block>
    }

    rule expr-if:sym<b> {
        <IF> <expr-nostruct> <block> <ELSE> <block-or_if>
    }
}

our class ExprIf::A {

    method expr-if:sym<a>($/) {
        make ExprIf.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }

    method expr-if:sym<b>($/) {
        make ExprIf.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
            block-or_if   =>  $<block-or_if>.made,
        )
    }
}


#------------------------------------
our class ExprLoop {
    has $.block;
    has $.maybe_label;
}

our class ExprLoop::G {

    rule expr-loop {
        <maybe-label> <LOOP> <block>
    }
}

our class ExprLoop::A {

    method expr-loop($/) {
        make ExprLoop.new(
            maybe-label =>  $<maybe-label>.made,
            block       =>  $<block>.made,
        )
    }
}

#--------------------------
our class ExprWhileLet {
    has $.expr_nostruct;
    has $.pat;
    has $.block;
    has $.maybe_label;
}

our class ExprWhileLet::G {

    rule expr-while_let {
        <maybe-label> <WHILE> <LET> <pat> '=' <expr-nostruct> <block>
    }
}

our class ExprWhileLet::A {

    method expr-while_let($/) {
        make ExprWhileLet.new(
            maybe-label   =>  $<maybe-label>.made,
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }
}


#---------------------------------------
our class ExprWhile {
    has $.expr_nostruct;
    has $.block;
    has $.maybe_label;
}

our class ExprWhile::G {

    rule expr-while {
        <maybe-label> <WHILE> <expr-nostruct> <block>
    }
}

our class ExprWhile::A {

    method expr-while($/) {
        make ExprWhile.new(
            maybe-label   =>  $<maybe-label>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }
}

#--------------------------
our class Guard::G {

    proto rule maybe-guard { * }

    rule maybe-guard:sym<a> {
        <IF> <expr-nostruct>
    }

    rule maybe-guard:sym<b> {

    }
}

our class Guard::A {

    method maybe-guard:sym<a>($/) {
        make $<expr_nostruct>.made
    }

    method maybe-guard:sym<b>($/) {
        MkNone<140269876955936>
    }
}

#--------------------------------
our class DeclLocal {
    has $.pat;
    has $.maybe_init_expr;
    has $.maybe_ty_ascription;
}

our class Let::G {

    rule let {
        <LET> <pat> <maybe-ty_ascription> <maybe-init_expr> ';'
    }
}

our class Let::A {

    method let($/) {
        make DeclLocal.new(
            pat                 =>  $<pat>.made,
            maybe-ty_ascription =>  $<maybe-ty_ascription>.made,
            maybe-init_expr     =>  $<maybe-init_expr>.made,
        )
    }
}


#----------------------------------
our class ArmBlock {
    has $.block_expr;
    has $.block;
    has $.pats_or;
    has $.maybe_guard;
    has $.maybe_outer_attrs;
}

our class ArmNonblock {
    has $.nonblock_expr;
    has $.maybe_outer_attrs;
    has $.block_expr_dot;
    has $.maybe_guard;
    has $.pats_or;
}

our class Arms {
    has $.match_clause;
}

our class ExprMatch {
    has $.match_clauses;
    has $.nonblock_match_clause;
    has $.expr_nostruct;
}

our class ExprMatch::G {

    proto rule expr-match { * }

    rule expr-match:sym<a> {
        <MATCH> <expr-nostruct> '{' '}'
    }

    rule expr-match:sym<b> {
        <MATCH> <expr-nostruct> '{' <match-clauses> '}'
    }

    rule expr-match:sym<c> {
        <MATCH> <expr-nostruct> '{' <match-clauses> <nonblock-match_clause> '}'
    }

    rule expr-match:sym<d> {
        <MATCH> <expr-nostruct> '{' <nonblock-match_clause> '}'
    }

    proto rule match-clauses { * }

    rule match-clauses:sym<a> {
        <match-clause>
    }

    rule match-clauses:sym<b> {
        <match-clauses> <match-clause>
    }

    proto rule match-clause { * }

    rule match-clause:sym<a> {
        <nonblock-match_clause> ','
    }

    rule match-clause:sym<b> {
        <block-match_clause>
    }

    rule match-clause:sym<c> {
        <block-match_clause> ','
    }

    proto rule nonblock-match_clause { * }

    rule nonblock-match_clause:sym<a> {
        <maybe-outer_attrs> <pats-or> <maybe-guard> <FAT-ARROW> <nonblock-expr>
    }

    rule nonblock-match_clause:sym<b> {
        <maybe-outer_attrs> <pats-or> <maybe-guard> <FAT-ARROW> <block-expr_dot>
    }

    proto rule block-match_clause { * }

    rule block-match_clause:sym<a> {
        <maybe-outer_attrs> <pats-or> <maybe-guard> <FAT-ARROW> <block>
    }

    rule block-match_clause:sym<b> {
        <maybe-outer_attrs> <pats-or> <maybe-guard> <FAT-ARROW> <block-expr>
    }
}

our class ExprMatch::A {

    method expr-match:sym<a>($/) {
        make ExprMatch.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-match:sym<b>($/) {
        make ExprMatch.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            match-clauses =>  $<match-clauses>.made,
        )
    }

    method expr-match:sym<c>($/) {
        make ExprMatch.new(
            expr-nostruct         =>  $<expr-nostruct>.made,
            match-clauses         =>  $<match-clauses>.made,
            nonblock-match_clause =>  $<nonblock-match_clause>.made,
        )
    }

    method expr-match:sym<d>($/) {
        make ExprMatch.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method match-clauses:sym<a>($/) {
        make Arms.new(
            match-clause =>  $<match-clause>.made,
        )
    }

    method match-clauses:sym<b>($/) {
        ExtNode<140195582985864>
    }

    method match-clause:sym<a>($/) {

    }

    method match-clause:sym<b>($/) {
        make $<block-match_clause>.made
    }

    method match-clause:sym<c>($/) {

    }

    method nonblock-match_clause:sym<a>($/) {
        make ArmNonblock.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            nonblock-expr     =>  $<nonblock-expr>.made,
        )
    }

    method nonblock-match_clause:sym<b>($/) {
        make ArmNonblock.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            block-expr_dot    =>  $<block-expr_dot>.made,
        )
    }

    method block-match_clause:sym<a>($/) {
        make ArmBlock.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            block             =>  $<block>.made,
        )
    }

    method block-match_clause:sym<b>($/) {
        make ArmBlock.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            block-expr        =>  $<block-expr>.made,
        )
    }
}

#------------------------------------------
our class TTDelim {
    has $.token_trees;
}

our class TTTok {
    has $.unpaired_token;
}

our class TokenTree::G {

    proto rule token-trees { * }

    rule token-trees:sym<a> {

    }

    rule token-trees:sym<b> {
        <token-trees> <token-tree>
    }

    proto rule token-tree { * }

    rule token-tree:sym<a> {
        <delimited-token_trees>
    }

    rule token-tree:sym<b> {
        <unpaired-token>
    }

    proto rule delimited-token_trees { * }

    rule delimited-token_trees:sym<a> {
        <parens-delimited_token_trees>
    }

    rule delimited-token_trees:sym<b> {
        <braces-delimited_token_trees>
    }

    rule delimited-token_trees:sym<c> {
        <brackets-delimited_token_trees>
    }

    rule parens-delimited_token_trees {
        '(' <token-trees> ')'
    }

    rule braces-delimited_token_trees {
        '{' <token-trees> '}'
    }

    rule brackets-delimited_token_trees {
        '[' <token-trees> ']'
    }
}

our class TokenTree::A {

    method token-trees:sym<a>($/) {
        make TokenTrees.new(

        )
    }

    method token-trees:sym<b>($/) {
        ExtNode<140250172947112>
    }

    method token-tree:sym<a>($/) {
        make $<delimited-token_trees>.made
    }

    method token-tree:sym<b>($/) {
        make TTTok.new(
            unpaired-token =>  $<unpaired-token>.made,
        )
    }

    method delimited-token_trees:sym<a>($/) {
        make $<parens-delimited_token_trees>.made
    }

    method delimited-token_trees:sym<b>($/) {
        make $<braces-delimited_token_trees>.made
    }

    method delimited-token_trees:sym<c>($/) {
        make $<brackets-delimited_token_trees>.made
    }

    method parens-delimited_token_trees($/) {
        make TTDelim.new(
            token-trees =>  $<token-trees>.made,
        )
    }

    method braces-delimited_token_trees($/) {
        make TTDelim.new(
            token-trees =>  $<token-trees>.made,
        )
    }

    method brackets-delimited_token_trees($/) {
        make TTDelim.new(
            token-trees =>  $<token-trees>.made,
        )
    }
}

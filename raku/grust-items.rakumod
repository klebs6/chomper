our role ItemsAndAttributes {
    token maybe-shebang { 
        <SHEBANG_LINE>?
    }
}

#------------------------
our role Crate::G {

    proto token crate { * }

    token crate:sym<A> {  
        <maybe_shebang> 
        <inner_attrs> 
        <maybe_mod_items> 
    }

    token crate:sym<B> {  
        <maybe_shebang> 
        <maybe_mod_items>  
    }
}

our role Crate::A {
    method crate:sym<A>($/) {
        make Crate.new(
            inner_attrs     => $<inner_attrs>.made,
            maybe_mod_items => $<maybe_mod_items>.made,
        )
    }

    method crate:sym<B>($/) {
        make Crate.new(
            maybe_mod_items => $<maybe_mod_items>.made,
        )
    }
}

#------------------------
our role InnerAttrs::G {

    token maybe_inner_attrs {
        <inner_attrs>?
    }

    rule inner_attrs {
        <inner_attr>+
    }

    proto rule inner_attr { * }

    rule inner_attr:sym<shebang-meta> {
        <SHEBANG> '[' <meta_item> ']'   
    }

    rule inner_attr:sym<inner-doc-comment> {
        <INNER_DOC_COMMENT>
    }
}

our role InnerAttrs::A {

    method maybe_inner_attrs($/) {
        make $<inner_attrs>.made
    }

    method inner_attrs($/) {
        make $<inner_attr>>>.made
    }

    method inner_attr:sym<shebang-meta>($/) {
        make InnerAttr.new(
            meta_item => $<meta_item>.made,
        )
    }

    method inner_attr:sym<inner-doc-comment>($/) {
        make InnerAttr.new(
            doc_comment => $/.Str,
        )
    }
}

#------------------------
our role OuterAttrs::G {

    token maybe_outer_attrs {
        <outer_attrs>?
    }

    rule outer_attrs {
        <outer_attr>+
    }

    proto rule outer_attr { * }

    rule outer_attr:sym<bang-meta> {
        '#' '[' <meta_item> ']'    
    }

    rule outer_attr:sym<inner-doc-comment> {
        <OUTER_DOC_COMMENT>        
    }
}

our role OuterAttrs::A {

    method maybe_outer_attrs($/) {
        make $<outer_attrs>.made
    }

    method outer_attrs($/) {
        make $<outer_attr>>>.made
    }

    method outer_attr:sym<bang-meta>($/) {
        make $<meta_item>.made
    }

    method outer_attr:sym<outer-doc-comment>($/) {
        make DocComment.new(
            text => $/.Str,
        )
    }
}

#------------------------
our role MetaItem::G {

    proto token meta_item { * }

    token meta_item:sym<ident> {
        <ident>                      
    }

    token meta_item:sym<name-value> {
        <ident> '=' <lit>              
    }

    token meta_item:sym<list> {
        <ident> '(' <meta_seq> ','? ')' 
    }

    token meta_seq_inner {
        <meta_item>+ %% <comma>
    }

    token meta_seq {
        <meta_seq_inner>?
    }
}

our role MetaItem::A {

    method meta_item:sym<ident>($/) {
        make MetaWord.new(
            ident => $<ident>.made,
        )
    }

    method meta_item:sym<name-value>($/) {
        make MetaNameValue.new(
            name => $<ident>.made,
            lit  => $<lit>.made,
        )
    }

    method meta_item:sym<list>($/) {
        make MetaList.new(
            name => $<ident>.made,
            seq  => $<meta_seq>.made,
        )
    }

    method meta_seq_inner($/) {
        make $<meta_item>>.made
    }

    method meta_seq($/) {
        make $<meta_seq_inner>.made
    }
}

#------------------------
our role ModItems::G {

    token maybe_mod_items {
        <mod_items>?
    }

    token mod_items {
        <mod_item>+
    }

    token attrs_and_vis {
        <maybe_outer_attrs> <visibility>
    }

    token mod_item {
        <attrs_and_vis> <item>
    }
}

our role ModItems::A {

    method maybe_mod_items($/) {
        make $<mod_items>.made
    }

    method mod_items($/) {
        make $<mod_item>>>.made
    }

    method attrs_and_vis($/) {
        make AttrsAndVis.new(
            maybe_outer_attrs => $<maybe_outer_attrs>.made,
            visibility        => $<visibility>.made,
        )
    }

    method mod_item($/) {
        make Item.new(
            attrs_and_vis => $<attrs_and_vis>.made,
            item          => $<item>.made,
        )
    }
}

#------------------------
our role Item::G {

    #---------------
    # items that can appear outside of a fn block
    proto token item { * }
    token item:sym<stmt>  { <stmt_item>  }
    token item:sym<macro> { <item_macro> }

    #---------------
    # items that can appear in "stmts"
    proto token stmt_item { * }
    token stmt_item:sym<static> { <item_static> } 
    token stmt_item:sym<const>  { <item_const>  } 
    token stmt_item:sym<type>   { <item_type>   } 
    token stmt_item:sym<block>  { <block_item>  } 
    token stmt_item:sym<view>   { <view_item>   } 
}

our role Item::A {

    method item:sym<stmt>($/)        { make $<stmt_item>.made   }
    method item:sym<macro>($/)       { make $<item_macro>.made  }

    method stmt_item:sym<static>($/) { make $<item_static>.made } 
    method stmt_item:sym<const>($/)  { make $<item_const>.made  } 
    method stmt_item:sym<type>($/)   { make $<item_type>.made   } 
    method stmt_item:sym<block>($/)  { make $<block_item>.made  } 
    method stmt_item:sym<view>($/)   { make $<view_item>.made   } 
}

#------------------------
our class ItemStatic {
    has $.expr;
    has $.ty;
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

#------------------------
our class ItemConst {
    has $.ident;
    has $.expr;
    has $.ty;
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

#------------------------
our class ItemMacro {
    has $.path_expr;
    has $.braces_delimited_token_trees;
    has $.brackets_delimited_token_trees;
    has $.parens_delimited_token_trees;
    has $.maybe_ident;
}


our class ItemMacro::G {

    proto rule item-macro { * }

    rule item-macro:sym<a> {
        <path_expr> '!' <maybe_ident> <parens_delimited_token_trees> ';'
    }

    rule item-macro:sym<b> {
        <path_expr> '!' <maybe_ident> <braces_delimited_token_trees>
    }

    rule item-macro:sym<c> {
        <path_expr> '!' <maybe_ident> <brackets_delimited_token_trees> ';'
    }
}

our class ItemMacro::A {

    method item-macro:sym<a>($/) {
        make ItemMacro.new(
            path_expr                    =>  $<path_expr>.made,
            maybe_ident                  =>  $<maybe_ident>.made,
            parens_delimited_token_trees =>  $<parens_delimited_token_trees>.made,
        )
    }

    method item-macro:sym<b>($/) {
        make ItemMacro.new(
            path_expr                    =>  $<path_expr>.made,
            maybe_ident                  =>  $<maybe_ident>.made,
            braces_delimited_token_trees =>  $<braces_delimited_token_trees>.made,
        )
    }

    method item-macro:sym<c>($/) {
        make ItemMacro.new(
            path_expr                      =>  $<path_expr>.made,
            maybe_ident                    =>  $<maybe_ident>.made,
            brackets_delimited_token_trees =>  $<brackets_delimited_token_trees>.made,
        )
    }
}

#------------------------
our class ViewItemExternCrate {
    has $.ident;
}

our class ViewItemExternFn {
    has $.item_fn;
    has $.maybe_abi;
}

our class ViewItemUse {
    has $.view_path;
}

our class ViewItem::G {

    proto rule view-item { * }

    rule view-item:sym<a> {
        <use_item>
    }

    rule view-item:sym<b> {
        <extern_fn_item>
    }

    rule view-item:sym<c> {
        <EXTERN> <CRATE> <ident> ';'
    }

    rule view-item:sym<d> {
        <EXTERN> <CRATE> <ident> <AS> <ident> ';'
    }

    rule extern-fn_item {
        <EXTERN> <maybe_abi> <item_fn>
    }

    rule use-item {
        <USE> <view_path> ';'
    }
}

our class ViewItem::A {

    method view-item:sym<a>($/) {
        make $<use_item>.made
    }

    method view-item:sym<b>($/) {
        make $<extern_fn_item>.made
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

    method extern-fn_item($/) {
        make ViewItemExternFn.new(
            maybe_abi =>  $<maybe_abi>.made,
            item_fn   =>  $<item_fn>.made,
        )
    }

    method use-item($/) {
        make ViewItemUse.new(
            view_path =>  $<view_path>.made,
        )
    }
}

#------------------------
our class ViewPathGlob {
    has $.path_no_types_allowed;
}

our class ViewPathList {
    has $.path_no_types_allowed;
    has $.idents_or_self;
}

our class ViewPathSimple {
    has $.ident;
    has $.path_no_types_allowed;
}

our class ViewPath::G {

    proto rule view-path { * }

    rule view-path:sym<a> {
        <path_no_types_allowed>
    }

    rule view-path:sym<b> {
        <path_no_types_allowed> <MOD_SEP> '{' '}'
    }

    rule view-path:sym<c> {
        <MOD_SEP> '{' '}'
    }

    rule view-path:sym<d> {
        <path_no_types_allowed> <MOD_SEP> '{' <idents_or_self> '}'
    }

    rule view-path:sym<e> {
        <MOD_SEP> '{' <idents_or_self> '}'
    }

    rule view-path:sym<f> {
        <path_no_types_allowed> <MOD_SEP> '{' <idents_or_self> ',' '}'
    }

    rule view-path:sym<g> {
        <MOD_SEP> '{' <idents_or_self> ',' '}'
    }

    rule view-path:sym<h> {
        <path_no_types_allowed> <MOD_SEP> '*'
    }

    rule view-path:sym<i> {
        <MOD_SEP> '*'
    }

    rule view-path:sym<j> {
        '*'
    }

    rule view-path:sym<k> {
        '{' '}'
    }

    rule view-path:sym<l> {
        '{' <idents_or_self> '}'
    }

    rule view-path:sym<m> {
        '{' <idents_or_self> ',' '}'
    }

    rule view-path:sym<n> {
        <path_no_types_allowed> <AS> <ident>
    }
}

our class ViewPath::A {

    method view-path:sym<a>($/) {
        make ViewPathSimple.new(
            path_no_types_allowed =>  $<path_no_types_allowed>.made,
        )
    }

    method view-path:sym<b>($/) {
        make ViewPathList.new(
            path_no_types_allowed =>  $<path_no_types_allowed>.made,
        )
    }

    method view-path:sym<c>($/) {
        make ViewPathList.new(

        )
    }

    method view-path:sym<d>($/) {
        make ViewPathList.new(
            path_no_types_allowed =>  $<path_no_types_allowed>.made,
            idents_or_self        =>  $<idents_or_self>.made,
        )
    }

    method view-path:sym<e>($/) {
        make ViewPathList.new(
            idents_or_self =>  $<idents_or_self>.made,
        )
    }

    method view-path:sym<f>($/) {
        make ViewPathList.new(
            path_no_types_allowed =>  $<path_no_types_allowed>.made,
            idents_or_self        =>  $<idents_or_self>.made,
        )
    }

    method view-path:sym<g>($/) {
        make ViewPathList.new(
            idents_or_self =>  $<idents_or_self>.made,
        )
    }

    method view-path:sym<h>($/) {
        make ViewPathGlob.new(
            path_no_types_allowed =>  $<path_no_types_allowed>.made,
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
            idents_or_self =>  $<idents_or_self>.made,
        )
    }

    method view-path:sym<m>($/) {
        make ViewPathList.new(
            idents_or_self =>  $<idents_or_self>.made,
        )
    }

    method view-path:sym<n>($/) {
        make ViewPathSimple.new(
            path_no_types_allowed =>  $<path_no_types_allowed>.made,
            ident                 =>  $<ident>.made,
        )
    }
}


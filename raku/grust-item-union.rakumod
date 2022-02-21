
our class ItemUnion::Rules {

    proto rule item-union { * }

    rule item-union:sym<a> {
        <UNION> <ident> <generic-params> <maybe-where_clause> '{' <struct-decl_fields> '}'
    }

    rule item-union:sym<b> {
        <UNION> <ident> <generic-params> <maybe-where_clause> '{' <struct-decl_fields> ',' '}'
    }
}

our class ItemUnion::Actions {

    method item-union:sym<a>($/) {
        make ItemUnion.new(

        )
    }

    method item-union:sym<b>($/) {
        make ItemUnion.new(

        )
    }
}


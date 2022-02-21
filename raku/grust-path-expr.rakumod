#-------------------------------------
our class SelfPath {
    has $.path_generic_args_with_colons;
}

our class PathExpr::Rules {

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

our class PathExpr::Actions {

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

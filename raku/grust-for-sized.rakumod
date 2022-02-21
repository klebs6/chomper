our class ForSized {
    has $.ident;
}

our class ForSized::Rules {

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

our class ForSized::Actions {

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


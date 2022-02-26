our class ForSized {
    has $.ident;
}

our class ForSized::Rules {

    rule for-sized {
        [
            <FOR> 
            [
                | [ '?' <ident> ]
                | [ <ident> '?' ]
            ]
        ]?
    }
}

our class ForSized::Actions {

    method for-sized($/) {
        make ForSized.new(
            ident =>  $<ident>.made,
        )
    }
}

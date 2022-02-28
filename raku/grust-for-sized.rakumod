use grust-model;

our role ForSized::Rules {

    rule for-sized {
        [
            <for_> 
            [
                | [ '?' <ident> ]
                | [ <ident> '?' ]
            ]
        ]?
    }
}

our role ForSized::Actions {

    method for-sized($/) {
        make ForSized.new(
            ident =>  $<ident>.made,
        )
    }
}

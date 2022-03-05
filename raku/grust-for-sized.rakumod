use grust-model;

our role ForSized::Rules {

    rule for-sized {
        [
            <kw-for> 
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
            text  => ~$/,
        )
    }
}

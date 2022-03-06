use Data::Dump::Tree;

our class ForSized {
    has $.ident;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

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

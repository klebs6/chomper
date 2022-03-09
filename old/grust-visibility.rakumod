use Data::Dump::Tree;

our class Public { 

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

our class Inherited { 

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

our role Visibility::Rules {
    rule visibility { <kw-pub>? }
}

our role Visibility::Actions {

    method visibility($/) { 
        if $/<kw-pub>:exists {
            make Public.new(
                text => ~$/,
            )
        } else {
            make Inherited.new(
                text => ~$/,
            )
        }
    }
}

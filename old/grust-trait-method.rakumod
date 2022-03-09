use Data::Dump::Tree;

our class Required {
    has $.type-method;

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

our class Provided {
    has $.method;

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

our role TraitMethod::Rules {

    proto rule trait-method { * }

    rule trait-method:sym<a> { <type-method> }
    rule trait-method:sym<b> { <method> }

}

our role TraitMethod::Actions {

    method trait-method:sym<a>($/) {
        make Required.new(
            type-method =>  $<type-method>.made,
            text        => ~$/,
        )
    }

    method trait-method:sym<b>($/) {
        make Provided.new(
            method => $<method>.made,
            text   => ~$/,
        )
    }
}

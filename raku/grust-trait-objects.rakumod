our class TraitObjectType {
    has Bool $.dyn;
    has $.type-param-bounds;

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

our class TraitObjectTypeOneBound {
    has Bool $.dyn;
    has $.trait-bound;

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

our role TraitObjectType::Rules {

    rule trait-object-type {
        <kw-dyn>? 
        <type-param-bounds>
    }

    rule trait-object-type-one-bound {
        <kw-dyn>?
        <trait-bound>
    }
}

our role TraitObjectType::Actions {

    method trait-object-type($/) {
        make TraitObjectType.new(
            dyn               => so $/<kw-dyn>:exists,
            type-param-bounds => $<type-param-bounds>.made,
            text       => $/.Str,
        )
    }

    method trait-object-type-one-bound($/) {
        make TraitObjectTypeOneBound.new(
            dyn         => so $/<kw-dyn>:exists,
            trait-bound => $<trait-bound>.made,
            text       => $/.Str,
        )
    }
}

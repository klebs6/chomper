use Data::Dump::Tree;

our class Union {
    has $.identifier;
    has $.maybe-generic-params;
    has $.maybe-where-clause;
    has $.struct-fields;

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

our role Union::Rules {

    rule union {
        <kw-union>
        <identifier>
        <generic-params>?
        <where-clause>?
        <tok-lbrace>
        <struct-fields>
        <tok-rbrace>
    }
}

our role Union::Actions {

    method union($/) {
        make Union.new(
            identifier           => $<identifier>.made,
            maybe-generic-params => $<generic-params>.made,
            maybe-where-clause   => $<where-clause>.made,
            struct-fields        => $<struct-fields>.made,
            text                 => $/.Str,
        )
    }
}

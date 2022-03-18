use Data::Dump::Tree;

our class Union {
    has $.identifier;
    has $.maybe-generic-params;
    has $.maybe-where-clause;
    has $.struct-fields;

    has $.text;

    method gist {

        my $builder = "union ";

        $builder ~= $.identifier.gist;

        if $.maybe-generic-params {
            $builder ~= $.maybe-generic-params.gist;
        }

        if $.maybe-where-clause {
            $builder ~= "\n" ~ $.maybe-where-clause.gist ~ "\n";
        }

        $builder ~= '{';
        $builder ~= $.struct-fields.gist.indent(4);
        $builder ~= '}';

        $builder
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

use Data::Dump::Tree;

our class TypePath {
    has @.type-path-segments;

    has $.text;

    method gist {
        @.type-path-segments.join("::")
    }
}

our class TypePathSegment {
    has $.path-ident-segment;
    has $.maybe-type-path-segment-suffix;

    has $.text;

    method gist {

        my $builder = $.path-ident-segment.gist;

        if so $.maybe-type-path-segment-suffix {
            $builder ~= "::{$.maybe-type-path-segment-suffix.gist}";
        }

        $builder
    }
}

our class TypePathSegmentSuffixGeneric {
    has $.generic-args;

    has $.text;

    method gist {
        $.generic-args.gist
    }
}

our class TypePathSegmentSuffixTypePathFn {
    has $.type-path-fn;

    has $.text;

    method gist {
        $.type-path-fn.gist
    }
}

our class TypePathFn {
    has $.maybe-type-path-fn-inputs;
    has $.maybe-type;

    has $.text;

    method gist {

        my $builder = "(";

        if $.maybe-type-path-fn-inputs {
            $builder ~= $.maybe-type-path-fn-inputs;
        }

        $builder ~= ")";

        if $.maybe-type {
            $builder ~= " -> " ~ $.maybe-type.gist;
        }

        $builder
    }
}

our class TypePathFnInputs {
    has @.types;

    has $.text;

    method gist {
        @.types>>.gist.join(", ")
    }
}

our role TypePath::Rules {

    rule type-path {
        <tok-path-sep>?
        [ <type-path-segment>+ %% <tok-path-sep> ]
    }

    rule type-path-segment { 
        <path-ident-segment> 
        [
            <tok-path-sep>?
            <type-path-segment-suffix>
        ]?
    }

    #----------------------
    proto rule type-path-segment-suffix { * }

    rule type-path-segment-suffix:sym<generic> {  
        <generic-args>
    }

    rule type-path-segment-suffix:sym<type-path-fn> {  
        <type-path-fn>
    }

    rule type-path-fn {
        <tok-lparen> 
        <type-path-fn-inputs>? 
        <tok-rparen> 
        [ <tok-rarrow> <type> ]?
    }

    rule type-path-fn-inputs {
        <type>+ %% <tok-comma>
    }
}

our role TypePath::Actions {

    method type-path($/) {
        make TypePath.new(
            type-path-segments => $<type-path-segment>>>.made,
            text               => $/.Str,
        )
    }

    method type-path-segment($/) { 
        make TypePathSegment.new(
            path-ident-segment             => $<path-ident-segment>.made,
            maybe-type-path-segment-suffix => $<type-path-segment-suffix>.made,
            text                           => $/.Str,
        )
    }

    #----------------------
    method type-path-segment-suffix:sym<generic>($/) {  
        make TypePathSegmentSuffixGeneric.new(
            generic-args => $<generic-args>.made,
            text         => $/.Str,
        )
    }

    method type-path-segment-suffix:sym<type-path-fn>($/) {  
        make TypePathSegmentSuffixTypePathFn.new(
            type-path-fn => $<type-path-fn>.made,
            text         => $/.Str,
        )
    }

    method type-path-fn($/) {
        make TypePathFn.new(
            maybe-type-path-fn-inputs => $<type-path-fn-inputs>.made,
            maybe-type                => $<type>.made,
            text                      => $/.Str,
        )
    }

    method type-path-fn-inputs($/) {
        make TypePathFnInputs.new(
            types => $<type>>>.made,
            text  => $/.Str,
        )
    }
}

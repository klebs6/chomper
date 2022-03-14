our class TypeParamBoundLifetime {
    has $.lifetime;

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

our class TypeParamBoundTraitBound {
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

our class TraitBound {
    has Bool $.qmark;
    has $.maybe-for-lifetimes;
    has $.type-path;

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

our class MinusLiteralExpression {
    has $.literal-expression;

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

our class GenericArgsBinding {
    has $.identifier;
    has $.type;

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

our role GenericArgs::Rules {

    rule type-param-bounds {
        <type-param-bound>+ %% <tok-plus>
    }

    proto rule type-param-bound { * }
    rule type-param-bound:sym<lt> { <lifetime> }
    rule type-param-bound:sym<tb> { <trait-bound> }

    proto rule trait-bound { * }

    rule trait-bound:sym<no-parens> { 
        <tok-qmark>?
        <for-lifetimes>? 
        <type-path> 
    }

    rule trait-bound:sym<parens> { 
        <tok-lparen> 
        <tok-qmark>?
        <for-lifetimes>? 
        <type-path> 
        <tok-rparen> 
    }

    rule generic-args {
        <tok-lt>
        [ <generic-arg>* %% <tok-comma> ]
        <tok-gt>
    }

    proto rule generic-arg { * }

    rule generic-arg:sym<lifetime>             { <lifetime> }
    rule generic-arg:sym<generic-args-binding> { <generic-args-binding> }
    rule generic-arg:sym<type>                 { <type> }
    rule generic-arg:sym<generic-args-const>   { <generic-args-const> }

    proto rule generic-args-const                    { * }
    rule generic-args-const:sym<block>               { <block-expression> }
    rule generic-args-const:sym<lit>                 { <literal-expression> }
    rule generic-args-const:sym<minus-lit>           { <minus-literal-expression> }
    rule generic-args-const:sym<simple-path-segment> { <simple-path-segment> }

    rule minus-literal-expression {
        <tok-minus> <literal-expression>
    }

    rule generic-args-binding {
        <identifier> <tok-eq> <type>
    }
}

our role GenericArgs::Actions {

    method type-param-bounds($/) {
        make $<type-param-bound>>>.made
    }

    method type-param-bound:sym<lt>($/) { make $<lifetime>.made }
    method type-param-bound:sym<tb>($/) { make $<trait-bound>.made }

    method trait-bound:sym<no-parens>($/) { 
        make TraitBound.new(
            qmark               => so $/<tok-qmark>:exists,
            maybe-for-lifetimes => $<for-lifetimes>.made,
            type-path           => $<type-path>.made,
        )
    }

    method trait-bound:sym<parens>($/) { 
        make TraitBound.new(
            qmark               => so $/<tok-qmark>:exists,
            maybe-for-lifetimes => $<for-lifetimes>.made,
            type-path           => $<type-path>.made,
        )
    }

    method generic-args($/) {
        make $<generic-arg>>>.made
    }

    method generic-arg:sym<lifetime>($/)                   { make $<lifetime>.made }
    method generic-arg:sym<generic-args-binding>($/)       { make $<generic-args-binding>.made }
    method generic-arg:sym<type>($/)                       { make $<type>.made }
    method generic-arg:sym<generic-args-const>($/)         { make $<generic-args-const>.made }

    method generic-args-const:sym<block>($/)               { make $<block-expression>.made }
    method generic-args-const:sym<lit>($/)                 { make $<literal-expression>.made }
    method generic-args-const:sym<minus-lit>($/)           { make $<minus-literal-expression>.made }
    method generic-args-const:sym<simple-path-segment>($/) { make $<simple-path-segment>.made }

    method minus-literal-expression($/) {
        make MinusLiteralExpression.new(
            literal-expression => $<literal-expression>.made
        )
    }

    method generic-args-binding($/) {
        make GenericArgsBinding.new(
            identifier => $<identifier>.made,
            type       => $<type>.made
        )
    }
}

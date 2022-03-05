use grust-model;

our role FnParams::Rules {

    rule fn-decl-allow-variadic {
        <fn-params-allow-variadic> <ret-ty>
    }

    rule fn-params {
        '(' <maybe-params> ')'
    }

    #---------------------------
    rule fn-params-allow-variadic { '(' [<params> [',' <tok-dotdotdot>?]?]? ')' }

    #---------------------------
    rule fn-anon-params { '(' [<anon-param> <anon-params-allow-variadic-tail>]? ')' }

    #---------------------------
    proto rule fn-params-with-self { * }

    rule fn-params-with-self:sym<a> { '(' <maybe-mut> <kw-self> <maybe-ty-ascription> <maybe-comma-params> ')' }
    rule fn-params-with-self:sym<b> { '(' '&' <maybe-mut> <kw-self> <maybe-ty-ascription> <maybe-comma-params> ')' }
    rule fn-params-with-self:sym<c> { '(' '&' <lifetime> <maybe-mut> <kw-self> <maybe-ty-ascription> <maybe-comma-params> ')' }
    rule fn-params-with-self:sym<d> { '(' <maybe-params> ')' }

    #---------------------------
    proto rule fn-anon-params-with-self { * }

    rule fn-anon-params-with-self:sym<a> { '(' <maybe-mut> <kw-self> <maybe-ty-ascription> <maybe-comma-anon-params> ')' }
    rule fn-anon-params-with-self:sym<b> { '(' '&' <maybe-mut> <kw-self> <maybe-ty-ascription> <maybe-comma-anon-params> ')' }
    rule fn-anon-params-with-self:sym<c> { '(' '&' <lifetime> <maybe-mut> <kw-self> <maybe-ty-ascription> <maybe-comma-anon-params> ')' }
    rule fn-anon-params-with-self:sym<d> { '(' <maybe-anon-params> ')' }
}

our role FnParams::Actions {

    method fn-decl-allow-variadic($/) {
        make FnDecl.new(
            fn-params-allow-variadic =>  $<fn-params-allow-variadic>.made,
            ret-ty                   =>  $<ret-ty>.made,
            text                     => ~$/,
        )
    }

    method fn-params($/) {
        make $<maybe-params>.made
    }

    #---------------------------
    method fn-params-allow-variadic($/) { make $<params>.made }

    #---------------------------
    method fn-anon-params($/) {
        make [$<anon-param>.made, $<anon-params-allow-variadic-tail>.made]
    }

    #---------------------------
    method fn-params-with-self:sym<a>($/) {
        make SelfLower.new(
            maybe-mut           =>  $<maybe-mut>.made,
            maybe-ty-ascription =>  $<maybe-ty-ascription>.made,
            maybe-comma-params  =>  $<maybe-comma-params>.made,
            text                => ~$/,
        )
    }

    method fn-params-with-self:sym<b>($/) {
        make SelfRegion.new(
            maybe-mut           =>  $<maybe-mut>.made,
            maybe-ty-ascription =>  $<maybe-ty-ascription>.made,
            maybe-comma-params  =>  $<maybe-comma-params>.made,
            text                => ~$/,
        )
    }

    method fn-params-with-self:sym<c>($/) {
        make SelfRegion.new(
            lifetime            =>  $<lifetime>.made,
            maybe-mut           =>  $<maybe-mut>.made,
            maybe-ty-ascription =>  $<maybe-ty-ascription>.made,
            maybe-comma-params  =>  $<maybe-comma-params>.made,
            text                => ~$/,
        )
    }

    method fn-params-with-self:sym<d>($/) {
        make SelfStatic.new(
            maybe-params =>  $<maybe-params>.made,
            text         => ~$/,
        )
    }

    #---------------------------
    method fn-anon-params-with-self:sym<a>($/) {
        make SelfLower.new(
            maybe-mut               =>  $<maybe-mut>.made,
            maybe-ty-ascription     =>  $<maybe-ty-ascription>.made,
            maybe-comma-anon-params =>  $<maybe-comma-anon-params>.made,
            text                    => ~$/,
        )
    }

    method fn-anon-params-with-self:sym<b>($/) {
        make SelfRegion.new(
            maybe-mut               =>  $<maybe-mut>.made,
            maybe-ty-ascription     =>  $<maybe-ty-ascription>.made,
            maybe-comma-anon-params =>  $<maybe-comma-anon-params>.made,
            text                    => ~$/,
        )
    }

    method fn-anon-params-with-self:sym<c>($/) {
        make SelfRegion.new(
            lifetime                =>  $<lifetime>.made,
            maybe-mut               =>  $<maybe-mut>.made,
            maybe-ty-ascription     =>  $<maybe-ty-ascription>.made,
            maybe-comma-anon-params =>  $<maybe-comma-anon-params>.made,
            text                    => ~$/,
        )
    }

    method fn-anon-params-with-self:sym<d>($/) {
        make SelfStatic.new(
            maybe-anon-params =>  $<maybe-anon-params>.made,
            text              => ~$/,
        )
    }
}

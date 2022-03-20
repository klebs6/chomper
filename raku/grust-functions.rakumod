use Data::Dump::Tree;

our class Function {
    has $.function-qualifiers;
    has $.identifier;
    has $.maybe-generic-params;
    has $.maybe-function-parameters;
    has $.maybe-function-return-type;
    has $.maybe-where-clause;
    has $.maybe-block-expression;

    has $.text;

    method gist {

        my $builder = 
        $.function-qualifiers.gist 
        ~ " fn " 
        ~ $.identifier.gist;

        if $.maybe-generic-params {
            $builder ~= $.maybe-generic-params.gist;
        }

        $builder ~= "(";

        if $.maybe-function-parameters {
            $builder ~= $.maybe-function-parameters.gist;
        }

        $builder ~= ")";

        if $.maybe-function-return-type {
            $builder ~= $.maybe-function-return-type.gist;
        }

        if $.maybe-where-clause {
            $builder ~= "\n" ~ $.maybe-where-clause.gist;
        }

        if $.maybe-block-expression {
            $builder ~= $.maybe-block-expression.gist;
        } else {
            $builder ~= ";";
        }

        $builder
    }
}

our class FunctionQualifiers {
    has Bool $.const;
    has Bool $.async;
    has Bool $.unsafe;
    has $.maybe-function-extern-modifier;

    has $.text;

    method gist {

        my $builder = "";

        if $.const {
            $builder ~= "const ";
        }

        if $.async {
            $builder ~= "async ";
        }

        if $.unsafe {
            $builder ~= "unsafe ";
        }

        if $.maybe-function-extern-modifier {
            $builder ~= $.maybe-function-extern-modifier.gist;
        }

        $builder
    }
}

our class FunctionParameters {
    has $.maybe-self-param;
    has @.function-params;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-self-param {

            $builder ~= $.maybe-self-param.gist;

            if @.function-params.elems gt 0 {
                $builder ~= ", ";
            }
        }

        $builder ~ @.function-params>>.gist.join(", ")
    }
}

our class SelfParam {
    has @.outer-attributes;
    has $.self-param-variant;

    has $.text;

    method gist {

        my $builder = "";

        for @.outer-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        $builder ~ $.self-param-variant.gist
    }
}

our class SelfBorrow {
    has $.maybe-lifetime;

    has $.text;

    method gist {

        my $builder = "&";

        if $.maybe-lifetime {
            $builder ~= $.maybe-lifetime.gist;
        }

        $builder
    }
}

our class SelfParamVariantShorthand {
    has $.maybe-self-borrow;
    has Bool $.mutable;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-self-borrow {
            $builder ~= $.maybe-self-borrow.gist;
        }

        if $.mutable {
            $builder ~= "mut ";
        }

        $builder ~ "self"
    }
}

our class SelfParamVariantTyped {
    has Bool $.mutable;
    has $.type;

    has $.text;

    method gist {

        my $builder = "";

        if $.mutable {
            $builder ~= "mut ";
        }

        $builder ~= "self:" ~ $.type.gist;

        $builder
    }
}

our class FunctionParam {
    has $.maybe-comment;
    has @.outer-attributes;
    has $.function-param-variant;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-comment {
            $builder ~= "\n" ~ $.maybe-comment.gist ~ "\n";
        }

        for @.outer-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        $builder ~= $.function-param-variant.gist;

        $builder
    }
}

our class FunctionParamVariantPatternType {
    has $.pattern-no-top-alt;
    has $.type;

    has $.text;

    method gist {
        $.pattern-no-top-alt.gist 
        ~ ": " 
        ~ $.type.gist
    }
}

our class FunctionParamVariantPatternEllipsis {
    has $.pattern-no-top-alt;

    has $.text;

    method gist {
        $.pattern-no-top-alt.gist 
        ~ ": " 
        ~ "..."
    }
}

our class FunctionParamVariantEllipsis { 

    has $.text;

    method gist {
        "..."
    }
}

our class FunctionReturnType {
    has $.type;
    has $.maybe-comment;

    has $.text;

    method gist {
        my $builder = "-> " ~ $.type.gist;

        if $.maybe-comment {
            $builder ~= " " ~ $.maybe-comment.gist;
        }

        $builder
    }
}

our role Function::Rules {

    rule function {
        <function-qualifiers>
        <kw-fn>
        <identifier>
        <generic-params>?
        <tok-lparen>
        <function-parameters>?
        <tok-rparen>
        <function-return-type>?
        <where-clause>?
        [
            | <block-expression>
            | <tok-semi>
        ]
    }

    rule function-qualifiers {
        <kw-const>?
        <kw-async>?
        <kw-unsafe>?
        <function-extern-modifier>?
    }

    proto rule abi { * }

    rule abi:sym<str>     { <string-literal> }

    rule abi:sym<raw-str> { <raw-string-literal> }

    #----------------------
    proto rule function-parameters { * }

    rule function-parameters:sym<self-and-just-params> {
        <self-param> 
        <tok-comma>
        [ <function-param>+ %% <tok-comma> ]
    }

    rule function-parameters:sym<just-self> {
        <self-param> <tok-comma>?
    }

    rule function-parameters:sym<just-params> {
        <function-param>+ %% <tok-comma>
    }


    #----------------------
    rule self-param {  
        <outer-attribute>*
        <self-param-variant>
    }

    rule self-borrow {
        <tok-and> <lifetime>?
    }

    proto rule self-param-variant { * }

    rule self-param-variant:sym<shorthand> { 
        <self-borrow>?
        <kw-mut>?
        <kw-selfvalue>
    }

    rule self-param-variant:sym<typed> { 
        <kw-mut>?
        <kw-selfvalue>
        <tok-colon>
        <type>
    }

    #-------------------
    rule function-param {
        <comment>?
        <outer-attribute>*
        <function-param-variant>
    }

    proto rule function-param-variant { * }

    rule function-param-variant:sym<pattern-type> {
        <pattern-no-top-alt> 
        <tok-colon>
        <type> 
    }

    rule function-param-variant:sym<pattern-ellipsis> {
        <pattern-no-top-alt> 
        <tok-colon>
        <tok-dotdotdot>
    }

    rule function-param-variant:sym<ellipsis> {
        <tok-dotdotdot>
    }

    rule function-param-variant:sym<type> {
        <type>
    }

    #-------------------
    rule function-return-type {
        <tok-rarrow>
        <type>
        <comment>?
    }
}

our role Function::Actions {

    method function($/) {
        make Function.new(
            function-qualifiers        => $<function-qualifiers>.made,
            identifier                 => $<identifier>.made,
            maybe-generic-params       => $<generic-params>.made,
            maybe-function-parameters  => $<function-parameters>.made,
            maybe-function-return-type => $<function-return-type>.made,
            maybe-where-clause         => $<where-clause>.made,
            maybe-block-expression     => $<block-expression>.made,
            text                       => $/.Str,
        )
    }

    method function-qualifiers($/) {
        make FunctionQualifiers.new(
            const                          => so $/<kw-const>:exists,
            async                          => so $/<kw-async>:exists,
            unsafe                         => so $/<kw-unsafe>:exists,
            maybe-function-extern-modifier => $<function-extern-modifier>.made,
            text                           => $/.Str,
        )
    }

    method abi:sym<str>($/)     { make $<string-literal>.made }
    method abi:sym<raw-str>($/) { make $<raw-string-literal>.made }

    #----------------------
    method function-parameters:sym<self-and-just-params>($/) {
        make FunctionParameters.new(
            maybe-self-param => $<self-param>.made,
            function-params  => $<function-param>>>.made,
            text             => $/.Str,
        )
    }

    method function-parameters:sym<just-self>($/) {
        make FunctionParameters.new(
            maybe-self-param => $<self-param>.made,
            text             => $/.Str,
        )
    }

    method function-parameters:sym<just-params>($/) {
        make FunctionParameters.new(
            function-params => $<function-param>>>.made,
            text            => $/.Str,
        )
    }

    #----------------------
    method self-param($/) {  
        make SelfParam.new(
            outer-attributes   => $<outer-attribute>>>.made,
            self-param-variant => $<self-param-variant>.made,
            text               => $/.Str,
        )
    }

    method self-borrow($/) {
        make SelfBorrow.new(
            maybe-lifetime => $<lifetime>.made,
            text           => $/.Str,
        )
    }

    method self-param-variant:sym<shorthand>($/) { 
        make SelfParamVariantShorthand.new(
            maybe-self-borrow => $<self-borrow>.made,
            mutable           => so $/<kw-mut>:exists,
            text              => $/.Str,
        )
    }

    method self-param-variant:sym<typed>($/) { 
        make SelfParamVariantTyped.new(
            mutable => so $/<kw-mut>:exists,
            type    => $<type>.made,
            text    => $/.Str,
        )
    }

    #-------------------
    method function-param($/) {
        make FunctionParam.new(
            maybe-comment          => $<comment>.made,
            outer-attributes       => $<outer-attribute>>>.made,
            function-param-variant => $<function-param-variant>.made,
            text                   => $/.Str,
        )
    }

    method function-param-variant:sym<pattern-type>($/) {
        make FunctionParamVariantPatternType.new(
            pattern-no-top-alt => $<pattern-no-top-alt>.made,
            type               => $<type>.made,
            text               => $/.Str,
        )
    }

    method function-param-variant:sym<pattern-ellipsis>($/) {
        make FunctionParamVariantPatternEllipsis.new(
            pattern-no-top-alt => $<pattern-no-top-alt>.made,
            text               => $/.Str,
        )
    }

    method function-param-variant:sym<ellipsis>($/) {
        make FunctionParamVariantEllipsis.new
    }

    method function-param-variant:sym<type>($/) {
        make $<type>.made
    }

    #-------------------
    method function-return-type($/) {
        make FunctionReturnType.new(
            type          => $<type>.made,
            maybe-comment => $<comment>.made,
            text          => $/.Str,
        )
    }
}

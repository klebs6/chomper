
our class BareFunctionType {
    has $.maybe-for-lifetimes;
    has $.function-type-qualifiers;
    has $.maybe-function-parameters;
    has $.maybe-function-return-type;

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

our class FunctionExternModifier {
    has $.maybe-abi;

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

our class FunctionTypeQualifiers {
    has Bool $.unsafe;
    has $.maybe-function-extern-modifier;

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

our class BareFunctionReturnType {
    has $.type-no-bounds;

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

our class FunctionParametersBasic {
    has @.maybe-named-params;

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

our class FunctionParametersVariadic {
    has @.maybe-named-params;
    has @.outer-attributes;

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

our class MaybeNamedParam {
    has @.outer-attributes;
    has $.maybe-identifier-or-underscore;
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

our role BareFunctionType::Rules {

    rule bare-function-type {
        <for-lifetimes>?
        <function-type-qualifiers>
        <kw-fn>
        <tok-lparen>
        <function-parameters>?
        <tok-rparen>
        <bare-function-return-type>?
    }

    rule function-extern-modifier {
        <kw-extern>
        <abi>?
    }

    rule function-type-qualifiers {
        <kw-unsafe>?
        <function-extern-modifier>?
    }

    rule bare-function-return-type {
        <tok-rarrow>
        <type-no-bounds>
    }

    #-------------------
    proto rule function-parameters { * }

    rule function-parameters:sym<basic> {  
        <maybe-named-param>+ %% <tok-comma>
    }

    rule function-parameters:sym<variadic> {  
        [<maybe-named-param>+ % <tok-comma>]
        <outer-attribute>*
        <tok-dotdotdot>
    }

    rule maybe-named-param {
        <outer-attribute>*
        [
            <identifier-or-underscore>
            <tok-colon>
        ]?
        <type>
    }
}

our role BareFunctionType::Actions {}

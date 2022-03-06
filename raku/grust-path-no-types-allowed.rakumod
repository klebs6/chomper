use Data::Dump::Tree;

use grust-ident;

#--------------------------
# A path with no type parameters;
# e.g. `foo::bar::Baz`
#
# These show up in 'use' view-items, because these
# are processed without respect to types.
our class ViewPath {
    has $.base;
    has Ident @.tail;

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

#--------------------------
# A path with a lifetime and type parameters, with
# no double colons before the type parameters;
# e.g. `foo::bar<'a>::Baz<t>`
#
# These show up in "trait references", the
# components of type-parameter bounds lists, as
# well as in the prefix of the
# path-generic-args-and-bounds rule, which is the
# full form of a named typed expression.
#
# They do not have (nor need) an extra '::' before
# '<' because unlike in expr context, there are no
# "less-than" type exprs to be ambiguous with.
our class Components {
    has $.maybe-ty-sums;
    has $.generic-args;
    has $.ret-ty;
    has $.ident;

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

our role PathNoTypesAllowed::Rules {

    proto rule path-no-types-allowed-base { * }

    rule path-no-types-allowed-base:sym<a> { <ident> }
    rule path-no-types-allowed-base:sym<b> { <tok-mod-sep>? <kw-self> }
    rule path-no-types-allowed-base:sym<c> { <tok-mod-sep>? <kw-super> }

    rule path-no-types-allowed {  
        <tok-mod-sep>? #i added this here so we could parse things scoped globally

        <path-no-types-allowed-base> 
        [<tok-mod-sep> <ident>]*
    }
}

our role PathNoTypesAllowed::Actions {

    method path-no-types-allowed($/) {
        make ViewPath.new(
            base =>  $<path-no-types-allowed-base>.made,
            tail =>  $<ident>>>.made,
            text => ~$/,
        )
    }

    method path-no-types-allowed-base:sym<a>($/) { make $<ident>.made }
    method path-no-types-allowed-base:sym<b>($/) { make $<kw-self>.made }
    method path-no-types-allowed-base:sym<c>($/) { make $<kw-super>.made }
}

our role PathGenericArgsWithoutColons::Rules {

    rule path-generic-args-without-colons {  
        #{self.set-prec(IDENT)}
        <path-generic-args-without-colons-item>+ %% <tok-mod-sep>
    }

    proto rule path-generic-args-without-colons-item { * }

    rule path-generic-args-without-colons-item:sym<c>  { <ident> '(' <maybe-ty-sums> ')' <ret-ty> }
    token path-generic-args-without-colons-item:sym<b> { <ident> <tok-mod-sep>? <generic-args> }
    token path-generic-args-without-colons-item:sym<a> { <ident> }
}

our role PathGenericArgsWithoutColons::Actions {

    method path-generic-args-without-colons($/) {

        my @args = $<path-generic-args-without-colons-item>>>.made;

        if @args.elems eq 1 {
            make @args[0]
        } else {
            make @args
        }
    }

    method path-generic-args-without-colons-item:sym<a>($/) {
        make $<ident>.made
    }

    method path-generic-args-without-colons-item:sym<b>($/) {
        make Components.new(
            ident        => $<ident>.made,
            generic-args => $<generic-args>.made,
            text         => ~$/,
        )
    }

    method path-generic-args-without-colons-item:sym<c>($/) {
        make Components.new(
            ident         => $<ident>.made,
            maybe-ty-sums => $<maybe-ty-sums>.made,
            ret-ty        => $<ret-ty>.made,
            text          => ~$/,
        )
    }
}

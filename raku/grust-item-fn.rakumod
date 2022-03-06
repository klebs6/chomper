use Data::Dump::Tree;

our class ItemFn {
    has $.ident;
    has $.generic-params;
    has $.fn-decl;
    has $.maybe-where-clause;
    has $.inner-attrs-and-block;

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

our class ItemUnsafeFn {
    has $.ident;
    has $.generic-params;
    has $.fn-decl;
    has $.maybe-where-clause;
    has $.inner-attrs-and-block;

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

our role Fn::Rules {

    proto rule item-fn { * }

    rule item-fn:sym<a> {
        <kw-const>?
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }

    proto rule item-unsafe-fn { * }

    rule item-unsafe-fn:sym<a> {
        <kw-const>?
        <kw-unsafe> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }

    rule item-unsafe-fn:sym<b> {
        <kw-unsafe> 
        <kw-extern> 
        <maybe-abi> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }
}

our role Fn::Actions {

    method item-fn:sym<a>($/) {
        make ItemFn.new(
            const                 => so $/<kw-const>:exists,
            ident                 => $<ident>.made,
            generic-params        => $<generic-params>.made,
            fn-decl               => $<fn-decl>.made,
            maybe-where-clause    => $<maybe-where-clause>.made,
            inner-attrs-and-block => $<inner-attrs-and-block>.made,
            text                  => ~$/,
        )
    }

    method item-unsafe-fn:sym<a>($/) {
        make ItemUnsafeFn.new(
            const                 =>  so $/<kw-const>:exists,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where-clause    =>  $<maybe-where-clause>.made,
            inner-attrs-and-block =>  $<inner-attrs-and-block>.made,
            text                  => ~$/,
        )
    }

    method item-unsafe-fn:sym<b>($/) {
        make ItemUnsafeFn.new(
            maybe-abi             =>  $<maybe-abi>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where-clause    =>  $<maybe-where-clause>.made,
            inner-attrs-and-block =>  $<inner-attrs-and-block>.made,
            text                  => ~$/,
        )
    }
}

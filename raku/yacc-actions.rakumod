use dequote;

our class YaccItem {
    has $.name     is required;
    has @.subrules is required;
}

our class Subrule {
    has $.body    is required;
    has $.actions is required;
}

our class SubruleToken {
    has $.value   is required;
}

our class PrecPragma {
    has $.value   is required;
}

our class QuotedChar {
    has $.value   is required;
}

our class SubruleActions {
    has $.initializer is required;
}

our class MkNode {
    has @.args is required;
}

our class MkAtom {
    has $.name is required;
}

our class ExtNode {
    has @.args is required;
}

our class DollarArg {
    has $.value is required;
}

our class EmptySubrule {}
our class MkNone       {}

our class Yacc::Actions {

    method TOP($/) {
        make $<yacc-snippet>.made
    }

    method yacc-snippet($/) {
        make $<yacc-item>>>.made
    }

    method yacc-item($/) {
        make YaccItem.new(
            name     => $<name>.made,
            subrules => $<subrule>>>.made,
        )
    }

    method name($/) {
        make $/.Str
    }

    method subrule($/) {
        make Subrule.new(
            body    => $<subrule-body>.made,
            actions => $<subrule-actions>.made,
        )
    }

    method subrule-body:sym<basic>($/) {
        make $<subrule-body-item>>>.made
    }

    method subrule-body:sym<empty>($/) {
        make EmptySubrule.new
    }

    method subrule-body-item:sym<token>($/) {
        make SubruleToken.new(
            value => $<subrule-token>.Str
        )
    }

    method subrule-body-item:sym<quoted>($/) {
        make QuotedChar.new(
            value => $<quoted-char>.Str
        )
    }

    method subrule-body-item:sym<prec-pragma>($/) {
        make PrecPragma.new(
            value => $<subrule-token>.made
        )
    }

    method subrule-token($/) {
        make $/.Str
    }

    method ident($/) {
        make $/.Str
    }

    method quoted-char($/) {
        make $/.Str
    }

    method char($/) {
        make $/.Str
    }

    method subrule-actions($/) {
        make SubruleActions.new(
            initializer => $<subrule-action-initializer>.made
        )
    }

    method subrule-action-initializer:sym<mk-node>($/) {
        make $<mk-node-initializer>.made
    }

    method subrule-action-initializer:sym<mk-atom>($/) {
        make $<mk-atom-initializer>.made
    }

    method subrule-action-initializer:sym<arg>($/) {
        make $<arg>.made
    }

    method subrule-action-initializer:sym<mk-none>($/) {
        make $<mk-none-initializer>.made
    }

    method subrule-action-initializer:sym<ext-node>($/) {
        make $<ext-node-initializer>.made
    }

    method mk-node-initializer($/) {
        make MkNode.new(
            args => $<args>.made,
        )
    }

    method mk-atom-initializer($/) {
        make MkAtom.new(
            name => dequote($<arg>.made),
        )
    }

    method mk-none-initializer($/) {
        make MkNone.new
    }

    method ext-node-initializer($/) {
        make ExtNode.new(
            args => $<args>.made,
        )
    }

    method args($/) {
        make $<arg>>>.made
    }

    method quoted-str($/) {
        make $/.Str
    }

    method arg:sym<quoted-str>($/) {  
        make $<quoted-str>.made
    }

    method arg:sym<ident>($/) { 
        make $<ident>.made
    }

    method arg:sym<int>($/) {  
        make $/.Int
    }

    method arg:sym<dollar-int>($/) {  
        make DollarArg.new( value => $/<int>.Str )
    }

    method arg:sym<mk-node>($/) {  
        make $<mk-node-initializer>.made
    }

    method arg:sym<mk-atom>($/) {  
        make $<mk-atom-initializer>.made
    }

    method arg:sym<mk-none>($/) {  
        make $<mk-none-initializer>.made
    }
}

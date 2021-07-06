use snake-case;

our sub chop-macro-body($text, $ldelim = '[', $rdelim = ']') {
    my $lidx = $text.indices($ldelim)[0];
    my $ridx = $text.indices($rdelim)[*-1];
    my $head = $text.substr(0 .. $lidx - 1);
    my $body = $text.substr($lidx + 1 .. $ridx - 1);

    ($head, $body)
}

our sub clean-macro($macro) {

    my ($head, $body);

    if $macro.grep(/\!\(/) {
        ($head, $body) = chop-macro-body($macro, '(', ')');
    } else {
        ($head, $body) = chop-macro-body($macro, '[', ']');
    }

    "$head\{$body\}"
}

our sub translate-macro-short($macro) {

    my $idx = $macro.index("(");
    my $ridx = $macro.rindex(")");
    my $macro-name = $macro.substr(0..$idx-1);
    my $macro-body = $macro.substr($idx+1..$ridx-1);

    "{$macro-name.lc}!\{{$macro-body.chomp.trim}\}"
}

our sub translate-macro($macro) {

    #use Grammar::Tracer;

    grammar BasicMacro {

        rule TOP {
            <.ws>
            <macro-name> 
            '(' 
            <macro-args> 
            ')'
        }

        token macro-name {
            <.ident>
        }

        regex macro-args {
            <macro-arg>* %% ','
        }

        regex macro-arg {
            <-[,]>+
        }

        token ident {
            <[ A..Z a..z _ 0..9 ]>+
        }
    }

    class Actions {

        method TOP($/) {
            make $/<macro-name>.made ~ "!\{\n" ~ $/<macro-args>.made ~ "\n\}"
        }

        method macro-name($/) {
            make snake-case($/.Str)
        }

        method macro-args($/) {
            make $/<macro-arg>>>.chomp>>.trim.join(",\n").indent(4)
        }

    }

    BasicMacro.parse($macro, actions => Actions.new).made

}

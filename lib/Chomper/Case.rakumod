our sub snake-to-kebab($input) {
    $input.subst(/_+/,"-")
}

our sub is-screaming-snake-case($input) {
    grammar Screamer {
        token TOP { <segment>+ %% "_" }
        token segment { <[A..Z 0..9]>+ }
    }
    so Screamer.parse($input)
}

our sub is-lower-snake-case($input) {
    grammar LowerSnake {
        token TOP { <segment>+ %% "_" }
        token segment { <[a..z 0..9]>+ }
    }
    so LowerSnake.parse($input)
}

our sub snake-to-camel($input) {

    my $type-stripped = $input.subst(/_t$/, "");

    if is-screaming-snake-case($type-stripped) {
        screaming-snake-case-to-camel-case($type-stripped)

    } else {
        $type-stripped.split("_")>>.tc.join("")
    }
}

our sub is-camel-case($type) {
    my $camel-seg = regex { <[A..Z]> <[a..z]>* };
    my $camel     = regex { $camel-seg+ };
    $type ~~ $camel
}

our sub screaming-snake-case-to-camel-case($in) {
    $in.trim.chomp.split("_")>>.lc>>.tc.join("")
}

our sub kebab-to-camel($id) {
    my @parts = $id.split("-");
    @parts>>.tc.join("").subst(/_$/,"")
}

our sub camel-to-kebab($id) {

    grammar Camel {

        token TOP {
            <.ws> <camel-ident>
        }

        token camel-ident {
            <camel-hump>+
        }

        token camel-hump {
            <[A..Z]> <[a..z]>*
        }
    }

    class Camel::Actions {
        method TOP($/) {
            make $<camel-ident>.made
        }

        method camel-ident($/) {
            make $<camel-hump>>>.made.join("-")
        }

        method camel-hump($/) {
            make $/.lc
        }
    }

    Camel.parse($id, actions => Camel::Actions.new).made
}

#use Grammar::Tracer;

grammar LineComments {

    rule TOP {
        <.ws>
        <line-comment>+
    }

    token line-comment {
        [ '//' | '///' ] [<.ws>? | <line-comment-body> ]
    }

    rule line-comment-body {
        \N*
    }
}

class LineComments::Actions {

    method TOP($/) {
        my @lines = $/<line-comment>>>.made;

        #for short block comments, we don't use the leading pipe
        if @lines.elems < 4 {
            @lines = @lines>>.subst(regex {^ '|' }, "");
        }

        my $body = @lines.join("\n").trim-trailing;

        make "/**\n" ~ $body.indent(2) ~ "\n  */";
    }

    method line-comment($/) {

        if $/<line-comment-body>:exists {

            make "|" ~ $/<line-comment-body>.Str.trim-trailing

        } else {

            make "|" 
        }
    }
}

our sub line-comment-to-block-comment($text, :$indent = False) {

    my $x = LineComments.parse(
        $text, 
        actions => LineComments::Actions.new)
        .made;

    if $x {
        if $indent {

            $x.indent(4)

        } else {

            $x
        }
    }
}

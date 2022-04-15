use Chomper::Formatting;
use Chomper::Textwidth;

role BlockCommentRole {

    rule block-comment {
        <.block-comment-opener>
        <block-comment-body>
        <.block-comment-closer>
    }

    token block-comment-opener      { '/*' | '/**' }
    token block-comment-closer      { '*/' }
    token block-comment-line-opener { '*'  }

    regex block-comment-body {
        <block-comment-line>*?
        <block-comment-line=terminator-line>
    }

    rule block-comment-line {
        <.ws> <block-comment-line-opener>? <text=until-newline>
    }
    rule terminator-line {
        <.ws> <block-comment-line-opener>? <text=until-newline> <?before <.block-comment-closer>>
    }
    regex until-newline {
        \N+
    }
}

class BlockCommentActions {

    has Bool $.indent;
    has Int  $.width;

    submethod BUILD(:$indent, :$approx-text-width = 46) {
        $!indent = $indent;
        $!width  = $indent ?? $approx-text-width - 4 !! $approx-text-width;
    }

    method TOP($/) {
        make $/<block-comment><block-comment-body>.made
    }

    method block-comment-body($/) {
        my $body = do for $/<block-comment-line>.List {
            $_<text>.Str
        }.join("\n");

        $body = ensure-textwidth($body, $!width);

        my $text = apply-lhs-line($body);

        my $out = qq:to/END/.chomp;
        /**
        {$text.indent(2)}
          */
        END

        if $!indent {
            make $out.indent(4)
        } else {
            make $out
        }
    }
}

grammar BlockComment does BlockCommentRole {

    rule TOP {
        <.ws>
        <block-comment>
    }
}

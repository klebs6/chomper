use util;
use reformat-block-comment;
use block-comment;
use line-comment-to-block-comment;

our role CanGetDocComments {

    has $.line-comment;
    has $.block-comment;

    method init-can-get-doc-comments(Match :$submatch) {
        $!line-comment  = format-rust-comments(get-rcomments-list($submatch));
        $!block-comment = ~$submatch<block-comment>;
    }

    method get-doc-comments {

        if $!block-comment {
            return reformat-block-comment($!block-comment);
        }

        $!line-comment
    }
}

our role GetDocComments {

    #TODO: can we somehow use a @!comments here?
    method get-doc-comments(@comments) {

        if @comments.elems > 0 {

            my @doc-comments = do for @comments {
                make-doc-comment($_).chomp.trim
            };

            "\n" ~ @doc-comments.join("\n") ~ "\n"

        } else {
            ""
        }
    }
}

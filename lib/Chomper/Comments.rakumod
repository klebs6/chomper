use Chomper::Util;
use Chomper::DoxyComment;
use Chomper::ReformatBlockComment;
use Chomper::BlockComment;
use Chomper::LineCommentToBlockComment;

our role CanGetDocComments {

    has $.line-comment;
    has $.block-comment;

    method init-can-get-doc-comments(Match :$submatch) {
        $!line-comment  = format-rust-comments(get-rcomments-list($submatch));

        if $submatch<block-comment>:exists {
            $!block-comment = ~$submatch<block-comment>;
        } else {
            $!block-comment = "";
        }
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

our sub format-comments(@comments) {

    if @comments.elems eq 0 {
        return "";
    }

    if @comments.elems eq 1 and @comments[0].trim ~~ "" {
        return "";
    }

    @comments 

    ==> map({
        make-doc-comment($_).chomp.trim
    })

    ==> join("\n")

    ==> line-comment-to-block-comment()

    ==> parse-doxy-comment()
}

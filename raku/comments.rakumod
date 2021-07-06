use util;

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


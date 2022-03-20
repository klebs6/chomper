# token block-comment { '/*' .*?  '*/' }
our class BlockComment { 
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token line-comment {         '//' <-[ \r \n ]>*     }
our class LineComment { 
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex comment:sym<line> { 
#   [<line-comment> <.ws>?]+ 
# }
our class Comment::Line does IComment {
    has LineComment @.line-comments is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

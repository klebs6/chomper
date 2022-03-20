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

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

our role Comment::Actions {

    # token block-comment { '/*' .*? '*/' }
    method block-comment($/) {
        make BlockComment.new(
            value => ~$/,
        )
    }

    # token line-comment { '//' <-[ \r \n ]>* }
    method line-comment($/) {
        make LineComment.new(
            value => ~$/,
        )
    }

    # regex comment:sym<line> { [<line-comment> <.ws>?]+ }
    method comment:sym<line>($/) {
        make Comment::Line.new(
            line-comments => $<line-comment>>>.made,
        )
    }

    # rule comment:sym<block> { <block-comment> } 
    method comment:sym<block>($/) {
        make $<block-comment>.made
    }
}

our role Comment::Rules {

    token block-comment {
        '/*' .*?  '*/'
    }

    token line-comment {
        '//' <-[ \r \n ]>*
    }

    proto rule comment { * }

    regex comment:sym<line> {
        [<line-comment> <ws>?]+
    }

    rule comment:sym<block> {
        <block-comment>
    }
}

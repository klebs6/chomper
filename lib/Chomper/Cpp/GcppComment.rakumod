unit module Chomper::Cpp::GcppComment;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# token block-comment { '/*' .*?  '*/' }
class BlockComment does IComment is export {
    has Str $.value is required;

    has $.text;

    method name {
        'BlockComment'
    }

    method gist(:$treemark=False) {
        $.value
    }
}

# token line-comment {         '//' <-[ \r \n ]>*     }
class LineComment does IComment is export {
    has Str $.value is required;

    has $.text;

    method name {
        'LineComment'
    }

    method gist(:$treemark=False) {
        '// ' ~ $.value.gist
    }
}

# regex comment:sym<line> { 
#   [<line-comment> <.ws>?]+ 
# }
class MultiLineComment does IComment is export {
    has LineComment @.line-comments is required;

    has $.text;

    method name {
        'MultiLineComment'
    }

    method gist(:$treemark=False) {
        @.line-comments>>.gist(:$treemark).join("\n")
    }
}

package CommentGrammar is export {

    our role Actions {

        # token block-comment { '/*' .*? '*/' }
        method block-comment($/) {
            make BlockComment.new(
                value => ~$/,
            )
        }

        method line-comment-body($/) {
            make ~$/
        }

        # token line-comment { '//' <-[ \r \n ]>* }
        method line-comment($/) {
            make LineComment.new(
                value => $<line-comment-body>.made,
            )
        }

        # regex comment:sym<line> { [<line-comment> <.ws>?]+ }
        method comment:sym<line>($/) {
            make MultiLineComment.new(
                line-comments => $<line-comment>>>.made,
                text          => ~$/,
            )
        }

        # rule comment:sym<block> { <block-comment> } 
        method comment:sym<block>($/) {
            make $<block-comment>.made
        }
    }

    our role Rules {

        token block-comment {
            '/*' .*?  '*/'
        }

        token line-comment-body {
            <-[ \r \n ]>*
        }

        token line-comment {
            '//' <line-comment-body>
        }

        proto rule comment { * }

        regex comment:sym<line> {
            [<line-comment> <ws>?]+
        }

        rule comment:sym<block> {
            <block-comment>
        }
    }
}

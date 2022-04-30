unit module Chomper::Rust::GrustComment;

use Data::Dump::Tree;

use Chomper::DoxyComment;

class Comment is export {
    has Str  $.text;
    has Bool $.line;

    method maybe-item-name{
        Nil
    }

    method item-variant {
        self
    }

    method gist {

        if $.line {

            my @lines = $.text.split("\n");

            @lines.map({

                "// " ~ $_

            }).join("\n")

        } else {
            "/* " ~ $.text ~ " */"
        }
    }
}

package CommentGrammar is export {

    our role Rules 
    {
        proto rule comment { * }

        rule comment:sym<line>  {  <line-comment>+ }
        rule comment:sym<block> {  <block-comment> }
    }

    our role Actions {

        method comment:sym<line>($/)  { 
            make Comment.new(
                text => $<line-comment>>>.made.join("\n"),
                line => True,
            )
        }

        method comment:sym<block>($/) { 
            make Comment.new(
                text => $<block-comment>.made,
                line => False,
            )
        }
    }
}

use Data::Dump::Tree;

use doxy-comment;

our class Comment {
    has Str  $.text;
    has Bool $.line;

    method gist {

        if $.line {

            my @lines = $.text.split("\n");

            @lines.map: {

                "// " ~ $_

            }.join("\n")

        } else {
            "/* " ~ $.text ~ " */"
        }
    }
}

our role Comment::Rules 
{
    proto rule comment { * }

    rule comment:sym<line>  {  <line-comment>+ }
    rule comment:sym<block> {  <block-comment> }
}

our role Comment::Actions {

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

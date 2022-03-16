use Data::Dump::Tree;

use doxy-comment;

our role Comment::Rules 
{
    proto rule comment { * }

    rule comment:sym<line>  {  <line-comment>+ }
    rule comment:sym<block> {  <block-comment> }
}

our role Comment::Actions {

    method comment:sym<line>($/)  { 

        make 
        parse-doxy-comment(
            "\n/*\n" 
            ~ $<line-comment>>>.made.join("\n")
            ~ "\n*/"
        )
    }

    method comment:sym<block>($/) { make $<block-comment>.made }
}

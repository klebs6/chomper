use Data::Dump::Tree;

use grust-model;

our role UnpairedToken::Rules {

    rule unpaired-tokens { <unpaired-token>* }

    rule unpaired-token  { <.unpaired-token-case> }

    proto rule unpaired-token-case { * }

    rule unpaired-token-case:sym<a>   { <tok-shl> }
    rule unpaired-token-case:sym<b>   { <tok-shr> }
    rule unpaired-token-case:sym<c>   { <tok-le> }
    rule unpaired-token-case:sym<d>   { <tok-eqeq> }
    rule unpaired-token-case:sym<e>   { <tok-ne> }
    rule unpaired-token-case:sym<f>   { <tok-ge> }
    rule unpaired-token-case:sym<g>   { <tok-andand> }
    rule unpaired-token-case:sym<h>   { <tok-oror> }
    rule unpaired-token-case:sym<i>   { <tok-larrow> }
    rule unpaired-token-case:sym<j>   { <tok-shleq> }
    rule unpaired-token-case:sym<k>   { <tok-shreq> }
    rule unpaired-token-case:sym<l>   { <tok-minuseq> }
    rule unpaired-token-case:sym<m>   { <tok-andeq> }
    rule unpaired-token-case:sym<n>   { <tok-oreq> }
    rule unpaired-token-case:sym<o>   { <tok-pluseq> }
    rule unpaired-token-case:sym<p>   { <tok-stareq> }
    rule unpaired-token-case:sym<q>   { <tok-slasheq> }
    rule unpaired-token-case:sym<r>   { <tok-careteq> }
    rule unpaired-token-case:sym<s>   { <tok-percenteq> }
    rule unpaired-token-case:sym<t>   { <tok-dotdot> }
    rule unpaired-token-case:sym<u>   { <tok-dotdotdot> }
    rule unpaired-token-case:sym<v>   { <tok-mod-sep> }
    rule unpaired-token-case:sym<w>   { <tok-rarrow> }
    rule unpaired-token-case:sym<x>   { <tok-fat-arrow> }
    rule unpaired-token-case:sym<ah>  { <tok-underscore> }
    rule unpaired-token-case:sym<lit> { <lit> }
    rule unpaired-token-case:sym<ai>  { <lifetime> }
    rule unpaired-token-case:sym<aj>  { <kw-self> }
    rule unpaired-token-case:sym<ak>  { <kw-static> }
    rule unpaired-token-case:sym<al>  { <kw-abstract> }
    rule unpaired-token-case:sym<am>  { <kw-alignof> }
    rule unpaired-token-case:sym<an>  { <kw-as> }
    rule unpaired-token-case:sym<ao>  { <kw-become> }
    rule unpaired-token-case:sym<ap>  { <kw-break> }
    rule unpaired-token-case:sym<aq>  { <kw-catch> }
    rule unpaired-token-case:sym<ar>  { <kw-crate> }
    rule unpaired-token-case:sym<as>  { <kw-default> }
    rule unpaired-token-case:sym<at>  { <kw-do> }
    rule unpaired-token-case:sym<au>  { <kw-else> }
    rule unpaired-token-case:sym<av>  { <kw-enum> }
    rule unpaired-token-case:sym<aw>  { <kw-extern> }
    rule unpaired-token-case:sym<ax>  { <kw-false> }
    rule unpaired-token-case:sym<ay>  { <kw-final> }
    rule unpaired-token-case:sym<az>  { <kw-fn> }
    rule unpaired-token-case:sym<ba>  { <kw-for> }
    rule unpaired-token-case:sym<bb>  { <kw-if> }
    rule unpaired-token-case:sym<bc>  { <kw-impl> }
    rule unpaired-token-case:sym<bd>  { <kw-in> }
    rule unpaired-token-case:sym<be>  { <kw-let> }
    rule unpaired-token-case:sym<bf>  { <kw-loop> }
    rule unpaired-token-case:sym<bg>  { <kw-macro> }
    rule unpaired-token-case:sym<bh>  { <kw-match> }
    rule unpaired-token-case:sym<bi>  { <kw-mod> }
    rule unpaired-token-case:sym<bj>  { <kw-move> }
    rule unpaired-token-case:sym<bk>  { <kw-mut> }
    rule unpaired-token-case:sym<bl>  { <kw-offsetof> }
    rule unpaired-token-case:sym<bm>  { <kw-override> }
    rule unpaired-token-case:sym<bn>  { <kw-priv> }
    rule unpaired-token-case:sym<bo>  { <kw-pub> }
    rule unpaired-token-case:sym<bp>  { <kw-pure> }
    rule unpaired-token-case:sym<bq>  { <kw-ref> }
    rule unpaired-token-case:sym<br>  { <kw-return> }
    rule unpaired-token-case:sym<bs>  { <kw-struct> }
    rule unpaired-token-case:sym<bt>  { <kw-sizeof> }
    rule unpaired-token-case:sym<bu>  { <kw-super> }
    rule unpaired-token-case:sym<bv>  { <kw-true> }
    rule unpaired-token-case:sym<bw>  { <kw-trait> }
    rule unpaired-token-case:sym<bx>  { <kw-type> }
    rule unpaired-token-case:sym<by>  { <kw-union> }
    rule unpaired-token-case:sym<bz>  { <kw-unsafe> }
    rule unpaired-token-case:sym<ca>  { <kw-unsized> }
    rule unpaired-token-case:sym<cb>  { <kw-use> }
    rule unpaired-token-case:sym<cc>  { <kw-virtual> }
    rule unpaired-token-case:sym<cd>  { <kw-while> }
    rule unpaired-token-case:sym<ce>  { <kw-yield> }
    rule unpaired-token-case:sym<cf>  { <kw-continue> }
    rule unpaired-token-case:sym<cg>  { <kw-proc> }
    rule unpaired-token-case:sym<ch>  { <kw-box> }
    rule unpaired-token-case:sym<ci>  { <kw-const> }
    rule unpaired-token-case:sym<cj>  { <kw-where> }
    rule unpaired-token-case:sym<ck>  { <kw-typeof> }
    rule unpaired-token-case:sym<cl>  { <inner-doc-comment> }
    rule unpaired-token-case:sym<cm>  { <outer-doc-comment> }
    rule unpaired-token-case:sym<cn>  { <shebang> }
    rule unpaired-token-case:sym<co>  { <static-lifetime> }
    rule unpaired-token-case:sym<ag>  { <ident_> }
    rule unpaired-token-case:sym<cp>  { ';' }
    rule unpaired-token-case:sym<cq>  { ',' }
    rule unpaired-token-case:sym<cr>  { '.' }
    rule unpaired-token-case:sym<cs>  { '@' }
    rule unpaired-token-case:sym<ct>  { '#' }
    rule unpaired-token-case:sym<cu>  { '~' }
    rule unpaired-token-case:sym<cv>  { ':' }
    rule unpaired-token-case:sym<cw>  { '$' }
    rule unpaired-token-case:sym<cx>  { '=' }
    rule unpaired-token-case:sym<cy>  { '?' }
    rule unpaired-token-case:sym<cz>  { '!' }
    rule unpaired-token-case:sym<da>  { '<' }
    rule unpaired-token-case:sym<db>  { '>' }
    rule unpaired-token-case:sym<dc>  { '-' }
    rule unpaired-token-case:sym<dd>  { '&' }
    rule unpaired-token-case:sym<de>  { '|' }
    rule unpaired-token-case:sym<df>  { '+' }
    rule unpaired-token-case:sym<dg>  { '*' }
    rule unpaired-token-case:sym<dh>  { '/' }
    rule unpaired-token-case:sym<di>  { '^' }
    rule unpaired-token-case:sym<dj>  { '%' }
}

our role UnpairedToken::Actions {
    method unpaired-token($/)  { make ~$/ }
}

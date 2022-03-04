use grust-model;

our role UnpairedToken::Rules {

    rule unpaired-tokens { <unpaired-token>* }

    proto rule unpaired-token { * }

    rule unpaired-token:sym<a>   { <tok-shl> }
    rule unpaired-token:sym<b>   { <tok-shr> }
    rule unpaired-token:sym<c>   { <tok-le> }
    rule unpaired-token:sym<d>   { <tok-eqeq> }
    rule unpaired-token:sym<e>   { <tok-ne> }
    rule unpaired-token:sym<f>   { <tok-ge> }
    rule unpaired-token:sym<g>   { <tok-andand> }
    rule unpaired-token:sym<h>   { <tok-oror> }
    rule unpaired-token:sym<i>   { <tok-larrow> }
    rule unpaired-token:sym<j>   { <tok-shleq> }
    rule unpaired-token:sym<k>   { <tok-shreq> }
    rule unpaired-token:sym<l>   { <tok-minuseq> }
    rule unpaired-token:sym<m>   { <tok-andeq> }
    rule unpaired-token:sym<n>   { <tok-oreq> }
    rule unpaired-token:sym<o>   { <tok-pluseq> }
    rule unpaired-token:sym<p>   { <tok-stareq> }
    rule unpaired-token:sym<q>   { <tok-slasheq> }
    rule unpaired-token:sym<r>   { <tok-careteq> }
    rule unpaired-token:sym<s>   { <tok-percenteq> }
    rule unpaired-token:sym<t>   { <tok-dotdot> }
    rule unpaired-token:sym<u>   { <tok-dotdotdot> }
    rule unpaired-token:sym<v>   { <tok-mod-sep> }
    rule unpaired-token:sym<w>   { <tok-rarrow> }
    rule unpaired-token:sym<x>   { <tok-fat-arrow> }
    rule unpaired-token:sym<ah>  { <tok-underscore> }
    rule unpaired-token:sym<lit> { <lit> }
    rule unpaired-token:sym<ai>  { <lifetime> }
    rule unpaired-token:sym<aj>  { <kw-self> }
    rule unpaired-token:sym<ak>  { <kw-static> }
    rule unpaired-token:sym<al>  { <kw-abstract> }
    rule unpaired-token:sym<am>  { <kw-alignof> }
    rule unpaired-token:sym<an>  { <kw-as> }
    rule unpaired-token:sym<ao>  { <kw-become> }
    rule unpaired-token:sym<ap>  { <kw-break> }
    rule unpaired-token:sym<aq>  { <kw-catch> }
    rule unpaired-token:sym<ar>  { <kw-crate> }
    rule unpaired-token:sym<as>  { <kw-default> }
    rule unpaired-token:sym<at>  { <kw-do> }
    rule unpaired-token:sym<au>  { <kw-else> }
    rule unpaired-token:sym<av>  { <kw-enum> }
    rule unpaired-token:sym<aw>  { <kw-extern> }
    rule unpaired-token:sym<ax>  { <kw-false> }
    rule unpaired-token:sym<ay>  { <kw-final> }
    rule unpaired-token:sym<az>  { <kw-fn> }
    rule unpaired-token:sym<ba>  { <kw-for> }
    rule unpaired-token:sym<bb>  { <kw-if> }
    rule unpaired-token:sym<bc>  { <kw-impl> }
    rule unpaired-token:sym<bd>  { <kw-in> }
    rule unpaired-token:sym<be>  { <kw-let> }
    rule unpaired-token:sym<bf>  { <kw-loop> }
    rule unpaired-token:sym<bg>  { <kw-macro> }
    rule unpaired-token:sym<bh>  { <kw-match> }
    rule unpaired-token:sym<bi>  { <kw-mod> }
    rule unpaired-token:sym<bj>  { <kw-move> }
    rule unpaired-token:sym<bk>  { <kw-mut> }
    rule unpaired-token:sym<bl>  { <kw-offsetof> }
    rule unpaired-token:sym<bm>  { <kw-override> }
    rule unpaired-token:sym<bn>  { <kw-priv> }
    rule unpaired-token:sym<bo>  { <kw-pub> }
    rule unpaired-token:sym<bp>  { <kw-pure> }
    rule unpaired-token:sym<bq>  { <kw-ref> }
    rule unpaired-token:sym<br>  { <kw-return> }
    rule unpaired-token:sym<bs>  { <kw-struct> }
    rule unpaired-token:sym<bt>  { <kw-sizeof> }
    rule unpaired-token:sym<bu>  { <kw-super> }
    rule unpaired-token:sym<bv>  { <kw-true> }
    rule unpaired-token:sym<bw>  { <kw-trait> }
    rule unpaired-token:sym<bx>  { <kw-type> }
    rule unpaired-token:sym<by>  { <kw-union> }
    rule unpaired-token:sym<bz>  { <kw-unsafe> }
    rule unpaired-token:sym<ca>  { <kw-unsized> }
    rule unpaired-token:sym<cb>  { <kw-use> }
    rule unpaired-token:sym<cc>  { <kw-virtual> }
    rule unpaired-token:sym<cd>  { <kw-while> }
    rule unpaired-token:sym<ce>  { <kw-yield> }
    rule unpaired-token:sym<cf>  { <kw-continue> }
    rule unpaired-token:sym<cg>  { <kw-proc> }
    rule unpaired-token:sym<ch>  { <kw-box> }
    rule unpaired-token:sym<ci>  { <kw-const> }
    rule unpaired-token:sym<cj>  { <kw-where> }
    rule unpaired-token:sym<ck>  { <kw-typeof> }
    rule unpaired-token:sym<cl>  { <inner-doc-comment> }
    rule unpaired-token:sym<cm>  { <outer-doc-comment> }
    rule unpaired-token:sym<cn>  { <shebang> }
    rule unpaired-token:sym<co>  { <static-lifetime> }
    rule unpaired-token:sym<ag>  { <ident_> }
    rule unpaired-token:sym<cp>  { ';' }
    rule unpaired-token:sym<cq>  { ',' }
    rule unpaired-token:sym<cr>  { '.' }
    rule unpaired-token:sym<cs>  { '@' }
    rule unpaired-token:sym<ct>  { '#' }
    rule unpaired-token:sym<cu>  { '~' }
    rule unpaired-token:sym<cv>  { ':' }
    rule unpaired-token:sym<cw>  { '$' }
    rule unpaired-token:sym<cx>  { '=' }
    rule unpaired-token:sym<cy>  { '?' }
    rule unpaired-token:sym<cz>  { '!' }
    rule unpaired-token:sym<da>  { '<' }
    rule unpaired-token:sym<db>  { '>' }
    rule unpaired-token:sym<dc>  { '-' }
    rule unpaired-token:sym<dd>  { '&' }
    rule unpaired-token:sym<de>  { '|' }
    rule unpaired-token:sym<df>  { '+' }
    rule unpaired-token:sym<dg>  { '*' }
    rule unpaired-token:sym<dh>  { '/' }
    rule unpaired-token:sym<di>  { '^' }
    rule unpaired-token:sym<dj>  { '%' }
}

our role UnpairedToken::Actions {
    method unpaired-token:sym<a>($/)  { make ~$/ }
    method unpaired-token:sym<b>($/)  { make ~$/ }
    method unpaired-token:sym<c>($/)  { make ~$/ }
    method unpaired-token:sym<d>($/)  { make ~$/ }
    method unpaired-token:sym<e>($/)  { make ~$/ }
    method unpaired-token:sym<f>($/)  { make ~$/ }
    method unpaired-token:sym<g>($/)  { make ~$/ }
    method unpaired-token:sym<h>($/)  { make ~$/ }
    method unpaired-token:sym<i>($/)  { make ~$/ }
    method unpaired-token:sym<j>($/)  { make ~$/ }
    method unpaired-token:sym<k>($/)  { make ~$/ }
    method unpaired-token:sym<l>($/)  { make ~$/ }
    method unpaired-token:sym<m>($/)  { make ~$/ }
    method unpaired-token:sym<n>($/)  { make ~$/ }
    method unpaired-token:sym<o>($/)  { make ~$/ }
    method unpaired-token:sym<p>($/)  { make ~$/ }
    method unpaired-token:sym<q>($/)  { make ~$/ }
    method unpaired-token:sym<r>($/)  { make ~$/ }
    method unpaired-token:sym<s>($/)  { make ~$/ }
    method unpaired-token:sym<t>($/)  { make ~$/ }
    method unpaired-token:sym<u>($/)  { make ~$/ }
    method unpaired-token:sym<v>($/)  { make ~$/ }
    method unpaired-token:sym<w>($/)  { make ~$/ }
    method unpaired-token:sym<x>($/)  { make ~$/ }
    method unpaired-token:sym<y>($/)  { make ~$/ }
    method unpaired-token:sym<z>($/)  { make ~$/ }
    method unpaired-token:sym<aa>($/) { make ~$/ }
    method unpaired-token:sym<ab>($/) { make ~$/ }
    method unpaired-token:sym<ac>($/) { make ~$/ }
    method unpaired-token:sym<ad>($/) { make ~$/ }
    method unpaired-token:sym<ae>($/) { make ~$/ }
    method unpaired-token:sym<af>($/) { make ~$/ }
    method unpaired-token:sym<ag>($/) { make ~$/ }
    method unpaired-token:sym<ah>($/) { make ~$/ }
    method unpaired-token:sym<ai>($/) { make ~$/ }
    method unpaired-token:sym<aj>($/) { make ~$/ }
    method unpaired-token:sym<ak>($/) { make ~$/ }
    method unpaired-token:sym<al>($/) { make ~$/ }
    method unpaired-token:sym<am>($/) { make ~$/ }
    method unpaired-token:sym<an>($/) { make ~$/ }
    method unpaired-token:sym<ao>($/) { make ~$/ }
    method unpaired-token:sym<ap>($/) { make ~$/ }
    method unpaired-token:sym<aq>($/) { make ~$/ }
    method unpaired-token:sym<ar>($/) { make ~$/ }
    method unpaired-token:sym<as>($/) { make ~$/ }
    method unpaired-token:sym<at>($/) { make ~$/ }
    method unpaired-token:sym<au>($/) { make ~$/ }
    method unpaired-token:sym<av>($/) { make ~$/ }
    method unpaired-token:sym<aw>($/) { make ~$/ }
    method unpaired-token:sym<ax>($/) { make ~$/ }
    method unpaired-token:sym<ay>($/) { make ~$/ }
    method unpaired-token:sym<az>($/) { make ~$/ }
    method unpaired-token:sym<ba>($/) { make ~$/ }
    method unpaired-token:sym<bb>($/) { make ~$/ }
    method unpaired-token:sym<bc>($/) { make ~$/ }
    method unpaired-token:sym<bd>($/) { make ~$/ }
    method unpaired-token:sym<be>($/) { make ~$/ }
    method unpaired-token:sym<bf>($/) { make ~$/ }
    method unpaired-token:sym<bg>($/) { make ~$/ }
    method unpaired-token:sym<bh>($/) { make ~$/ }
    method unpaired-token:sym<bi>($/) { make ~$/ }
    method unpaired-token:sym<bj>($/) { make ~$/ }
    method unpaired-token:sym<bk>($/) { make ~$/ }
    method unpaired-token:sym<bl>($/) { make ~$/ }
    method unpaired-token:sym<bm>($/) { make ~$/ }
    method unpaired-token:sym<bn>($/) { make ~$/ }
    method unpaired-token:sym<bo>($/) { make ~$/ }
    method unpaired-token:sym<bp>($/) { make ~$/ }
    method unpaired-token:sym<bq>($/) { make ~$/ }
    method unpaired-token:sym<br>($/) { make ~$/ }
    method unpaired-token:sym<bs>($/) { make ~$/ }
    method unpaired-token:sym<bt>($/) { make ~$/ }
    method unpaired-token:sym<bu>($/) { make ~$/ }
    method unpaired-token:sym<bv>($/) { make ~$/ }
    method unpaired-token:sym<bw>($/) { make ~$/ }
    method unpaired-token:sym<bx>($/) { make ~$/ }
    method unpaired-token:sym<by>($/) { make ~$/ }
    method unpaired-token:sym<bz>($/) { make ~$/ }
    method unpaired-token:sym<ca>($/) { make ~$/ }
    method unpaired-token:sym<cb>($/) { make ~$/ }
    method unpaired-token:sym<cc>($/) { make ~$/ }
    method unpaired-token:sym<cd>($/) { make ~$/ }
    method unpaired-token:sym<ce>($/) { make ~$/ }
    method unpaired-token:sym<cf>($/) { make ~$/ }
    method unpaired-token:sym<cg>($/) { make ~$/ }
    method unpaired-token:sym<ch>($/) { make ~$/ }
    method unpaired-token:sym<ci>($/) { make ~$/ }
    method unpaired-token:sym<cj>($/) { make ~$/ }
    method unpaired-token:sym<ck>($/) { make ~$/ }
    method unpaired-token:sym<cl>($/) { make ~$/ }
    method unpaired-token:sym<cm>($/) { make ~$/ }
    method unpaired-token:sym<cn>($/) { make ~$/ }
    method unpaired-token:sym<co>($/) { make ~$/ }
    method unpaired-token:sym<cp>($/) { make ~$/ }
    method unpaired-token:sym<cq>($/) { make ~$/ }
    method unpaired-token:sym<cr>($/) { make ~$/ }
    method unpaired-token:sym<cs>($/) { make ~$/ }
    method unpaired-token:sym<ct>($/) { make ~$/ }
    method unpaired-token:sym<cu>($/) { make ~$/ }
    method unpaired-token:sym<cv>($/) { make ~$/ }
    method unpaired-token:sym<cw>($/) { make ~$/ }
    method unpaired-token:sym<cx>($/) { make ~$/ }
    method unpaired-token:sym<cy>($/) { make ~$/ }
    method unpaired-token:sym<cz>($/) { make ~$/ }
    method unpaired-token:sym<da>($/) { make ~$/ }
    method unpaired-token:sym<db>($/) { make ~$/ }
    method unpaired-token:sym<dc>($/) { make ~$/ }
    method unpaired-token:sym<dd>($/) { make ~$/ }
    method unpaired-token:sym<de>($/) { make ~$/ }
    method unpaired-token:sym<df>($/) { make ~$/ }
    method unpaired-token:sym<dg>($/) { make ~$/ }
    method unpaired-token:sym<dh>($/) { make ~$/ }
    method unpaired-token:sym<di>($/) { make ~$/ }
    method unpaired-token:sym<dj>($/) { make ~$/ }
}

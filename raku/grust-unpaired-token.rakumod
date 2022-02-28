use grust-model;

our role UnpairedToken::Rules {

    rule unpaired-tokens { <unpaired-token>* }

    proto rule unpaired-token { * }

    rule unpaired-token:sym<a>  { <shl> }
    rule unpaired-token:sym<b>  { <shr> }
    rule unpaired-token:sym<c>  { <le_> }
    rule unpaired-token:sym<d>  { <eqeq> }
    rule unpaired-token:sym<e>  { <ne_> }
    rule unpaired-token:sym<f>  { <ge_> }
    rule unpaired-token:sym<g>  { <andand> }
    rule unpaired-token:sym<h>  { <oror> }
    rule unpaired-token:sym<i>  { <larrow> }
    rule unpaired-token:sym<j>  { <shleq> }
    rule unpaired-token:sym<k>  { <shreq> }
    rule unpaired-token:sym<l>  { <minuseq> }
    rule unpaired-token:sym<m>  { <andeq> }
    rule unpaired-token:sym<n>  { <oreq> }
    rule unpaired-token:sym<o>  { <pluseq> }
    rule unpaired-token:sym<p>  { <stareq> }
    rule unpaired-token:sym<q>  { <slasheq> }
    rule unpaired-token:sym<r>  { <careteq> }
    rule unpaired-token:sym<s>  { <percenteq> }
    rule unpaired-token:sym<t>  { <dotdot> }
    rule unpaired-token:sym<u>  { <dotdotdot> }
    rule unpaired-token:sym<v>  { <mod-sep> }
    rule unpaired-token:sym<w>  { <rarrow> }
    rule unpaired-token:sym<x>  { <fat-arrow> }
    rule unpaired-token:sym<y>  { <lit-byte> }
    rule unpaired-token:sym<z>  { <lit-char> }
    rule unpaired-token:sym<aa> { <lit-int> }
    rule unpaired-token:sym<ab> { <lit-float> }
    rule unpaired-token:sym<ac> { <lit-str> }
    rule unpaired-token:sym<ad> { <lit-str-raw> }
    rule unpaired-token:sym<ae> { <lit-byte-str> }
    rule unpaired-token:sym<af> { <lit-byte-str-raw> }
    rule unpaired-token:sym<ag> { <ident_> }
    rule unpaired-token:sym<ah> { <underscore> }
    rule unpaired-token:sym<ai> { <lifetime> }
    rule unpaired-token:sym<aj> { <self_> }
    rule unpaired-token:sym<ak> { <static> }
    rule unpaired-token:sym<al> { <kw-abstract> }
    rule unpaired-token:sym<am> { <kw-alignof> }
    rule unpaired-token:sym<an> { <kw-as> }
    rule unpaired-token:sym<ao> { <kw-become> }
    rule unpaired-token:sym<ap> { <kw-break> }
    rule unpaired-token:sym<aq> { <catch> }
    rule unpaired-token:sym<ar> { <kw-crate> }
    rule unpaired-token:sym<as> { <default_> }
    rule unpaired-token:sym<at> { <do_> }
    rule unpaired-token:sym<au> { <else_> }
    rule unpaired-token:sym<av> { <enum_> }
    rule unpaired-token:sym<aw> { <extern> }
    rule unpaired-token:sym<ax> { <false> }
    rule unpaired-token:sym<ay> { <final> }
    rule unpaired-token:sym<az> { <fn> }
    rule unpaired-token:sym<ba> { <for_> }
    rule unpaired-token:sym<bb> { <if_> }
    rule unpaired-token:sym<bc> { <impl> }
    rule unpaired-token:sym<bd> { <in> }
    rule unpaired-token:sym<be> { <let_> }
    rule unpaired-token:sym<bf> { <loop_> }
    rule unpaired-token:sym<bg> { <macro_> }
    rule unpaired-token:sym<bh> { <match_> }
    rule unpaired-token:sym<bi> { <mod_> }
    rule unpaired-token:sym<bj> { <move> }
    rule unpaired-token:sym<bk> { <mut> }
    rule unpaired-token:sym<bl> { <offsetof> }
    rule unpaired-token:sym<bm> { <override> }
    rule unpaired-token:sym<bn> { <priv> }
    rule unpaired-token:sym<bo> { <pub> }
    rule unpaired-token:sym<bp> { <pure> }
    rule unpaired-token:sym<bq> { <ref> }
    rule unpaired-token:sym<br> { <return_> }
    rule unpaired-token:sym<bs> { <struct> }
    rule unpaired-token:sym<bt> { <sizeof> }
    rule unpaired-token:sym<bu> { <super> }
    rule unpaired-token:sym<bv> { <true> }
    rule unpaired-token:sym<bw> { <trait> }
    rule unpaired-token:sym<bx> { <type> }
    rule unpaired-token:sym<by> { <union> }
    rule unpaired-token:sym<bz> { <unsafe> }
    rule unpaired-token:sym<ca> { <unsized> }
    rule unpaired-token:sym<cb> { <use_> }
    rule unpaired-token:sym<cc> { <virtual> }
    rule unpaired-token:sym<cd> { <while_> }
    rule unpaired-token:sym<ce> { <yield> }
    rule unpaired-token:sym<cf> { <continue_> }
    rule unpaired-token:sym<cg> { <proc> }
    rule unpaired-token:sym<ch> { <kw-box> }
    rule unpaired-token:sym<ci> { <const> }
    rule unpaired-token:sym<cj> { <where_> }
    rule unpaired-token:sym<ck> { <typeof> }
    rule unpaired-token:sym<cl> { <inner-doc-comment> }
    rule unpaired-token:sym<cm> { <outer-doc-comment> }
    rule unpaired-token:sym<cn> { <shebang> }
    rule unpaired-token:sym<co> { <static-lifetime> }
    rule unpaired-token:sym<cp> { ';' }
    rule unpaired-token:sym<cq> { ',' }
    rule unpaired-token:sym<cr> { '.' }
    rule unpaired-token:sym<cs> { '@' }
    rule unpaired-token:sym<ct> { '#' }
    rule unpaired-token:sym<cu> { '~' }
    rule unpaired-token:sym<cv> { ':' }
    rule unpaired-token:sym<cw> { '$' }
    rule unpaired-token:sym<cx> { '=' }
    rule unpaired-token:sym<cy> { '?' }
    rule unpaired-token:sym<cz> { '!' }
    rule unpaired-token:sym<da> { '<' }
    rule unpaired-token:sym<db> { '>' }
    rule unpaired-token:sym<dc> { '-' }
    rule unpaired-token:sym<dd> { '&' }
    rule unpaired-token:sym<de> { '|' }
    rule unpaired-token:sym<df> { '+' }
    rule unpaired-token:sym<dg> { '*' }
    rule unpaired-token:sym<dh> { '/' }
    rule unpaired-token:sym<di> { '^' }
    rule unpaired-token:sym<dj> { '%' }
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

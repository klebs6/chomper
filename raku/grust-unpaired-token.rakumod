use grust-model;

our role UnpairedToken::Rules {

    rule unpaired-tokens { <unpaired-token>* }

    proto rule unpaired-token { * }

    rule unpaired-token:sym<a>  { <SHL> }
    rule unpaired-token:sym<b>  { <SHR> }
    rule unpaired-token:sym<c>  { <LE> }
    rule unpaired-token:sym<d>  { <EQEQ> }
    rule unpaired-token:sym<e>  { <NE> }
    rule unpaired-token:sym<f>  { <GE> }
    rule unpaired-token:sym<g>  { <ANDAND> }
    rule unpaired-token:sym<h>  { <OROR> }
    rule unpaired-token:sym<i>  { <LARROW> }
    rule unpaired-token:sym<j>  { <SHLEQ> }
    rule unpaired-token:sym<k>  { <SHREQ> }
    rule unpaired-token:sym<l>  { <MINUSEQ> }
    rule unpaired-token:sym<m>  { <ANDEQ> }
    rule unpaired-token:sym<n>  { <OREQ> }
    rule unpaired-token:sym<o>  { <PLUSEQ> }
    rule unpaired-token:sym<p>  { <STAREQ> }
    rule unpaired-token:sym<q>  { <SLASHEQ> }
    rule unpaired-token:sym<r>  { <CARETEQ> }
    rule unpaired-token:sym<s>  { <PERCENTEQ> }
    rule unpaired-token:sym<t>  { <DOTDOT> }
    rule unpaired-token:sym<u>  { <DOTDOTDOT> }
    rule unpaired-token:sym<v>  { <MOD-SEP> }
    rule unpaired-token:sym<w>  { <RARROW> }
    rule unpaired-token:sym<x>  { <FAT-ARROW> }
    rule unpaired-token:sym<y>  { <LIT-BYTE> }
    rule unpaired-token:sym<z>  { <LIT-CHAR> }
    rule unpaired-token:sym<aa> { <LIT-INT> }
    rule unpaired-token:sym<ab> { <LIT-FLOAT> }
    rule unpaired-token:sym<ac> { <LIT-STR> }
    rule unpaired-token:sym<ad> { <LIT-STR-RAW> }
    rule unpaired-token:sym<ae> { <LIT-BYTE-STR> }
    rule unpaired-token:sym<af> { <LIT-BYTE-STR-RAW> }
    rule unpaired-token:sym<ag> { <IDENT> }
    rule unpaired-token:sym<ah> { <UNDERSCORE> }
    rule unpaired-token:sym<ai> { <LIFETIME> }
    rule unpaired-token:sym<aj> { <SELF> }
    rule unpaired-token:sym<ak> { <STATIC> }
    rule unpaired-token:sym<al> { <ABSTRACT> }
    rule unpaired-token:sym<am> { <ALIGNOF> }
    rule unpaired-token:sym<an> { <AS> }
    rule unpaired-token:sym<ao> { <BECOME> }
    rule unpaired-token:sym<ap> { <BREAK> }
    rule unpaired-token:sym<aq> { <CATCH> }
    rule unpaired-token:sym<ar> { <CRATE> }
    rule unpaired-token:sym<as> { <DEFAULT> }
    rule unpaired-token:sym<at> { <DO> }
    rule unpaired-token:sym<au> { <ELSE> }
    rule unpaired-token:sym<av> { <ENUM> }
    rule unpaired-token:sym<aw> { <EXTERN> }
    rule unpaired-token:sym<ax> { <FALSE> }
    rule unpaired-token:sym<ay> { <FINAL> }
    rule unpaired-token:sym<az> { <FN> }
    rule unpaired-token:sym<ba> { <FOR> }
    rule unpaired-token:sym<bb> { <IF> }
    rule unpaired-token:sym<bc> { <IMPL> }
    rule unpaired-token:sym<bd> { <IN> }
    rule unpaired-token:sym<be> { <LET> }
    rule unpaired-token:sym<bf> { <LOOP> }
    rule unpaired-token:sym<bg> { <MACRO> }
    rule unpaired-token:sym<bh> { <MATCH_> }
    rule unpaired-token:sym<bi> { <MOD> }
    rule unpaired-token:sym<bj> { <MOVE> }
    rule unpaired-token:sym<bk> { <MUT> }
    rule unpaired-token:sym<bl> { <OFFSETOF> }
    rule unpaired-token:sym<bm> { <OVERRIDE> }
    rule unpaired-token:sym<bn> { <PRIV> }
    rule unpaired-token:sym<bo> { <PUB> }
    rule unpaired-token:sym<bp> { <PURE> }
    rule unpaired-token:sym<bq> { <REF> }
    rule unpaired-token:sym<br> { <RETURN> }
    rule unpaired-token:sym<bs> { <STRUCT> }
    rule unpaired-token:sym<bt> { <SIZEOF> }
    rule unpaired-token:sym<bu> { <SUPER> }
    rule unpaired-token:sym<bv> { <TRUE> }
    rule unpaired-token:sym<bw> { <TRAIT> }
    rule unpaired-token:sym<bx> { <TYPE> }
    rule unpaired-token:sym<by> { <UNION> }
    rule unpaired-token:sym<bz> { <UNSAFE> }
    rule unpaired-token:sym<ca> { <UNSIZED> }
    rule unpaired-token:sym<cb> { <USE> }
    rule unpaired-token:sym<cc> { <VIRTUAL> }
    rule unpaired-token:sym<cd> { <WHILE> }
    rule unpaired-token:sym<ce> { <YIELD> }
    rule unpaired-token:sym<cf> { <CONTINUE> }
    rule unpaired-token:sym<cg> { <PROC> }
    rule unpaired-token:sym<ch> { <BOX> }
    rule unpaired-token:sym<ci> { <CONST> }
    rule unpaired-token:sym<cj> { <WHERE> }
    rule unpaired-token:sym<ck> { <TYPEOF> }
    rule unpaired-token:sym<cl> { <INNER-DOC-COMMENT> }
    rule unpaired-token:sym<cm> { <OUTER-DOC-COMMENT> }
    rule unpaired-token:sym<cn> { <SHEBANG> }
    rule unpaired-token:sym<co> { <STATIC-LIFETIME> }
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


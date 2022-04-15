unit module Chomper::Rust::GrustReservedKeywords;

use Data::Dump::Tree;

#`(
These keywords aren't used yet, but they are
reserved for future use. They have the same
restrictions as strict keywords. The reasoning
behind this is to make current programs forward
compatible with future versions of Rust by
forbidding them to use these keywords.)
our role ReservedKeywords::Rules {
    token kw-abstract { abstract }
    token kw-become   { become }
    token kw-box      { box }
    token kw-do       { do }
    token kw-final    { final }
    token kw-macro    { macro }
    token kw-override { override }
    token kw-priv     { priv }
    token kw-typeof   { typeof }
    token kw-unsized  { unsized }
    token kw-virtual  { virtual }
    token kw-yield    { yield }

    #added in the 2018 edition
    token kw-try      { try }

    proto token reserved-keyword { * }
    token reserved-keyword:sym<kw-abstract> { <kw-abstract> }
    token reserved-keyword:sym<kw-become>   { <kw-become> }
    token reserved-keyword:sym<kw-box>      { <kw-box> }
    token reserved-keyword:sym<kw-do>       { <kw-do> }
    token reserved-keyword:sym<kw-final>    { <kw-final> }
    token reserved-keyword:sym<kw-macro>    { <kw-macro> }
    token reserved-keyword:sym<kw-override> { <kw-override> }
    token reserved-keyword:sym<kw-priv>     { <kw-priv> }
    token reserved-keyword:sym<kw-typeof>   { <kw-typeof> }
    token reserved-keyword:sym<kw-unsized>  { <kw-unsized> }
    token reserved-keyword:sym<kw-virtual>  { <kw-virtual> }
    token reserved-keyword:sym<kw-yield>    { <kw-yield> }
    token reserved-keyword:sym<kw-try>      { <kw-try> }
}

our role ReservedKeywords::Actions {}

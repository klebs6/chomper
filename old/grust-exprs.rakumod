use Data::Dump::Tree;

use grust-model;

our role Exprs::Rules {

    rule maybe-exprs { <exprs>? ','? }
    rule maybe-expr  { <expr>? }

    rule exprs               { <exprs-item>+ %% "," }

    proto token exprs-item  { * }
    token exprs-item:sym<a> { <expr> }
    token exprs-item:sym<b> { <expr-nostruct> } #not in original grammar
}

our role Exprs::Actions {

    method maybe-exprs($/) { make $<exprs>.made }
    method maybe-expr($/)  { make $<expr>.made }

    method exprs($/)       { make $<exprs-item>>>.made }

    method exprs-item:sym<a>($/) { make $<expr>.made }
    method exprs-item:sym<b>($/) { make $<expr-nostruct>.made }
}

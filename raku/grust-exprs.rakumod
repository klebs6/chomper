use grust-model;

our role Exprs::Rules {

    rule maybe-exprs { <exprs>? ','? }
    rule maybe-expr  { <expr>? }

    rule exprs           { [<expr> | <expr-nostruct>]+ %% "," }
    #old way: rule exprs { <expr>]+ %% "," }
}

our role Exprs::Actions {

    method maybe-exprs($/) { make $<exprs>.made }
    method maybe-expr($/)  { make $<expr>.made }
    method exprs($/)       { make $<expr>>>.made }
}

our class Exprs {
    has $.expr;
}

our class Exprs::Rules {
    rule maybe-exprs { <exprs>? ','? }
    rule maybe-expr  { <expr>? }
    rule exprs       { <expr>+ %% "," }
}

our class Exprs::Actions {

    method maybe-exprs($/) { make $<exprs>.made }
    method maybe-expr($/)  { make $<expr>.made }
    method exprs($/)       { make $<expr>>>.made }
}

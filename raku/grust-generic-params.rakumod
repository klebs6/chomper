use grust-model;

our role GenericParams::Rules {

    rule generic-params { <generic-params-base>? }

    proto rule generic-params-base { * }

    rule generic-params-base:sym<g> { 
        '<' 
        [
            [<lifetimes> ','?]? 
            [<const-generics> ','?]? 
            [<ty-params> ','?]?
        ]? 
        '>' 
    }
}

our role GenericParams::Actions {

    method generic-params($/) {
        make $<generic-params-base>.made
    }

    method generic-params-base:sym<g>($/) {
        make Generics.new(
            lifetimes      =>  $<lifetimes>.made,
            const-generics =>  $<const-generics>.made,
            ty-params      =>  $<ty-params>.made,
        )
    }
}

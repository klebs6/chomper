our role GenericParams::Rules {

    rule generic-params {
        <tok-lt>
        [
            <generic-param>* %% <tok-comma>
        ]
        <tok-gt>
    }

    rule generic-param {
        <outer-attribute>*
        <generic-param-variant>
    }

    #-----------------
    proto rule generic-param-variant { * }

    rule generic-param-variant:sym<lt>    { <lifetime-param> }

    rule generic-param-variant:sym<type>  { <type-param> }

    rule generic-param-variant:sym<const> { <const-param> }

    #-----------------
    rule lifetime-param {
        <lifetime-or-label> [ <tok-colon> <lifetime-bounds> ]?
    }

    rule type-param {
        <identifier>
        [ <tok-colon> <type-param-bounds>? ]?
        [ <tok-eq> <type> ]?
    }

    rule const-param {
        <kw-const> 
        <identifier> 
        <tok-colon> 
        <type>
    }
}

our role GenericParams::Actions {}

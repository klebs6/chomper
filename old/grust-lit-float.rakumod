use Data::Dump::Tree;

our class LitFloat { 
    has $.val; 

    method gist {
        "{$.val}"
    }
}

our role LitFloat::Rules {

    token lit-float { <lit-float-body> }

    proto token lit-float-body { * }

    token lit-float-body:sym<a> { 
        <decdigit>
        <decdigit-cont>*
        '.'
        <!before <ident-or-dot>>
    }

    token ident-or-dot {
        | <ident>
        | <tok-dot>
    }


    token lit-float-body:sym<b> { 
        <decdigit>
        <decdigit-cont>*
        '.'
        <decdigit>
        <decdigit-cont>*
        <litfloat-exp>?
        <litfloat-ty>?
    }

    token lit-float-body:sym<c> { 
        <decdigit>
        <decdigit-cont>*
        <litfloat-exp>
        <litfloat-ty>?
    }

    token lit-float-body:sym<d> { 
        <decdigit>
        <decdigit-cont>*
        <litfloat-ty>
    }

    token litfloat-exp { 
        <[ e E ]> 
        <[ + - ]>? 
        <decdigit-cont>+
    }

    token litfloat-ty { '_'? 'f' [ '32' || '64' ]? }
}

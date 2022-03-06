use Data::Dump::Tree;

our class LitFloat { 
    has $.val; 

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        ddt self;
        exit;
    }
}

our role LitFloat::Rules {

    proto token lit-float { * }

    token lit-float:sym<a> { 
        <decdigit>
        <decdigit-cont>*
        '.'
        <!before <ident-or-dot>>
    }

    token ident-or-dot {
        | <ident>
        | <tok-dot>
    }


    token lit-float:sym<b> { 
        <decdigit>
        <decdigit-cont>*
        '.'
        <decdigit>
        <decdigit-cont>*
        <litfloat-exp>?
        <litfloat-ty>?
    }

    token lit-float:sym<c> { 
        <decdigit>
        <decdigit-cont>*
        <litfloat-exp>
        <litfloat-ty>?
    }

    token lit-float:sym<d> { 
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

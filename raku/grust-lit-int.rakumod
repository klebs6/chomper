use Data::Dump::Tree;

use grust-model;

our class LitInteger { 
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

our role LitInt::Rules {

    token lit-int { 
        || '0x' <hexdigit>+ <intlit-ty>?
        || '0b' <bindigit>+ <intlit-ty>?
        || <decdigit> <decdigit-cont>* <intlit-ty>?
        #|| <lit-char>
    }

    proto token intlit-ty { * }

    token intlit-ty:sym<prim> { 
        [    
            ||    'u'
            ||    'i'
        ]
        [   
            ||    '8'
            ||    '16'
            ||    '32'
            ||    '64'
        ]?
    }

    token intlit-ty:sym<size> { 
        [    
            ||    'usize'
            ||    'isize'
        ]
    }


    token bindigit      { <[ 0 .. 1 _ ]> }
    token decdigit      { <[ 0 .. 9 _ ]> }
    token decdigit-cont { <[ 0 .. 9 _ ]> }
    token hexdigit      { <[ 0 .. 9 a..f A..F _ ]> }
}

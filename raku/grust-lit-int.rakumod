use grust-model;

our role LitInt::Rules {

    token lit-int { 
        || <lit-char>
        || '0x' <hexdigit>+ <intlit-ty>?
        || '0b' <bindigit>+ <intlit-ty>?
        || <decdigit> <decdigit-cont>* <intlit-ty>?
    }

    token intlit-ty { 
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


    token bindigit      { <[ 0 .. 1 ]> }
    token decdigit      { <[ 0 .. 9 ]> }
    token decdigit-cont { <[ 0 .. 9 ]> }
    token hexdigit      { <[ 0 .. 9 ]> }
}

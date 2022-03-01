use grust-model;

our role LitStr::Rules {
    token escapedchar { 
        || n
        || r
        || t
        || \\
        || \'
        || \"
        || x <hexdigit> ** 2
        || u <hexdigit> ** 4
        || U <hexdigit> ** 8
    }

    token strchar { 
        || <-[ \\ " ]>
        || '\\' <strescape>
    }

    token strescape { 
        || '\n'
        || <escapedchar>
    }

    token lit-str { 
        \" <strchar>* \"
    }

    token lit-char { 
        || \' <escapedchar> \'
        || \' . \'
    }
}

use Data::Dump::Tree;

use grust-model;

our class LitByte { 
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

our class LitByteStr { 
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

our class LitChar { 
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

our class LitStr { 
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

our role String::Rules {

    proto rule str { * }

    rule str:sym<a> { <lit-str> }
    rule str:sym<b> { <lit-str-raw> }
    rule str:sym<c> { <lit-byte-str> }
    rule str:sym<d> { <lit-byte-str-raw> }
}

our role String::Actions {

    method str:sym<a>($/) {
        make LitStr.new( value => ~$/)
    }

    method str:sym<b>($/) {
        make LitStr.new( value => ~$/)
    }

    method str:sym<c>($/) {
        make LitByteStr.new( value => ~$/)
    }

    method str:sym<d>($/) {
        make LitByteStr.new( value => ~$/)
    }
}

our class Integersuffix::Ul 
does IIntegersuffix {

    has Unsignedsuffix $.unsignedsuffix is required;
    has Longsuffix     $.longsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Integersuffix::Ull 
does IIntegersuffix {

    has Unsignedsuffix $.unsignedsuffix is required;
    has ILonglongsuffix $.longlongsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Integersuffix::Lu 
does IIntegersuffix {

    has Longsuffix     $.longsuffix is required;
    has Unsignedsuffix $.unsignedsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Integersuffix::Llu 
does IIntegersuffix {

    has ILonglongsuffix $.longsuffix is required;
    has Unsignedsuffix $.unsignedsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Unsignedsuffix { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Longsuffix { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Longlongsuffix::Ll 
does ILonglongsuffix {

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Longlongsuffix::LL 
does ILonglongsuffix {

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token udsuffix { <identifier> }
our class Udsuffix { 
    has Str $.value is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule cvqualifierseq { <cv-qualifier>+ }
our class Cvqualifierseq { 
    has ICvQualifier @.cv-qualifiers;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule cv-qualifier:sym<const> { <const> }
our class CvQualifier::Const does ICvQualifier {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule cv-qualifier:sym<volatile> { <volatile> }
our class CvQualifier::Volatile does ICvQualifier {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

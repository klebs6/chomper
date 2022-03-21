use Data::Dump::Tree;

use gcpp-roles;

# rule refqualifier:sym<and> { <and_> }
our class Refqualifier::And does IRefqualifier {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule refqualifier:sym<and-and> { <and-and> }
our class Refqualifier::AndAnd does IRefqualifier {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role Ref::Actions {

    # rule refqualifier:sym<and> { <and_> }
    method refqualifier:sym<and>($/) {
        make Refqualifier::And.new
    }

    # rule refqualifier:sym<and-and> { <and-and> } 
    method refqualifier:sym<and-and>($/) {
        make Refqualifier::AndAnd.new
    }
}

our role Ref::Rules {

    proto rule refqualifier { * }
    rule refqualifier:sym<and>     { <and_> }
    rule refqualifier:sym<and-and> { <and-and> }
}

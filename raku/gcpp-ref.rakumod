
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

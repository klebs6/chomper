unit module Chomper::Cpp::GcppRef;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

package RefQualifier is export {

    # rule refqualifier:sym<and> { <and_> }
    our class And does IRefQualifier {

        has $.text;

        method gist(:$treemark=False) {
            "&"
        }
    }

    # rule refqualifier:sym<and-and> { <and-and> }
    our class AndAnd does IRefQualifier {

        has $.text;

        method gist(:$treemark=False) {
            "&&"
        }
    }
}

package RefGrammar is export {

    our role Actions {

        # rule refqualifier:sym<and> { <and_> }
        method refqualifier:sym<and>($/) {
            make RefQualifier::And.new
        }

        # rule refqualifier:sym<and-and> { <and-and> } 
        method refqualifier:sym<and-and>($/) {
            make RefQualifier::AndAnd.new
        }
    }

    our role Rules {

        proto rule refqualifier { * }
        rule refqualifier:sym<and>     { <and_> }
        rule refqualifier:sym<and-and> { <and-and> }
    }
}

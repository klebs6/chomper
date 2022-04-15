unit module Chomper::Cpp::GcppCv;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule cvqualifierseq { <cv-qualifier>+ }
class Cvqualifierseq is export { 
    has ICvQualifier @.cv-qualifiers;

    has $.text;

    method gist(:$treemark=False) {
        @.cv_qualifiers>>.gist(:$treemark).join(" ")
    }
}

package CvQualifier is export {

    # rule cv-qualifier:sym<const> { <const> }
    our class Const_ does ICvQualifier {

        has $.text;

        method gist(:$treemark=False) {
            "const"
        }
    }

    # rule cv-qualifier:sym<volatile> { <volatile> }
    our class Volatile_ does ICvQualifier {

        has $.text;

        method gist(:$treemark=False) {
            "volatile"
        }
    }
}

package CVGrammar is export {

    our role Actions {

        # rule cvqualifierseq { <cv-qualifier>+ } 
        method cvqualifierseq($/) {
            make Cvqualifierseq.new(
                cv-qualifiers => $<cv-qualifier>>>.made,
                text          => ~$/,
            )
        }

        # rule cv-qualifier:sym<const> { <const> }
        method cv-qualifier:sym<const>($/) {
            make CvQualifier::Const_.new
        }

        # rule cv-qualifier:sym<volatile> { <volatile> } 
        method cv-qualifier:sym<volatile>($/) {
            make CvQualifier::Volatile_.new
        }
    }

    our role Rules {

        rule cvqualifierseq {
            <cv-qualifier>+
        }

        proto rule cv-qualifier { * }
        rule cv-qualifier:sym<const>    { <const> }
        rule cv-qualifier:sym<volatile> { <volatile> }
    }
}

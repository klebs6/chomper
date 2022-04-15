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

# rule cv-qualifier:sym<const> { <const> }
class CvQualifier::Const does ICvQualifier is export {

    has $.text;

    method gist(:$treemark=False) {
        "const"
    }
}

# rule cv-qualifier:sym<volatile> { <volatile> }
class CvQualifier::Volatile does ICvQualifier is export {

    has $.text;

    method gist(:$treemark=False) {
        "volatile"
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
            make CvQualifier::Const.new
        }

        # rule cv-qualifier:sym<volatile> { <volatile> } 
        method cv-qualifier:sym<volatile>($/) {
            make CvQualifier::Volatile.new
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

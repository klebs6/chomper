unit module Chomper::Cpp::GcppTranslationUnit;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppDeclaration;

# token translation-unit { <declarationseq>? $ }
class TranslationUnit is export { 
    has IDeclarationseq $.declarationseq;

    has $.text;

    method gist(:$treemark=False) {
        $.declarationseq.gist(:$treemark)
    }
}

package TranslationUnitGrammar is export {

    our role Actions {

        # token translation-unit { <declarationseq>? $ }
        method translation-unit($/) {
            make $<declarationseq>.made
        }
    }

    our role Rules {
        token translation-unit {
            <declarationseq>?  $
        }
    }
}

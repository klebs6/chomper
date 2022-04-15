unit module Chomper::Cpp::GcppTranslationUnit;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppDeclaration;

# token translation-unit { <declarationseq>? $ }
our class TranslationUnit { 
    has IDeclarationseq $.declarationseq;

    has $.text;

    method gist(:$treemark=False) {
        $.declarationseq.gist(:$treemark)
    }
}

our role TranslationUnit::Actions {

    # token translation-unit { <declarationseq>? $ }
    method translation-unit($/) {
        make $<declarationseq>.made
    }
}

our role TranslationUnit::Rules {
    token translation-unit {
        <declarationseq>?  $
    }
}
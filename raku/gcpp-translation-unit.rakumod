use Data::Dump::Tree;

use gcpp-roles;
use gcpp-declaration;

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

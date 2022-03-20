
# token translation-unit {         <declarationseq>?  $     }
our class TranslationUnit { 
    has IDeclarationseq $.declarationseq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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


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

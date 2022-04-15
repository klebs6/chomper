use Data::Dump::Tree;

our enum TranslationSource<LangCpp LangPython>;
our enum TranslationTarget<LangRust>;

my $DEBUG-TRANSLATE = True;

our sub debug(**@args --> True) {
    so $DEBUG-TRANSLATE and 
    say |@args;
}

our sub ddtbug(**@args --> True) {
    so $DEBUG-TRANSLATE and 
    ddt |@args;
}

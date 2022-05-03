use Data::Dump::Tree;

our $all-caps = token {
    ^ <[A..Z]>+ $
};

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

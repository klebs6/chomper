use rust-grammar;
use global-subparse;

#[this is sometimes useful in scripts]
our grammar Crate::Grammar 
does Rust::Grammar::Role
does GlobalSubparse {
    rule TOP {
        <crate>
    }
}

our class Crate::Grammar::Actions does Rust::Actions::Role {
    method TOP($/) {
        make $<crate>.made
    }
}

#"naked" implies that we strip the
#outer-attributes
our sub get-naked-crate-items-for-file($file) {

    my @crate-items 
    = get-crate-items(:$file);

    my @variants 
    = @crate-items>>.item-variant;

    say "returning crate items for $file";

    @variants[0]
}

#"naked" implies that we strip the
#outer-attributes
our sub get-crate-items(:$file) {

    my $text    = $file.IO.slurp;
    my $actions = Crate::Grammar::Actions.new;
    my $items   = Crate::Grammar.subparse($text, :$actions, :g);

    my @made = |$items>>.made;
    @made>>.crate-items
}

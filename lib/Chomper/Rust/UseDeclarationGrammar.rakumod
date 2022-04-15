unit module Chomper::Rust::GrustUseDeclarationGrammar;

use Chomper::Rust::RustGrammar;
use Chomper::GlobalSubparse;

#[this is sometimes useful in scripts]
our grammar UseDeclaration::Grammar 
does Rust::Grammar::Role
does GlobalSubparse {
    rule TOP {
        <use-declaration>
    }
}

our class UseDeclaration::Grammar::Actions does Rust::Actions::Role {
    method TOP($/) {
        make $<use-declaration>.made
    }
}

our sub get-use-declarations-for-file($file) {

    my $text    = $file.IO.slurp;
    my $actions = UseDeclaration::Grammar::Actions.new;
    my $items   = UseDeclaration::Grammar.subparse($text, :$actions, :g);

    |$items>>.made
}
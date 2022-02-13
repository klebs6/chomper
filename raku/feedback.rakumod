use Data::Dump::Tree;
use NativeCall;

use crates;
use cargo;
use wrap-body-todo;
use infer-rustdoc;
use todo-block;
use rust-ffi;
use cpp-translate;

our class Feedback::Workspace {

    has Str       $.file         is required;
    has Int       $.start        is required;
    has Int       $.end          is required;
    has Str       $.active-crate;
    has Str       $.file-text;
    has Str       $.visual-range;
    has Str       $.rust-fn-name;
    has LineRange $.rust-fn-range;
    has Str       $.rust-fn-text;
    has TodoBlock $.rust-todo-block;

    method get-rust-fn-text {

        my $b = $!rust-fn-range.begin - 1;
        my $e = $!rust-fn-range.end;

        my $rust-fn-text = $!file-text.lines[$b..$e];
        $rust-fn-text.join("\n")
    }

    method get-todo-block {
        my $idx       = $!rust-fn-text.index("todo!");
        my $until-end = $!rust-fn-text.substr($idx,*);

        TodoBlock::Grammar.subparse($until-end, actions => TodoBlock::Actions.new).made
    }

    submethod BUILD(:$file, :$start, :$end) {
        $!file            = $file;
        $!start           = $start;
        $!end             = $end;
        $!active-crate    = $!file.split("/")[0];
        generate-single-rustdoc-db($!active-crate);
        $!file-text       = $!file.IO.slurp;
        $!visual-range    = $*IN.slurp;
        $!rust-fn-name    = get-rust-fn($!active-crate, $!file, $!start, $!end);
        $!rust-fn-range   = get-rust-fn-range($!active-crate, $!file, $!start, $!end);
        $!rust-fn-text    = self.get-rust-fn-text();
        $!rust-todo-block = self.get-todo-block();
        $!file-text       = "";
    }
}

our sub pop-first-from-todo(:$file, :$start, :$end) {
    my $w = Feedback::Workspace.new(:$file, :$start, :$end);
    ddt $w;
    exit;
    my $body = $w.rust-todo-block.body;
    my $stmt = cpp-translate($body)<statementSeq><statement>.List[0];
    say "        " ~ ~$stmt;
    say "        " ~ wrap-body-todo($w.rust-todo-block.body.split(~$stmt)[1]);

    exit;
    #exit;
    #test-rustif($crate, $file, $start, $end);
}

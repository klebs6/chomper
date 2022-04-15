use Data::Dump::Tree;
use JSON::Class;
use NativeCall;
use String::CRC32;

use Chomper::Crates;
use Chomper::Cargo;
use Chomper::WrapBodyTodo;
use Chomper::Rust::InferRustdoc;
use Chomper::TodoBlock;
use Chomper::Rust::RustFfi;
use Chomper::Cpp::CppTranslate;

our $session-file = "./translate.session";

our class Session does JSON::Class {
    has $.active-checksum is rw;
}

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
    has Session   $.session;

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

    method maybe-resume-session {

        if $session-file.IO.e {

            $!session = Session.from-json($session-file.IO.slurp);

        } else {

            $!session = Session.new;
        }
    }

    method session-checksum-changed returns Bool {

        my $crc          = String::CRC32::crc32($!file-text);

        if $!session.active-checksum {

            my Bool $changed = so $!session.active-checksum ne $crc;

            if $changed {
                $!session.active-checksum = $crc;
            }

            $changed

        } else {

            $!session.active-checksum = $crc;

            True
        }
    }

    submethod BUILD(:$file, :$start, :$end) {
        $!file            = $file;
        $!start           = $start;
        $!end             = $end;
        $!active-crate    = $!file.split("/")[0];
        $!file-text       = $!file.IO.slurp;

        self.maybe-resume-session();

        if self.session-checksum-changed() {
            generate-single-rustdoc-db($!active-crate);
        }

        $!visual-range    = $*IN.slurp;
        $!rust-fn-name    = get-rust-fn($!active-crate, $!file, $!start, $!end);
        $!rust-fn-range   = get-rust-fn-range($!active-crate, $!file, $!start, $!end);
        $!rust-fn-text    = self.get-rust-fn-text();
        $!rust-todo-block = self.get-todo-block();
        $!file-text       = "";
    }

    method write-session {
        spurt $session-file, $!session.to-json()
    }

    method get-first-stmt {
        my $body = self.rust-todo-block.body;
        cpp-translate($body)<statementSeq><statement>.List[0]
    }
}

our sub pop-first-from-todo(:$file, :$start, :$end) {
    my $ws   = Feedback::Workspace.new(:$file, :$start, :$end);
    my $stmt = $ws.get-first-stmt();

    say "        " ~ ~$stmt;
    say "        " ~ wrap-body-todo($ws.rust-todo-block.body.split(~$stmt)[1]);
    $ws.write-session();
}

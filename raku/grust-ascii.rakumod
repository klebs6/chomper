our class Ascii {
    has Str $.value;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        ddt self;
        exit;
    }
}

our role Ascii::Rules {

    proto token ascii-escape { * }

    token ascii-escape:sym<x> { \\x <oct-digit> <hex-digit> }
    token ascii-escape:sym<n> { \\n }
    token ascii-escape:sym<r> { \\r }
    token ascii-escape:sym<t> { \\t }
    token ascii-escape:sym<s> { \\\\ }
    token ascii-escape:sym<0> { \\0 }

    token ascii-for-char {
        <any-ascii> <?{$/ !~~ /[\' | \\ | \n | \r | \t]/}>
    }

    token ascii-for-string {
        <any-ascii> <?{$/ !~~ /[\" | \\ | $Tokens::Rules::isolated-cr]/}>
    }

    token any-ascii {
        <:ASCII>
    }

    token ascii {
        <any-ascii>
    }
}

our role Ascii::Actions {
    method ascii($/) {
        make Ascii.new(
            value => $/.Str
        )
    }
}

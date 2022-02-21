unit package Rust::Lexer;

my $pushback-len = 4;

enum XState <
str
rawstr
rawstr_esc_begin
rawstr_esc_body
rawstr_esc_end
byte
bytestr
rawbytestr
rawbytestr_nohash
pound
shebang_or_attr
ltorchar
linecomment
doc_line
blockcomment
doc_block
suffix
INITIAL
>;

class XStateStack {
    has XState @.start-condition-stack = [];
    method peek(-->XState) {
        @!start-condition-stack[*-1] // Nil
    }
}

multi sub line-number(Int $idx, Str $target) {
    my $prev = $target.substr(0,$idx);
    $prev.lines.elems - 1
}

multi sub line-number(Match $match) {
    my $idx    = $match.from;
    my $target = $match.target;
    line-number($idx,$target)
}

grammar G {

    method begin(XState $.state) {

    }

    method push_state(XState $.state) {

    }

    method pop_state {

    }

    token TOP {
        :my XStateStack $*STATES = XStateStack.new;
        :my Int $*NUM-HASHES   = 0;
        :my Int $*END-HASHES   = 0;
        :my Int $*SAW-NON-HASH = 0;
    }

    token ident {
        <[a..z A..Z \x80..\xff _]> 
        <[a..z A..Z 0..9 \x80..\xff _]>*
    }

    token ws {
        <[\s\n\t\r]>+
    }

    token byte-order-mark {
        \xef \xbb \xbf {
            die "BOM found in invalid location" 
            unless line-number($/) eq 0
        }
    }

    #-----------------------------
    proto token lit-integer { * }

    token lit-integer:sym<hex> {
        0x <[0..9 a..f A..F _ ]>+
        {self.begin(XState::<suffix>)}
    }

    token lit-integer:sym<oct> {
        0o <[0..7 _]>+
        {self.begin(XState::<suffix>)}
    }

    token lit-integer:sym<bin> {
        0b <[01_]>+
        {self.begin(XState::<suffix>)}
    }

    token lit-integer:sym<int> {
        <[0..9]> <[0..9_]>*                                       
        {self.begin(XState::<suffix>)}
    }

    token lit-integer:sym<suf> {
        <[0..9]>
        <[0..9 _]>*
        \.
        [
            | \.
            | <[a..z A..Z]>
        ]
        { 
            #yyless(yyleng - 2); 
            self.begin(XState::<suffix>)
        }
    }

    #-----------------------------
    proto token lit-float { * }

    token lit-float:sym<a> {
        <[0..9]> 
        <[0..9 _]>* 
        \. 
        <[0..9 _]>*
        [
            <[eE]>
            <[\-\+]>?
            <[0..9 _]>+
        ]?
        {
            self.begin(XState::<suffix>)
        }
    }

    token lit-float:sym<b> {
        <[0..9]>
        <[0..9_]>*
        (\.<[0..9_]>*)?
        <[eE]>
        <[\-\+]>?
        <[0..9_]>+          
        {
            self.begin(XState::<suffix>)
        }
    }

}

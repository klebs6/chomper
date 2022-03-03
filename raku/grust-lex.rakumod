use grust-model;

enum XState <
str
rawstr
rawstr-esc-begin
rawstr-esc-body
rawstr-esc-end
byte
bytestr
rawbytestr
rawbytestr-nohash
pound
shebang-or-attr
ltorchar
linecomment
doc-line
blockcomment
doc-block
suffix
initial
>;

#--------------------------------------
=begin comment
\/\*(\*|\!)[^*]       { yy-push-state(INITIAL); yy-push-state(doc-block); yymore(); }
<doc-block>\/\*       { yy-push-state(doc-block); yymore(); }
<doc-block>\*\/       {
    yy-pop-state();
    if (yy-top-state() == doc-block) {
        yymore();
    } else {
        return ((yytext[2] == '!') ? INNER-DOC-COMMENT : OUTER-DOC-COMMENT);
    }
}
<doc-block>(.|\n)     { yymore(); }
=end comment
our role Lex::DocBlock {

    token doc-block {
        \/\*(\*|\!)<[^*]>
        {self.push-state("INITIAL"); self.push-state("doc-block");}
        [
            | <doc-block-open>
            | <doc-block-close>
            | <doc-block-continue>
        ]+
        <?{$*CURRENT-STATE eq "INITIAL"}>
    }

    token doc-block-open {
        <?{$*CURRENT-STATE eq "doc-block"}>
        \/\*
        {self.push-state("doc-block");}
    }

    token doc-block-close {
        <?{$*CURRENT-STATE eq doc-block}>
        \*\/
        {
            self.pop-state();
        }
    }

    token doc-block-continue {
        <?{$*CURRENT-STATE eq doc-block}>
        | .
        | \n
    }
}

#--------------------------------------
=begin comment
\/\/(\/|\!)           { BEGIN(doc-line); yymore(); }
<doc-line>\n          { BEGIN(INITIAL);
                        yyleng--;
                        yytext[yyleng] = 0;
                        return ((yytext[2] == '!') ? INNER-DOC-COMMENT : OUTER-DOC-COMMENT);
                      }
<doc-line>[^\n]*      { yymore(); }
=end comment
our role Lex::DocLine {

    token doc-line {
        \/\/[\/|\!]
        { self.push-state("doc-line") }
        [
            | <doc-line-terminator>
            | <doc-line-body>
        ]+
        <?{$*CURRENT-STATE eq "INITIAL"}>
    }

    token doc-line-terminator {
        <?{$*CURRENT-STATE eq "doc-line"}>
        \n
        { self.push-state("INITIAL") }
    }

    token doc-line-body {
        <?{$*CURRENT-STATE eq "doc-line"}>
        <[^\n]>*
    }
}

#--------------------------------------
=begin comment
\x27                                      { BEGIN(ltorchar); yymore(); }
<ltorchar>static                          { BEGIN(INITIAL); return STATIC-LIFETIME; }
<ltorchar>{ident}                         { BEGIN(INITIAL); return LIFETIME; }

<ltorchar>\\[nrt\\\x27\x220]\x27          { BEGIN(suffix); return LIT-CHAR; }
<ltorchar>\\x[0-9a-fA-F]{2}\x27           { BEGIN(suffix); return LIT-CHAR; }
<ltorchar>\\u\{([0-9a-fA-F]_*){1,6}\}\x27 { BEGIN(suffix); return LIT-CHAR; }
<ltorchar>.\x27                           { BEGIN(suffix); return LIT-CHAR; }
<ltorchar>[\x80-\xff]{2,4}\x27            { BEGIN(suffix); return LIT-CHAR; }
=end comment
our role Lex::LifetimeOrChar {

    proto token lifetime-or-char { * }

    token lifetime-or-char-begin {
        \x27 { self.begin(XState::ltorchar) }
    }

    token lifetime-or-char:sym<static> {
        <lifetime-or-char-begin>
        static
    }

    token lifetime-or-char:sym<lt> {
        <lifetime-or-char-begin>
        <identifier>
    }

    token lifetime-or-char:sym<char> {
        <lifetime-or-char-begin>
        [
            \\<[nrt\\\x27\x220]> \x27
            \\x<[0..9 a..f A..F]> ** {2} \x27           
            \\u\{(<[0..9 a..f A..F]>_*) ** {1,6}\} \x27 
            .\x27                           
            <[\x80..\xff]> ** {2,4} \x27           
        ]
        {self.begin(XState::suffix)}
    }
}

#--------------------------------------
=begin comment
b\x22                                     { BEGIN(bytestr); yymore(); }
<bytestr>\x22                             { BEGIN(suffix); return LIT-BYTE-STR; }
<bytestr>\\[n\nrt\\\x27\x220]             { yymore(); }
<bytestr>\\x[0-9a-fA-F]{2}                { yymore(); }
<bytestr>\\u\{([0-9a-fA-F]_*){1,6}\}      { yymore(); }
<bytestr>\\[^n\nrt\\\x27\x220]            { return -1; }
<bytestr>(.|\n)                           { yymore(); }
=end comment
our role Lex::ByteStr {

    token byte-str-begin {
        b\x22
    }

    token byte-str-end {
        \x22 <suffix>?
    }

    token byte-str-continue {
        | \\[n\nrt\\\x27\x220]
        | \\x<[0..9 a..f A..F]> ** {2}
        | \\u\{(<[0..9 a..f A..F]>_*) ** {1,6}\}
        | (.|\n)
    }

    token byte-str {
        <byte-str-begin> 
        <byte-str-continue>* 
        <byte-str-end>
    }

    token lit-byte-str { <byte-str>
    }
}

#--------------------------------------
=begin comment
br\x22                                    { BEGIN(rawbytestr-nohash); yymore(); }
<rawbytestr-nohash>\x22                   { BEGIN(suffix); return LIT-BYTE-STR-RAW; }
<rawbytestr-nohash>(.|\n)                 { yymore(); }
=end comment
our role Lex::RawByteStrNoHash {

    token raw-byte-str-no-hash-begin {
        br\x22
    }

    token raw-byte-str-no-hash-end {
        \x22 <suffix>?
    }

    token raw-byte-str-no-hash-continue {
        | .
        | \n
    }

    token raw-byte-str-no-hash {
        <raw-byte-str-no-hash-begin>
        <raw-byte-str-no-hash-continue>*
        <raw-byte-str-no-hash-end>
    }
    token lit-byte-str-raw { <raw-byte-str-no-hash>
    }
}

#--------------------------------------
=begin comment
br/# {
    BEGIN(rawbytestr);
    yymore();
    num-hashes = 0;
    saw-non-hash = 0;
    end-hashes = 0;
}

<rawbytestr># {
    if (!saw-non-hash) {
        num-hashes++;
    } elsif (end-hashes != 0) {
        end-hashes++;
        if (end-hashes == num-hashes) {
            BEGIN(INITIAL);
            return LIT-BYTE-STR-RAW;
        }
    }
    yymore();
}

<rawbytestr>\x22# {
    end-hashes = 1;
    if (end-hashes == num-hashes) {
        BEGIN(INITIAL);
        return LIT-BYTE-STR-RAW;
    }
    yymore();
}

<rawbytestr>(.|\n) {
    if (!saw-non-hash) {
        saw-non-hash = 1;
    }
    if (end-hashes != 0) {
        end-hashes = 0;
    }
    yymore();
}

=end comment
our role Lex::RawByteStr {

    token raw-byte-str-begin {
        :my $*RAW-BYTE-STR-EXIT = False;
        br\# 
        { 
            self.begin(XState::<rawbytestr>); 
            $*NUM-HASHES        = 0;
            $*SAW-NON-HASH      = 0;
            $*END-HASHES        = 0;
        }
    }

    token raw-byte-str-add-hash {
        <?{!$*RAW-BYTE-STR-EXIT}>
        \#
        {
            if !$*SAW-NON-HASH {
                $*NUM-HASHES++;
            } elsif $*END-HASHES != 0 {
                $*END-HASHES++;
                if $*END-HASHES eq $*NUM-HASHES {
                    self.begin(XState::<initial>);
                    $*RAW-BYTE-STR-EXIT = True;
                }
            }
        }
    }

    token raw-byte-str-close-hash {
        <?{!$*RAW-BYTE-STR-EXIT}>
        \x22\#
        {
            $*END-HASHES = 1;
            if $*END-HASHES eq $*NUM-HASHES {
                self.begin(XState::<initial>);
                $*RAW-BYTE-STR-EXIT = True;
            }
        }
    }

    token raw-byte-str-inner {
        <?{!$*RAW-BYTE-STR-EXIT}>
        [
            | .
            | \n
        ]
        {
            if !$*SAW-NON-HASH {
                $*SAW-NON-HASH = 1;
            }

            if $*END-HASHES != 0 {
                $*END-HASHES = 0;
            }
        }
    }

    token raw-byte-str-end {
        <?{$*RAW-BYTE-STR-EXIT}>
    }

    token raw-byte-str-continue {
        | <raw-byte-str-add-hash>
        | <raw-byte-str-close-hash>
        | <raw-byte-str-inner>
    }

    token raw-byte-str {
        <raw-byte-str-begin> 
        <raw-byte-str-continue>* 
        <raw-byte-str-end>
    }
}

#--------------------------------------
=begin comment
b\x27                           { BEGIN(byte); yymore(); }
<byte>\\[nrt\\\x27\x220]\x27    { BEGIN(INITIAL); return LIT-BYTE; }
<byte>\\x[0-9a-fA-F]{2}\x27     { BEGIN(INITIAL); return LIT-BYTE; }
<byte>\\u([0-9a-fA-F]_*){4}\x27 { BEGIN(INITIAL); return LIT-BYTE; }
<byte>\\U([0-9a-fA-F]_*){8}\x27 { BEGIN(INITIAL); return LIT-BYTE; }
<byte>.\x27                     { BEGIN(INITIAL); return LIT-BYTE; }
=end comment
our role Lex::Byte {

    token byte-begin {
        b\x27
    }

    token byte-end {
        | \\<[nrt\\\x27\x220]>\x27    
        | \\x<[0..9 a..f A..F]>
        | \\u(<[0..9 a..f A..F]>_*)
        | \\U(<[0..9 a..f A..F]>_*)
        | .\x27                     
    }

    token byte {
        <byte-begin><byte-end>
    }

    token lit-byte { <byte> }
}

#--------------------------------------
=begin comment
r\x22           { BEGIN(rawstr); yymore(); }
<rawstr>\x22    { BEGIN(suffix); return LIT-STR-RAW; }
<rawstr>(.|\n)  { yymore(); }
=end comment
our role Lex::RawStr {
    token raw-str-begin {
        r\x22
    }

    token raw-str-end {
        \x22 <suffix>?
    }

    token raw-str-continue {
        | .
        | \n
    }

    token raw-str {
        <raw-str-begin> 
        <raw-str-continue>* 
        <raw-str-end>
    }

    token lit-str-raw { <raw-str>
    }
}

#--------------------------------------
=begin comment
r/#             {
    BEGIN(rawstr-esc-begin);
    yymore();
    num-hashes = 0;
    saw-non-hash = 0;
    end-hashes = 0;
}

<rawstr-esc-begin># {
    num-hashes++;
    yymore();
}

<rawstr-esc-begin>\x22 {
    BEGIN(rawstr-esc-body);
    yymore();
}

<rawstr-esc-begin>(.|\n) { return -1; }
<rawstr-esc-body>\x22/# {
    BEGIN(rawstr-esc-end);
    yymore();
}

<rawstr-esc-body>(.|\n) {
    yymore();
}

<rawstr-esc-end># {
    end-hashes++;
    if (end-hashes == num-hashes) {
        BEGIN(INITIAL);
        return LIT-STR-RAW;
    }
    yymore();
}

<rawstr-esc-end>[^#] {
    end-hashes = 0;
    BEGIN(rawstr-esc-body);
    yymore();
}
=end comment
our role Lex::RawStrEsc {

    token raw-str-esc-end {
        'TODO'

    }
}

#--------------------------------------
=begin comment
\x22                             { BEGIN(str); yymore(); }
<str>\x22                        { BEGIN(suffix); return LIT-STR; }
<str>\\[n\nr\rt\\\x27\x220]      { yymore(); }
<str>\\x[0-9a-fA-F]{2}           { yymore(); }
<str>\\u\{([0-9a-fA-F]_*){1,6}\} { yymore(); }
<str>\\[^n\nrt\\\x27\x220]       { return -1; }
<str>(.|\n)                      { yymore(); }
=end comment
our role Lex::Str_ {
    token rust-string {
        'TODO'
    }
}


#--------------------------------------
=begin comment
<suffix>{ident}       { BEGIN(INITIAL); }
<suffix>(.|\n)        { yyless(0); BEGIN(INITIAL); }
=end comment
our role Lex::Suffix {

    token suffix {
        | <identifier> 
        | .
        | \n
    }
}


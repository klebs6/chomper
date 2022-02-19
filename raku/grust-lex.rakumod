
#--------------------------------------
=begin comment
\/\*(\*|\!)[^*]       { yy_push_state(INITIAL); yy_push_state(doc_block); yymore(); }
<doc_block>\/\*       { yy_push_state(doc_block); yymore(); }
<doc_block>\*\/       {
    yy_pop_state();
    if (yy_top_state() == doc_block) {
        yymore();
    } else {
        return ((yytext[2] == '!') ? INNER_DOC_COMMENT : OUTER_DOC_COMMENT);
    }
}
<doc_block>(.|\n)     { yymore(); }
=end comment
our role DocBlock {

    token doc-block {
        \/\*(\*|\!)<[^*]>
        {self.push-state("INITIAL"); self.push-state("doc_block");}
        [
            | <doc-block-open>
            | <doc-block-close>
            | <doc-block-continue>
        ]+
        <?{$*CURRENT-STATE eq "INITIAL"}>
    }

    token doc-block-open {
        <?{$*CURRENT-STATE eq "doc_block"}>
        \/\*
        {self.push-state("doc_block");}
    }

    token doc-block-close {
        <?{$*CURRENT-STATE eq doc_block}>
        \*\/
        {
            self.pop-state();
        }
    }

    token doc-block-continue {
        <?{$*CURRENT-STATE eq doc_block}>
        | .
        | \n
    }
}

#--------------------------------------
=begin comment
\/\/(\/|\!)           { BEGIN(doc_line); yymore(); }
<doc_line>\n          { BEGIN(INITIAL);
                        yyleng--;
                        yytext[yyleng] = 0;
                        return ((yytext[2] == '!') ? INNER_DOC_COMMENT : OUTER_DOC_COMMENT);
                      }
<doc_line>[^\n]*      { yymore(); }
=end comment
our role DocLine {

    token doc-line {
        \/\/[\/|\!]
        { self.push-state("doc_line") }
        [
            | <doc-line-terminator>
            | <doc-line-body>
        ]+
        <?{$*CURRENT-STATE eq "INITIAL"}>
    }

    token doc-line-terminator {
        <?{$*CURRENT-STATE eq "doc_line"}>
        \n
        { self.push-state("INITIAL") }
    }

    token doc-line-body {
        <?{$*CURRENT-STATE eq "doc_line"}>
        <[^\n]>*
    }
}

#--------------------------------------
=begin comment
\x27                                      { BEGIN(ltorchar); yymore(); }
<ltorchar>static                          { BEGIN(INITIAL); return STATIC_LIFETIME; }
<ltorchar>{ident}                         { BEGIN(INITIAL); return LIFETIME; }

<ltorchar>\\[nrt\\\x27\x220]\x27          { BEGIN(suffix); return LIT_CHAR; }
<ltorchar>\\x[0-9a-fA-F]{2}\x27           { BEGIN(suffix); return LIT_CHAR; }
<ltorchar>\\u\{([0-9a-fA-F]_*){1,6}\}\x27 { BEGIN(suffix); return LIT_CHAR; }
<ltorchar>.\x27                           { BEGIN(suffix); return LIT_CHAR; }
<ltorchar>[\x80-\xff]{2,4}\x27            { BEGIN(suffix); return LIT_CHAR; }
=end comment
our role LifetimeOrChar {

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
            \\<[nrt\\\x27\x220]>\x27          
            \\x<[0..9 a..f A..F]>{2}\x27           
            \\u\{(<[0..9 a..f A..F]>_*){1,6}\}\x27 
            .\x27                           
            <[\x80..\xff]>{2,4}\x27           
        ]
        {self.begin(XState::suffix)}
    }
}

#--------------------------------------
=begin comment
b\x22                                     { BEGIN(bytestr); yymore(); }
<bytestr>\x22                             { BEGIN(suffix); return LIT_BYTE_STR; }
<bytestr>\\[n\nrt\\\x27\x220]             { yymore(); }
<bytestr>\\x[0-9a-fA-F]{2}                { yymore(); }
<bytestr>\\u\{([0-9a-fA-F]_*){1,6}\}      { yymore(); }
<bytestr>\\[^n\nrt\\\x27\x220]            { return -1; }
<bytestr>(.|\n)                           { yymore(); }
=end comment
our role ByteStr {

    token byte-str-begin {
        b\x22
    }

    token byte-str-end {
        \x22 <suffix>?
    }

    token byte-str-continue {
        | \\[n\nrt\\\x27\x220]
        | \\x<[0..9 a..f A..F]>{2}
        | \\u\{(<[0..9 a..f A..F]>_*){1,6}\}
        | (.|\n)
    }

    token byte-str {
        <byte-str-begin> 
        <byte-str-continue>* 
        <byte-str-end>
    }
}

#--------------------------------------
=begin comment
br\x22                                    { BEGIN(rawbytestr_nohash); yymore(); }
<rawbytestr_nohash>\x22                   { BEGIN(suffix); return LIT_BYTE_STR_RAW; }
<rawbytestr_nohash>(.|\n)                 { yymore(); }
=end comment
our role RawByteStrNoHash {

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
}

#--------------------------------------
=begin comment
br/# {
    BEGIN(rawbytestr);
    yymore();
    num_hashes = 0;
    saw_non_hash = 0;
    end_hashes = 0;
}

<rawbytestr># {
    if (!saw_non_hash) {
        num_hashes++;
    } else if (end_hashes != 0) {
        end_hashes++;
        if (end_hashes == num_hashes) {
            BEGIN(INITIAL);
            return LIT_BYTE_STR_RAW;
        }
    }
    yymore();
}

<rawbytestr>\x22# {
    end_hashes = 1;
    if (end_hashes == num_hashes) {
        BEGIN(INITIAL);
        return LIT_BYTE_STR_RAW;
    }
    yymore();
}

<rawbytestr>(.|\n) {
    if (!saw_non_hash) {
        saw_non_hash = 1;
    }
    if (end_hashes != 0) {
        end_hashes = 0;
    }
    yymore();
}

=end comment
our role RawByteStr {

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
            } else if $*END-HASHES != 0 {
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
            $*END-HASHES = 1
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
<byte>\\[nrt\\\x27\x220]\x27    { BEGIN(INITIAL); return LIT_BYTE; }
<byte>\\x[0-9a-fA-F]{2}\x27     { BEGIN(INITIAL); return LIT_BYTE; }
<byte>\\u([0-9a-fA-F]_*){4}\x27 { BEGIN(INITIAL); return LIT_BYTE; }
<byte>\\U([0-9a-fA-F]_*){8}\x27 { BEGIN(INITIAL); return LIT_BYTE; }
<byte>.\x27                     { BEGIN(INITIAL); return LIT_BYTE; }
=end comment
our role Byte {

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
}

#--------------------------------------
=begin comment
r\x22           { BEGIN(rawstr); yymore(); }
<rawstr>\x22    { BEGIN(suffix); return LIT_STR_RAW; }
<rawstr>(.|\n)  { yymore(); }
=end comment
our role RawStr {
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
}

#--------------------------------------
=begin comment
# { BEGIN(pound); yymore(); }
<pound>\! { BEGIN(shebang_or_attr); yymore(); }
<shebang_or_attr>\[ {
  BEGIN(INITIAL);
  yyless(2);
  return SHEBANG;
}
<shebang_or_attr>[^\[\n]*\n {
  // Since the \n was eaten as part of the token, yylineno will have
  // been incremented to the value 2 if the shebang was on the first
  // line. This yyless undoes that, setting yylineno back to 1.
  yyless(yyleng - 1);
  if (yyget_lineno() == 1) {
    BEGIN(INITIAL);
    return SHEBANG_LINE;
  } else {
    BEGIN(INITIAL);
    yyless(2);
    return SHEBANG;
  }
}
<pound>. { BEGIN(INITIAL); yyless(1); return '#'; }
=end comment
our role Pound {
    token pound {

    }
}

#--------------------------------------
=begin comment
r/#             {
    BEGIN(rawstr_esc_begin);
    yymore();
    num_hashes = 0;
    saw_non_hash = 0;
    end_hashes = 0;
}

<rawstr_esc_begin># {
    num_hashes++;
    yymore();
}

<rawstr_esc_begin>\x22 {
    BEGIN(rawstr_esc_body);
    yymore();
}

<rawstr_esc_begin>(.|\n) { return -1; }
<rawstr_esc_body>\x22/# {
    BEGIN(rawstr_esc_end);
    yymore();
}

<rawstr_esc_body>(.|\n) {
    yymore();
}

<rawstr_esc_end># {
    end_hashes++;
    if (end_hashes == num_hashes) {
        BEGIN(INITIAL);
        return LIT_STR_RAW;
    }
    yymore();
}

<rawstr_esc_end>[^#] {
    end_hashes = 0;
    BEGIN(rawstr_esc_body);
    yymore();
}
=end comment
our role RawStrEsc {

    token raw-str-esc-end {

    }
}

#--------------------------------------
=begin comment
\x22                             { BEGIN(str); yymore(); }
<str>\x22                        { BEGIN(suffix); return LIT_STR; }
<str>\\[n\nr\rt\\\x27\x220]      { yymore(); }
<str>\\x[0-9a-fA-F]{2}           { yymore(); }
<str>\\u\{([0-9a-fA-F]_*){1,6}\} { yymore(); }
<str>\\[^n\nrt\\\x27\x220]       { return -1; }
<str>(.|\n)                      { yymore(); }
=end comment
our role Str_ {
    token rust-string {

    }
}

#--------------------------------------
=begin comment
\/\/|\/\/\/\/         { BEGIN(linecomment); }
<linecomment>\n       { BEGIN(INITIAL); }
<linecomment>[^\n]*   { }
=end comment
our role LineComment {

    token line-comment-begin {
        || \/\/\/
        || \/\/
    }

    token line-comment-end {
        \n
    }

    token line-comment-continue {
        <[^\n]>*
    }

    token line-comment {
        <line-comment-begin>
        <line-comment-continue>*
        <line-comment-end>
    }
}

#--------------------------------------
=begin comment
<suffix>{ident}       { BEGIN(INITIAL); }
<suffix>(.|\n)        { yyless(0); BEGIN(INITIAL); }
=end comment
our role Suffix {

    token suffix {
        | <identifier> 
        | .
        | \n) 
    }
}

#--------------------------------------
=begin comment
\/\*                  { yy_push_state(blockcomment); }
<blockcomment>\/\*    { yy_push_state(blockcomment); }
<blockcomment>\*\/    { yy_pop_state(); }
<blockcomment>(.|\n)  { }
=end comment
our role BlockComment {

    token block-comment-begin {
        \/\*
        { 
            self.push-state(XState::<initial>)
            self.push-state(XState::<blockcomment>) 
        }
    }

    token block-comment-continue {
        | <block-comment-push>
        | <block-comment-pop>
        | <block-comment-inner>
    }

    token block-comment-push {
        \/\*
        { self.push-state(XState::<blockcomment>) }
    }

    token block-comment-pop {
        \*\/
        { self.pop-state() }
    }

    token block-comment-inner {
        | .
        | \n
    }

    token block-comment-end {
        <?{self.peek-state() eq XState::<initial> }>
    }

    token block-comment {
        <block-comment-begin> 
        <block-comment-continue>* 
        <block-comment-end>
    }
}

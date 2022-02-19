unit package Rust::Lexer;

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

    token TOP {
        :my XStateStack $*STATES = XStateStack.new;
        :my Int $*NUM-HASHES   = 0;
        :my Int $*END-HASHES   = 0;
        :my Int $*SAW-NON-HASH = 0;
    }

    token ident {
        <[a..z A..Z \x80..\xff _]> <[a..z A..Z 0..9 \x80..\xff _]>*
    }

    token ws {
        <[\s\n\t\r]>+
    }

    token byte-order-mark {
        \xef \xbb \xbf {
            die "BOM found in invalid location" unless line-number($/) eq 0
        }
    }

    #-----------------------------
    proto token lit-integer { * }

    token lit-integer:sym<hex> {
        0x <[0..9 a..f A..F _ ]>+
        {self.begin(XState::suffix)}
    }

    token lit-integer:sym<oct> {
        0o <[0..7 _]>+
        {self.begin(XState::suffix)}
    }

    token lit-integer:sym<bin> {
        0b <[01_]>+
        {self.begin(XState::suffix)}
    }

    token lit-integer:sym<int> {
        <[0..9]> <[0..9_]>*                                       
        {self.begin(XState::suffix)}
    }

    token lit-integer:sym<suf> {
    #[0-9][0-9_]*\.(\.|[a-zA-Z])    { yyless(yyleng - 2); BEGIN(suffix); return LIT_INTEGER; }

    }

    #-----------------------------
    proto token lit-float { * }

    token lit-float:sym<a> {

    }

    token lit-float:sym<b> {

    }

    #-----------------------------
    token semicolon { ';'    } 
    token comma     { ','    } 
    token dotdotdot { \.\.\. } 
    token dotdot    { \.\.   } 
    token dot       { \.     } 
    token lparen    { '('    } 
    token rparen    { ')'    } 
    token lbrace    { '{'    } 
    token rbrace    { '}'    } 
    token lbrack    { '['    } 
    token rbrack    { ']'    } 
    token at        { '@'    } 
    token tilde     { '~'    } 
    token mod-sep   { '::'   } 
    token colon     { ':'    } 
    token dollar    { \$     } 
    token question  { \?     } 
    token eqeq      { '=='   } 
    token fat-arrow { '=>'   } 
    token equals    { '='    } 
    token n-equals  { '!='   } 
    token bang      { '!'    } 
    token l-equals  { '<='   } 
    token shl       { '<<'   } 
    token shr       { '>>'   } 
    token shl-eq    { '<<='  } 
    token shr-eq    { '>>='  } 
    token less      { '<'  } 
    token greater   { '>'  } 
    token g-equals  { '>='  } 

    #-------------------------------
    token UNDERSCORE { _ }
    token ABSTRACT   { abstract }
    token ALIGNOF    { alignof }
    token AS         { as }
    token BECOME     { become }
    token BOX        { box }
    token BREAK      { break }
    token CATCH_     { catch }
    token CONST      { const }
    token CONTINUE   { continue }
    token CRATE      { crate }
    token DEFAULT    { default }
    token DO         { do }
    token ELSE       { else }
    token ENUM       { enum }
    token EXTERN     { extern }
    token FALSE      { false }
    token FINAL      { final }
    token FN         { fn }
    token FOR        { for }
    token IF         { if }
    token IMPL       { impl }
    token IN         { in }
    token LET        { let }
    token LOOP       { loop }
    token MACRO      { macro }
    token MATCH      { match }
    token MOD        { mod }
    token MOVE       { move }
    token MUT        { mut }
    token OFFSETOF   { offsetof }
    token OVERRIDE   { override }
    token PRIV       { priv }
    token PROC       { proc }
    token PURE       { pure }
    token PUB        { pub }
    token REF        { ref }
    token RETURN     { return }
    token SELF       { self }
    token SIZEOF     { sizeof }
    token STATIC     { static }
    token STRUCT     { struct }
    token SUPER      { super }
    token TRAIT      { trait }
    token TRUE       { true }
    token TYPE       { type }
    token TYPEOF     { typeof }
    token UNION      { union }
    token UNSAFE     { unsafe }
    token UNSIZED    { unsized }
    token USE        { use }
    token VIRTUAL    { virtual }
    token WHERE      { where }
    token WHILE      { while }
    token YIELD      { yield }
}

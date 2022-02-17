use cpp-model;

our class CPP14Parser::Actions {
    method semi($/) {
        make $<comment>.made
    }

    # token integer-literal:sym<dec> { <decimal-literal> <integersuffix>? }
    method integer-literal:sym<dec>($/) {
        make IntegerLiteral::Dec.new(
            decimal-literal => $<decimal-literal>.made,
            integersuffix   => $<integersuffix>.made,
        )
    }

    # token integer-literal:sym<oct> { <octal-literal> <integersuffix>? }
    method integer-literal:sym<oct>($/) {
        make IntegerLiteral::Oct.new(
            octal-literal => $<octal-literal>.made,
            integersuffix => $<integersuffix>.made,
        )
    }

    # token integer-literal:sym<hex> { <hexadecimal-literal> <integersuffix>? }
    method integer-literal:sym<hex>($/) {
        make IntegerLiteral::Hex.new(
            hexadecimal-literal => $<hexadecimal-literal>.made,
            integersuffix       => $<integersuffix>.made,
        )
    }

    # token integer-literal:sym<bin> { <binary-literal> <integersuffix>? } 
    method integer-literal:sym<bin>($/) {
        make IntegerLiteral::Bin.new(
            binary-literal => $<binary-literal>.made,
            integersuffix  => $<integersuffix>.made,
        )
    }

    # token character-literal-prefix:sym<u> { 'u' }
    method character-literal-prefix:sym<u>($/) {
        make 'u'
    }

    # token character-literal-prefix:sym<U> { 'U' }
    method character-literal-prefix:sym<U>($/) {
        make 'U'
    }

    # token character-literal-prefix:sym<L> { 'L' }
    method character-literal-prefix:sym<L>($/) {
        make 'L'
    }

    # token character-literal { <character-literal-prefix>? '\'' <cchar>+ '\'' } 
    method character-literal($/) {
        make CharacterLiteral.new(
            character-literal-prefix => $<character-literal-prefix>.made,
            cchar                    => $<cchar>>>.made,
        )
    }

    # token floating-literal:sym<frac> { <fractionalconstant> <exponentpart>? <floatingsuffix>? }
    method floating-literal:sym<frac>($/) {
        make FloatingLiteral::Frac.new(
            fractionalconstant => $<fractionalconstant>.made,
            exponentpart       => $<exponentpart>.made,
            floatingsuffix     => $<floatingsuffix>.made,
        )
    }

    # token floating-literal:sym<digit> { <digitsequence> <exponentpart> <floatingsuffix>? } 
    method floating-literal:sym<digit>($/) {
        make FloatingLiteral::Digit.new(
            digitsequence  => $<digitsequence>.made,
            exponentpart   => $<exponentpart>.made,
            floatingsuffix => $<floatingsuffix>.made,
        )
    }

    # token string-literal-item { <encodingprefix>? [ || <rawstring> || '"' <schar>* '"' ] }
    method string-literal-item($/) {
        make ~$/;
    }

    # token string-literal { <string-literal-item> [<.ws> <string-literal-item>]* } 
    method string-literal($/) {
        my @items = $<string-literal-item>>>.made;

        make StringLiteral.new(
            value => @items.join("\n"),
        )
    }

    # token boolean-literal:sym<f> { <false_> }
    method boolean-literal:sym<f>($/) {
        make BooleanLiteral::F.new
    }

    # token boolean-literal:sym<t> { <true_> }
    method boolean-literal:sym<t>($/) {
        make BooleanLiteral::T.new
    }

    # token pointer-literal { <nullptr> } 
    method pointer-literal($/) {
        make PointerLiteral.new
    }

    # token user-defined-literal:sym<int> { <user-defined-integer-literal> }
    method user-defined-literal:sym<int>($/) {
        make $<user-defined-integer-literal>.made
    }

    # token user-defined-literal:sym<float> { <user-defined-floating-literal> }
    method user-defined-literal:sym<float>($/) {
        make $<user-defined-floating-literal>.made
    }

    # token user-defined-literal:sym<str> { <user-defined-string-literal> }
    method user-defined-literal:sym<str>($/) {
        make $<user-defined-string-literal>.made
    }

    # token user-defined-literal:sym<char> { <user-defined-character-literal> }
    method user-defined-literal:sym<char>($/) {
        make $<user-defined-character-literal>.made
    }

    # token multi-line-macro { '
    method multi-line-macro($/) {
        make ~$/
    }

    # token directive { '
    method directive($/) {
        make ~$/
    }

    # token hexquad { <hexadecimaldigit> ** 4 }
    method hexquad($/) {
        make Hexquad.new(
            hexadecimaldigit => $<hexadecimaldigit>>>.made,
        )
    }

    # token universalcharactername:sym<one> { '\\u' <hexquad> }
    method universalcharactername:sym<one>($/) {
        make Universalcharactername.new(
            first => $<first>.made,
        )
    }

    # token universalcharactername:sym<two> { '\\U' <hexquad> <hexquad> } 
    method universalcharactername:sym<two>($/) {
        make Universalcharactername.new(
            first => $<first>.made,
            second => $<second>.made,
        )
    }

    # token identifier-start:sym<nondigit> { <nondigit> }
    method identifier-start:sym<nondigit>($/) {
        make $<nondigit>.made
    }

    # token identifier-start:sym<ucn> { <universalcharactername> } 
    method identifier-start:sym<ucn>($/) {
        make $<universalcharactername>.made
    }

    # token identifier-continue:sym<digit> { <digit> }
    method identifier-continue:sym<digit>($/) {
        make $<digit>.made
    }

    # token identifier-continue:sym<nondigit> { <nondigit> }
    method identifier-continue:sym<nondigit>($/) {
        make $<nondigit>.made
    }

    # token identifier-continue:sym<ucn> { <universalcharactername> }
    method identifier-continue:sym<ucn>($/) {
        make $<universalcharactername>.made
    }

    # token identifier { <identifier-start> <identifier-continue>* }
    method identifier($/) {
        make Identifier.new(
            value => ~$/,
        )
    }

    # token nondigit { <[ a .. z A .. Z _]> }
    method nondigit($/) {
        make Nondigit.new(
            value => ~$/,
        )
    }

    # token digit { <[ 0 .. 9 ]> }
    method digit($/) {
        make Digit.new(
            value => ~$/,
        )
    }

    # token decimal-literal { <nonzerodigit> [ '\''? <digit>]* }
    method decimal-literal($/) {
        make DecimalLiteral.new(
            value => ~$/,
        )
    }

    # token octal-literal { '0' [ '\''? <octaldigit>]* }
    method octal-literal($/) {
        make OctalLiteral.new(
            value => ~$/,
        )
    }

    # token hexadecimal-literal { [ '0x' || '0X' ] <hexadecimaldigit> [ '\''? <hexadecimaldigit> ]* }
    method hexadecimal-literal($/) {
        make HexadecimalLiteral.new(
            value => ~$/,
        )
    }

    # token binary-literal { [ '0b' || '0B' ] <binarydigit> [ '\''? <binarydigit> ]* }
    method binary-literal($/) {
        make BinaryLiteral.new(
            value => ~$/,
        )
    }

    # token nonzerodigit { <[ 1 .. 9 ]> }
    method nonzerodigit($/) {
        make Nonzerodigit.new(
            value => ~$/,
        )
    }

    # token octaldigit { <[ 0 .. 7 ]> }
    method octaldigit($/) {
        make Octaldigit.new(
            value => ~$/,
        )
    }

    # token hexadecimaldigit { <[ 0 .. 9 ]> }
    method hexadecimaldigit($/) {
        make Hexadecimaldigit.new(
            value => ~$/,
        )
    }

    # token binarydigit { <[ 0 1 ]> } 
    method binarydigit($/) {
        make Binarydigit.new(
            value => ~$/,
        )
    }

    # token integersuffix:sym<ul> { <unsignedsuffix> <longsuffix>? }
    method integersuffix:sym<ul>($/) {
        make Integersuffix::Ul.new(
            unsignedsuffix => $<unsignedsuffix>.made,
            longsuffix     => $<longsuffix>.made,
        )
    }

    # token integersuffix:sym<ull> { <unsignedsuffix> <longlongsuffix>? }
    method integersuffix:sym<ull>($/) {
        make Integersuffix::Ull.new(
            unsignedsuffix => $<unsignedsuffix>.made,
            longlongsuffix => $<longlongsuffix>.made,
        )
    }

    # token integersuffix:sym<lu> { <longsuffix> <unsignedsuffix>? }
    method integersuffix:sym<lu>($/) {
        make Integersuffix::Lu.new(
            longsuffix     => $<longsuffix>.made,
            unsignedsuffix => $<unsignedsuffix>.made,
        )
    }

    # token integersuffix:sym<llu> { <longlongsuffix> <unsignedsuffix>? } 
    method integersuffix:sym<llu>($/) {
        make Integersuffix::Llu.new(
            longsuffix     => $<longsuffix>.made,
            unsignedsuffix => $<unsignedsuffix>.made,
        )
    }

    # token unsignedsuffix { <[ u U ]> }
    method unsignedsuffix($/) {
        make Unsignedsuffix.new
    }

    # token longsuffix { <[ l L ]> } 
    method longsuffix($/) {
        make Longsuffix.new
    }

    # token longlongsuffix:sym<ll> { 'll' }
    method longlongsuffix:sym<ll>($/) {
        make Longlongsuffix::Ll.new
    }

    # token longlongsuffix:sym<LL> { 'LL' } 
    method longlongsuffix:sym<LL>($/) {
        make Longlongsuffix::LL.new
    }

    # token cchar:sym<basic> { <-[ \' \\ \r \n ]> }
    method cchar:sym<basic>($/) {
        make Cchar::Basic.new(
            value => ~$/,
        )
    }

    # token cchar:sym<escape> { <escapesequence> }
    method cchar:sym<escape>($/) {
        make $<escapesequence>.made
    }

    # token cchar:sym<universal> { <universalcharactername> } 
    method cchar:sym<universal>($/) {
        make $<universalcharactername>.made
    }

    # token escapesequence:sym<simple> { <simpleescapesequence> }
    method escapesequence:sym<simple>($/) {
        make $<simpleescapesequence>.made
    }

    # token escapesequence:sym<octal> { <octalescapesequence> }
    method escapesequence:sym<octal>($/) {
        make $<octalescapesequence>.made
    }

    # token escapesequence:sym<hex> { <hexadecimalescapesequence> } 
    method escapesequence:sym<hex>($/) {
        make $<hexadecimalescapesequence>.made
    }

    # token simpleescapesequence:sym<slash> { '\\\'' }
    method simpleescapesequence:sym<slash>($/) {
        make Simpleescapesequence::Slash.new
    }

    # token simpleescapesequence:sym<quote> { '\\"' }
    method simpleescapesequence:sym<quote>($/) {
        make Simpleescapesequence::Quote.new
    }

    # token simpleescapesequence:sym<question> { '\\?' }
    method simpleescapesequence:sym<question>($/) {
        make Simpleescapesequence::Question.new
    }

    # token simpleescapesequence:sym<double-slash> { '\\\\' }
    method simpleescapesequence:sym<double-slash>($/) {
        make Simpleescapesequence::DoubleSlash.new
    }

    # token simpleescapesequence:sym<a> { '\\a' }
    method simpleescapesequence:sym<a>($/) {
        make Simpleescapesequence::A.new
    }

    # token simpleescapesequence:sym<b> { '\\b' }
    method simpleescapesequence:sym<b>($/) {
        make Simpleescapesequence::B.new
    }

    # token simpleescapesequence:sym<f> { '\\f' }
    method simpleescapesequence:sym<f>($/) {
        make Simpleescapesequence::F.new
    }

    # token simpleescapesequence:sym<n> { '\\n' }
    method simpleescapesequence:sym<n>($/) {
        make Simpleescapesequence::N.new
    }

    # token simpleescapesequence:sym<r> { '\\r' }
    method simpleescapesequence:sym<r>($/) {
        make Simpleescapesequence::R.new
    }

    # token simpleescapesequence:sym<t> { '\\t' }
    method simpleescapesequence:sym<t>($/) {
        make Simpleescapesequence::T.new
    }

    # token simpleescapesequence:sym<v> { '\\v' }
    method simpleescapesequence:sym<v>($/) {
        make Simpleescapesequence::V.new
    }

    # token simpleescapesequence:sym<rn-n> { '\\' [ || '\r' '\n'? || '\n' ] } 
    method simpleescapesequence:sym<rn-n>($/) {
        make Simpleescapesequence::RnN.new
    }

    # token octalescapesequence { '\\' [<octaldigit> ** 1..3] }
    method octalescapesequence($/) {
        make Octalescapesequence.new(
            digits => $<octaldigit>>>.made,
        )
    }

    # token hexadecimalescapesequence { '\\x' <hexadecimaldigit>+ }
    method hexadecimalescapesequence($/) {
        make Hexadecimalescapesequence.new(
            digits => $<hexadecimaldigit>>>.made,
        )
    }

    # token fractionalconstant:sym<with-tail> { <digitsequence>? '.' <digitsequence> }
    method fractionalconstant:sym<with-tail>($/) {
        make Fractionalconstant::WithTail.new(
            value => ~$/,
        )
    }

    # token fractionalconstant:sym<no-tail> { <digitsequence> '.' }
    method fractionalconstant:sym<no-tail>($/) {
        make Fractionalconstant::NoTail.new(
            value => ~$/,
        )
    }

    # token exponentpart-prefix { 'e' || 'E' }
    method exponentpart-prefix($/) {
        make ExponentpartPrefix.new
    }

    # token exponentpart { <exponentpart-prefix> <sign>? <digitsequence> }
    method exponentpart($/) {
        make Exponentpart.new(
            value => ~$/,
        )
    }

    # token sign { <[ + - ]> }
    method sign:sym<+>($/) {
        make Sign::Plus.new
    }

    # token sign { <[ + - ]> }
    method sign:sym<->($/) {
        make Sign::Minus.new
    }

    # token digitsequence { <digit> [ '\''? <digit>]* }
    method digitsequence($/) {
        make Digitsequence.new(
            digits => $<digit>>>.made,
        )
    }

    # token floatingsuffix { <[ f l F L ]> } 
    method floatingsuffix($/) {
        make Floatingsuffix.new
    }

    # token encodingprefix:sym<u8> { 'u8' }
    method encodingprefix:sym<u8>($/) {
        make Encodingprefix::U8.new
    }

    # token encodingprefix:sym<u> { 'u' }
    method encodingprefix:sym<u>($/) {
        make Encodingprefix::U.new
    }

    # token encodingprefix:sym<U> { 'U' }
    method encodingprefix:sym<U>($/) {
        make Encodingprefix::U.new
    }

    # token encodingprefix:sym<L> { 'L' } 
    method encodingprefix:sym<L>($/) {
        make Encodingprefix::L.new
    }

    # token schar:sym<basic> { <-[ " \\ \r \n ]> }
    method schar:sym<basic>($/) {
        make Schar::Basic.new(
            value => ~$/,
        )
    }

    # token schar:sym<escape> { <escapesequence> }
    method schar:sym<escape>($/) {
        make $<escapesequence>.made
    }

    # token schar:sym<ucn> { <universalcharactername> }
    method schar:sym<ucn>($/) {
        make $<universalcharactername>.made
    }

    # token rawstring { || 'R"' [ || [ || '\\' <[ " ( ) ]> ] || <-[ \r \n ( ]> ] '(' <-[ ) ]>*? ')' [ || [ || '\\' <[ " ( ) ]> ] || <-[ \r \n " ]> ] '"' }
    method rawstring($/) {
        make Rawstring.new(
            value => ~$/,
        )
    }

    # token user-defined-integer-literal:sym<dec> { <decimal-literal> <udsuffix> }
    method user-defined-integer-literal:sym<dec>($/) {
        make UserDefinedIntegerLiteral::Dec.new(
            decimal-literal => $<decimal-literal>.made,
        )
    }

    # token user-defined-integer-literal:sym<oct> { <octal-literal> <udsuffix> }
    method user-defined-integer-literal:sym<oct>($/) {
        make UserDefinedIntegerLiteral::Oct.new(
            octal-literal => $<octal-literal>.made,
        )
    }

    # token user-defined-integer-literal:sym<hex> { <hexadecimal-literal> <udsuffix> }
    method user-defined-integer-literal:sym<hex>($/) {
        make UserDefinedIntegerLiteral::Hex.new(
            hexadecimal-literal => $<hexadecimal-literal>.made,
        )
    }

    # token user-defined-integer-literal:sym<bin> { <binary-literal> <udsuffix> } 
    method user-defined-integer-literal:sym<bin>($/) {
        make UserDefinedIntegerLiteral::Bin.new(
            binary-literal => $<binary-literal>.made,
        )
    }

    # token user-defined-floating-literal:sym<frac> { <fractionalconstant> <exponentpart>? <udsuffix> }
    method user-defined-floating-literal:sym<frac>($/) {
        make UserDefinedFloatingLiteral::Frac.new(
            fractionalconstant => $<fractionalconstant>.made,
            exponentpart => $<exponentpart>.made,
        )
    }

    # token user-defined-floating-literal:sym<digi> { <digitsequence> <exponentpart> <udsuffix> } 
    method user-defined-floating-literal:sym<digi>($/) {
        make UserDefinedFloatingLiteral::Digi.new(
            value => ~$/,
        )
    }

    # token user-defined-string-literal { <string-literal> <udsuffix> }
    method user-defined-string-literal($/) {
        make UserDefinedStringLiteral.new(
            value => ~$/,
        )
    }

    # token user-defined-character-literal { <character-literal> <udsuffix> }
    method user-defined-character-literal($/) {
        make UserDefinedCharacterLiteral.new(
            value => ~$/,
        )
    }

    # token udsuffix { <identifier> }
    method udsuffix($/) {
        make $<identifier>.made
    }

    # token block-comment { '/*' .*? '*/' }
    method block-comment($/) {
        make BlockComment.new(
            value => ~$/,
        )
    }

    # token line-comment { '//' <-[ \r \n ]>* }
    method line-comment($/) {
        make LineComment.new(
            value => ~$/,
        )
    }

    # rule TOP { <.ws> <statement-seq> }
    method TOP($/) {
        make $<statement-seq>.made
    }

    # token translation-unit { <declarationseq>? $ }
    method translation-unit($/) {
        make $<declarationseq>.made
    }

    # token primary-expression:sym<literal> { <literal>+ }
    method primary-expression:sym<literal>($/) {
        make $<literal>>>.made
    }

    # token primary-expression:sym<this> { <this> }
    method primary-expression:sym<this>($/) {
        make PrimaryExpression::This.new
    }

    # token primary-expression:sym<expr> { <.left-paren> <expression> <.right-paren> }
    method primary-expression:sym<expr>($/) {
        make $<expression>.made
    }

    # token primary-expression:sym<id> { <id-expression> }
    method primary-expression:sym<id>($/) {
        make $<id-expression>.made
    }

    # token primary-expression:sym<lambda> { <lambda-expression> } 
    method primary-expression:sym<lambda>($/) {
        make $<lambda-expression>.made
    }

    # regex id-expression:sym<qualified> { <qualified-id> }
    method id-expression:sym<qualified>($/) {
        make $<qualified-id>.made
    }

    # regex id-expression:sym<unqualified> { <unqualified-id> } 
    method id-expression:sym<unqualified>($/) {
        make $<unqualified-id>.made
    }

    # regex unqualified-id:sym<ident> { <identifier> }
    method unqualified-id:sym<ident>($/) {
        make $<identifier>.made
    }

    # regex unqualified-id:sym<op-func-id> { <operator-function-id> }
    method unqualified-id:sym<op-func-id>($/) {
        make $<operator-function-id>.made
    }

    # regex unqualified-id:sym<conversion-func-id> { <conversion-function-id> }
    method unqualified-id:sym<conversion-func-id>($/) {
        make $<conversion-function-id>.made
    }

    # regex unqualified-id:sym<literal-operator-id> { <literal-operator-id> }
    method unqualified-id:sym<literal-operator-id>($/) {
        make $<literal-operator-id>.made
    }

    # regex unqualified-id:sym<tilde-classname> { <tilde> <class-name> }
    method unqualified-id:sym<tilde-classname>($/) {
        make UnqualifiedId::TildeClassname.new(
            class-name => $<class-name>.made,
        )
    }

    # regex unqualified-id:sym<tilde-decltype> { <tilde> <decltype-specifier> }
    method unqualified-id:sym<tilde-decltype>($/) {
        make UnqualifiedId::TildeDecltype.new(
            decltype-specifier => $<decltype-specifier>.made,
        )
    }

    # regex unqualified-id:sym<template-id> { <template-id> } 
    method unqualified-id:sym<template-id>($/) {
        make $<template-id>.made
    }

    # regex qualified-id { <nested-name-specifier> <template>? <unqualified-id> } 
    method qualified-id($/) {
        make QualifiedId.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            template              => $<template>.made,
            unqualified-id        => $<unqualified-id>.made,
        )
    }

    # regex nested-name-specifier-prefix:sym<null> { <doublecolon> }
    method nested-name-specifier-prefix:sym<null>($/) {
        make NestedNameSpecifierPrefix::Null.new
    }

    # regex nested-name-specifier-prefix:sym<type> { <the-type-name> <doublecolon> }
    method nested-name-specifier-prefix:sym<type>($/) {
        make NestedNameSpecifierPrefix::Type.new(
            the-type-name => $<the-type-name>.made,
        )
    }

    # regex nested-name-specifier-prefix:sym<ns> { <namespace-name> <doublecolon> }
    method nested-name-specifier-prefix:sym<ns>($/) {
        make NestedNameSpecifierPrefix::Ns.new(
            namespace-name => $<namespace-name>.made,
        )
    }

    # regex nested-name-specifier-prefix:sym<decl> { <decltype-specifier> <doublecolon> } 
    method nested-name-specifier-prefix:sym<decl>($/) {
        make NestedNameSpecifierPrefix::Decl.new(
            decltype-specifier => $<decltype-specifier>.made,
        )
    }

    # regex nested-name-specifier-suffix:sym<id> { <identifier> <doublecolon> }
    method nested-name-specifier-suffix:sym<id>($/) {
        make NestedNameSpecifierSuffix::Id.new(
            identifier => $<identifier>.made,
        )
    }

    # regex nested-name-specifier-suffix:sym<template> { <template>? <simple-template-id> <doublecolon> } 
    method nested-name-specifier-suffix:sym<template>($/) {
        make NestedNameSpecifierSuffix::Template.new(
            template           => $<template>.made,
            simple-template-id => $<simple-template-id>.made,
        )
    }

    # regex nested-name-specifier { <nested-name-specifier-prefix> <nested-name-specifier-suffix>* }
    method nested-name-specifier($/) {

        my $base     = $<nested-name-specifier-prefix>.made;
        my @suffixes = $<nested-name-specifier-suffix>>>.made;

        if @suffixes.elems gt 0 {
            make NestedNameSpecifier.new(
                nested-name-specifier-prefix   => $base,
                nested-name-specifier-suffixes => @suffixes,
            )
        } else {
            make $base
        }
    }

    # rule lambda-expression { <lambda-introducer> <lambda-declarator>? <compound-statement> }
    method lambda-expression($/) {
        make LambdaExpression.new(
            lambda-introducer  => $<lambda-introducer>.made,
            lambda-declarator  => $<lambda-declarator>.made,
            compound-statement => $<compound-statement>.made,
        )
    }

    # rule lambda-introducer { <.left-bracket> <lambda-capture>? <.right-bracket> } 
    method lambda-introducer($/) {
        make $<lambda-capture>.made
    }

    # rule lambda-capture:sym<list> { <capture-list> }
    method lambda-capture:sym<list>($/) {
        make $<capture-list>.made
    }

    # rule lambda-capture:sym<def> { <capture-default> [ <.comma> <capture-list> ]? } 
    method lambda-capture:sym<def>($/) {

        my $body = $<capture-default>.made;
        my $tail = $<capture-list>.made;

        if $tail {
            make LambdaCapture::Def.new(
                capture-default => $body,
                capture-list    => $tail,
            )

        } else {
            make $body
        }
    }

    # rule capture-default:sym<and> { <and_> }
    method capture-default:sym<and>($/) {
        make CaptureDefault::And.new
    }

    # rule capture-default:sym<assign> { <assign> } 
    method capture-default:sym<assign>($/) {
        make CaptureDefault::Assign.new
    }

    # rule capture-list { <capture> [ <.comma> <capture> ]* <ellipsis>? } 
    method capture-list($/) {

        my @captures     = $<capture>>>.made;
        my $has-ellipsis = so $/<ellipsis>:exists;

        if @captures.elems gt 1 or $has-ellipsis {
            make CaptureList.new(
                captures          => @captures,
                trailing-ellipsis => $has-ellipsis,
            )
        } else {
            make @captures[0]
        }
    }

    # rule capture:sym<simple> { <simple-capture> }
    method capture:sym<simple>($/) {
        make Capture::Simple.new
    }

    # rule capture:sym<init> { <initcapture> } 
    method capture:sym<init>($/) {
        make Capture::Init.new
    }

    # rule simple-capture:sym<id> { <and_>? <identifier> }
    method simple-capture:sym<id>($/) {

        my $id      = $<identifier>.made;
        my $has-and = so $/<and_>:exists;

        if $has-and {
            make SimpleCapture::Id.new(
                has-and_   => $<and_>.made,
                identifier => $id,
            )
        } else {
            make $id
        }
    }

    # rule simple-capture:sym<this> { <this> } 
    method simple-capture:sym<this>($/) {
        make SimpleCapture::This.new
    }

    # rule initcapture { <and_>? <identifier> <initializer> } 
    method initcapture($/) {
        make Initcapture.new(
            has-and     => $<has-and>.made,
            identifier  => $<identifier>.made,
            initializer => $<initializer>.made,
        )
    }

    # rule lambda-declarator { 
    #   <.left-paren> 
    #   <parameter-declaration-clause>? 
    #   <.right-paren> 
    #   <mutable>? 
    #   <exception-specification>? 
    #   <attribute-specifier-seq>? 
    #   <trailing-return-type>? 
    # } 
    method lambda-declarator($/) {
        make LambdaDeclarator.new(
            parameter-declaration-clause => $<parameter-declaration-clause>.made,
            mutable                      => $<mutable>.made,
            exception-specification      => $<exception-specification>.made,
            attribute-specifier-seq      => $<attribute-specifier-seq>.made,
            trailing-return-type         => $<trailing-return-type>.made,
        )
    }

    # rule postfix-expression { <postfix-expression-body> <postfix-expression-tail>* }
    method postfix-expression($/) {
        my $body = $<postfix-expression-body>.made;
        my @tail = $<postfix-expression-tail>>>.made.List;

        if @tail.elems gt 0 {
            make PostfixExpression.new(
                postfix-expression-body => $body,
                postfix-expression-tail => @tail,
            )
        } else {
            make $body
        }
    }

    # rule bracket-tail { <.left-bracket> [ <expression> || <braced-init-list> ] <.right-bracket> }
    method bracket-tail($/) {
        make BracketTail.new
    }

    # rule postfix-expression-tail:sym<bracket> { <bracket-tail> }
    method postfix-expression-tail:sym<bracket>($/) {
        make $<bracket-tail>.made
    }

    # rule postfix-expression-tail:sym<parens> { <.left-paren> <expression-list>? <.right-paren> }
    method postfix-expression-tail:sym<parens>($/) {
        make $<expression-list>.made
    }

    # rule postfix-expression-tail:sym<indirection-id> { [ <dot> || <arrow> ] <template>? <id-expression> }
    method postfix-expression-tail:sym<indirection-id>($/) {
        make PostfixExpressionTail::IndirectionId.new(
            template      => $<template>.made,
            id-expression => $<id-expression>.made,
        )
    }

    # rule postfix-expression-tail:sym<indirection-pseudo-dtor> { [ <dot> || <arrow> ] <pseudo-destructor-name> }
    method postfix-expression-tail:sym<indirection-pseudo-dtor>($/) {
        make PostfixExpressionTail::IndirectionPseudoDtor.new(
            pseudo-destructor-name => $<pseudo-destructor-name>.made,
        )
    }

    # rule postfix-expression-tail:sym<pp-mm> { [ <plus-plus> || <minus-minus> ] } 
    method postfix-expression-tail:sym<pp>($/) {
        make PostfixExpressionTail::PlusPlus.new
    }

    method postfix-expression-tail:sym<mm>($/) {
        make PostfixExpressionTail::MinusMinus.new
    }

    # token postfix-expression-body { 
    #   || <postfix-expression-list> 
    #   || <postfix-expression-cast> 
    #   || <postfix-expression-typeid> 
    #   || <primary-expression> 
    # } 
    method postfix-expression-body($/) {

        given $/.keys[0] {
            when "postfix-expression-list" {
                make $<postfix-expression-list>.made
            }
            when "postfix-expression-cast" {
                make $<postfix-expression-cast>.made
            }
            when "postfix-expression-typeid" {
                make $<postfix-expression-type-id>.made
            }
            when "primary-expression" {
                make $<primary-expression>.made
            }
            default {
                die "bad switch";
            }
        }
    }

    # token cast-token:sym<dyn> { <dynamic_cast> }
    method cast-token:sym<dyn>($/) {
        make CastToken::Dyn.new
    }

    # token cast-token:sym<static> { <static_cast> }
    method cast-token:sym<static>($/) {
        make CastToken::Static.new
    }

    # token cast-token:sym<reinterpret> { <reinterpret_cast> }
    method cast-token:sym<reinterpret>($/) {
        make CastToken::Reinterpret.new
    }

    # token cast-token:sym<const> { <const_cast> }
    method cast-token:sym<const>($/) {
        make CastToken::Const.new
    }

    # rule postfix-expression-cast { 
    #   <cast-token> 
    #   <less> 
    #   <the-type-id> 
    #   <greater> 
    #   <.left-paren> 
    #   <expression> 
    #   <.right-paren> 
    # }
    method postfix-expression-cast($/) {
        make PostfixExpressionCast.new(
            cast-token  => $<cast-token>.made,
            the-type-id => $<the-type-id>.made,
            expression  => $<expression>.made,
        )
    }

    # rule postfix-expression-typeid { 
    #   <type-id-of-the-type-id> 
    #   <.left-paren> 
    #   [ <expression> || <the-type-id>] 
    #   <.right-paren> 
    # } 
    method postfix-expression-typeid:sym<expr>($/) {
        make PostfixExpressionTypeid::Expr.new(
            type-id-of-the-type-id => $<type-id-of-the-type-id>.made,
            expression             => $<expression>.made,
        )
    }

    method postfix-expression-typeid:sym<type-id>($/) {
        make PostfixExpressionTypeid::TypeId.new(
            type-id-of-the-type-id => $<type-id-of-the-type-id>.made,
            the-type-id            => $<the-type-id>.made,
        )
    }

    # token post-list-head:sym<simple> { <simple-type-specifier> }
    method post-list-head:sym<simple>($/) {
        make $<simple-type-specifier>.made
    }

    # token post-list-head:sym<type-name> { <type-name-specifier> } 
    method post-list-head:sym<type-name>($/) {
        make $<type-name-specifier>.made
    }

    # token post-list-tail:sym<parenthesized> { <.left-paren> <expression-list>? <.right-paren> }
    method post-list-tail:sym<parenthesized>($/) {
        make $<expression-list>.made
    }

    # token post-list-tail:sym<braced> { <braced-init-list> }
    method post-list-tail:sym<braced>($/) {
        make $<braced-init-list>.made
    }

    # token postfix-expression-list { <post-list-head> <post-list-tail> } 
    method postfix-expression-list($/) {
        make PostfixExpressionList.new(
            post-list-head => $<post-list-head>.made,
            post-list-tail => $<post-list-tail>.made,
        )
    }

    # rule type-id-of-the-type-id { <typeid_> }
    method type-id-of-the-type-id($/) {
        make $<typeid>.made
    }

    # rule expression-list { <initializer-list> } 
    method expression-list($/) {
        make $<initializer-list>.made
    }

    # rule pseudo-destructor-name:sym<basic> { 
    #   <nested-name-specifier>? 
    #   [ <the-type-name> <doublecolon> ]? 
    #   <tilde> 
    #   <the-type-name> 
    # }
    method pseudo-destructor-name:sym<basic>($/) {
        make PseudoDestructorName::Basic.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            the-scoped-type-name  => $<the-scoped-type-name>.made,
            the-type-anme         => $<the-type-anme>.made,
        )
    }

    # rule pseudo-destructor-name:sym<template> { 
    #   <nested-name-specifier> 
    #   <template> 
    #   <simple-template-id> 
    #   <doublecolon> 
    #   <tilde> 
    #   <the-type-name> 
    # }
    method pseudo-destructor-name:sym<template>($/) {
        make PseudoDestructorName::Template.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            simple-template-id    => $<simple-template-id>.made,
            the-type-name         => $<the-type-name>.made,
        )
    }

    # rule pseudo-destructor-name:sym<decltype> { 
    #   <tilde> 
    #   <decltype-specifier> 
    # } 
    method pseudo-destructor-name:sym<decltype>($/) {
        make PseudoDestructorName::Decltype.new(
            decltype-specifier => $<decltype-specifier>.made,
        )
    }

    # rule unary-expression { || <new-expression> || <unary-expression-case> }
    method unary-expression($/) {
        make do if $/<new-expression>:exists {
            $<new-expression>.made
        } else {
            $<unary-expression-case>.made
        }
    }

    # rule unary-expression-case:sym<postfix> { <postfix-expression> }
    method unary-expression-case:sym<postfix>($/) {
        make $<postfix-expression>.made
    }

    # rule unary-expression-case:sym<pp> { <plus-plus> <unary-expression> }
    method unary-expression-case:sym<pp>($/) {
        make UnaryExpressionCase::PlusPlus.new(
            unary-expression => $<unary-expression>.made,
        )
    }

    # rule unary-expression-case:sym<mm> { <minus-minus> <unary-expression> }
    method unary-expression-case:sym<mm>($/) {
        make UnaryExpressionCase::MinusMinus.new(
            unary-expression => $<unary-expression>.made,
        )
    }

    # rule unary-expression-case:sym<unary-op> { <unary-operator> <unary-expression> }
    method unary-expression-case:sym<unary-op>($/) {
        make UnaryExpressionCase::UnaryOp.new(
            unary-operator => $<unary-operator>.made,
            unary-expression => $<unary-expression>.made,
        )
    }

    # rule unary-expression-case:sym<sizeof> { <sizeof> <unary-expression> }
    method unary-expression-case:sym<sizeof>($/) {
        make UnaryExpressionCase::Sizeof.new(
            unary-expression => $<unary-expression>.made,
        )
    }

    # rule unary-expression-case:sym<sizeof-typeid> { <sizeof> <.left-paren> <the-type-id> <.right-paren> }
    method unary-expression-case:sym<sizeof-typeid>($/) {
        make UnaryExpressionCase::SizeofTypeid.new(
            the-type-id => $<the-type-id>.made,
        )
    }

    # rule unary-expression-case:sym<sizeof-ids> { <sizeof> <ellipsis> <.left-paren> <identifier> <.right-paren> }
    method unary-expression-case:sym<sizeof-ids>($/) {
        make UnaryExpressionCase::SizeofIds.new(
            identifier => $<identifier>.made,
        )
    }

    # rule unary-expression-case:sym<alignof> { <alignof> <.left-paren> <the-type-id> <.right-paren> }
    method unary-expression-case:sym<alignof>($/) {
        make UnaryExpressionCase::Alignof.new(
            the-type-id => $<the-type-id>.made,
        )
    }

    # rule unary-expression-case:sym<noexcept> { <no-except-expression> }
    method unary-expression-case:sym<noexcept>($/) {
        make $<no-except-expression>.made
    }

    # rule unary-expression-case:sym<delete> { <delete-expression> } 
    method unary-expression-case:sym<delete>($/) {
        make $<delete-expression>.made
    }

    # rule unary-operator:sym<or_> { <or_> }
    method unary-operator:sym<or_>($/) {
        make UnaryOperator::Or.new
    }

    # rule unary-operator:sym<star> { <star> }
    method unary-operator:sym<star>($/) {
        make UnaryOperator::Star.new
    }

    # rule unary-operator:sym<and_> { <and_> }
    method unary-operator:sym<and_>($/) {
        make UnaryOperator::And.new
    }

    # rule unary-operator:sym<plus> { <plus> }
    method unary-operator:sym<plus>($/) {
        make UnaryOperator::Plus.new
    }

    # rule unary-operator:sym<tilde> { <tilde> }
    method unary-operator:sym<tilde>($/) {
        make UnaryOperator::Tilde.new
    }

    # rule unary-operator:sym<minus> { <minus> }
    method unary-operator:sym<minus>($/) {
        make UnaryOperator::Minus.new
    }

    # rule unary-operator:sym<not> { <not_> } 
    method unary-operator:sym<not>($/) {
        make UnaryOperator::Not.new
    }

    # rule new-expression:sym<new-type-id> { <doublecolon>? <new_> <new-placement>? <new-type-id> <new-initializer>? }
    method new-expression:sym<new-type-id>($/) {
        make NewExpression::NewTypeId.new(
            new-placement   => $<new-placement>.made,
            new-type-id     => $<new-type-id>.made,
            new-initializer => $<new-initializer>.made,
        )
    }

    # rule new-expression:sym<the-type-id> { <doublecolon>? <new_> <new-placement>? <.left-paren> <the-type-id> <.right-paren> <new-initializer>? }
    method new-expression:sym<the-type-id>($/) {
        make NewExpression::TheTypeId.new(
            new-placement   => $<new-placement>.made,
            the-type-id     => $<the-type-id>.made,
            new-initializer => $<new-initializer>.made,
        )
    }

    # rule new-placement { <.left-paren> <expression-list> <.right-paren> }
    method new-placement($/) {
        make $<expression-list>.made
    }

    # rule new-type-id { <type-specifier-seq> <new-declarator>? }
    method new-type-id($/) {

        my $base           = $<type-specifier-seq>.made;
        my $new-declarator = $<new-declarator>.made;

        if $new-declarator {
            make NewTypeId.new(
                type-specifier-seq => $base,
                new-declarator     => $new-declarator,
            )
        } else {
            make $base
        }
    }

    # rule new-declarator { <pointer-operator>* <no-pointer-new-declarator>? } 
    method new-declarator($/) {
        my $base = $<no-pointer-new-declarator>.made;
        my @ops  = $<pointer-operator>>>.made;

        if @ops.elems gt 0 {
            make NewDeclarator.new(
                pointer-operators         => @ops,
                no-pointer-new-declarator => $base,
            )
        } elems {
            make $base
        }
    }

    # rule no-pointer-new-declarator { <.left-bracket> <expression> <.right-bracket> <attribute-specifier-seq>? <no-pointer-new-declarator-tail>* }
    method no-pointer-new-declarator($/) {
        make NoPointerNewDeclarator.new(
            expression                     => $<expression>.made,
            attribute-specifier-seq        => $<attribute-specifier-seq>.made,
            no-pointer-new-declarator-tail => $<no-pointer-new-declarator-tail>>>.made,
        )
    }

    # rule no-pointer-new-declarator-tail { <.left-bracket> <constant-expression> <.right-bracket> <attribute-specifier-seq>? } 
    method no-pointer-new-declarator-tail($/) {
        make NoPointerNewDeclaratorTail.new(
            constant-expression     => $<constant-expression>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
        )
    }

    # rule new-initializer:sym<expr-list> { <.left-paren> <expression-list>? <.right-paren> }
    method new-initializer:sym<expr-list>($/) {
        make $<expression-list>.made;
    }

    # rule new-initializer:sym<braced> { <braced-init-list> } 
    method new-initializer:sym<braced>($/) {
        make $<braced-init-list>.made
    }

    # rule delete-expression { <doublecolon>? <delete> [ <.left-bracket> <.right-bracket> ]? <cast-expression> }
    method delete-expression($/) {
        make DeleteExpression.new(
            cast-expression => $<cast-expression>.made,
        )
    }

    # rule no-except-expression { <noexcept> <.left-paren> <expression> <.right-paren> }
    method no-except-expression($/) {
        make NoExceptExpression.new(
            expression => $<expression>.made,
        )
    }

    # rule cast-expression { [ <.left-paren> <the-type-id> <.right-paren> ]* <unary-expression> }
    method cast-expression($/) {

        my $base     = $<unary-expression>.made;
        my @type-ids = $<the-type-id>>>.made.List;

        if @type-ids.elems gt 0 {

            make CastExpression.new(
                unary-expression => $base,
                the-type-ids     => @type-ids,
            )

        } else {

            make $base
        }
    }

    # rule pointer-member-operator:sym<dot> { <dot-star> }
    method pointer-member-operator:sym<dot>($/) {
        make PointerMemberOperator::Dot.new
    }

    # rule pointer-member-operator:sym<arrow> { <arrow-star> }
    method pointer-member-operator:sym<arrow>($/) {
        make PointerMemberOperator::Arrow.new
    }

    # rule pointer-member-expression { <cast-expression> <pointer-member-expression-tail>* }
    method pointer-member-expression($/) {
        my $base = $<cast-expression>.made;
        my @tail = $<pointer-member-expression-tail>>>.made;
        if @tail.elems gt 0 {
            make PointerMemberExpression.new(
                cast-expression                => $base,
                pointer-member-expression-tail => @tail,
            )
        } else {
            make $base
        }
    }

    # rule pointer-member-expression-tail { <pointer-member-operator> <cast-expression> } 
    method pointer-member-expression-tail($/) {
        make PointerMemberExpressionTail.new(
            pointer-member-operator => $<pointer-member-operator>.made,
            cast-expression         => $<cast-expression>.made,
        )
    }

    # token multiplicative-operator:sym<*> { <star> }
    method multiplicative-operator:sym<*>($/) {
        make MultiplicativeOperator::Star.new
    }

    # token multiplicative-operator:sym</> { <div_> }
    method multiplicative-operator:sym</>($/) {
        make MultiplicativeOperator::Slash.new
    }

    # token multiplicative-operator:sym<%> { <mod_> }
    method multiplicative-operator:sym<%>($/) {
        make MultiplicativeOperator::Mod.new
    }

    # rule multiplicative-expression { <pointer-member-expression> <multiplicative-expression-tail>* }
    method multiplicative-expression($/) {
        my $base = $<pointer-member-expression>.made;
        my @tail = $<multiplicative-expression-tail>>>.made.List;

        if @tail.elems gt 0 {
            make MultiplicativeExpression.new(
                pointer-member-expression      => $base,
                multiplicative-expression-tail => @tail,
            )
        } else {
            make $base
        }
    }

    # rule multiplicative-expression-tail { <multiplicative-operator> <pointer-member-expression> } 
    method multiplicative-expression-tail($/) {
        make MultiplicativeExpressionTail.new(
            multiplicative-operator   => $<multiplicative-operator>.made,
            pointer-member-expression => $<pointer-member-expression>.made,
        )
    }

    # token additive-operator:sym<plus> { <plus> }
    method additive-operator:sym<plus>($/) {
        make AdditiveOperator::Plus.new
    }

    # token additive-operator:sym<minus> { <minus> } 
    method additive-operator:sym<minus>($/) {
        make AdditiveOperator::Minus.new
    }

    # rule additive-expression-tail { <additive-operator> <multiplicative-expression> }
    method additive-expression-tail($/) {
        make AdditiveExpressionTail.new(
            additive-operator         => $<additive-operator>.made,
            multiplicative-expression => $<multiplicative-expression>.made,
        )
    }

    # rule additive-expression { <multiplicative-expression> <additive-expression-tail>* }
    method additive-expression($/) {
        my $base = $<multiplicative-expression>.made;
        my @tail = $<additive-expression-tail>>>.made.List;

        if @tail.elems gt 0 {
            make AdditiveExpression.new(
                multiplicative-expression => $base,
                additive-expression-tail  => @tail,
            )

        } else {
            make $base
        }
    }

    # rule shift-expression-tail { <shift-operator> <additive-expression> }
    method shift-expression-tail($/) {
        make ShiftExpressionTail.new(
            shift-operator      => $<shift-operator>.made,
            additive-expression => $<additive-expression>.made,
        )
    }

    # rule shift-expression { <additive-expression> <shift-expression-tail>* } 
    method shift-expression($/) {

        my $base = $<additive-expression>.made;
        my @tail = $<shift-expression-tail>>>.made.List;

        if @tail.elems gt 0 {

            make ShiftExpression.new(
                additive-expression   => $base,
                shift-expression-tail => @tail,
            )

        } else {

            make $base
        }
    }

    # rule shift-operator:sym<right> { <.greater> <.greater> }
    method shift-operator:sym<right>($/) {
        make ShiftOperator::Right.new
    }

    # rule shift-operator:sym<left> { <.less> <.less> } 
    method shift-operator:sym<left>($/) {
        make ShiftOperator::Left.new
    }

    # rule relational-operator:sym<less> { <.less> }
    method relational-operator:sym<less>($/) {
        make RelationalOperator::Less.new
    }

    # rule relational-operator:sym<greater> { <.greater> }
    method relational-operator:sym<greater>($/) {
        make RelationalOperator::Greater.new
    }

    # rule relational-operator:sym<less-eq> { <.less-equal> }
    method relational-operator:sym<less-eq>($/) {
        make RelationalOperator::LessEq.new
    }

    # rule relational-operator:sym<greater-eq> { <.greater-equal> } 
    method relational-operator:sym<greater-eq>($/) {
        make RelationalOperator::GreaterEq.new
    }

    # regex relational-expression-tail { <.ws> <relational-operator> <.ws> <shift-expression> }
    method relational-expression-tail($/) {
        make RelationalExpressionTail.new(
            relational-operator => $<relational-operator>.made,
            shift-expression    => $<shift-expression>.made,
        )
    }

    # regex relational-expression { <shift-expression> <relational-expression-tail>* } 
    method relational-expression($/) {
        my $base = $<shift-expression>.made;
        my @tail = $<relational-expression-tail>>>.made.List;

        if @tail.elems gt 0 {
            make RelationalExpression.new(
                shift-expression           => $base,
                relational-expression-tail => @tail,
            )
        } else {
            make $base
        }
    }

    # token equality-operator:sym<eq> { <equal> }
    method equality-operator:sym<eq>($/) {
        make EqualityOperator::Eq.new
    }

    # token equality-operator:sym<neq> { <not-equal> } 
    method equality-operator:sym<neq>($/) {
        make EqualityOperator::Neq.new
    }

    # rule equality-expression-tail { <equality-operator> <relational-expression> }
    method equality-expression-tail($/) {
        make EqualityExpressionTail.new(
            equality-operator     => $<equality-operator>.made,
            relational-expression => $<relational-expression>.made,
        )
    }

    # rule equality-expression { <relational-expression> <equality-expression-tail>* }
    method equality-expression($/) {
        my $base = $<relational-expression>.made;
        my @tail = $<equality-expression-tail>>>.made.List;

        if @tail.elems gt 0 {
            make EqualityExpression.new(
                relational-expression    => $base,
                equality-expression-tail => @tail,
            )
        } else {
            make $base
        }
    }

    # rule and-expression { <equality-expression> [ <and_> <equality-expression> ]* }
    method and-expression($/) {

        my @equality-expressions = $<equality-expression>>>.made.List;

        if @equality-expressions.elems gt 1 {
            make AndExpression.new(
                equality-expressions => @equality-expressions,
            )

        } else {
            make @equality-expressions[0]
        }
    }

    # rule exclusive-or-expression { <and-expression> [ <caret> <and-expression> ]* }
    method exclusive-or-expression($/) {
        my @and-expressions = $<and-expression>>>.made;

        if @and-expressions.elems gt 1 {
            make ExclusiveOrExpression.new(
                and-expressions => @and-expressions,
            )
        } else {
            make @and-expressions[0]
        }
    }

    # rule inclusive-or-expression { <exclusive-or-expression> [ <or_> <exclusive-or-expression> ]* }
    method inclusive-or-expression($/) {

        my @exclusive-or-expressions = $<exclusive-or-expression>>>.made;

        if @exclusive-or-expressions.elems gt 1 {
            make InclusiveOrExpression.new(
                exclusive-or-expressions => @exclusive-or-expressions,
            )

        } else {
            make @exclusive-or-expressions[0]
        }
    }

    # rule logical-and-expression { <inclusive-or-expression> [ <and-and> <inclusive-or-expression>]* }
    method logical-and-expression($/) {

        my @inclusive-or-expressions = $<inclusive-or-expression>>>.made;

        if @inclusive-or-expressions.elems gt 1 {
            make LogicalAndExpression.new(
                inclusive-or-expressions => @inclusive-or-expressions,
            )
        } else {
            make @inclusive-or-expressions[0]
        }
    }

    # rule logical-or-expression { <logical-and-expression> [ <or-or> <logical-and-expression> ]* }
    method logical-or-expression($/) {

        my @exprs = $<logical-and-expression>>>.made;

        if @exprs.elems gt 1 {
            make LogicalOrExpression.new(
                logical-and-expressions => @exprs,
            )
        } else {
            make @exprs[0]
        }
    }

    # rule conditional-expression-tail { <question> <expression> <colon> <assignment-expression> }
    method conditional-expression-tail($/) {
        make ConditionalExpressionTail.new(
            question-expression   => $<question-expression>.made,
            assignment-expression => $<assignment-expression>.made,
        )
    }

    # rule conditional-expression { <logical-or-expression> <conditional-expression-tail>? } 
    method conditional-expression($/) {

        my $base = $<logical-or-expression>.made;
        my $tail = $<conditional-expression-tail>.made;

        if $tail {

            make ConditionalExpression.new(
                logical-or-expression       => $base,
                conditional-expression-tail => $tail,
            )

        } else {

            make $base
        }
    }

    # rule assignment-expression:sym<throw> { <throw-expression> }
    method assignment-expression:sym<throw>($/) {
        make AssignmentExpression::Throw.new(
            throw-expression => $<throw-expression>.made,
        )
    }

    # rule assignment-expression:sym<basic> { <logical-or-expression> <assignment-operator> <initializer-clause> }
    method assignment-expression:sym<basic>($/) {
        make AssignmentExpression::Basic.new(
            logical-or-expression => $<logical-or-expression>.made,
            assignment-operator   => $<assignment-operator>.made,
            initializer-clause    => $<initializer-clause>.made,
        )
    }

    # rule assignment-expression:sym<conditional> { <conditional-expression> }
    method assignment-expression:sym<conditional>($/) {
        make $<conditional-expression>.made
    }

    # token assignment-operator:sym<assign> { <.assign> }
    method assignment-operator:sym<assign>($/) {
        make AssignmentOperator::Assign.new
    }

    # token assignment-operator:sym<star-assign> { <.star-assign> }
    method assignment-operator:sym<star-assign>($/) {
        make AssignmentOperator::StarAssign.new
    }

    # token assignment-operator:sym<div-assign> { <.div-assign> }
    method assignment-operator:sym<div-assign>($/) {
        make AssignmentOperator::DivAssign.new
    }

    # token assignment-operator:sym<mod-assign> { <.mod-assign> }
    method assignment-operator:sym<mod-assign>($/) {
        make AssignmentOperator::ModAssign.new
    }

    # token assignment-operator:sym<plus-assign> { <.plus-assign> }
    method assignment-operator:sym<plus-assign>($/) {
        make AssignmentOperator::PlusAssign.new
    }

    # token assignment-operator:sym<minus-assign> { <.minus-assign> }
    method assignment-operator:sym<minus-assign>($/) {
        make AssignmentOperator::MinusAssign.new
    }

    # token assignment-operator:sym<rshift-assign> { <.right-shift-assign> }
    method assignment-operator:sym<rshift-assign>($/) {
        make AssignmentOperator::RshiftAssign.new
    }

    # token assignment-operator:sym<lshift-assign> { <.left-shift-assign> }
    method assignment-operator:sym<lshift-assign>($/) {
        make AssignmentOperator::LshiftAssign.new
    }

    # token assignment-operator:sym<and-assign> { <.and-assign> }
    method assignment-operator:sym<and-assign>($/) {
        make AssignmentOperator::AndAssign.new
    }

    # token assignment-operator:sym<xor-assign> { <.xor-assign> }
    method assignment-operator:sym<xor-assign>($/) {
        make AssignmentOperator::XorAssign.new
    }

    # token assignment-operator:sym<or-assign> { <.or-assign> }
    method assignment-operator:sym<or-assign>($/) {
        make AssignmentOperator::OrAssign.new
    }

    # rule expression { <assignment-expression>+ %% <.comma> }
    method expression($/) {
        my @exprs = $<assignment-expression>>>.made;

        if @exprs.elems gt 1 {
            make Expression.new(
                assignment-expressions => @exprs,
            )
        } else {
            make @exprs[0]
        }
    }

    # rule constant-expression { <conditional-expression> }
    method constant-expression($/) {
        make $<conditional-expression>.made
    }

    # regex comment:sym<line> { [<line-comment> <.ws>?]+ }
    method comment:sym<line>($/) {
        make Comment::Line.new(
            line-comments => $<line-comment>>>.made,
        )
    }

    # rule comment:sym<block> { <block-comment> } 
    method comment:sym<block>($/) {
        make $<block-comment>.made
    }

    # token statement:sym<attributed> { <comment>? <attribute-specifier-seq>? <attributed-statement-body> }
    method statement:sym<attributed>($/) {

        my $comment = $<comment>.made;
        my $attribs = $<attribute-specifier-seq>.made;
        my $body    = $<attributed-statement-body>.made;

        if not $comment and not $attribs {

            make $body

        } else {

            make Statement::Attributed.new(
                comment                   => $comment,
                attribute-specifier-seq   => $attribs,
                attributed-statement-body => $body,
            )
        }
    }

    # token statement:sym<labeled> { <comment>? <labeled-statement> }
    method statement:sym<labeled>($/) {

        my $comment = $<comment>.made;
        my $body    = $<labeled-statement>.made;

        if not $comment {

            make $body

        } else {

            make Statement::Labeled.new(
                comment           => $comment,
                labeled-statement => $body,
            )
        }
    }

    # token statement:sym<declaration> { <comment>? <declaration-statement> }
    method statement:sym<declaration>($/) {

        my $comment = $<comment>.made;
        my $body    = $<declaration-statement>.made;

        if not $comment {

            make $body

        } else {

            make Statement::Declaration.new(
                comment               => $comment,
                declaration-statement => $body,
            )
        }
    }

    # rule attributed-statement-body:sym<expression> { <expression-statement> }
    method attributed-statement-body:sym<expression>($/) {
        make $<expression-statement>.made;
    }

    # rule attributed-statement-body:sym<compound> { <compound-statement> }
    method attributed-statement-body:sym<compound>($/) {
        make $<compound-statement>.made;
    }

    # rule attributed-statement-body:sym<selection> { <selection-statement> }
    method attributed-statement-body:sym<selection>($/) {
        make $<selection-statement>.made
    }

    # rule attributed-statement-body:sym<iteration> { <iteration-statement> }
    method attributed-statement-body:sym<iteration>($/) {
        make $<iteration-statement>.made
    }

    # rule attributed-statement-body:sym<jump> { <jump-statement> }
    method attributed-statement-body:sym<jump>($/) {
        make $<jump-statement>.made
    }

    # rule attributed-statement-body:sym<try> { <try-block> } 
    method attributed-statement-body:sym<try>($/) {
        make $<try-block>.made
    }

    # rule labeled-statement-label-body:sym<id> { <identifier> }
    method labeled-statement-label-body:sym<id>($/) {
        make $<identifier>.made
    }

    # rule labeled-statement-label-body:sym<case-expr> { <case> <constant-expression> }
    method labeled-statement-label-body:sym<case-expr>($/) {
        make LabeledStatementLabelBody::CaseExpr.new(
            constant-expression => $<constant-expression>.made,
        )
    }

    # rule labeled-statement-label-body:sym<default> { <default_> } 
    method labeled-statement-label-body:sym<default>($/) {
        make LabeledStatementLabelBody::Default.new
    }

    # rule labeled-statement-label { <attribute-specifier-seq>? <labeled-statement-label-body> <colon> }
    method labeled-statement-label($/) {
        make LabeledStatementLabel.new(
            attribute-specifier-seq      => $<attribute-specifier-seq>.made,
            labeled-statement-label-body => $<labeled-statement-label-body>.made,
        )
    }

    # rule labeled-statement { <labeled-statement-label> <statement> }
    method labeled-statement($/) {
        make LabeledStatement.new(
            labeled-statement-label => $<labeled-statement-label>.made,
            statement               => $<statement>.made,
        )
    }

    # rule declaration-statement { <block-declaration> } 
    method declaration-statement($/) {
        make $<block-declaration>.made
    }

    # rule expression-statement { <expression>? <semi> }
    method expression-statement($/) {

        my $comment = $<semi>.made;
        my $body    = $<expression>.made;

        if $comment {
            make ExpressionStatement.new(
                comment    => $comment,
                expression => $body,
            )
        } else {
            make $body
        }
    }

    # rule compound-statement { <.left-brace> <statement-seq>? <.right-brace> }
    method compound-statement($/) {
        make $<statement-seq>.made
    }

    # regex statement-seq { <statement> [<.ws> <statement>]* } 
    method statement-seq($/) {
        make $<statement>>>.made;
    }

    # rule selection-statement:sym<if> { <if_> <.left-paren> <condition> <.right-paren> <statement> [ <comment>? <else_> <statement> ]? }
    method selection-statement:sym<if>($/) {
        my @statements = $<statement>>>.made;
        make SelectionStatement::If.new(
            condition              => $<condition>.made,
            statement              => @statements[0],
            else-statement-comment => $<comment>.made // Nil,
            else-statement         => @statements[1] // Nil,
        )
    }

    # rule selection-statement:sym<switch> { <switch> <.left-paren> <condition> <.right-paren> <statement> } 
    method selection-statement:sym<switch>($/) {
        make SelectionStatement::Switch.new(
            condition => $<condition>.made,
            statement => $<statement>.made,
        )
    }

    # rule condition:sym<expr> { <expression> } 
    method condition:sym<expr>($/) {
        make $<expression>.made
    }

    # rule condition-decl-tail:sym<assign-init> { <assign> <initializer-clause> }
    method condition-decl-tail:sym<assign-init>($/) {
        make ConditionDeclTail::AssignInit.new(
            initializer-clause => $<initializer-clause>.made,
        )
    }

    # rule condition-decl-tail:sym<braced-init> { <braced-init-list> } 
    method condition-decl-tail:sym<braced-init>($/) {
        make $<braced-init-list>.made
    }

    # rule condition:sym<decl> { <attribute-specifier-seq>? <decl-specifier-seq> <declarator> <condition-decl-tail> } 
    method condition:sym<decl>($/) {
        make Condition::Decl.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            decl-specifier-seq      => $<decl-specifier-seq>.made,
            declarator              => $<declarator>.made,
            condition-decl-tail     => $<condition-decl-tail>.made,
        )
    }

    # rule iteration-statement:sym<while> { <while_> <.left-paren> <condition> <.right-paren> <statement> }
    method iteration-statement:sym<while>($/) {
        make IterationStatement::While.new(
            condition => $<condition>.made,
            statement => $<statement>.made,
        )
    }

    # rule iteration-statement:sym<do> { <do_> <statement> <while_> <.left-paren> <expression> <.right-paren> <semi> }
    method iteration-statement:sym<do>($/) {
        make IterationStatement::Do.new(
            comment    => $<semi>.made // Nil,
            statement  => $<statement>.made,
            expression => $<expression>.made,
        )
    }

    # rule iteration-statement:sym<for> { 
    #   <for_> 
    #   <.left-paren> 
    #   <for-init-statement> 
    #   <condition>? 
    #   <semi> 
    #   <expression>? 
    #   <.right-paren> 
    #   <statement> 
    # }
    method iteration-statement:sym<for>($/) {
        make IterationStatement::For.new(
            comment            => $<semi>.made,
            for-init-statement => $<for-init-statement>.made,
            condition          => $<condition>.made,
            expression         => $<expression>.made,
            statement          => $<statement>.made,
        )
    }

    # rule iteration-statement:sym<for-range> { 
    #   <.for_> 
    #   <.left-paren> 
    #   <for-range-declaration> 
    #   <.colon> 
    #   <for-range-initializer> 
    #   <.right-paren> 
    #   <statement> 
    # } 
    method iteration-statement:sym<for-range>($/) {
        make IterationStatement::ForRange.new(
            for-range-declaration => $<for-range-declaration>.made,
            for-range-initializer => $<for-range-initializer>.made,
            statement             => $<statement>.made,
        )
    }

    # rule for-init-statement:sym<expression-statement> { <expression-statement> }
    method for-init-statement:sym<expression-statement>($/) {
        make $<expression-statement>.made
    }

    # rule for-init-statement:sym<simple-declaration> { <simple-declaration> }
    method for-init-statement:sym<simple-declaration>($/) {
        make $<simple-declaration>.made
    }

    # rule for-range-declaration { <attribute-specifier-seq>? <decl-specifier-seq> <declarator> }
    method for-range-declaration($/) {
        make ForRangeDeclaration.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            decl-specifier-seq      => $<decl-specifier-seq>.made,
            declarator              => $<declarator>.made,
        )
    }

    # rule for-range-initializer:sym<expression> { <expression> }
    method for-range-initializer:sym<expression>($/) {
        make $<expression>.made
    }

    # rule for-range-initializer:sym<braced-init-list> { <braced-init-list> } 
    method for-range-initializer:sym<braced-init-list>($/) {
        make $<braced-init-list>.made
    }

    # rule jump-statement:sym<break> { <break_> <semi> }
    method jump-statement:sym<break>($/) {
        make JumpStatement::Break.new(
            comment => $<semi>.made,
        )
    }

    # rule jump-statement:sym<continue> { <continue_> <semi> }
    method jump-statement:sym<continue>($/) {
        make JumpStatement::Continue.new(
            comment => $<semi>.made,
        )
    }

    # rule jump-statement:sym<return> { <return_> <return-statement-body>? <semi> }
    method jump-statement:sym<return>($/) {
        make JumpStatement::Return.new(
            comment               => $<semi>.made,
            return-statement-body => $<return-statement-body>.made,
        )
    }

    # rule jump-statement:sym<goto> { <goto_> <identifier> <semi> }
    method jump-statement:sym<goto>($/) {
        make JumpStatement::Goto.new(
            comment    => $<semi>.made,
            identifier => $<identifier>.made,
        )
    }

    # rule return-statement-body:sym<expr> { <expression> }
    method return-statement-body:sym<expr>($/) {
        make $<expression>.made
    }

    # rule return-statement-body:sym<braced-init-list> { <braced-init-list> }
    method return-statement-body:sym<braced-init-list>($/) {
        make $<braced-init-list>.made
    }

    # rule declarationseq { <declaration>+ } 
    method declarationseq($/) {

        my @decls = $<declaration>>>.made;

        if @decls.elems gt 1 {

            make Declarationseq.new(
                declarations => @decls,
            )

        } else {

            make @decls[0]
        }
    }

    # rule declaration:sym<block-declaration> { <block-declaration> }
    method declaration:sym<block-declaration>($/) {
        make $<block-declaration>.made
    }

    # rule declaration:sym<function-definition> { <function-definition> }
    method declaration:sym<function-definition>($/) {
        make $<function-definition>.made
    }

    # rule declaration:sym<template-declaration> { <template-declaration> }
    method declaration:sym<template-declaration>($/) {
        make $<template-declaration>.made
    }

    # rule declaration:sym<explicit-instantiation> { <explicit-instantiation> }
    method declaration:sym<explicit-instantiation>($/) {
        make $<explicit-instantiation>.made
    }

    # rule declaration:sym<explicit-specialization> { <explicit-specialization> }
    method declaration:sym<explicit-specialization>($/) {
        make $<explicit-specialization>.made
    }

    # rule declaration:sym<linkage-specification> { <linkage-specification> }
    method declaration:sym<linkage-specification>($/) {
        make $<linkage-specification>.made
    }

    # rule declaration:sym<namespace-definition> { <namespace-definition> }
    method declaration:sym<namespace-definition>($/) {
        make $<namespace-definition>.made
    }

    # rule declaration:sym<empty-declaration> { <empty-declaration> }
    method declaration:sym<empty-declaration>($/) {
        make $<empty-declaration>.made
    }

    # rule declaration:sym<attribute-declaration> { <attribute-declaration> }
    method declaration:sym<attribute-declaration>($/) {
        make $<attribute-declaration>.made
    }

    # rule block-declaration:sym<simple> { <simple-declaration> }
    method block-declaration:sym<simple>($/) {
        make $<simple-declaration>.made
    }

    # rule block-declaration:sym<asm> { <asm-definition> }
    method block-declaration:sym<asm>($/) {
        make $<asm-definition>.made
    }

    # rule block-declaration:sym<namespace-alias> { <namespace-alias-definition> }
    method block-declaration:sym<namespace-alias>($/) {
        make $<namespace-alias-definition>.made
    }

    # rule block-declaration:sym<using-decl> { <using-declaration> }
    method block-declaration:sym<using-decl>($/) {
        make $<using-declaration>.made
    }

    # rule block-declaration:sym<using-directive> { <using-directive> }
    method block-declaration:sym<using-directive>($/) {
        make $<using-directive>.made
    }

    # rule block-declaration:sym<static-assert> { <static-assert-declaration> }
    method block-declaration:sym<static-assert>($/) {
        make $<static-assert-declaration>.made
    }

    # rule block-declaration:sym<alias> { <alias-declaration> }
    method block-declaration:sym<alias>($/) {
        make $<alias-declaration>.made
    }

    # rule block-declaration:sym<opaque-enum-decl> { <opaque-enum-declaration> }
    method block-declaration:sym<opaque-enum-decl>($/) {
        make $<opaque-enum-declaration>.made
    }

    # rule alias-declaration { <.using> <identifier> <attribute-specifier-seq>? <.assign> <the-type-id> <.semi> } 
    method alias-declaration($/) {
        make AliasDeclaration.new(
            comment                 => $<semi>.made,
            identifier              => $<identifier>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            the-type-id             => $<the-type-id>.made,
        )
    }

    # rule simple-declaration:sym<basic> { <decl-specifier-seq>? <init-declarator-list>? <.semi> }
    method simple-declaration:sym<basic>($/) {
        make SimpleDeclaration::Basic.new(
            comment              => $<semi>.made,
            decl-specifier-seq   => $<decl-specifier-seq>.made,
            init-declarator-list => $<init-declarator-list>.made,
        )
    }

    # rule simple-declaration:sym<init-list> { <attribute-specifier-seq> <decl-specifier-seq>? <init-declarator-list> <.semi> }
    method simple-declaration:sym<init-list>($/) {
        make SimpleDeclaration::InitList.new(
            comment                 => $<semi>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            decl-specifier-seq      => $<decl-specifier-seq>.made,
            init-declarator-list    => $<init-declarator-list>.made,
        )
    }

    # rule static-assert-declaration { <static_assert> <.left-paren> <constant-expression> <.comma> <string-literal> <.right-paren> <.semi> }
    method static-assert-declaration($/) {
        make StaticAssertDeclaration.new(
            constant-expression => $<constant-expression>.made,
            string-literal      => $<string-literal>.made,
        )
    }

    # rule empty-declaration { <.semi> }
    method empty-declaration($/) {

        my $comment = $<semi>.made;

        if $comment {
            make EmptyDeclaration.new(
                comment => $comment,
            )
        }
    }

    # rule attribute-declaration { <attribute-specifier-seq> <.semi> } 
    method attribute-declaration($/) {

        my $comment = $<semi>.made;
        my $body    = $<attribute-specifier-seq>.made;

        if $comment {
            make AttributeDeclaration.new(
                comment                 => $comment,
                attribute-specifier-seq => $body,
            )
        } else {
            make $body
        }
    }

    # token decl-specifier:sym<storage-class> { <storage-class-specifier> }
    method decl-specifier:sym<storage-class>($/) {
        make $<storage-class-specifier>.made
    }

    # token decl-specifier:sym<type> { <type-specifier> }
    method decl-specifier:sym<type>($/) {
        make $<type-specifier>.made
    }

    # token decl-specifier:sym<func> { <function-specifier> }
    method decl-specifier:sym<func>($/) {
        make $<function-specifier>.made
    }

    # token decl-specifier:sym<friend> { <.friend> }
    method decl-specifier:sym<friend>($/) {
        make DeclSpecifier::Friend.new
    }

    # token decl-specifier:sym<typedef> { <.typedef> }
    method decl-specifier:sym<typedef>($/) {
        make DeclSpecifier::Typedef.new
    }

    # token decl-specifier:sym<constexpr> { <.constexpr> }
    method decl-specifier:sym<constexpr>($/) {
        make DeclSpecifier::Constexpr.new
    }

    # regex decl-specifier-seq { <decl-specifier> [<.ws> <decl-specifier>]*? <attribute-specifier-seq>? } 
    method decl-specifier-seq($/) {
        my @specifiers = $<decl-specifier>>>.made;
        my $seq        = $<attribute-specifier-seq>.made;

        if @specifiers.elems gt 1 or $seq {
            make DeclSpecifierSeq.new(
                decl-specifiers         => @specifiers,
                attribute-specifier-seq => $seq,
            )
        } else {
            make @specifiers[0]
        }
    }

    # rule storage-class-specifier:sym<register> { <.register> }
    method storage-class-specifier:sym<register>($/) {
        make StorageClassSpecifier::Register.new
    }

    # rule storage-class-specifier:sym<static> { <.static> }
    method storage-class-specifier:sym<static>($/) {
        make StorageClassSpecifier::Static.new
    }

    # rule storage-class-specifier:sym<thread_local> { <.thread_local> }
    method storage-class-specifier:sym<thread_local>($/) {
        make StorageClassSpecifier::Thread_local.new
    }

    # rule storage-class-specifier:sym<extern> { <.extern> }
    method storage-class-specifier:sym<extern>($/) {
        make StorageClassSpecifier::Extern.new
    }

    # rule storage-class-specifier:sym<mutable> { <.mutable> } 
    method storage-class-specifier:sym<mutable>($/) {
        make StorageClassSpecifier::Mutable.new
    }

    # rule function-specifier:sym<inline> { <.inline> }
    method function-specifier:sym<inline>($/) {
        make FunctionSpecifier::Inline.new
    }

    # rule function-specifier:sym<virtual> { <.virtual> }
    method function-specifier:sym<virtual>($/) {
        make FunctionSpecifier::Virtual.new
    }

    # rule function-specifier:sym<explicit> { <.explicit> }
    method function-specifier:sym<explicit>($/) {
        make FunctionSpecifier::Explicit.new
    }

    # rule typedef-name { <identifier> } 
    method typedef-name($/) {
        make $<identifier>.made
    }

    # rule type-specifier:sym<trailing-type-specifier> { <trailing-type-specifier> }
    method type-specifier:sym<trailing-type-specifier>($/) {
        make $<trailing-type-specifier>.made
    }

    # rule type-specifier:sym<class-specifier> { <class-specifier> }
    method type-specifier:sym<class-specifier>($/) {
        make $<class-specifier>.made
    }

    # rule type-specifier:sym<enum-specifier> { <enum-specifier> } 
    method type-specifier:sym<enum-specifier>($/) {
        make $<enum-specifier>.made
    }

    # rule trailing-type-specifier:sym<cv-qualifier> { <cv-qualifier> <simple-type-specifier> }
    method trailing-type-specifier:sym<cv-qualifier>($/) {
        make TrailingTypeSpecifier::CvQualifier.new(
            cv-qualifier          => $<cv-qualifier>.made,
            simple-type-specifier => $<simple-type-specifier>.made,
        )
    }

    # rule trailing-type-specifier:sym<simple> { <simple-type-specifier> }
    method trailing-type-specifier:sym<simple>($/) {
        make $<simple-type-specifier>.made
    }

    # rule trailing-type-specifier:sym<elaborated> { <elaborated-type-specifier> }
    method trailing-type-specifier:sym<elaborated>($/) {
        make $<elaborated-type-specifier>.made
    }

    # rule trailing-type-specifier:sym<typename> { <type-name-specifier> } 
    method trailing-type-specifier:sym<typename>($/) {
        make $<type-name-specifier>.made
    }

    # rule type-specifier-seq { <type-specifier>+ <attribute-specifier-seq>? }
    method type-specifier-seq($/) {

        my $tail  = $<attribute-specifier-seq>.made;
        my @items = $<type-specifier>>>.made;

        if $tail or @items.elems gt 1 {

            make TypeSpecifierSeq.new(
                type-specifiers         => @items,
                attribute-specifier-seq => $tail,
            )

        } else {

            make @items[0]
        }
    }

    # rule trailing-type-specifier-seq { <trailing-type-specifier>+ <attribute-specifier-seq>? }
    method trailing-type-specifier-seq($/) {
        my $tail  = $<attribute-specifier-seq>.made;
        my @items = $<trailing-type-specifier>>>.made;

        if $tail or @items.elems gt 1 {
            make TrailingTypeSpecifierSeq.new(
                trailing-type-specifiers => @items,
                attribute-specifier-seq  => $tail,
            )
        } else {
            make @items[0]
        }
    }

    # rule simple-type-length-modifier:sym<short> { <.short> }
    method simple-type-length-modifier:sym<short>($/) {
        make SimpleTypeLengthModifier::Short.new
    }

    # rule simple-type-length-modifier:sym<long_> { <.long_> }
    method simple-type-length-modifier:sym<long_>($/) {
        make SimpleTypeLengthModifier::Long.new
    }

    # rule simple-type-signedness-modifier:sym<unsigned> { <.unsigned> }
    method simple-type-signedness-modifier:sym<unsigned>($/) {
        make SimpleTypeSignednessModifier::Unsigned.new
    }

    # rule simple-type-signedness-modifier:sym<signed> { <.signed> }
    method simple-type-signedness-modifier:sym<signed>($/) {
        make SimpleTypeSignednessModifier::Signed.new
    }

    # rule full-type-name { <nested-name-specifier>? <the-type-name> }
    method full-type-name($/) {

        my $prefix = $<nested-name-specifier>.made;
        my $body   = $<the-type-name>.made;

        if $prefix {

            make FullTypeName.new(
                nested-name-specifier => $prefix,
                the-type-name         => $body,
            )

        } else {

            make $body
        }
    }

    # rule scoped-template-id { <nested-name-specifier> <.template> <simple-template-id> }
    method scoped-template-id($/) {
        make ScopedTemplateId.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            simple-template-id    => $<simple-template-id>.made,
        )
    }

    # rule simple-int-type-specifier { <simple-type-signedness-modifier>? <simple-type-length-modifier>* <int_> }
    method simple-int-type-specifier($/) {
        make SimpleIntTypeSpecifier.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
            simple-type-length-modifiers    => $<simple-type-length-modifier>>>.made,
        )
    }

    # rule simple-char-type-specifier { <simple-type-signedness-modifier>? <char_> }
    method simple-char-type-specifier($/) {
        make SimpleCharTypeSpecifier.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
        )
    }

    # rule simple-char16-type-specifier { <simple-type-signedness-modifier>? <char16> }
    method simple-char16-type-specifier($/) {
        make SimpleChar16TypeSpecifier.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
        )
    }

    # rule simple-char32-type-specifier { <simple-type-signedness-modifier>? <char32> }
    method simple-char32-type-specifier($/) {
        make SimpleChar32TypeSpecifier.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
        )
    }

    # rule simple-wchar-type-specifier { <simple-type-signedness-modifier>? <wchar> }
    method simple-wchar-type-specifier($/) {
        make SimpleWcharTypeSpecifier.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
        )
    }

    # rule simple-double-type-specifier { <simple-type-length-modifier>? <double> } 
    method simple-double-type-specifier($/) {
        make SimpleDoubleTypeSpecifier.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
        )
    }

    # regex simple-type-specifier:sym<int> { <simple-int-type-specifier> }
    method simple-type-specifier:sym<int>($/) {
        make $<simple-int-type-specifier>.made
    }

    # regex simple-type-specifier:sym<full> { <full-type-name> }
    method simple-type-specifier:sym<full>($/) {
        make $<full-type-name>.made
    }

    # regex simple-type-specifier:sym<scoped> { <scoped-template-id> }
    method simple-type-specifier:sym<scoped>($/) {
        make $<scoped-template-id>.made
    }

    # regex simple-type-specifier:sym<signedness-mod> { <simple-type-signedness-modifier> }
    method simple-type-specifier:sym<signedness-mod>($/) {
        make $<simple-type-signedness-modifier>.made
    }

    # regex simple-type-specifier:sym<signedness-mod-length> { 
    #   <simple-type-signedness-modifier>? 
    #   <simple-type-length-modifier>+ 
    # }
    method simple-type-specifier:sym<signedness-mod-length>($/) {
        make SimpleTypeSpecifier::SignednessModLength.new(
            simple-type-signedness-modifier => $<simple-type-signedness-modifier>.made,
            simple-type-length-modifier     => $<simple-type-length-modifier>>>.made,
        )
    }

    # regex simple-type-specifier:sym<char> { <simple-char-type-specifier> }
    method simple-type-specifier:sym<char>($/) {
        make $<simple-char-type-specifier>.made
    }

    # regex simple-type-specifier:sym<char16> { <simple-char16-type-specifier> }
    method simple-type-specifier:sym<char16>($/) {
        make $<simple-char16-type-specifier>.made
    }

    # regex simple-type-specifier:sym<char32> { <simple-char32-type-specifier> }
    method simple-type-specifier:sym<char32>($/) {
        make $<simple-char32-type-specifier>.made
    }

    # regex simple-type-specifier:sym<wchar> { <simple-wchar-type-specifier> }
    method simple-type-specifier:sym<wchar>($/) {
        make $<simple-wchar-type-specifier>.made
    }

    # regex simple-type-specifier:sym<bool> { <bool_> }
    method simple-type-specifier:sym<bool>($/) {
        make SimpleTypeSpecifier::Bool.new
    }

    # regex simple-type-specifier:sym<float> { <float> }
    method simple-type-specifier:sym<float>($/) {
        make SimpleTypeSpecifier::Float.new
    }

    # regex simple-type-specifier:sym<double> { <simple-double-type-specifier> }
    method simple-type-specifier:sym<double>($/) {
        make $<simple-double-type-specifier>.made
    }

    # regex simple-type-specifier:sym<void> { <void_> }
    method simple-type-specifier:sym<void>($/) {
        make SimpleTypeSpecifier::Void.new
    }

    # regex simple-type-specifier:sym<auto> { <auto> }
    method simple-type-specifier:sym<auto>($/) {
        make SimpleTypeSpecifier::Auto.new
    }

    # regex simple-type-specifier:sym<decltype> { <decltype-specifier> } 
    method simple-type-specifier:sym<decltype>($/) {
        make $<decltype-specifier>.made
    }

    # rule the-type-name:sym<simple-template-id> { <simple-template-id> }
    method the-type-name:sym<simple-template-id>($/) {
        make $<simple-template-id>.made
    }

    # rule the-type-name:sym<class> { <class-name> }
    method the-type-name:sym<class>($/) {
        make $<class-name>.made
    }

    # rule the-type-name:sym<enum> { <enum-name> }
    method the-type-name:sym<enum>($/) {
        make $<enum-name>.made
    }

    # rule the-type-name:sym<typedef> { <typedef-name> } 
    method the-type-name:sym<typedef>($/) {
        make $<typedef-name>.made
    }

    # rule decltype-specifier-body:sym<expr> { <expression> }
    method decltype-specifier-body:sym<expr>($/) {
        make $<expression>.made
    }

    # rule decltype-specifier-body:sym<auto> { <auto> }
    method decltype-specifier-body:sym<auto>($/) {
        make DecltypeSpecifierBody::Auto.new
    }

    # rule decltype-specifier { <decltype> <.left-paren> <decltype-specifier-body> <.right-paren> } 
    method decltype-specifier($/) {
        make DecltypeSpecifier.new(
            decltype-specifier-body => $<decltype-specifier-body>.made,
        )
    }

    # rule elaborated-type-specifier:sym<class-ident> { 
    #   <.class-key> 
    #   <attribute-specifier-seq>? 
    #   <nested-name-specifier>? 
    #   <identifier> 
    # }
    method elaborated-type-specifier:sym<class-ident>($/) {
        make ElaboratedTypeSpecifier::ClassIdent.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            nested-name-specifier   => $<nested-name-specifier>.made,
            identifier              => $<identifier>.made,
        )
    }

    # rule elaborated-type-specifier:sym<class-template-id> { <.class-key> <simple-template-id> }
    method elaborated-type-specifier:sym<class-template-id>($/) {
        make ElaboratedTypeSpecifier::ClassTemplateId.new(
            simple-template-id => $<simple-template-id>.made,
        )
    }

    # rule elaborated-type-specifier:sym<class-nested-template-id> { 
    #   <.class-key> 
    #   <nested-name-specifier> 
    #   <template>? 
    #   <simple-template-id> 
    # }
    method elaborated-type-specifier:sym<class-nested-template-id>($/) {
        make ElaboratedTypeSpecifier::ClassNestedTemplateId.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            simple-template-id    => $<simple-template-id>.made,
        )
    }

    # rule elaborated-type-specifier:sym<enum> { <.enum_> <nested-name-specifier>? <identifier> } 
    method elaborated-type-specifier:sym<enum>($/) {
        make ElaboratedTypeSpecifier::Enum.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            identifier            => $<identifier>.made,
        )
    }

    # rule enum-name { <identifier> }
    method enum-name($/) {
        make $<identifier>.made
    }

    # rule enum-specifier { <enum-head> <.left-brace> [ <enumerator-list> <.comma>? ]? <.right-brace> }
    method enum-specifier($/) {
        make EnumSpecifier.new(
            enumerator-list => $<enumerator-list>.made,
        )
    }

    # rule enum-head { <.enumkey> <attribute-specifier-seq>? [ <nested-name-specifier>? <identifier> ]? <enumbase>? }
    method enum-head($/) {
        make EnumHead.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            nested-name-specifier   => $<nested-name-specifier>.made,
            identifier              => $<identifier>.made,
            enum-base               => $<enum-base>.made,
        )
    }

    # rule opaque-enum-declaration { <.enumkey> <attribute-specifier-seq>? <identifier> <enumbase>? <semi> }
    method opaque-enum-declaration($/) {
        make OpaqueEnumDeclaration.new(
            comment                 => $<semi>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            identifier              => $<identifier>.made,
            enum-base               => $<enum-base>.made,
        )
    }

    # rule enumkey { <enum_> [ <class_> || <struct> ]? }
    method enumkey($/) {
        make Enumkey.new
    }

    # rule enumbase { <colon> <type-specifier-seq> }
    method enumbase($/) {
        make Enumbase.new(
            type-specifier-seq => $<type-specifier-seq>.made,
        )
    }

    # rule enumerator-list { <enumerator-definition> [ <.comma> <enumerator-definition> ]* }
    method enumerator-list($/) {
        make $<enumerator-definition>>>.made
    }

    # rule enumerator-definition { <enumerator> [ <assign> <constant-expression> ]? }
    method enumerator-definition($/) {
        make EnumeratorDefinition.new(
            enumerator          => $<enumerator>.made,
            constant-expression => $<constant-expression>.made,
        )
    }

    # rule enumerator { <identifier> }
    method enumerator($/) {
        make $<identifier>.made
    }

    # rule namespace-name:sym<original> { <original-namespace-name> }
    method namespace-name:sym<original>($/) {
        make $<original-namespace-name>.made
    }

    # rule namespace-name:sym<alias> { <namespace-alias> }
    method namespace-name:sym<alias>($/) {
        make $<namespace-alias>.made
    }

    # rule original-namespace-name { <identifier> } 
    method original-namespace-name($/) {
        make $<identifier>.made
    }

    # rule namespace-tag:sym<ident> { <identifier> }
    method namespace-tag:sym<ident>($/) {
        make $<identifier>.made
    }

    # rule namespace-tag:sym<ns-name> { <original-namespace-name> } 
    method namespace-tag:sym<ns-name>($/) {
        make $<original-namespace-name>.made
    }

    # rule namespace-definition { <inline>? <namespace> <namespace-tag>? <.left-brace> <namespaceBody=declarationseq>? <.right-brace> }
    method namespace-definition($/) {
        make NamespaceDefinition.new(
            inline         => $<inline>.made,
            namespace-tag  => $<namespace-tag>.made,
            namespace-body => $<namespace-body>.made,
        )
    }

    # rule namespace-alias { <identifier> }
    method namespace-alias($/) {
        make $<identifier>.made
    }

    # rule namespace-alias-definition { <namespace> <identifier> <assign> <qualifiednamespacespecifier> <semi> }
    method namespace-alias-definition($/) {
        make NamespaceAliasDefinition.new(
            comment                     => $<semi>.made,
            identifier                  => $<identifier>.made,
            qualifiednamespacespecifier => $<qualifiednamespacespecifier>.made,
        )
    }

    # rule qualifiednamespacespecifier { <nested-name-specifier>? <namespace-name> } 
    method qualifiednamespacespecifier($/) {

        my $prefix = $<nested-name-specifier>.made;
        my $body   = $<namespace-name>.made;

        if $prefix {
            make Qualifiednamespacespecifier.new(
                nested-name-specifier => $prefix,
                namespace-name        => $body,
            )
        } else {
            make $body
        }
    }

    # rule using-declaration-prefix:sym<nested> { [ <typename_>? <nested-name-specifier> ] }
    method using-declaration-prefix:sym<nested>($/) {
        make UsingDeclarationPrefix::Nested.new(
            nested-name-specifier => $<nested-name-specifier>.made,
        )
    }

    # rule using-declaration-prefix:sym<base> { <doublecolon> } 
    method using-declaration-prefix:sym<base>($/) {
        make UsingDeclarationPrefix::Base.new
    }

    # rule using-declaration { <using> <using-declaration-prefix> <unqualified-id> <semi> }
    method using-declaration($/) {
        make UsingDeclaration.new(
            comment                  => $<semi>.made,
            using-declaration-prefix => $<using-declaration-prefix>.made,
            unqualified-id           => $<unqualified-id>.made,
        )
    }

    # rule using-directive { <attribute-specifier-seq>? <using> <namespace> <nested-name-specifier>? <namespace-name> <semi> }
    method using-directive($/) {
        make UsingDirective.new(
            comment                 => $<semi>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            nested-name-specifier   => $<nested-name-specifier>.made,
            namespace-name          => $<namespace-name>.made,
        )
    }

    # rule asm-definition { <asm> <.left-paren> <string-literal> <.right-paren> <.semi> } 
    method asm-definition($/) {
        make AsmDefinition.new(
            comment        => $<semi>.made,
            string-literal => $<string-literal>.made,
        )
    }

    # rule linkage-specification-body:sym<seq> { <.left-brace> <declarationseq>? <.right-brace> }
    method linkage-specification-body:sym<seq>($/) {
        make $<declarationseq>.made
    }

    # rule linkage-specification-body:sym<decl> { <declaration> }
    method linkage-specification-body:sym<decl>($/) {
        make $<declaration>.made
    }

    # rule linkage-specification { <extern> <string-literal> <linkage-specification-body> }
    method linkage-specification($/) {
        make LinkageSpecification.new(
            string-literal => $<string-literal>.made,
            linkage-specification-body => $<linkage-specification-body>.made,
        )
    }

    # rule attribute-specifier-seq { <attribute-specifier>+ } 
    method attribute-specifier-seq($/) {
        make $<attribute-specifier>>>.made
    }

    # rule attribute-specifier:sym<double-braced> { <.left-bracket> <.left-bracket> <attribute-list>? <.right-bracket> <.right-bracket> }
    method attribute-specifier:sym<double-braced>($/) {
        make $<attribute-list>.made
    }

    # rule attribute-specifier:sym<alignment> { <alignmentspecifier> } 
    method attribute-specifier:sym<alignment>($/) {
        make $<alignmentspecifier>.made
    }

    # rule alignmentspecifierbody:sym<type-id> { <the-type-id> }
    method alignmentspecifierbody:sym<type-id>($/) {
        make $<the-type-id>.made
    }

    # rule alignmentspecifierbody:sym<const-expr> { <constant-expression> } 
    method alignmentspecifierbody:sym<const-expr>($/) {
        make $<constant-expression>.made
    }

    # rule alignmentspecifier { <alignas> <.left-paren> <alignmentspecifierbody> <ellipsis>? <.right-paren> }
    method alignmentspecifier($/) {
        make Alignmentspecifier.new(
            alignmentspecifierbody => $<alignmentspecifierbody>.made,
            has-ellipsis           => $<has-ellipsis>.made,
        )
    }

    # rule attribute-list { <attribute> [ <.comma> <attribute> ]* <ellipsis>? }
    method attribute-list($/) {

        my $has-ellipsis = so $/<ellipsis>:exists;
        my @attribs      = $<attribute>>>.made;

        if $has-ellipsis {

            make AttributeList.new(
                attributes   => @attribs,
                has-ellipsis => $has-ellipsis,
            )

        } else {
            make @attribs[0]
        }
    }

    # rule attribute { [ <attribute-namespace> <doublecolon> ]? <identifier> <attribute-argument-clause>? }
    method attribute($/) {
        make Attribute.new(
            attribute-namespace       => $<attribute-namespace>.made,
            identifier                => $<identifier>.made,
            attribute-argument-clause => $<attribute-argument-clause>.made,
        )
    }

    # rule attribute-namespace { <identifier> }
    method attribute-namespace($/) {
        make $<identifier>.made
    }

    # rule attribute-argument-clause { <.left-paren> <balanced-token-seq>? <.right-paren> }
    method attribute-argument-clause($/) {
        make $<balanced-token-seq>.made
    }

    # rule balanced-token-seq { <balancedrule>+ } 
    method balanced-token-seq($/) {
        make $<balancedrule>>>.made
    }

    # rule balancedrule:sym<parens> { <.left-paren> <balanced-token-seq> <.right-paren> }
    method balancedrule:sym<parens>($/) {
        make $<balanced-token-seq>.made
    }

    # rule balancedrule:sym<brackets> { <.left-bracket> <balanced-token-seq> <.right-bracket> }
    method balancedrule:sym<brackets>($/) {
        make $<balanced-token-seq>.made
    }

    # rule balancedrule:sym<braces> { <.left-brace> <balanced-token-seq> <.right-brace> } 
    method balancedrule:sym<braces>($/) {
        make $<balanced-token-seq>.made
    }

    # rule init-declarator-list { <init-declarator> [ <.comma> <init-declarator> ]* }
    method init-declarator-list($/) {
        make $<init-declarator>>>.made
    }

    # rule init-declarator { <declarator> <initializer>? } 
    method init-declarator($/) {

        my $initializer = $<initializer>.made;
        my $body        = $<declarator>.made;

        if $initializer {

            make InitDeclarator.new(
                declarator  => $body,
                initializer => $initializer,
            )

        } else {

            make $body
        }
    }

    # rule declarator:sym<ptr> { <pointer-declarator> }
    method declarator:sym<ptr>($/) {
        make $<pointer-declarator>.made
    }

    # rule declarator:sym<no-ptr> { <no-pointer-declarator> <parameters-and-qualifiers> <trailing-return-type> }
    method declarator:sym<no-ptr>($/) {
        make Declarator::NoPtr.new(
            no-pointer-declarator     => $<no-pointer-declarator>.made,
            parameters-and-qualifiers => $<parameters-and-qualifiers>.made,
            trailing-return-type      => $<trailing-return-type>.made,
        )
    }

    # rule pointer-declarator { <augmented-pointer-operator>* <no-pointer-declarator> }
    method pointer-declarator($/) {

        my $base      = $<no-pointer-declarator>.made;
        my @augmented = $<augmented-pointer-operator>>>.made.List;

        if @augmented.elems gt 0 {

            make PointerDeclarator.new(
                augmented-pointer-operators => @augmented,
                no-pointer-declarator       => $base,
            )

        } else {

            make $base
        }
    }

    # rule augmented-pointer-operator { <pointer-operator> <const>? } 
    method augmented-pointer-operator($/) {

        my $const = $<const>.made;
        my $body  = $<pointer-operator>.made;

        if $const {
            make AugmentedPointerOperator.new(
                pointer-operator => $body,
                const            => $const,
            )
        } else {
            make $body
        }
    }

    # rule no-pointer-declarator-base:sym<base> { <declaratorid> <attribute-specifier-seq>? }
    method no-pointer-declarator-base:sym<base>($/) {
        my $base  = $<declaratorid>.made;
        my $maybe = $<attribute-specifier-seq>.made;

        if $maybe {
            make NoPointerDeclaratorBase::Base.new(
                declaratorid            => $base,
                attribute-specifier-seq => $maybe,
            )

        } else {
            make $base
        }
    }

    # rule no-pointer-declarator-base:sym<parens> { <.left-paren> <pointer-declarator> <.right-paren> } 
    method no-pointer-declarator-base:sym<parens>($/) {
        make $<pointer-declarator>.made
    }

    # rule no-pointer-declarator-tail:sym<basic> { <parameters-and-qualifiers> }
    method no-pointer-declarator-tail:sym<basic>($/) {
        make $<parameters-and-qualifiers>.made
    }

    # rule no-pointer-declarator-tail:sym<bracketed> { <.left-bracket> <constant-expression>? <.right-bracket> <attribute-specifier-seq>? } 
    method no-pointer-declarator-tail:sym<bracketed>($/) {
        make NoPointerDeclaratorTail::Bracketed.new(
            constant-expression     => $<constant-expression>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
        )
    }

    # rule no-pointer-declarator { <no-pointer-declarator-base> <no-pointer-declarator-tail>* } 
    method no-pointer-declarator($/) {

        my @tail = $<no-pointer-declarator-tail>>>.made;
        my $base = $<no-pointer-declarator-base>.made;

        if @tail.elems gt 0 {

            make NoPointerDeclarator.new(
                no-pointer-declarator-base => $base,
                no-pointer-declarator-tail => @tail,
            )

        } else {

            make $base
        }
    }

    # rule parameters-and-qualifiers { 
    #   <.left-paren> 
    #   <parameter-declaration-clause>? 
    #   <.right-paren> 
    #   <cvqualifierseq>? 
    #   <refqualifier>? 
    #   <exception-specification>? 
    #   <attribute-specifier-seq>? 
    # j}
    method parameters-and-qualifiers($/) {
        make ParametersAndQualifiers.new(
            parameter-declaration-clause => $<parameter-declaration-clause>.made,
            cvqualifierseq               => $<cvqualifierseq>.made,
            refqualifier                 => $<refqualifier>.made,
            exception-specification      => $<exception-specification>.made,
            attribute-specifier-seq      => $<attribute-specifier-seq>.made,
        )
    }

    # rule trailing-return-type { <arrow> <trailing-type-specifier-seq> <abstract-declarator>? } 
    method trailing-return-type($/) {
        make TrailingReturnType.new(
            trailing-type-specifier-seq => $<trailing-type-specifier-seq>.made,
            abstract-declarator         => $<abstract-declarator>.made,
        )
    }

    # rule pointer-operator:sym<ref> { <and_> <attribute-specifier-seq>? }
    method pointer-operator:sym<ref>($/) {
        make PointerOperator::Ref.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
        )
    }

    # rule pointer-operator:sym<ref-ref> { <and-and> <attribute-specifier-seq>? }
    method pointer-operator:sym<ref-ref>($/) {
        make PointerOperator::RefRef.new(
            and-and                 => $<and-and>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
        )
    }

    # rule pointer-operator:sym<star> { <nested-name-specifier>? <star> <attribute-specifier-seq>? <cvqualifierseq>? }
    method pointer-operator:sym<star>($/) {
        make PointerOperator::Star.new(
            nested-name-specifier   => $<nested-name-specifier>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            cvqualifierseq          => $<cvqualifierseq>.made,
        )
    }

    # rule cvqualifierseq { <cv-qualifier>+ } 
    method cvqualifierseq($/) {
        make $<cv-qualifier>>>.made
    }

    # rule cv-qualifier:sym<const> { <const> }
    method cv-qualifier:sym<const>($/) {
        make CvQualifier::Const.new
    }

    # rule cv-qualifier:sym<volatile> { <volatile> } 
    method cv-qualifier:sym<volatile>($/) {
        make CvQualifier::Volatile.new
    }

    # rule refqualifier:sym<and> { <and_> }
    method refqualifier:sym<and>($/) {
        make Refqualifier::And.new
    }

    # rule refqualifier:sym<and-and> { <and-and> } 
    method refqualifier:sym<and-and>($/) {
        make Refqualifier::AndAnd.new
    }

    # rule declaratorid { <ellipsis>? <id-expression> }
    method declaratorid($/) {

        my $has-ellipsis = so $/<ellipsis>:exists;
        my $body         = $<id-expression>.made;

        if $has-ellipsis {
            make Declaratorid.new(
                has-ellipsis  => $has-ellipsis,
                id-expression => $body,
            )
        } else {
            make $body
        }
    }

    # rule the-type-id { <type-specifier-seq> <abstract-declarator>? } 
    method the-type-id($/) {

        my $tail = $<abstract-declarator>.made;
        my $body = $<type-specifier-seq>.made;

        if $tail {
            make TheTypeId.new(
                type-specifier-seq  => $body,
                abstract-declarator => $tail,
            )
        } else {
            make $body
        }
    }

    # rule abstract-declarator:sym<base> { <pointer-abstract-declarator> }
    method abstract-declarator:sym<base>($/) {
        make $<pointer-abstract-declarator>.made
    }

    # rule abstract-declarator:sym<aug> { <no-pointer-abstract-declarator>? <parameters-and-qualifiers> <trailing-return-type> }
    method abstract-declarator:sym<aug>($/) {
        make AbstractDeclarator::Aug.new(
            no-pointer-abstract-declarator => $<no-pointer-abstract-declarator>.made,
            parameters-and-qualifiers      => $<parameters-and-qualifiers>.made,
            trailing-return-type           => $<trailing-return-type>.made,
        )
    }

    # rule abstract-declarator:sym<abstract-pack> { <abstract-pack-declarator> } 
    method abstract-declarator:sym<abstract-pack>($/) {
        make $<abstract-pack-declarator>.made
    }

    # rule pointer-abstract-declarator:sym<no-ptr> { <no-pointer-abstract-declarator> }
    method pointer-abstract-declarator:sym<no-ptr>($/) {
        make $<no-pointer-abstract-declarator>.made
    }

    # rule pointer-abstract-declarator:sym<ptr> { <pointer-operator>+ <no-pointer-abstract-declarator>? } 
    method pointer-abstract-declarator:sym<ptr>($/) {
        my @ops  = $<pointer-operator>>>.made;
        my $tail = $<no-pointer-abstract-declarator>.made;

        if $tail or @ops.elems gt 1 {
            make PointerAbstractDeclarator::Ptr.new(
                pointer-operators              => @ops,
                no-pointer-abstract-declarator => $tail,
            )
        } else {
            make @ops[0]
        }
    }

    # rule no-pointer-abstract-declarator-body:sym<base> { <parameters-and-qualifiers> }
    method no-pointer-abstract-declarator-body:sym<base>($/) {
        make $<parameters-and-qualifiers>.made
    }

    # rule no-pointer-abstract-declarator-body:sym<brack> { <no-pointer-abstract-declarator> <no-pointer-abstract-declarator-bracketed-base> }
    method no-pointer-abstract-declarator-body:sym<brack>($/) {
        make NoPointerAbstractDeclaratorBody::Brack.new(
            no-pointer-abstract-declarator                => $<no-pointer-abstract-declarator>.made,
            no-pointer-abstract-declarator-bracketed-base => $<no-pointer-abstract-declarator-bracketed-base>.made,
        )
    }

    # rule no-pointer-abstract-declarator { <no-pointer-abstract-declarator-base> <no-pointer-abstract-declarator-body>* } 
    method no-pointer-abstract-declarator($/) {

        my $base = $<no-pointer-abstract-declarator-base>.made;
        my @body = $<no-pointer-abstract-declarator-body>>>.made;

        if @body.elems gt 0 {
            make NoPointerAbstractDeclarator.new(
                no-pointer-abstract-declarator-base => $base,
                no-pointer-abstract-declarator-body => @body,
            )
        } else {
            make $base
        }
    }

    # rule no-pointer-abstract-declarator-base:sym<basic> { <parameters-and-qualifiers> }
    method no-pointer-abstract-declarator-base:sym<basic>($/) {
        make $<parameters-and-qualifiers>.made
    }

    # rule no-pointer-abstract-declarator-base:sym<bracketed> { <no-pointer-abstract-declarator-bracketed-base> }
    method no-pointer-abstract-declarator-base:sym<bracketed>($/) {
        make $<no-pointer-abstract-declarator-bracketed-base>.made
    }

    # rule no-pointer-abstract-declarator-base:sym<parenthesized> { <.left-paren> <pointer-abstract-declarator> <.right-paren> }
    method no-pointer-abstract-declarator-base:sym<parenthesized>($/) {
        make $<pointer-abstract-declarator>.made
    }

    # rule no-pointer-abstract-declarator-bracketed-base { <.left-bracket> <constant-expression>? <.right-bracket> <attribute-specifier-seq>? }
    method no-pointer-abstract-declarator-bracketed-base($/) {
        make NoPointerAbstractDeclaratorBracketedBase.new(
            constant-expression     => $<constant-expression>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
        )
    }

    # rule abstract-pack-declarator { <pointer-operator>* <no-pointer-abstract-pack-declarator> } 
    method abstract-pack-declarator($/) {

        my @ops  = $<pointer-operator>>>.made;
        my $body = $<no-pointer-abstract-pack-declarator>.made;

        if @ops.elems gt 0 {
            make AbstractPackDeclarator.new(
                pointer-operators                   => @ops,
                no-pointer-abstract-pack-declarator => $body,
            )

        } else {

            make $body
        }
    }

    # rule no-pointer-abstract-pack-declarator-basic { <parameters-and-qualifiers> }
    method no-pointer-abstract-pack-declarator-basic($/) {
        make $<parameters-and-qualifiers>.made
    }

    # rule no-pointer-abstract-pack-declarator-brackets { <.left-bracket> <constant-expression>? <.right-bracket> <attribute-specifier-seq>? } 
    method no-pointer-abstract-pack-declarator-brackets($/) {
        make NoPointerAbstractPackDeclaratorBrackets.new(
            constant-expression     => $<constant-expression>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
        )
    }

    # rule no-pointer-abstract-pack-declarator-body:sym<basic> { <no-pointer-abstract-pack-declarator-basic> }
    method no-pointer-abstract-pack-declarator-body:sym<basic>($/) {
        make $<no-pointer-abstract-pack-declarator-basic>.made
    }

    # rule no-pointer-abstract-pack-declarator-body:sym<brack> { <no-pointer-abstract-pack-declarator-brackets> } 
    method no-pointer-abstract-pack-declarator-body:sym<brack>($/) {
        make $<no-pointer-abstract-pack-declarator-brackets>.made
    }

    # rule no-pointer-abstract-pack-declarator { <ellipsis> <no-pointer-abstract-pack-declarator-body>* }
    method no-pointer-abstract-pack-declarator($/) {
        make $<no-pointer-abstract-pack-declarator-body>>>.made
    }

    # rule parameter-declaration-clause { <parameter-declaration-list> [ <.comma>? <ellipsis> ]? }
    method parameter-declaration-clause($/) {
        make ParameterDeclarationClause.new(
            parameter-declaration-list => $<parameter-declaration-list>.made,
            has-ellipsis               => $<has-ellipsis>.made,
        )
    }

    # rule parameter-declaration-list { <parameter-declaration> [ <.comma> <parameter-declaration> ]* } 
    method parameter-declaration-list($/) {
        make $<parameter-declaration>>>.made
    }

    # rule parameter-declaration-body:sym<decl> { <declarator> }
    method parameter-declaration-body:sym<decl>($/) {
        make $<declarator>.made
    }

    # rule parameter-declaration-body:sym<abst> { <abstract-declarator>? }
    method parameter-declaration-body:sym<abst>($/) {
        make $<abstract-declarator>.made
    }

    # rule parameter-declaration { <attribute-specifier-seq>? <decl-specifier-seq> <parameter-declaration-body> [ <assign> <initializer-clause> ]? }
    method parameter-declaration($/) {
        make ParameterDeclaration.new(
            attribute-specifier-seq    => $<attribute-specifier-seq>.made,
            decl-specifier-seq         => $<decl-specifier-seq>.made,
            parameter-declaration-body => $<parameter-declaration-body>.made,
            initializer-clause         => $<initializer-clause>.made,
        )
    }

    # rule function-definition { <attribute-specifier-seq>? <decl-specifier-seq>? <declarator> <virtual-specifier-seq>? <function-body> } 
    method function-definition($/) {
        make FunctionDefinition.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            decl-specifier-seq      => $<decl-specifier-seq>.made,
            declarator              => $<declarator>.made,
            virtual-specifier-seq   => $<virtual-specifier-seq>.made,
            function-body           => $<function-body>.made,
        )
    }

    # rule function-body:sym<compound> { <constructor-initializer>? <compound-statement> }
    method function-body:sym<compound>($/) {

        my $prefix = $<constructor-initializer>.made;
        my $body   = $<compound-statement>.made;

        if $prefix {
            make FunctionBody::Compound.new(
                constructor-initializer => $prefix,
                compound-statement      => $body,
            )
        } else {
            make $body
        }
    }

    # rule function-body:sym<try> { <function-try-block> }
    method function-body:sym<try>($/) {
        make $<function-try-block>.made
    }

    # rule function-body:sym<assign-default> { <assign> <default_> <semi> }
    method function-body:sym<assign-default>($/) {
        make FunctionBody::AssignDefault.new(
            comment        => $<semi>.made,
        )
    }

    # rule function-body:sym<assign-delete> { <assign> <delete> <semi> } 
    method function-body:sym<assign-delete>($/) {
        make FunctionBody::AssignDelete.new(
            comment        => $<semi>.made,
        )
    }

    # rule initializer:sym<brace-or-eq> { <brace-or-equal-initializer> }
    method initializer:sym<brace-or-eq>($/) {
        make $<brace-or-equal-initializer>.made
    }

    # rule initializer:sym<paren-expr-list> { <.left-paren> <expression-list> <.right-paren> } 
    method initializer:sym<paren-expr-list>($/) {
        make $<expression-list>.made
    }

    # rule brace-or-equal-initializer:sym<assign-init> { <assign> <initializer-clause> }
    method brace-or-equal-initializer:sym<assign-init>($/) {
        make $<initializer-clause>.made
    }

    # rule brace-or-equal-initializer:sym<braced-init-list> { <braced-init-list> } 
    method brace-or-equal-initializer:sym<braced-init-list>($/) {
        make $<braced-init-list>.made
    }

    # rule initializer-clause:sym<assignment> { <comment>? <assignment-expression> }
    method initializer-clause:sym<assignment>($/) {

        my $comment = $<comment>.made;
        my $base    = $<assignment-expression>.made;

        if $comment {
            make InitializerClause::Assignment.new(
                comment               => $comment,
                assignment-expression => $base,
            )
        } else {
            make $base
        }
    }

    # rule initializer-clause:sym<braced> { <comment>? <braced-init-list> } 
    method initializer-clause:sym<braced>($/) {

        my $comment = $<comment>.made;
        my $base    = $<braced-init-list>.made;

        if $comment {
            make InitializerClause::Braced.new(
                comment          => $comment,
                braced-init-list => $base,
            )
        } else {
            make $base
        }
    }

    # rule initializer-list { <initializer-clause> <ellipsis>? [ <.comma> <initializer-clause> <ellipsis>? ]* }
    method initializer-list($/) {
        make $<initializer-clause>>>.made
    }

    # rule braced-init-list { <.left-brace> [ <initializer-list> <.comma>? ]? <.right-brace> } 
    method braced-init-list($/) {
        make $<initializer-list>.made
    }

    # rule class-name:sym<id> { <identifier> }
    method class-name:sym<id>($/) {
        make $<identifier>.made
    }

    # rule class-name:sym<template-id> { <simple-template-id> }
    method class-name:sym<template-id>($/) {
        make $<simple-template-id>.made
    }

    # rule class-specifier { <class-head> <.left-brace> <member-specification>? <.right-brace> } 
    method class-specifier($/) {
        make ClassSpecifier.new(
            class-head           => $<class-head>.mde,
            member-specification => $<member-specification>.made,
        )
    }

    # rule class-head:sym<class> { 
    #   <.class-key> 
    #   <attribute-specifier-seq>? 
    #   [ <class-head-name> <class-virt-specifier>? ]? 
    #   <base-clause>? 
    # }
    method class-head:sym<class>($/) {
        make ClassHead::Class.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            class-head-name         => $<class-head-name>.made,
            class-virt-specifier    => $<class-virt-specifier>.made,
            base-clause             => $<base-clause>.made,
        )
    }

    # rule class-head:sym<union> { 
    #   <union> 
    #   <attribute-specifier-seq>? 
    #   [ <class-head-name> <class-virt-specifier>? ]? 
    # } 
    method class-head:sym<union>($/) {
        make ClassHead::Union.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            class-head-name         => $<class-head-name>.made,
            class-virt-specifier    => $<class-virt-specifier>.made,
        )
    }

    # rule class-head-name { <nested-name-specifier>? <class-name> }
    method class-head-name($/) {

        my $prefix = $<nested-name-specifier>.made;
        my $body   = $<class-name>.made;

        if $prefix {
            make ClassHeadName.new(
                nested-name-specifier => $prefix,
                class-name            => $body,
            )
        } else {
            make $body
        }
    }

    # rule class-virt-specifier { <final> } 
    method class-virt-specifier($/) {
        make ClassVirtSpecifier.new
    }

    # rule class-key:sym<class> { <.class_> }
    method class-key:sym<class>($/) {
        make ClassKey::Class.new
    }

    # rule class-key:sym<struct> { <.struct> } 
    method class-key:sym<struct>($/) {
        make ClassKey::Struct.new
    }

    # rule member-specification-base:sym<decl> { <memberdeclaration> }
    method member-specification-base:sym<decl>($/) {
        make $<memberdeclaration>.made
    }

    # rule member-specification-base:sym<access> { <access-specifier> <colon> }
    method member-specification-base:sym<access>($/) {
        make MemberSpecificationBase::Access.new(
            access-specifier => $<access-specifier>.made,
        )
    }

    # rule member-specification { <member-specification-base>+ } 
    method member-specification($/) {
        make $<member-specification-base>>>.made
    }

    # rule memberdeclaration:sym<basic> { 
    #   <attribute-specifier-seq>? 
    #   <decl-specifier-seq>? 
    #   <member-declarator-list>? 
    #   <semi> 
    # }
    method memberdeclaration:sym<basic>($/) {
        make Memberdeclaration::Basic.new(
            comment                 => $<semi>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            decl-specifier-seq      => $<decl-specifier-seq>.made,
            member-declarator-list  => $<member-declarator-list>.made,
        )
    }

    # rule memberdeclaration:sym<func> { <function-definition> }
    method memberdeclaration:sym<func>($/) {
        make $<function-definition>.made
    }

    # rule memberdeclaration:sym<using> { <using-declaration> }
    method memberdeclaration:sym<using>($/) {
        make $<using-declaration>.made
    }

    # rule memberdeclaration:sym<static-assert> { <static-assert-declaration> }
    method memberdeclaration:sym<static-assert>($/) {
        make $<static-assert-declaration>.made
    }

    # rule memberdeclaration:sym<template> { <template-declaration> }
    method memberdeclaration:sym<template>($/) {
        make $<template-declaration>.made
    }

    # rule memberdeclaration:sym<alias> { <alias-declaration> }
    method memberdeclaration:sym<alias>($/) {
        make $<alias-declaration>.made
    }

    # rule memberdeclaration:sym<empty> { <empty-declaration> } 
    method memberdeclaration:sym<empty>($/) {
        make Memberdeclaration::Empty.new
    }

    # rule member-declarator-list { <member-declarator> [ <.comma> <member-declarator> ]* } 
    method member-declarator-list($/) {
        make $<member-declarator>>>.made
    }

    # rule member-declarator:sym<virt> { <declarator> <virtual-specifier-seq>? <pure-specifier>? }
    method member-declarator:sym<virt>($/) {

        my $base = $<declarator>.made;
        my $t0   = $<virtual-specifier-seq>.made;
        my $t1   = $<pure-specifier>.made;

        if $t0 or $t1 {
            make MemberDeclarator::Virt.new(
                declarator            => $base,
                virtual-specifier-seq => $t0,
                pure-specifier        => $t1,
            )
        } else {
            make $base
        }
    }

    # rule member-declarator:sym<brace-or-eq> { <declarator> <brace-or-equal-initializer>? }
    method member-declarator:sym<brace-or-eq>($/) {
        my $body = $<declarator>.made;
        my $tail = $<brace-or-equal-initializer>.made;

        if $tail {
            make MemberDeclarator::BraceOrEq.new(
                declarator                 => $body,
                brace-or-equal-initializer => $tail,
            )
        } else {
            make $body
        }
    }

    # rule member-declarator:sym<ident> { <identifier>? <attribute-specifier-seq>? <colon> <constant-expression> } 
    method member-declarator:sym<ident>($/) {
        make MemberDeclarator::Ident.new(
            identifier              => $<identifier>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            constant-expression     => $<constant-expression>.made,
        )
    }

    # rule virtual-specifier-seq { <virtual-specifier>+ } 
    method virtual-specifier-seq($/) {
        make $<virtual-specifier>>>.made
    }

    # rule virtual-specifier:sym<override> { <override> }
    method virtual-specifier:sym<override>($/) {
        make VirtualSpecifier::Override.new
    }

    # rule virtual-specifier:sym<final> { <final> } 
    method virtual-specifier:sym<final>($/) {
        make VirtualSpecifier::Final.new
    }

    # rule pure-specifier { <assign> <val=octal-literal> 
    method pure-specifier($/) {
        make PureSpecifier.new(
            val => $<val>.made,
        )
    }

    # rule base-clause { <colon> <base-specifier-list> }
    method base-clause($/) {
        make BaseClause.new(
            base-specifier-list => $<base-specifier-list>.made,
        )
    }

    # rule base-specifier-list { <base-specifier> <ellipsis>? [ <.comma> <base-specifier> <ellipsis>? ]* } 
    method base-specifier-list($/) {
        make $<base-specifier>>>.made
    }

    # rule base-specifier:sym<base-type> { <attribute-specifier-seq>? <base-type-specifier> }
    method base-specifier:sym<base-type>($/) {
        make BaseSpecifier::BaseType.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            base-type-specifier     => $<base-type-specifier>.made,
        )
    }

    # rule base-specifier:sym<virtual> { <attribute-specifier-seq>? <virtual> <access-specifier>? <base-type-specifier> }
    method base-specifier:sym<virtual>($/) {
        make BaseSpecifier::Virtual.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            access-specifier        => $<access-specifier>.made,
            base-type-specifier     => $<base-type-specifier>.made,
        )
    }

    # rule base-specifier:sym<access> { <attribute-specifier-seq>? <access-specifier> <virtual>? <base-type-specifier> } 
    method base-specifier:sym<access>($/) {
        make BaseSpecifier::Access.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            access-specifier        => $<access-specifier>.made,
            is-virtual              => $<is-virtual>.made,
            base-type-specifier     => $<base-type-specifier>.made,
        )
    }

    # rule class-or-decl-type:sym<class> { <nested-name-specifier>? <class-name> }
    method class-or-decl-type:sym<class>($/) {
        make ClassOrDeclType::Class.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            class-name            => $<class-name>.made,
        )
    }

    # rule class-or-decl-type:sym<decltype> { <decltype-specifier> } 
    method class-or-decl-type:sym<decltype>($/) {
        make $<decltype-specifier>.made
    }

    # rule base-type-specifier { <class-or-decl-type> }
    method base-type-specifier($/) {
        make $<class-or-decl-type>.made
    }

    # rule access-specifier:sym<private> { <private> }
    method access-specifier:sym<private>($/) {
        make AccessSpecifier::Private.new
    }

    # rule access-specifier:sym<protected> { <protected> }
    method access-specifier:sym<protected>($/) {
        make AccessSpecifier::Protected.new
    }

    # rule access-specifier:sym<public> { <public> }
    method access-specifier:sym<public>($/) {
        make AccessSpecifier::Public.new
    }

    # rule conversion-function-id { <operator> <conversion-type-id> }
    method conversion-function-id($/) {
        make ConversionFunctionId.new(
            conversion-type-id => $<conversion-type-id>.made,
        )
    }

    # rule conversion-type-id { <type-specifier-seq> <conversion-declarator>? }
    method conversion-type-id($/) {
        make ConversionTypeId.new(
            type-specifier-seq => $<type-specifier-seq>.made,
            conversion-declarator => $<conversion-declarator>.made,
        )
    }

    # rule conversion-declarator { <pointer-operator> <conversion-declarator>? }
    method conversion-declarator($/) {
        make ConversionDeclarator.new(
            pointer-operator      => $<pointer-operator>.made,
            conversion-declarator => $<conversion-declarator>.made,
        )
    }

    # rule constructor-initializer { <colon> <mem-initializer-list> }
    method constructor-initializer($/) {
        make ConstructorInitializer.new(
            mem-initializer-list => $<mem-initializer-list>.made,
        )
    }

    # rule mem-initializer-list { <mem-initializer> <ellipsis>? [ <.comma> <mem-initializer> <ellipsis>? ]* } 
    method mem-initializer-list($/) {
        make MemInitializerList.new(
            mem-initializers => $<mem-initializer>>>.made,
        )
    }

    # rule mem-initializer:sym<expr-list> { <meminitializerid> <.left-paren> <expression-list>? <.right-paren> }
    method mem-initializer:sym<expr-list>($/) {
        make MemInitializer::ExprList.new(
            meminitializerid => $<meminitializerid>.made,
            expression-list  => $<expression-list>.made,
        )
    }

    # rule mem-initializer:sym<braced> { <meminitializerid> <braced-init-list> } 
    method mem-initializer:sym<braced>($/) {
        make MemInitializer::Braced.new(
            meminitializerid => $<meminitializerid>.made,
            braced-init-list => $<braced-init-list>.made,
        )
    }

    # rule meminitializerid:sym<class-or-decl> { <class-or-decl-type> }
    method meminitializerid:sym<class-or-decl>($/) {
        make $<class-or-decl-type>.made
    }

    # rule meminitializerid:sym<ident> { <identifier> }
    method meminitializerid:sym<ident>($/) {
        make $<identifier>.made
    }

    # rule operator-function-id { <operator> <the-operator> } 
    method operator-function-id($/) {
        make OperatorFunctionId.new(
            the-operator => $<the-operator>.made,
        )
    }

    # rule literal-operator-id:sym<string-lit> { <operator> <string-literal> <identifier> }
    method literal-operator-id:sym<string-lit>($/) {
        make LiteralOperatorId::StringLit.new(
            string-literal => $<string-literal>.made,
            identifier     => $<identifier>.made,
        )
    }

    # rule literal-operator-id:sym<user-defined> { <operator> <user-defined-string-literal> } 
    method literal-operator-id:sym<user-defined>($/) {
        make LiteralOperatorId::UserDefined.new(
            user-defined-string-literal => $<user-defined-string-literal>.made,
        )
    }

    # rule template-declaration { <template> <less> <templateparameter-list> <greater> <declaration> }
    method template-declaration($/) {
        make TemplateDeclaration.new(
            templateparameter-list => $<templateparameter-list>.made,
            declaration            => $<declaration>.made,
        )
    }

    # rule templateparameter-list { <template-parameter> [ <.comma> <template-parameter> ]* } 
    method templateparameter-list($/) {
        make @<template-parameter>>>.made
    }

    # rule template-parameter:sym<type> { <type-parameter> }
    method template-parameter:sym<type>($/) {
        make $<type-parameter>.made
    }

    # rule template-parameter:sym<param> { <parameter-declaration> } 
    method template-parameter:sym<param>($/) {
        make $<parameter-declaration>.made
    }

    # rule type-parameter-base:sym<basic> { [ <template> <less> <templateparameter-list> <greater> ]? <class_> }
    method type-parameter-base:sym<basic>($/) {
        make TypeParameterBase::Basic.new(
            templateparameter-list => $<templateparameter-list>.made,
        )
    }

    # rule type-parameter-base:sym<typename> { <typename_> } 
    method type-parameter-base:sym<typename>($/) {
        make TypeParameterBase::Typename.new
    }

    # rule type-parameter-suffix:sym<maybe-ident> { <ellipsis>? <identifier>? }
    method type-parameter-suffix:sym<maybe-ident>($/) {
        make TypeParameterSuffix::MaybeIdent.new(
            has-ellipsis => $<has-ellipsis>.made,
            identifier   => $<identifier>.made,
        )
    }

    # rule type-parameter-suffix:sym<assign-type-id> { <identifier>? <assign> <the-type-id> } 
    method type-parameter-suffix:sym<assign-type-id>($/) {
        make TypeParameterSuffix::AssignTypeId.new(
            identifier  => $<identifier>.made,
            the-type-id => $<the-type-id>.made,
        )
    }

    # rule type-parameter { <type-parameter-base> <type-parameter-suffix> }
    method type-parameter($/) {
        make TypeParameter.new(
            type-parameter-base   => $<type-parameter-base>.made,
            type-parameter-suffix => $<type-parameter-suffix>.made,
        )
    }

    # rule simple-template-id { <template-name> <less> <template-argument-list>? <greater> } 
    method simple-template-id($/) {
        make SimpleTemplateId.new(
            template-name          => $<template-name>.made,
            template-argument-list => $<template-argument-list>.made,
        )
    }

    # rule template-id:sym<simple> { <simple-template-id> }
    method template-id:sym<simple>($/) {
        make $<simple-template-id>.made
    }

    # rule template-id:sym<operator-function-id> { <operator-function-id> <less> <template-argument-list>? <greater> }
    method template-id:sym<operator-function-id>($/) {
        make TemplateId::OperatorFunctionId.new(
            operator-function-id   => $<operator-function-id>.made,
            template-argument-list => $<template-argument-list>.made,
        )
    }

    # rule template-id:sym<literal-operator-id> { <literal-operator-id> <less> <template-argument-list>? <greater> } 
    method template-id:sym<literal-operator-id>($/) {
        make TemplateId::LiteralOperatorId.new(
            literal-operator-id    => $<literal-operator-id>.made,
            template-argument-list => $<template-argument-list>.made,
        )
    }

    # token template-name { <identifier> }
    method template-name($/) {
        make $<identifier>.made
    }

    # rule template-argument-list { <template-argument> <ellipsis>? [ <.comma> <template-argument> <ellipsis>? ]* } 
    method template-argument-list($/) {
        make TemplateArgumentList.new(
            template-arguments => $<template-argument>>>.made,
        )
    }

    # token template-argument:sym<type-id> { <the-type-id> }
    method template-argument:sym<type-id>($/) {
        make $<the-type-id>.made
    }

    # token template-argument:sym<const-expr> { <constant-expression> }
    method template-argument:sym<const-expr>($/) {
        make $<constant-expression>.made
    }

    # token template-argument:sym<id-expr> { <id-expression> } 
    method template-argument:sym<id-expr>($/) {
        make $<id-expression>.made
    }

    # rule type-name-specifier:sym<ident> { <typename_> <nested-name-specifier> <identifier> }
    method type-name-specifier:sym<ident>($/) {
        make TypeNameSpecifier::Ident.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            identifier            => $<identifier>.made,
        )
    }

    # rule type-name-specifier:sym<template> { <typename_> <nested-name-specifier> <template>? <simple-template-id> } 
    method type-name-specifier:sym<template>($/) {
        make TypeNameSpecifier::Template.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            has-template          => $<has-template>.made,
            simple-template-id    => $<simple-template-id>.made,
        )
    }

    # rule explicit-instantiation { <extern>? <template> <declaration> }
    method explicit-instantiation($/) {
        make ExplicitInstantiation.new(
            declaration => $<declaration>.made,
        )
    }

    # rule explicit-specialization { <template> <less> <greater> <declaration> }
    method explicit-specialization($/) {
        make ExplicitSpecialization.new(
            declaration => $<declaration>.made,
        )
    }

    # rule try-block { <try_> <compound-statement> <handler-seq> }
    method try-block($/) {
        make TryBlock.new(
            compound-statement => $<compound-statement>.made,
            handler-seq        => $<handler-seq>.made,
        )
    }

    # rule function-try-block { <try_> <constructor-initializer>? <compound-statement> <handler-seq> }
    method function-try-block($/) {
        make FunctionTryBlock.new(
            constructor-initializer => $<constructor-initializer>.made,
            compound-statement      => $<compound-statement>.made,
            handler-seq             => $<handler-seq>.made,
        )
    }

    # rule handler-seq { <handler>+ }
    method handler-seq($/) {
        make $<handler>>>.made
    }

    # rule handler { <catch> <.left-paren> <exception-declaration> <.right-paren> <compound-statement> }
    method handler($/) {
        make Handler.new(
            exception-declaration => $<exception-declaration>.made,
            compound-statement    => $<compound-statement>.made,
        )
    }

    # rule some-declarator:sym<basic> { <declarator> }
    method some-declarator:sym<basic>($/) {
        make $<declarator>.made
    }

    # rule some-declarator:sym<abstract> { <abstract-declarator> } 
    method some-declarator:sym<abstract>($/) {
        make $<abstract-declarator>.made
    }

    # rule exception-declaration:sym<basic> { <attribute-specifier-seq>? <type-specifier-seq> <some-declarator>? }
    method exception-declaration:sym<basic>($/) {
        make ExceptionDeclaration::Basic.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            type-specifier-seq      => $<type-specifier-seq>.made,
            some-declarator         => $<some-declarator>.made,
        )
    }

    # rule exception-declaration:sym<ellipsis> { <ellipsis> }
    method exception-declaration:sym<ellipsis>($/) {
        make ExceptionDeclaration::Ellipsis.new
    }

    # rule throw-expression { <throw> <assignment-expression>? } 
    method throw-expression($/) {
        make ThrowExpression.new(
            assignment-expression => $<assignment-expression>.made,
        )
    }

    # token exception-specification:sym<dynamic> { <dynamic-exception-specification> }
    method exception-specification:sym<dynamic>($/) {
        make $<dynamic-exception-specification>.made
    }

    # token exception-specification:sym<noexcept> { <noe-except-specification> } 
    method exception-specification:sym<noexcept>($/) {
        make $<noe-except-specification>.made
    }

    # rule dynamic-exception-specification { <throw> <.left-paren> <type-id-list>? <.right-paren> }
    method dynamic-exception-specification($/) {
        make DynamicExceptionSpecification.new(
            type-id-list => $<type-id-list>.made,
        )
    }

    # rule type-id-list { <the-type-id> <ellipsis>? [ <.comma> <the-type-id> <ellipsis>? ]* } 
    method type-id-list($/) {
        make TypeIdList.new(
            the-type-ids => $<the-type-id>>>.made,
        )
    }

    # token noe-except-specification:sym<full> { <noexcept> <.left-paren> <constant-expression> <.right-paren> }
    method noe-except-specification:sym<full>($/) {
        make NoeExceptSpecification::Full.new(
            constant-expression => $<constant-expression>.made,
        )
    }

    # token noe-except-specification:sym<keyword-only> { <noexcept> } 
    method noe-except-specification:sym<keyword-only>($/) {
        make NoeExceptSpecification::KeywordOnly.new
    }

    # token the-operator:sym<new> { <new_> [ <.left-bracket> <.right-bracket>]? }
    method the-operator:sym<new>($/) {
        make TheOperator::New.new
    }

    # token the-operator:sym<delete> { <delete> [ <.left-bracket> <.right-bracket>]? }
    method the-operator:sym<delete>($/) {
        make TheOperator::Delete.new
    }

    # token the-operator:sym<plus> { <plus> }
    method the-operator:sym<plus>($/) {
        make TheOperator::Plus.new
    }

    # token the-operator:sym<minus> { <minus> }
    method the-operator:sym<minus>($/) {
        make TheOperator::Minus.new
    }

    # token the-operator:sym<star> { <star> }
    method the-operator:sym<star>($/) {
        make TheOperator::Star.new
    }

    # token the-operator:sym<div_> { <div_> }
    method the-operator:sym<div_>($/) {
        make TheOperator::Div.new
    }

    # token the-operator:sym<mod_> { <mod_> }
    method the-operator:sym<mod_>($/) {
        make TheOperator::Mod.new
    }

    # token the-operator:sym<caret> { <caret> }
    method the-operator:sym<caret>($/) {
        make TheOperator::Caret.new
    }

    # token the-operator:sym<and_> { <and_> <!before <and_>> }
    method the-operator:sym<and_>($/) {
        make TheOperator::And.new
    }

    # token the-operator:sym<or_> { <or_> }
    method the-operator:sym<or_>($/) {
        make TheOperator::Or.new
    }

    # token the-operator:sym<tilde> { <tilde> }
    method the-operator:sym<tilde>($/) {
        make TheOperator::Tilde.new
    }

    # token the-operator:sym<not> { <not_> }
    method the-operator:sym<not>($/) {
        make TheOperator::Not.new
    }

    # token the-operator:sym<assign> { <assign> }
    method the-operator:sym<assign>($/) {
        make TheOperator::Assign.new
    }

    # token the-operator:sym<greater> { <greater> }
    method the-operator:sym<greater>($/) {
        make TheOperator::Greater.new
    }

    # token the-operator:sym<less> { <less> }
    method the-operator:sym<less>($/) {
        make TheOperator::Less.new
    }

    # token the-operator:sym<greater-equal> { <greater-equal> }
    method the-operator:sym<greater-equal>($/) {
        make TheOperator::GreaterEqual.new
    }

    # token the-operator:sym<plus-assign> { <plus-assign> }
    method the-operator:sym<plus-assign>($/) {
        make TheOperator::PlusAssign.new
    }

    # token the-operator:sym<minus-assign> { <minus-assign> }
    method the-operator:sym<minus-assign>($/) {
        make TheOperator::MinusAssign.new
    }

    # token the-operator:sym<star-assign> { <star-assign> }
    method the-operator:sym<star-assign>($/) {
        make TheOperator::StarAssign.new
    }

    # token the-operator:sym<mod-assign> { <mod-assign> }
    method the-operator:sym<mod-assign>($/) {
        make TheOperator::ModAssign.new
    }

    # token the-operator:sym<xor-assign> { <xor-assign> }
    method the-operator:sym<xor-assign>($/) {
        make TheOperator::XorAssign.new
    }

    # token the-operator:sym<and-assign> { <and-assign> }
    method the-operator:sym<and-assign>($/) {
        make TheOperator::AndAssign.new
    }

    # token the-operator:sym<or-assign> { <or-assign> }
    method the-operator:sym<or-assign>($/) {
        make TheOperator::OrAssign.new
    }

    # token the-operator:sym<LessLess> { <less> <less> }
    method the-operator:sym<LessLess>($/) {
        make TheOperator::LessLess.new
    }

    # token the-operator:sym<GreaterGreater> { <greater> <greater> }
    method the-operator:sym<GreaterGreater>($/) {
        make TheOperator::GreaterGreater.new
    }

    # token the-operator:sym<right-shift-assign> { <right-shift-assign> }
    method the-operator:sym<right-shift-assign>($/) {
        make TheOperator::RightShiftAssign.new
    }

    # token the-operator:sym<left-shift-assign> { <left-shift-assign> }
    method the-operator:sym<left-shift-assign>($/) {
        make TheOperator::LeftShiftAssign.new
    }

    # token the-operator:sym<equal> { <equal> }
    method the-operator:sym<equal>($/) {
        make TheOperator::Equal.new
    }

    # token the-operator:sym<not-equal> { <not-equal> }
    method the-operator:sym<not-equal>($/) {
        make TheOperator::NotEqual.new
    }

    # token the-operator:sym<less-equal> { <less-equal> }
    method the-operator:sym<less-equal>($/) {
        make TheOperator::LessEqual.new
    }

    # token the-operator:sym<and-and> { <and-and> }
    method the-operator:sym<and-and>($/) {
        make TheOperator::AndAnd.new
    }

    # token the-operator:sym<or-or> { <or-or> }
    method the-operator:sym<or-or>($/) {
        make TheOperator::OrOr.new
    }

    # token the-operator:sym<plus-plus> { <plus-plus> }
    method the-operator:sym<plus-plus>($/) {
        make TheOperator::PlusPlus.new
    }

    # token the-operator:sym<minus-minus> { <minus-minus> }
    method the-operator:sym<minus-minus>($/) {
        make TheOperator::MinusMinus.new
    }

    # token the-operator:sym<comma> { <.comma> }
    method the-operator:sym<comma>($/) {
        make TheOperator::Comma.new
    }

    # token the-operator:sym<arrow-star> { <arrow-star> }
    method the-operator:sym<arrow-star>($/) {
        make TheOperator::ArrowStar.new
    }

    # token the-operator:sym<arrow> { <arrow> }
    method the-operator:sym<arrow>($/) {
        make TheOperator::Arrow.new
    }

    # token the-operator:sym<Parens> { <.left-paren> <.right-paren> }
    method the-operator:sym<Parens>($/) {
        make TheOperator::Parens.new
    }

    # token the-operator:sym<Brak> { <.left-bracket> <.right-bracket> }
    method the-operator:sym<Brak>($/) {
        make TheOperator::Brak.new
    }

    # token literal:sym<int> { <integer-literal> }
    method literal:sym<int>($/) {
        make $<integer-literal>.made
    }

    # token literal:sym<char> { <character-literal> }
    method literal:sym<char>($/) {
        make $<character-literal>.made,
    }

    # token literal:sym<float> { <floating-literal> } 
    method literal:sym<float>($/) {
        make $<floating-literal>.made,
    }

    # token literal:sym<str> { <string-literal> }
    method literal:sym<str>($/) {
        make $<string-literal>.made,
    }

    # token literal:sym<bool> { <boolean-literal> }
    method literal:sym<bool>($/) {
        make $<boolean-literal>.made
    }

    # token literal:sym<ptr> { <pointer-literal> }
    method literal:sym<ptr>($/) {
        make $<pointer-literal>.made
    }

    # token literal:sym<user-defined> { <user-defined-literal> }
    method literal:sym<user-defined>($/) {
        make $<user-defined-literal>.made
    }
}


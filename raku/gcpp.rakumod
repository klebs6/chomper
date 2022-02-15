use Grammar::Tracer;

our role CPP14Keyword {
    token alignas          { 'alignas'          } 
    token alignof          { 'alignof'          } 
    token asm              { 'asm'              } 
    token auto             { 'auto'             } 
    token bool_            { 'bool'             } 
    token break_           { 'break'            } 
    token case             { 'case'             } 
    token catch            { 'catch'            } 
    token char_            { 'char'             } 
    token char16           { 'char16_t'         } 
    token char32           { 'char32_t'         } 
    token class_           { 'class'            } 
    token const            { 'const'            } 
    token constexpr        { 'constexpr'        } 
    token const_cast       { 'const_cast'       } 
    token continue_        { 'continue'         } 
    token decltype         { 'decltype'         } 
    token default_         { 'default'          } 
    token delete           { 'delete'           } 
    token do_              { 'do'               } 
    token double           { 'double'           } 
    token dynamic_cast     { 'dynamic_cast'     } 
    token else_            { 'else'             } 
    token enum_            { 'enum'             } 
    token explicit         { 'explicit'         } 
    token export           { 'export'           } 
    token extern           { 'extern'           } 
    token false_           { 'false'            } 
    token final            { 'final'            } 
    token float            { 'float'            } 
    token for_             { 'for'              } 
    token friend           { 'friend'           } 
    token goto_            { 'goto'             } 
    token if_              { 'if'               } 
    token inline           { 'inline'           } 
    token int_             { 'int'              } 
    token long_            { 'long'             } 
    token mutable          { 'mutable'          } 
    token namespace        { 'namespace'        } 
    token new_             { 'new'              } 
    token noexcept         { 'noexcept'         } 
    token nullptr          { 'nullptr'          } 
    token operator         { 'operator'         } 
    token override         { 'override'         } 
    token private          { 'private'          } 
    token protected        { 'protected'        } 
    token public           { 'public'           } 
    token register         { 'register'         } 
    token reinterpret_cast { 'reinterpret_cast' } 
    token return_          { 'return'           } 
    token short            { 'short'            } 
    token signed           { 'signed'           } 
    token sizeof           { 'sizeof'           } 
    token static           { 'static'           } 
    token static_assert    { 'static_assert'    } 
    token static_cast      { 'static_cast'      } 
    token struct           { 'struct'           } 
    token switch           { 'switch'           } 
    token template         { 'template'         } 
    token this             { 'this'             } 
    token thread_local     { 'thread_local'     } 
    token throw            { 'throw'            } 
    token true_            { 'true'             } 
    token try_             { 'try'              } 
    token typedef          { 'typedef'          } 
    token typeid_          { 'typeid'           } 
    token typename_        { 'typename'         } 
    token union            { 'union'            } 
    token unsigned         { 'unsigned'         } 
    token using            { 'using'            } 
    token virtual          { 'virtual'          } 
    token void_            { 'void'             } 
    token volatile         { 'volatile'         } 
    token wchar            { 'wchar_t'          } 
    token while_           { 'while'            } 
    token left-paren       { '('                } 
    token right-paren      { ')'                } 
    token left-bracket     { '['                } 
    token right-bracket    { ']'                } 
    token left-brace       { '{'                } 
    token right-brace      { '}'                } 
    token plus             { '+'                } 
    token minus            { '-'                } 
    token star             { '*'                } 
    token div_             { '/'                } 
    token mod_             { '%'                } 
    token caret            { '^'                } 
    token and_             { '&'  <!before '&'>  } 
    token or_              { '|'  <!before '|'>  } 
    token tilde            { '~'                 } 
    token assign           { '='                 } 
    token less             { '<'  <!before '='>  } 
    token greater          { '>'  <!before '='>  } 
    token plus-assign      { '+='                } 
    token minus-assign     { '-='                } 
    token star-assign      { '*='                } 
    token div-assign       { '/='                } 
    token mod-assign       { '%='                } 
    token xor-assign       { '^='                } 
    token and-assign       { '&='                } 
    token or-assign        { '|='                } 
    token left-shift-assign  { '<<='             } 
    token right-shift-assign { '>>='             } 
    token equal            { '=='                } 
    token not-equal        { '!='                } 
    token less-equal       { '<='                } 
    token greater-equal    { '>='                } 
    token plus-plus        { '++'                } 
    token minus-minus      { '--'                } 
    token comma            { ','                 } 
    token arrow-star       { '->*'               } 
    token arrow            { '->'                } 
    token question         { '?'                 } 
    token colon            { ':'                 } 
    token doublecolon      { '::'                } 
    rule semi              { ';' <comment>?      }
    token dot              { '.'                 } 
    token dot-star         { '.*'                } 
    token ellipsis         { '...'               } 

    proto token not_        { * }
    token not_:sym<!>       { <sym> }
    token not_:sym<not>     { <sym> }

    proto token and-and     { * }
    token and-and:sym<&&>   { <sym> }
    token and-and:sym<and>  { <sym> }

    proto token or-or       { * }
    token or-or:sym<||>     { <sym> }
    token or-or:sym<or>     { <sym> }
}

our role CPP14Lexer does CPP14Keyword {

    #--------------------
    proto token integer-literal { * }
    token integer-literal:sym<dec> { <decimal-literal>     <integersuffix>? }
    token integer-literal:sym<oct> { <octal-literal>       <integersuffix>? }
    token integer-literal:sym<hex> { <hexadecimal-literal> <integersuffix>? }
    token integer-literal:sym<bin> { <binary-literal>      <integersuffix>? }

    #--------------------
    proto token character-literal-prefix { * }
    token character-literal-prefix:sym<u> { 'u' }
    token character-literal-prefix:sym<U> { 'U' }
    token character-literal-prefix:sym<L> { 'L' }

    token character-literal {
        <character-literal-prefix>? '\'' <cchar>+ '\''
    }

    #------------------------
    proto token floating-literal { * }

    token floating-literal:sym<frac> {
        <fractionalconstant>
        <exponentpart>?
        <floatingsuffix>?
    }

    token floating-literal:sym<digit> {
        <digitsequence>
        <exponentpart>
        <floatingsuffix>?
    }

    #------------------------
    token string-literal-item {
        <encodingprefix>?
        [   
           || <rawstring>
           || '"' <schar>* '"'
        ]
    }

    token string-literal {
        <string-literal-item> 
        [<.ws> <string-literal-item>]*
    }

    #--------------------
    proto token boolean-literal { * }
    token boolean-literal:sym<f> { <false_> }
    token boolean-literal:sym<t> { <true_> }

    token pointer-literal {
        <nullptr>
    }

    #--------------------
    proto token user-defined-literal { * }
    token user-defined-literal:syn<int>   { <user-defined-integer-literal> }
    token user-defined-literal:sym<float> { <user-defined-floating-literal> }
    token user-defined-literal:sym<str>   { <user-defined-string-literal> }
    token user-defined-literal:sym<char>  { <user-defined-character-literal> }

    token multi-line-macro {
        '#'
        [ <-[ \n ]>*? '\\' '\r'? '\n' ]
        <-[ \n ]>+
    }

    token directive {
        '#' <-[ \n ]>*
    }

    token hexquad {
        <hexadecimaldigit> ** 4
    }

    proto token universalcharactername { * }
    token universalcharactername:sym<one> { '\\u' <hexquad> }
    token universalcharactername:sym<two> { '\\U' <hexquad> <hexquad> }

    #-------------------
    proto token identifier-start { * }
    token identifier-start:sym<nondigit> { <nondigit> }
    token identifier-start:sym<ucn>      { <universalcharactername> }

    #-------------------
    proto token identifier-continue { * }
    token identifier-continue:sym<digit>    { <digit> }
    token identifier-continue:sym<nondigit> { <nondigit> }
    token identifier-continue:sym<ucn>      { <universalcharactername> }

    token identifier {
        <identifier-start>
        <identifier-continue>*
    }

    token nondigit {
        <[ a .. z A .. Z _]>
    }

    token digit {
        <[ 0 .. 9 ]>
    }

    token decimal-literal {
        <nonzerodigit> [ '\''?  <digit>]*
    }

    token octal-literal {
        '0' [ '\''?  <octaldigit>]*
    }

    token hexadecimal-literal {
        [ '0x' || '0X' ] <hexadecimaldigit> [ '\''?  <hexadecimaldigit> ]*
    }

    token binary-literal {
        [ '0b' || '0B' ] <binarydigit> [ '\''?  <binarydigit> ]*
    }

    token nonzerodigit {
        <[ 1 .. 9 ]>
    }

    token octaldigit {
        <[ 0 .. 7 ]>
    }

    token hexadecimaldigit {
        <[ 0 .. 9 ]>
    }

    token binarydigit {
        <[ 0 1 ]>
    }

    #------------------------------
    proto token integersuffix { * }
    token integersuffix:sym<ul>  { <unsignedsuffix> <longsuffix>? }
    token integersuffix:sym<ull> { <unsignedsuffix> <longlongsuffix>? }
    token integersuffix:sym<lu>  { <longsuffix>     <unsignedsuffix>? }
    token integersuffix:sym<llu> { <longlongsuffix> <unsignedsuffix>? }

    #------------------------------
    token unsignedsuffix {
        <[ u U ]>
    }

    token longsuffix {
        <[ l L ]>
    }

    #------------------------------
    proto token longlongsuffix { * }
    token longlongsuffix:sym<ll> { 'll' }
    token longlongsuffix:sym<LL> { 'LL' }

    #------------------------------
    proto token cchar { * }
    token cchar:sym<basic>     { <-[ \' \\ \r \n ]> }
    token cchar:sym<escape>    { <escapesequence> }
    token cchar:sym<universal> { <universalcharactername> }

    #------------------------------
    proto token escapesequence { * }
    token escapesequence:sym<simple> { <simpleescapesequence> }
    token escapesequence:sym<octal>  { <octalescapesequence> }
    token escapesequence:sym<hex>    { <hexadecimalescapesequence> }

    #------------------------------
    proto token simpleescapesequence { * }
    token simpleescapesequence:sym<slash>        { '\\\'' }
    token simpleescapesequence:sym<quote>        { '\\"' }
    token simpleescapesequence:sym<question>     { '\\?' }
    token simpleescapesequence:sym<double-slash> { '\\\\' }
    token simpleescapesequence:sym<a>            { '\\a' }
    token simpleescapesequence:sym<b>            { '\\b' }
    token simpleescapesequence:sym<f>            { '\\f' }
    token simpleescapesequence:sym<n>            { '\\n' }
    token simpleescapesequence:sym<r>            { '\\r' }
    token simpleescapesequence:sym<t>            { '\\t' }
    token simpleescapesequence:sym<v>            { '\\v' }
    token simpleescapesequence:sym<rn-n> {
        '\\'
        [   
            ||  '\r' '\n'?
            ||  '\n'
        ]
    }

    #------------------------------
    token octalescapesequence {
        '\\' [<octaldigit> ** 1..3]
    }

    token hexadecimalescapesequence {
        '\\x' <hexadecimaldigit>+
    }

    proto token fractionalconstant { * }
    token fractionalconstant:sym<with-tail> { <digitsequence>?  '.' <digitsequence> }
    token fractionalconstant:sym<no-tail>   { <digitsequence> '.' }

    token exponentpart-prefix {
        'e' || 'E'
    }

    token exponentpart {
        <exponentpart-prefix> <sign>?  <digitsequence>
    }

    token sign {
        <[ + - ]>
    }

    token digitsequence {
        <digit> [  '\''?  <digit>]*
    }

    token floatingsuffix {
        <[ f l F L ]>
    }

    #------------------
    proto token encodingprefix { * }
    token encodingprefix:sym<u8> { 'u8' }
    token encodingprefix:sym<u>  { 'u' }
    token encodingprefix:sym<U>  { 'U' }
    token encodingprefix:sym<L>  { 'L' }

    #------------------
    proto token schar { * }
    token schar:sym<basic>  { <-[ " \\ \r \n ]> }
    token schar:sym<escape> { <escapesequence> }
    token schar:sym<ucn>    { <universalcharactername> }

    token rawstring {
        ||  'R"'
            [   ||  [   ||  '\\'
                            <[ " ( ) ]>
                    ]
                ||  <-[ \r \n   ( ]>
            ]
            '('
            <-[ ) ]>*?
            ')'
            [   ||  [   ||  '\\'
                            <[ " ( ) ]>
                    ]
                ||  <-[ \r \n   " ]>
            ]
            '"'
    }

    proto token user-defined-integer-literal { * }
    token user-defined-integer-literal:sym<dec> { <decimal-literal> <udsuffix> }
    token user-defined-integer-literal:sym<oct> { <octal-literal> <udsuffix> }
    token user-defined-integer-literal:sym<hex> { <hexadecimal-literal> <udsuffix> }
    token user-defined-integer-literal:sym<bin> { <binary-literal> <udsuffix> }

    #-------------------
    proto token user-defined-floating-literal { * }
    token user-defined-floating-literal:sym<frac> { <fractionalconstant> <exponentpart>?  <udsuffix> }
    token user-defined-floating-literal:sym<digi> { <digitsequence> <exponentpart> <udsuffix> }

    #-------------------
    token user-defined-string-literal    { <string-literal> <udsuffix> }
    token user-defined-character-literal { <character-literal> <udsuffix> }

    token udsuffix {
        <identifier>
    }

    token whitespace {
        <[   \t ]>+
    }

    token newline_ {
        [   
            ||  '\r' '\n'?
            ||  '\n'
        ]
    }

    token block-comment {
        '/*' .*?  '*/'
    }

    token line-comment {
        '//' <-[ \r \n ]>*
    }
}

our role CPP14Parser does CPP14Lexer {

    #<statement-seq>
    rule TOP {
        <.ws> 
        <statement-seq>
        #<unary-expression>
    }

    token translation-unit {
        <declarationseq>?  $
    }

    proto token primary-expression { * }
    token primary-expression:sym<literal> { <literal>+ }
    token primary-expression:sym<this>    { <this> }
    token primary-expression:sym<expr>    { <.left-paren> <expression> <.right-paren> }
    token primary-expression:sym<id>      { <id-expression> }
    token primary-expression:sym<lambda>  { <lambda-expression> }

    #-------------------------------
    proto regex id-expression { * }
    regex id-expression:sym<qualified>   { <qualified-id> }
    regex id-expression:sym<unqualified> { <unqualified-id> }

    #-------------------------------
    proto regex unqualified-id { * }
    regex unqualified-id:sym<ident>               { <identifier> }
    regex unqualified-id:sym<op-func-id>          { <operator-function-id> }
    regex unqualified-id:sym<conversion-func-id>  { <conversion-function-id> }
    regex unqualified-id:sym<literal-operator-id> { <literal-operator-id> }
    regex unqualified-id:sym<tilde-classname>     { <tilde> <class-name> }
    regex unqualified-id:sym<tilde-decltype>      { <tilde> <decltype-specifier> }
    regex unqualified-id:sym<template-id>         { <template-id> }

    #-------------------------------
    regex qualified-id {
        <nested-name-specifier> 
        <template>?  
        <unqualified-id>
    }

    #-------------------------------
    proto regex nested-name-specifier-prefix { * }

    regex nested-name-specifier-prefix:sym<null> {
        <doublecolon>
    }

    regex nested-name-specifier-prefix:sym<type> {
        <the-type-name>
        <doublecolon>
    }

    regex nested-name-specifier-prefix:sym<ns> {
        <namespace-name>
        <doublecolon>
    }

    regex nested-name-specifier-prefix:sym<decl> {
        <decltype-specifier>
        <doublecolon>
    }

    #-------------------------------
    proto regex nested-name-specifier-suffix { * }

    regex nested-name-specifier-suffix:sym<id> {
        <identifier>
        <doublecolon>
    }

    regex nested-name-specifier-suffix:sym<template> {
        <template>? 
        <simple-template-id>
        <doublecolon>
    }

    #-------------------------------
    regex nested-name-specifier {
        <nested-name-specifier-prefix> 
        <nested-name-specifier-suffix>*
    }

    rule lambda-expression {
        <lambda-introducer> <lambda-declarator>?  <compound-statement>
    }

    rule lambda-introducer {
        <.left-bracket> <lambda-capture>?  <.right-bracket>
    }

    #-------------------------------
    proto rule lambda-capture { * }
    rule lambda-capture:sym<list> { <capture-list> }
    rule lambda-capture:sym<def>  { <capture-default> [ <.comma> <capture-list> ]? }

    #-------------------------------
    proto rule capture-default { * }
    rule capture-default:sym<and>    { <and_> }
    rule capture-default:sym<assign> { <assign> }

    #-------------------------------
    rule capture-list {
        <capture> [ <.comma> <capture> ]* <ellipsis>?
    }

    #-------------------------------
    proto rule capture { * }
    rule capture:sym<simple> { <simple-capture> }
    rule capture:sym<init>   { <initcapture> }

    #-------------------------------
    proto rule simple-capture { * }
    rule simple-capture:sym<id>   { <and_>? <identifier> }
    rule simple-capture:sym<this> { <this> }

    #-------------------------------
    rule initcapture {
        <and_>?  <identifier> <initializer>
    }

    #-------------------------------
    rule lambda-declarator {
        <.left-paren>
        <parameter-declaration-clause>?
        <.right-paren>
        <mutable>?
        <exception-specification>?
        <attribute-specifier-seq>?
        <trailing-return-type>?
    }

    #-------------------------------------
    rule postfix-expression {  
        <postfix-expression-body> <postfix-expression-tail>*
    }

    proto rule postfix-expression-tail { * }

    rule bracket-tail {
        <.left-bracket> 
        [ <expression> || <braced-init-list> ] 
        <.right-bracket>
    }

    rule postfix-expression-tail:sym<bracket> {
        <bracket-tail>
    }

    rule postfix-expression-tail:sym<parens> { 
        <.left-paren> 
        <expression-list>?  
        <.right-paren>
    }

    rule postfix-expression-tail:sym<indirection-id> { 
        [ <dot> ||  <arrow> ]
        <template>?  <id-expression> 
    }

    rule postfix-expression-tail:sym<indirection-pseudo-dtor> { 
        [ <dot> ||  <arrow> ]
        <pseudo-destructor-name> 
    }

    rule postfix-expression-tail:sym<pp-mm> { 
        [ <plus-plus> ||  <minus-minus> ]
    }

    #-------------------------------------
    #needs to stay like this for some reason..
    #ie, cant be made proto without breaking some
    #parses, for example:
    #
    # uint8_t{format}
    token postfix-expression-body { 
        || <postfix-expression-list>
        || <postfix-expression-cast>
        || <postfix-expression-typeid>
        || <primary-expression>
    }

    #-------------------------------------
    proto token cast-token { * }
    token cast-token:sym<dyn>         { <dynamic_cast> }
    token cast-token:sym<static>      { <static_cast> }
    token cast-token:sym<reinterpret> { <reinterpret_cast> }
    token cast-token:sym<const>       { <const_cast> }

    rule postfix-expression-cast {
        <cast-token>
        <less> 
        <the-type-id> 
        <greater> 
        <.left-paren> 
        <expression> 
        <.right-paren>
    }

    rule postfix-expression-typeid {
        <type-id-of-the-type-id> 
        <.left-paren> 
        [ <expression> ||  <the-type-id>] 
        <.right-paren>
    }

    #---------------------
    proto token post-list-head { * }
    token post-list-head:sym<simple>    { <simple-type-specifier> }
    token post-list-head:sym<type-name> { <type-name-specifier> }

    #---------------------
    proto token post-list-tail { * }
    token post-list-tail:sym<parenthesized> { <.left-paren> <expression-list>?  <.right-paren> }
    token post-list-tail:sym<braced>        { <braced-init-list> }

    token postfix-expression-list {
        <post-list-head>
        <post-list-tail>
    }

    #-------------------------------------
    rule type-id-of-the-type-id {
        <typeid_>
    }

    rule expression-list {
        <initializer-list>
    }

    #-------------------------------------
    proto rule pseudo-destructor-name { * }

    rule pseudo-destructor-name:sym<basic> {
        <nested-name-specifier>?
        [ <the-type-name> <doublecolon> ]?
        <tilde>
        <the-type-name>
    }

    rule pseudo-destructor-name:sym<template> {
        <nested-name-specifier>
        <template>
        <simple-template-id>
        <doublecolon>
        <tilde>
        <the-type-name>
    }

    rule pseudo-destructor-name:sym<decltype> {
        <tilde>
        <decltype-specifier>
    }

    #-------------------------------------
    rule unary-expression { 
        || <new-expression>
        || <unary-expression-case>
    }

    proto rule unary-expression-case { * }
    rule unary-expression-case:sym<postfix>  { <postfix-expression> }
    rule unary-expression-case:sym<pp>       { <plus-plus> <unary-expression> }
    rule unary-expression-case:sym<mm>       { <minus-minus> <unary-expression> }
    rule unary-expression-case:sym<unary-op> { <unary-operator> <unary-expression> }
    rule unary-expression-case:sym<sizeof>   { <sizeof> <unary-expression> }

    rule unary-expression-case:sym<sizeof-typeid> {
        <sizeof>
        <.left-paren>
        <the-type-id>
        <.right-paren>
    }

    rule unary-expression-case:sym<sizeof-ids> {
        <sizeof>
        <ellipsis>
        <.left-paren>
        <identifier>
        <.right-paren>
    }

    rule unary-expression-case:sym<alignof>  { <alignof> <.left-paren> <the-type-id> <.right-paren> }
    rule unary-expression-case:sym<noexcept> { <no-except-expression> }
    rule unary-expression-case:sym<delete>   { <delete-expression> }

    #--------------------------------------
    proto rule unary-operator { * } 
    rule unary-operator:sym<or_>   { <or_>   } 
    rule unary-operator:sym<star>  { <star>  }
    rule unary-operator:sym<and_>  { <and_>  } 
    rule unary-operator:sym<plus>  { <plus>  } 
    rule unary-operator:sym<tilde> { <tilde> } 
    rule unary-operator:sym<minus> { <minus> } 
    rule unary-operator:sym<not>   { <not_>  } 

    #--------------------------------------
    proto rule new-expression { * }

    rule new-expression:sym<new-type-id> {
        <doublecolon>?
        <new_>
        <new-placement>?
        <new-type-id>
        <new-initializer>?
    }

    rule new-expression:sym<the-type-id> {
        <doublecolon>?
        <new_>
        <new-placement>?
        <.left-paren> 
        <the-type-id> 
        <.right-paren>
        <new-initializer>?
    }

    rule new-placement {
        <.left-paren>
        <expression-list>
        <.right-paren>
    }

    rule new-type-id {
        <type-specifier-seq> <new-declarator>?
    }

    rule new-declarator {
        <pointer-operator>* 
        <no-pointer-new-declarator>?
    }

    #applied a transfomation on this rule to
    #prevent infinite loops
    #
    #if we get any bugs downstream come back to
    #this
    rule no-pointer-new-declarator {
        <.left-bracket>
        <expression>
        <.right-bracket>
        <attribute-specifier-seq>?
        <no-pointer-new-declarator-tail>*
    }

    rule no-pointer-new-declarator-tail {
        <.left-bracket>
        <constant-expression>
        <.right-bracket>
        <attribute-specifier-seq>?
    }

    #------------------------
    proto rule new-initializer { * }
    rule new-initializer:sym<expr-list> { <.left-paren> <expression-list>?  <.right-paren> }
    rule new-initializer:sym<braced>    { <braced-init-list> }

    #------------------------
    rule delete-expression {
        <doublecolon>?
        <delete>
        [ <.left-bracket> <.right-bracket> ]?
        <cast-expression>
    }

    rule no-except-expression {
        <noexcept>
        <.left-paren>
        <expression>
        <.right-paren>
    }

    rule cast-expression {
        [ <.left-paren> <the-type-id> <.right-paren> ]* <unary-expression>
    }

    proto rule pointer-member-operator { * }
    rule pointer-member-operator:sym<dot>   { <dot-star> }
    rule pointer-member-operator:sym<arrow> { <arrow-star> }

    rule pointer-member-expression {
        <cast-expression>
        <pointer-member-expression-tail>*
    }

    rule pointer-member-expression-tail {
        <pointer-member-operator>
        <cast-expression>
    }

    #-----------------
    proto token multiplicative-operator { * }
    token multiplicative-operator:sym<*> { <star> }
    token multiplicative-operator:sym</> { <div_> }
    token multiplicative-operator:sym<%> { <mod_> }

    rule multiplicative-expression {
        <pointer-member-expression>
        <multiplicative-expression-tail>*
    }

    rule multiplicative-expression-tail {
        <multiplicative-operator> 
        <pointer-member-expression>
    }

    #-----------------
    proto token additive-operator { * }
    token additive-operator:sym<plus>  {  <plus> }
    token additive-operator:sym<minus> {  <minus> }

    #-----------------
    rule additive-expression-tail {
        <additive-operator> 
        <multiplicative-expression>
    }

    rule additive-expression {
        <multiplicative-expression>
        <additive-expression-tail>*
    }

    rule shift-expression-tail {
        <shift-operator>
        <additive-expression>
    }

    rule shift-expression {
        <additive-expression>
        <shift-expression-tail>*
    }

    #-----------------------
    proto rule shift-operator { * }
    rule shift-operator:sym<right> { <.greater> <.greater> }
    rule shift-operator:sym<left>  { <.less> <.less> }

    #-----------------------
    proto rule relational-operator { * }
    rule relational-operator:sym<less>       { <.less> }
    rule relational-operator:sym<greater>    { <.greater> }
    rule relational-operator:sym<less-eq>    { <.less-equal> }
    rule relational-operator:sym<greater-eq> { <.greater-equal> }

    #-----------------------
    regex relational-expression-tail {
        <.ws>
        <relational-operator>
        <.ws>
        <shift-expression>
    }

    regex relational-expression {
        <shift-expression>
        <relational-expression-tail>*
    }

    #-----------------------
    proto token equality-operator { * }
    token equality-operator:sym<eq>  { <equal> }
    token equality-operator:sym<neq> { <not-equal> }

    #-----------------------
    rule equality-expression-tail {
        <equality-operator> 
        <relational-expression>
    }

    rule equality-expression {
        <relational-expression>
        <equality-expression-tail>*
    }

    rule and-expression {
        <equality-expression> [ <and_> <equality-expression> ]*
    }

    rule exclusive-or-expression {
        <and-expression> [ <caret> <and-expression> ]*
    }

    rule inclusive-or-expression {
        <exclusive-or-expression> [ <or_> <exclusive-or-expression> ]*
    }

    rule logical-and-expression {
        <inclusive-or-expression> [ <and-and> <inclusive-or-expression>]*
    }

    rule logical-or-expression {
        <logical-and-expression> [ <or-or> <logical-and-expression> ]*
    }

    rule conditional-expression-tail {
        <question> 
        <expression> 
        <colon> 
        <assignment-expression> 
    }

    rule conditional-expression {
        <logical-or-expression>
        <conditional-expression-tail>?
    }

    #-----------------------
    proto rule assignment-expression { * }

    rule assignment-expression:sym<throw> {  
        <throw-expression>
    }

    rule assignment-expression:sym<basic> {  
        <logical-or-expression> <assignment-operator> <initializer-clause>
    }

    rule assignment-expression:sym<conditional> {  
        <conditional-expression>
    }

    proto token assignment-operator { * }
    token assignment-operator:sym<assign>        { <.assign>           } 
    token assignment-operator:sym<star-assign>   { <.star-assign>       } 
    token assignment-operator:sym<div-assign>    { <.div-assign>        } 
    token assignment-operator:sym<mod-assign>    { <.mod-assign>        } 
    token assignment-operator:sym<plus-assign>   { <.plus-assign>       } 
    token assignment-operator:sym<minus-assign>  { <.minus-assign>      } 
    token assignment-operator:sym<rshift-assign> { <.right-shift-assign> } 
    token assignment-operator:sym<lshift-assign> { <.left-shift-assign>  } 
    token assignment-operator:sym<and-assign>    { <.and-assign>        } 
    token assignment-operator:sym<xor-assign>    { <.xor-assign>        } 
    token assignment-operator:sym<or-assign>     { <.or-assign>         } 

    rule expression {
        <assignment-expression>+ %% <.comma>
    }

    rule constant-expression { <conditional-expression> }

    proto rule comment { * }

    regex comment:sym<line> {
        [<line-comment> <.ws>?]+
    }

    rule comment:sym<block> {
        <block-comment>
    }

    #-----------------------------
    proto token statement { * }

    token statement:sym<attributed> { 
        <comment>?
        <attribute-specifier-seq>?
        <attributed-statement-body>
    }

    token statement:sym<labeled>     { <comment>? <labeled-statement>     }
    token statement:sym<declaration> { <comment>? <declaration-statement> }

    proto rule attributed-statement-body { * }
    rule attributed-statement-body:sym<expression> { <expression-statement> }
    rule attributed-statement-body:sym<compound>   { <compound-statement>   }
    rule attributed-statement-body:sym<selection>  { <selection-statement>  }
    rule attributed-statement-body:sym<iteration>  { <iteration-statement>  }
    rule attributed-statement-body:sym<jump>       { <jump-statement>       }
    rule attributed-statement-body:sym<try>        { <try-block>            }

    #-----------------------------
    proto rule labeled-statement-label-body { * }
    rule labeled-statement-label-body:sym<id>        { <identifier>                }
    rule labeled-statement-label-body:sym<case-expr> { <case> <constant-expression> }
    rule labeled-statement-label-body:sym<default>   { <default_>                   }

    #-----------------------------
    rule labeled-statement-label {
        <attribute-specifier-seq>?
        <labeled-statement-label-body>
        <colon>
    }

    rule labeled-statement {
        <labeled-statement-label>
        <statement>
    }

    rule declaration-statement { <block-declaration> }

    #-----------------------------
    rule expression-statement {
        <expression>?  <semi>
    }

    rule compound-statement {
        <.left-brace> <statement-seq>?  <.right-brace>
    }

    regex statement-seq {
        <statement> [<.ws> <statement>]*
    }

    #-----------------------------
    proto rule selection-statement { * }

    rule selection-statement:sym<if> {  
        <if_>
        <.left-paren>
        <condition>
        <.right-paren>
        <statement>
        [ <comment>? <else_> <statement> ]?
    }

    rule selection-statement:sym<switch> {  
        <switch> 
        <.left-paren> 
        <condition> 
        <.right-paren> 
        <statement>
    }

    #-----------------------------
    proto rule condition { * }

    rule condition:sym<expr> {
        <expression>
    }

    #-----------------------------
    proto rule condition-decl-tail { * }
    rule condition-decl-tail:sym<assign-init> { <assign> <initializer-clause> }
    rule condition-decl-tail:sym<braced-init> { <braced-init-list> }

    #-----------------------------
    rule condition:sym<decl> {
        <attribute-specifier-seq>?
        <decl-specifier-seq> 
        <declarator>
        <condition-decl-tail>
    }

    #-----------------------------
    proto rule iteration-statement { * }

    rule iteration-statement:sym<while> {
        <while_>
        <.left-paren>
        <condition>
        <.right-paren>
        <statement>
    }

    rule iteration-statement:sym<do> {
        <do_>
        <statement>
        <while_>
        <.left-paren>
        <expression>
        <.right-paren>
        <semi>
    }

    rule iteration-statement:sym<for> {
        <for_>
        <.left-paren>
        <for-init-statement>
        <condition>?
        <semi>
        <expression>?
        <.right-paren>
        <statement>
    }

    rule iteration-statement:sym<for-range> {
        <.for_>
        <.left-paren>
        <for-range-declaration>
        <.colon>
        <for-range-initializer>
        <.right-paren>
        <statement>
    }

    #-----------------------------
    proto rule for-init-statement { * }
    rule for-init-statement:sym<expression-statement> { <expression-statement> }
    rule for-init-statement:sym<simple-declaration> { <simple-declaration> }

    rule for-range-declaration {
        <attribute-specifier-seq>?
        <decl-specifier-seq>
        <declarator>
    }

    proto rule for-range-initializer { * }
    rule for-range-initializer:sym<expression>     { <expression> }
    rule for-range-initializer:sym<braced-init-list> { <braced-init-list> }

    #-------------------------------
    proto rule jump-statement { * }
    rule jump-statement:sym<break>    { <break_>                                        <semi> } 
    rule jump-statement:sym<continue> { <continue_>                                     <semi> } 
    rule jump-statement:sym<return>   { <return_> <return-statement-body>? <semi> } 
    rule jump-statement:sym<goto>     { <goto_> <identifier>                            <semi> } 

    proto rule return-statement-body { * }
    rule return-statement-body:sym<expr> { <expression> }
    rule return-statement-body:sym<braced-init-list> { <braced-init-list> }

    rule declarationseq { <declaration>+ }

    #-------------------------------
    proto rule declaration { * }
    rule declaration:sym<block-declaration>       { <block-declaration>         } 
    rule declaration:sym<function-definition>     { <function-definition>       } 
    rule declaration:sym<template-declaration>    { <template-declaration>      } 
    rule declaration:sym<explicit-instantiation>  { <explicit-instantiation>    } 
    rule declaration:sym<explicit-specialization> { <explicit-specialization>   } 
    rule declaration:sym<linkage-specification>   { <linkage-specification>     } 
    rule declaration:sym<namespace-definition>    { <namespace-definition>      } 
    rule declaration:sym<empty-declaration>       { <empty-declaration>         } 
    rule declaration:sym<attribute-declaration>   { <attribute-declaration>     } 

    proto rule block-declaration { * }
    rule block-declaration:sym<simple>            { <simple-declaration>        } 
    rule block-declaration:sym<asm>               { <asm-definition>            } 
    rule block-declaration:sym<namespace-alias>   { <namespace-alias-definition> } 
    rule block-declaration:sym<using-decl>        { <using-declaration>         } 
    rule block-declaration:sym<using-directive>   { <using-directive>           } 
    rule block-declaration:sym<static-assert>     { <static-assert-declaration>  } 
    rule block-declaration:sym<alias>             { <alias-declaration>         } 
    rule block-declaration:sym<opaque-enum-decl>  { <opaque-enum-declaration>    } 

    rule alias-declaration {
        <.using>
        <identifier>
        <attribute-specifier-seq>?
        <.assign>
        <the-type-id>
        <.semi>
    }

    #---------------------------
    proto rule simple-declaration { * }

    rule simple-declaration:sym<basic> { 
        <decl-specifier-seq>? 
        <init-declarator-list>? 
        <.semi> 
    }

    rule simple-declaration:sym<init-list> { 
        <attribute-specifier-seq> 
        <decl-specifier-seq>? 
        <init-declarator-list> 
        <.semi> 
    }

    rule static-assert-declaration {
        <static_assert>
        <.left-paren>
        <constant-expression>
        <.comma>
        <string-literal>
        <.right-paren>
        <.semi>
    }

    rule empty-declaration {
        <.semi>
    }

    rule attribute-declaration {
        <attribute-specifier-seq> <.semi>
    }

    #---------------------------
    proto token decl-specifier { * }
    token decl-specifier:sym<storage-class> { <storage-class-specifier> }
    token decl-specifier:sym<type>          { <type-specifier> }
    token decl-specifier:sym<func>          { <function-specifier> }
    token decl-specifier:sym<friend>        { <.friend> }
    token decl-specifier:sym<typedef>       { <.typedef> }
    token decl-specifier:sym<constexpr>     { <.constexpr> }

    regex decl-specifier-seq {
        <decl-specifier> [<.ws> <decl-specifier>]*?  <attribute-specifier-seq>?  
    }

    #---------------------------
    proto rule storage-class-specifier { * }
    rule storage-class-specifier:sym<register>     { <.register>     } 
    rule storage-class-specifier:sym<static>       { <.static>       } 
    rule storage-class-specifier:sym<thread_local> { <.thread_local> } 
    rule storage-class-specifier:sym<extern>       { <.extern>       } 
    rule storage-class-specifier:sym<mutable>      { <.mutable>      } 
    #---------------------------
    proto rule function-specifier { * }
    rule function-specifier:sym<inline>   { <.inline> }
    rule function-specifier:sym<virtual>  { <.virtual> }
    rule function-specifier:sym<explicit> { <.explicit> }

    rule typedef-name { <identifier> }

    #---------------------------
    proto rule type-specifier { * }
    rule type-specifier:sym<trailing-type-specifier> { <trailing-type-specifier> }
    rule type-specifier:sym<class-specifier>         { <class-specifier>        }
    rule type-specifier:sym<enum-specifier>          { <enum-specifier>         }

    #---------------------------
    proto rule trailing-type-specifier { * }
    rule trailing-type-specifier:sym<cv-qualifier> { <cv-qualifier> <simple-type-specifier> }
    rule trailing-type-specifier:sym<simple>       { <simple-type-specifier>     } 
    rule trailing-type-specifier:sym<elaborated>   { <elaborated-type-specifier> } 
    rule trailing-type-specifier:sym<typename>     { <type-name-specifier>       } 

    #---------------------------
    rule type-specifier-seq {
        <type-specifier>+ <attribute-specifier-seq>?
    }

    rule trailing-type-specifier-seq {
        <trailing-type-specifier>+ <attribute-specifier-seq>?
    }

    proto rule simple-type-length-modifier { * }
    rule simple-type-length-modifier:sym<short>  { <.short> }
    rule simple-type-length-modifier:sym<long_>  { <.long_>  }

    proto rule simple-type-signedness-modifier         { * }
    rule simple-type-signedness-modifier:sym<unsigned> { <.unsigned> }
    rule simple-type-signedness-modifier:sym<signed>   { <.signed> }

    rule full-type-name {
        <nested-name-specifier>? 
        <the-type-name>
    }

    rule scoped-template-id {
        <nested-name-specifier> 
        <.template> 
        <simple-template-id>
    }

    rule simple-int-type-specifier {
        <simple-type-signedness-modifier>? 
        <simple-type-length-modifier>* 
        <int_>
    }

    rule simple-char-type-specifier {
        <simple-type-signedness-modifier>?
        <char_>
    }

    rule simple-char16-type-specifier {
        <simple-type-signedness-modifier>?  
        <char16>
    }

    rule simple-char32-type-specifier {
        <simple-type-signedness-modifier>?
        <char32>
    }

    rule simple-wchar-type-specifier {
        <simple-type-signedness-modifier>? 
        <wchar>
    }

    rule simple-double-type-specifier {
        <simple-type-length-modifier>?
        <double>
    }

    #------------------------------
    proto regex simple-type-specifier { * }
    regex simple-type-specifier:sym<int>                   { <simple-int-type-specifier>                                  } 
    regex simple-type-specifier:sym<full>                  { <full-type-name>                                             } 
    regex simple-type-specifier:sym<scoped>                { <scoped-template-id>                                         } 
    regex simple-type-specifier:sym<signedness-mod>        { <simple-type-signedness-modifier>                               } 
    regex simple-type-specifier:sym<signedness-mod-length> { <simple-type-signedness-modifier>?  <simple-type-length-modifier>+ } 
    regex simple-type-specifier:sym<char>                  { <simple-char-type-specifier>                                 } 
    regex simple-type-specifier:sym<char16>                { <simple-char16-type-specifier>                               } 
    regex simple-type-specifier:sym<char32>                { <simple-char32-type-specifier>                               } 
    regex simple-type-specifier:sym<wchar>                 { <simple-wchar-type-specifier>                                } 
    regex simple-type-specifier:sym<bool>                  { <bool_>                                                      } 
    regex simple-type-specifier:sym<float>                 { <float>                                                      } 
    regex simple-type-specifier:sym<double>                { <simple-double-type-specifier>                               } 
    regex simple-type-specifier:sym<void>                  { <void_>                                                       } 
    regex simple-type-specifier:sym<auto>                  { <auto>                                                       } 
    regex simple-type-specifier:sym<decltype>              { <decltype-specifier>                                          } 

    #------------------------------
    proto rule the-type-name                   { * }
    rule the-type-name:sym<simple-template-id> { <simple-template-id> }
    rule the-type-name:sym<class>              { <class-name> }
    rule the-type-name:sym<enum>               { <enum-name> }
    rule the-type-name:sym<typedef>            { <typedef-name> }

    #------------------------------
    proto rule decltype-specifier-body { * }
    rule decltype-specifier-body:sym<expr> {  <expression> }
    rule decltype-specifier-body:sym<auto> {  <auto> }

    rule decltype-specifier {
        <decltype>
        <.left-paren>
        <decltype-specifier-body>
        <.right-paren>
    }

    #------------------------------
    proto rule elaborated-type-specifier { * }

    rule elaborated-type-specifier:sym<class-ident> {
        <.class-key>
        <attribute-specifier-seq>? 
        <nested-name-specifier>? 
        <identifier>
    }

    rule elaborated-type-specifier:sym<class-template-id> {
        <.class-key>
        <simple-template-id>
    }

    rule elaborated-type-specifier:sym<class-nested-template-id> {
        <.class-key>
        <nested-name-specifier> 
        <template>? 
        <simple-template-id>
    }

    rule elaborated-type-specifier:sym<enum> {
        <.enum_> <nested-name-specifier>? <identifier>
    }

    #------------------------------
    rule enum-name {
        <identifier>
    }

    rule enum-specifier {
        <enum-head>
        <.left-brace>
        [ <enumerator-list> <.comma>?  ]?
        <.right-brace>
    }

    rule enum-head {
        <.enumkey>
        <attribute-specifier-seq>?
        [ <nested-name-specifier>? <identifier> ]?
        <enumbase>?
    }

    rule opaque-enum-declaration {
        <.enumkey>
        <attribute-specifier-seq>?
        <identifier>
        <enumbase>?
        <semi>
    }

    rule enumkey {
        <enum_>
        [  <class_> || <struct> ]?
    }

    rule enumbase {
        <colon> <type-specifier-seq>
    }

    rule enumerator-list {
        <enumerator-definition>
        [ <.comma> <enumerator-definition> ]*
    }

    rule enumerator-definition {
        <enumerator>
        [ <assign> <constant-expression> ]?
    }

    rule enumerator {
        <identifier>
    }

    proto rule namespace-name { * }
    rule namespace-name:sym<original> { <original-namespace-name> }
    rule namespace-name:sym<alias>    { <namespace-alias> }

    rule original-namespace-name {
        <identifier>
    }

    #--------------------
    proto rule namespace-tag { * }
    rule namespace-tag:sym<ident>   { <identifier> }
    rule namespace-tag:sym<ns-name> { <original-namespace-name> }

    #--------------------
    rule namespace-definition {
        <inline>?
        <namespace>
        <namespace-tag>?
        <.left-brace>
        <namespaceBody=declarationseq>?
        <.right-brace>
    }

    rule namespace-alias {
        <identifier>
    }

    rule namespace-alias-definition {
        <namespace>
        <identifier>
        <assign>
        <qualifiednamespacespecifier>
        <semi>
    }

    rule qualifiednamespacespecifier {
        <nested-name-specifier>?
        <namespace-name>
    }

    #--------------------
    proto rule using-declaration-prefix { * }
    rule using-declaration-prefix:sym<nested> { [ <typename_>? <nested-name-specifier> ] }
    rule using-declaration-prefix:sym<base>   { <doublecolon> }

    #--------------------
    rule using-declaration {
        <using>
        <using-declaration-prefix>
        <unqualified-id>
        <semi>
    }

    rule using-directive {
        <attribute-specifier-seq>?
        <using>
        <namespace>
        <nested-name-specifier>?
        <namespace-name>
        <semi>
    }

    rule asm-definition {
        <asm>
        <.left-paren>
        <string-literal>
        <.right-paren>
        <.semi>
    }

    #--------------------
    proto rule linkage-specification-body { * }
    rule linkage-specification-body:sym<seq>  { <.left-brace> <declarationseq>?  <.right-brace> }
    rule linkage-specification-body:sym<decl> {  <declaration> }

    rule linkage-specification {
        <extern>
        <string-literal>
        <linkage-specification-body>
    }

    rule attribute-specifier-seq {
        <attribute-specifier>+
    }

    #--------------------
    proto rule attribute-specifier { * }

    rule attribute-specifier:sym<double-braced> {
        <.left-bracket>
        <.left-bracket>
        <attribute-list>?
        <.right-bracket>
        <.right-bracket>
    }

    rule attribute-specifier:sym<alignment> {
        <alignmentspecifier>
    }

    #--------------------
    proto rule alignmentspecifierbody { * }
    rule alignmentspecifierbody:sym<type-id>    { <the-type-id> }
    rule alignmentspecifierbody:sym<const-expr> { <constant-expression> }

    #--------------------
    rule alignmentspecifier {
        <alignas>
        <.left-paren>
        <alignmentspecifierbody>
        <ellipsis>?
        <.right-paren>
    }

    rule attribute-list {
        <attribute>
        [ <.comma> <attribute> ]*
        <ellipsis>?
    }

    rule attribute {
        [ <attribute-namespace> <doublecolon> ]?
        <identifier>
        <attribute-argument-clause>?
    }

    rule attribute-namespace {
        <identifier>
    }

    rule attribute-argument-clause {
        <.left-paren> <balanced-token-seq>?  <.right-paren>
    }

    rule balanced-token-seq {
        <balancedrule>+
    }

    #--------------------------
    proto rule balancedrule { * }
    rule balancedrule:sym<parens>   { <.left-paren> <balanced-token-seq> <.right-paren> }
    rule balancedrule:sym<brackets> { <.left-bracket> <balanced-token-seq> <.right-bracket> }
    rule balancedrule:sym<braces>   { <.left-brace> <balanced-token-seq> <.right-brace> }

    #--------------------------
    rule init-declarator-list {
        <init-declarator> [ <.comma> <init-declarator> ]*
    }

    rule init-declarator {
        <declarator> <initializer>?
    }

    #--------------------------
    proto rule declarator { * }
    rule declarator:sym<ptr>    { <pointer-declarator> }
    rule declarator:sym<no-ptr> { <no-pointer-declarator> <parameters-and-qualifiers> <trailing-return-type> }

    rule pointer-declarator {
        <augmented-pointer-operator>* <no-pointer-declarator>
    }

    rule augmented-pointer-operator {
        <pointer-operator> <const>?
    }

    #------------------------------
    proto rule no-pointer-declarator-base { * }
    rule no-pointer-declarator-base:sym<base>   { <declaratorid> <attribute-specifier-seq>? }
    rule no-pointer-declarator-base:sym<parens> { <.left-paren> <pointer-declarator> <.right-paren> }

    #------------------------------
    proto rule no-pointer-declarator-tail { * }
    rule no-pointer-declarator-tail:sym<basic>     { <parameters-and-qualifiers> }
    rule no-pointer-declarator-tail:sym<bracketed> { 
        <.left-bracket> 
        <constant-expression>?  
        <.right-bracket> 
        <attribute-specifier-seq>? 
    }

    #------------------------------
    rule no-pointer-declarator {
        <no-pointer-declarator-base>
        <no-pointer-declarator-tail>*
    }

    #------------------------------
    rule parameters-and-qualifiers {
        <.left-paren>
        <parameter-declaration-clause>?
        <.right-paren>
        <cvqualifierseq>?
        <refqualifier>?
        <exception-specification>?
        <attribute-specifier-seq>?
    }

    rule trailing-return-type {
        <arrow>
        <trailing-type-specifier-seq>
        <abstract-declarator>?
    }

    #-----------------------------
    proto rule pointer-operator { * }

    rule pointer-operator:sym<ref> {
        <and_>
        <attribute-specifier-seq>?
    }

    rule pointer-operator:sym<ref-ref> {
        <and-and>
        <attribute-specifier-seq>?
    }

    rule pointer-operator:sym<star> {
        <nested-name-specifier>?
        <star>
        <attribute-specifier-seq>?
        <cvqualifierseq>?
    }

    rule cvqualifierseq {
        <cv-qualifier>+
    }

    #-----------------------------
    proto rule cv-qualifier { * }
    rule cv-qualifier:sym<const>    { <const> }
    rule cv-qualifier:sym<volatile> { <volatile> }

    #-----------------------------
    proto rule refqualifier { * }
    rule refqualifier:sym<and>     { <and_> }
    rule refqualifier:sym<and-and> { <and-and> }

    #-----------------------------
    rule declaratorid {
        <ellipsis>?  <id-expression>
    }

    rule the-type-id {
        <type-specifier-seq> <abstract-declarator>?
    }

    #-----------------------------
    proto rule abstract-declarator { * }

    rule abstract-declarator:sym<base> {
        <pointer-abstract-declarator>
    }

    rule abstract-declarator:sym<aug> {
        <no-pointer-abstract-declarator>? <parameters-and-qualifiers> <trailing-return-type>
    }

    rule abstract-declarator:sym<abstract-pack> {
        <abstract-pack-declarator>
    }

    #-----------------------------
    proto rule pointer-abstract-declarator { * }
    rule pointer-abstract-declarator:sym<no-ptr> { <no-pointer-abstract-declarator> }
    rule pointer-abstract-declarator:sym<ptr>    { <pointer-operator>+ <no-pointer-abstract-declarator>? }

    #-----------------------------
    proto rule no-pointer-abstract-declarator-body { * }

    rule no-pointer-abstract-declarator-body:sym<base> {
        <parameters-and-qualifiers>
    }

    rule no-pointer-abstract-declarator-body:sym<brack> {
        <no-pointer-abstract-declarator> <no-pointer-abstract-declarator-bracketed-base>
    }

    rule no-pointer-abstract-declarator {
        <no-pointer-abstract-declarator-base>
        <no-pointer-abstract-declarator-body>*
    }

    #-----------------------------
    proto rule no-pointer-abstract-declarator-base { * }
    rule no-pointer-abstract-declarator-base:sym<basic>         { <parameters-and-qualifiers> }
    rule no-pointer-abstract-declarator-base:sym<bracketed>     { <no-pointer-abstract-declarator-bracketed-base> }
    rule no-pointer-abstract-declarator-base:sym<parenthesized> { 
        <.left-paren> 
        <pointer-abstract-declarator> 
        <.right-paren> 
    }

    rule no-pointer-abstract-declarator-bracketed-base {
        <.left-bracket> 
        <constant-expression>?  
        <.right-bracket> 
        <attribute-specifier-seq>?
    }

    rule abstract-pack-declarator {
        <pointer-operator>* 
        <no-pointer-abstract-pack-declarator>
    }

    #-----------------------------
    rule no-pointer-abstract-pack-declarator-basic {
        <parameters-and-qualifiers>
    }

    rule no-pointer-abstract-pack-declarator-brackets {
        <.left-bracket> 
        <constant-expression>?  
        <.right-bracket> 
        <attribute-specifier-seq>?
    }

    #-----------------------------
    proto rule no-pointer-abstract-pack-declarator-body { * }
    rule no-pointer-abstract-pack-declarator-body:sym<basic> { <no-pointer-abstract-pack-declarator-basic> }
    rule no-pointer-abstract-pack-declarator-body:sym<brack> { <no-pointer-abstract-pack-declarator-brackets> }

    #-----------------------------
    rule no-pointer-abstract-pack-declarator {
        <ellipsis>
        <no-pointer-abstract-pack-declarator-body>*
    }

    rule parameter-declaration-clause {
        <parameter-declaration-list> [ <.comma>? <ellipsis> ]?
    }

    rule parameter-declaration-list {
        <parameter-declaration> [ <.comma> <parameter-declaration> ]*
    }

    #-----------------------------
    proto rule parameter-declaration-body { * }
    rule parameter-declaration-body:sym<decl> { <declarator> }
    rule parameter-declaration-body:sym<abst> { <abstract-declarator>? }

    rule parameter-declaration {
        <attribute-specifier-seq>?
        <decl-specifier-seq>
        <parameter-declaration-body>
        [ <assign> <initializer-clause> ]?
    }

    rule function-definition {
        <attribute-specifier-seq>?
        <decl-specifier-seq>?
        <declarator>
        <virtual-specifier-seq>?
        <function-body>
    }

    #-----------------------------
    proto rule function-body { * }

    rule function-body:sym<compound> {
        <constructor-initializer>?  <compound-statement>
    }

    rule function-body:sym<try> {
        <function-try-block>
    }

    rule function-body:sym<assign-default> {
        <assign> <default_> <semi>
    }

    rule function-body:sym<assign-delete> {
        <assign> <delete> <semi>
    }

    #-----------------------------
    proto rule initializer { * }

    rule initializer:sym<brace-or-eq> {
        <brace-or-equal-initializer>
    }

    rule initializer:sym<paren-expr-list> {
        <.left-paren> <expression-list> <.right-paren>
    }

    #-----------------------------
    proto rule brace-or-equal-initializer { * }
    rule brace-or-equal-initializer:sym<assign-init>      { <assign> <initializer-clause> }
    rule brace-or-equal-initializer:sym<braced-init-list> { <braced-init-list> }

    #-----------------------------
    proto rule initializer-clause { * }

    rule initializer-clause:sym<assignment> {
        <comment>?
        <assignment-expression>
    }

    rule initializer-clause:sym<braced> {
        <comment>?
        <braced-init-list>
    }

    #-----------------------------
    rule initializer-list {
        <initializer-clause>
        <ellipsis>?
        [ <.comma> <initializer-clause> <ellipsis>? ]*
    }

    rule braced-init-list {
        <.left-brace> [ <initializer-list> <.comma>? ]?  <.right-brace>
    }

    #-----------------------------
    proto rule class-name { * }
    rule class-name:sym<id>          { <identifier> }
    rule class-name:sym<template-id> { <simple-template-id> }

    rule class-specifier {
        <class-head>
        <.left-brace>
        <member-specification>?
        <.right-brace>
    }

    #-----------------------------
    proto rule class-head { * }

    rule class-head:sym<class> {
        <.class-key>
        <attribute-specifier-seq>?
        [ <class-head-name> <class-virt-specifier>? ]?
        <base-clause>?
    }

    rule class-head:sym<union> {
        <union>
        <attribute-specifier-seq>?
        [ <class-head-name> <class-virt-specifier>? ]?
    }

    #-----------------------------
    rule class-head-name {
        <nested-name-specifier>?  <class-name>
    }

    rule class-virt-specifier {
        <final>
    }

    #-----------------------------
    proto rule class-key { * }
    rule class-key:sym<class>  { <.class_> }
    rule class-key:sym<struct> { <.struct> }

    #-----------------------------
    proto rule member-specification-base { * }
    rule member-specification-base:sym<decl>   { <memberdeclaration> }
    rule member-specification-base:sym<access> { <access-specifier> <colon> }

    rule member-specification {
        <member-specification-base>+
    }

    #-----------------------------
    proto rule memberdeclaration { * }

    rule memberdeclaration:sym<basic> {
        <attribute-specifier-seq>?  
        <decl-specifier-seq>?  
        <member-declarator-list>?  
        <semi>
    }

    rule memberdeclaration:sym<func>          { <function-definition> }
    rule memberdeclaration:sym<using>         { <using-declaration> }
    rule memberdeclaration:sym<static-assert> { <static-assert-declaration> }
    rule memberdeclaration:sym<template>      { <template-declaration> }
    rule memberdeclaration:sym<alias>         { <alias-declaration> }
    rule memberdeclaration:sym<empty>         { <empty-declaration> }

    #-----------------------------
    rule member-declarator-list {
        <member-declarator> [ <.comma> <member-declarator> ]*
    }

    #-----------------------------
    proto rule member-declarator { * }

    rule member-declarator:sym<virt> {
        <declarator>
        <virtual-specifier-seq>? 
        <pure-specifier>?
    }

    rule member-declarator:sym<brace-or-eq> {
        <declarator>
        <brace-or-equal-initializer>?
    }

    rule member-declarator:sym<ident> {
        <identifier>?
        <attribute-specifier-seq>?
        <colon>
        <constant-expression>
    }

    #-----------------------------
    rule virtual-specifier-seq {
        <virtual-specifier>+
    }

    #-----------------------------
    proto rule virtual-specifier { * }
    rule virtual-specifier:sym<override> { <override> }
    rule virtual-specifier:sym<final>    { <final> }

    #-----------------------------
    rule pure-specifier {
        <assign>
        <val=octal-literal>
        #|{if($val.text.compareTo("0")!=0) throw new InputMismatchException(this); }
    }

    rule base-clause {
        <colon> <base-specifier-list>
    }

    rule base-specifier-list {
        <base-specifier> <ellipsis>?  [ <.comma> <base-specifier> <ellipsis>?  ]*
    }

    #-----------------------------
    proto rule base-specifier { * }

    rule base-specifier:sym<base-type> {
        <attribute-specifier-seq>?
        <base-type-specifier>
    }

    rule base-specifier:sym<virtual> {
        <attribute-specifier-seq>?
        <virtual> 
        <access-specifier>? 
        <base-type-specifier>
    }

    rule base-specifier:sym<access> {
        <attribute-specifier-seq>?
        <access-specifier> 
        <virtual>? 
        <base-type-specifier>
    }

    #-----------------------------
    proto rule class-or-decl-type { * }
    rule class-or-decl-type:sym<class>    { <nested-name-specifier>?  <class-name> }
    rule class-or-decl-type:sym<decltype> { <decltype-specifier> }

    #-----------------------------
    rule base-type-specifier {
        <class-or-decl-type>
    }

    proto rule access-specifier { * }
    rule access-specifier:sym<private>   { <private> }
    rule access-specifier:sym<protected> { <protected> }
    rule access-specifier:sym<public>    { <public> }

    rule conversion-function-id {
        <operator> <conversion-type-id>
    }

    rule conversion-type-id {
        <type-specifier-seq> <conversion-declarator>?
    }

    rule conversion-declarator {
        <pointer-operator> <conversion-declarator>?
    }

    rule constructor-initializer {
        <colon> <mem-initializer-list>
    }

    rule mem-initializer-list {
        <mem-initializer>
        <ellipsis>?
        [ <.comma> <mem-initializer> <ellipsis>? ]*
    }

    #-----------------------------
    proto rule mem-initializer { * }

    rule mem-initializer:sym<expr-list> {
        <meminitializerid>
        <.left-paren> 
        <expression-list>?  
        <.right-paren>
    }

    rule mem-initializer:sym<braced> {
        <meminitializerid>
        <braced-init-list>
    }

    #-----------------------------
    proto rule meminitializerid { * }
    rule meminitializerid:sym<class-or-decl> { <class-or-decl-type> }
    rule meminitializerid:sym<ident>         { <identifier> }

    rule operator-function-id {
        <operator> <the-operator>
    }

    #-----------------------------
    proto rule literal-operator-id { * }

    rule literal-operator-id:sym<string-lit> {
        <operator>
        <string-literal> 
        <identifier>
    }

    rule literal-operator-id:sym<user-defined> {
        <operator>
        <user-defined-string-literal>
    }

    #-----------------------------
    rule template-declaration {
        <template>
        <less>
        <templateparameter-list>
        <greater>
        <declaration>
    }

    rule templateparameter-list {
        <template-parameter>
        [ <.comma> <template-parameter> ]*
    }

    #-----------------------------
    proto rule template-parameter { * }
    rule template-parameter:sym<type>  { <type-parameter> }
    rule template-parameter:sym<param> { <parameter-declaration> }

    #-----------------------------
    proto rule type-parameter-base { * }

    rule type-parameter-base:sym<basic> {
       [ <template> <less> <templateparameter-list> <greater> ]? 
       <class_>
    }

    rule type-parameter-base:sym<typename> {
       <typename_>
    }

    #-----------------------------
    proto rule type-parameter-suffix { * }
    rule type-parameter-suffix:sym<maybe-ident>    { <ellipsis>? <identifier>? }
    rule type-parameter-suffix:sym<assign-type-id> { <identifier>? <assign> <the-type-id> }

    #-----------------------------
    rule type-parameter {
        <type-parameter-base>
        <type-parameter-suffix>
    }

    rule simple-template-id {
        <template-name>
        <less>
        <template-argument-list>?
        <greater>
    }

    #-----------------------------
    proto rule template-id { * }

    rule template-id:sym<simple> {
        <simple-template-id>
    }

    rule template-id:sym<operator-function-id> {
        <operator-function-id>
        <less>
        <template-argument-list>?
        <greater>
    }

    rule template-id:sym<literal-operator-id> {
        <literal-operator-id>
        <less>
        <template-argument-list>?
        <greater>
    }

    #-----------------------------
    token template-name {
        <identifier>
    }

    rule template-argument-list {
        <template-argument> 
        <ellipsis>? 
        [ <.comma> <template-argument> <ellipsis>? ]*
    }

    #---------------------
    proto token template-argument { * }
    token template-argument:sym<type-id>    { <the-type-id> }
    token template-argument:sym<const-expr> { <constant-expression> }
    token template-argument:sym<id-expr>    { <id-expression> }

    #---------------------
    proto rule type-name-specifier { * }

    rule type-name-specifier:sym<ident> {
        <typename_>
        <nested-name-specifier>
        <identifier>
    }

    rule type-name-specifier:sym<template> {
        <typename_>
        <nested-name-specifier>
        <template>?  
        <simple-template-id>
    }

    #---------------------
    rule explicit-instantiation {
        <extern>?
        <template>
        <declaration>
    }

    rule explicit-specialization {
        <template>
        <less>
        <greater>
        <declaration>
    }

    rule try-block {
        <try_>
        <compound-statement>
        <handler-seq>
    }

    rule function-try-block {
        <try_>
        <constructor-initializer>?
        <compound-statement>
        <handler-seq>
    }

    rule handler-seq {
        <handler>+
    }

    rule handler {
        <catch>
        <.left-paren>
        <exception-declaration>
        <.right-paren>
        <compound-statement>
    }

    proto rule some-declarator { * }
    rule some-declarator:sym<basic>    { <declarator> }
    rule some-declarator:sym<abstract> { <abstract-declarator> }

    #---------------------
    proto rule exception-declaration { * }

    rule exception-declaration:sym<basic> {
        <attribute-specifier-seq>?
        <type-specifier-seq>
        <some-declarator>?
    }

    rule exception-declaration:sym<ellipsis> {
        <ellipsis>
    }

    rule throw-expression {
        <throw> <assignment-expression>?
    }

    #---------------------
    proto token exception-specification { * }
    token exception-specification:sym<dynamic>  { <dynamic-exception-specification> }
    token exception-specification:sym<noexcept> { <noe-except-specification> }

    #---------------------
    rule dynamic-exception-specification {
        <throw> <.left-paren> <type-id-list>?  <.right-paren>
    }

    rule type-id-list {
         <the-type-id> <ellipsis>? [ <.comma> <the-type-id> <ellipsis>? ]*
    }

    #---------------------
    proto token noe-except-specification { * }
    token noe-except-specification:sym<full>         { <noexcept> <.left-paren> <constant-expression> <.right-paren> }
    token noe-except-specification:sym<keyword-only> { <noexcept> }

    #---------------------
    proto token the-operator   { * }
    token the-operator:sym<new>                { <new_>   [ <.left-bracket> <.right-bracket>]? } 
    token the-operator:sym<delete>             { <delete> [ <.left-bracket> <.right-bracket>]? } 
    token the-operator:sym<plus>               { <plus>                                    } 
    token the-operator:sym<minus>              { <minus>                                   } 
    token the-operator:sym<star>               { <star>                                    } 
    token the-operator:sym<div_>               { <div_>                                     } 
    token the-operator:sym<mod_>               { <mod_>                                     } 
    token the-operator:sym<caret>              { <caret>                                   } 
    token the-operator:sym<and_>               { <and_>    <!before <and_>>                  } 
    token the-operator:sym<or_>                { <or_>                                      } 
    token the-operator:sym<tilde>              { <tilde>                                   } 
    token the-operator:sym<not>                { <not_>                                     } 
    token the-operator:sym<assign>             { <assign>                                  } 
    token the-operator:sym<greater>            { <greater>                                 } 
    token the-operator:sym<less>               { <less>                                    } 
    token the-operator:sym<greater-equal>      { <greater-equal>                            } 
    token the-operator:sym<plus-assign>        { <plus-assign>                              } 
    token the-operator:sym<minus-assign>       { <minus-assign>                             } 
    token the-operator:sym<star-assign>        { <star-assign>                              } 
    token the-operator:sym<mod-assign>         { <mod-assign>                               } 
    token the-operator:sym<xor-assign>         { <xor-assign>                               } 
    token the-operator:sym<and-assign>         { <and-assign>                               } 
    token the-operator:sym<or-assign>          { <or-assign>                                } 
    token the-operator:sym<LessLess>           { <less> <less>                             } 
    token the-operator:sym<GreaterGreater>     { <greater> <greater>                       } 
    token the-operator:sym<right-shift-assign> { <right-shift-assign>                        } 
    token the-operator:sym<left-shift-assign>  { <left-shift-assign>                         } 
    token the-operator:sym<equal>              { <equal>                                   } 
    token the-operator:sym<not-equal>          { <not-equal>                                } 
    token the-operator:sym<less-equal>         { <less-equal>                               } 
    token the-operator:sym<and-and>            { <and-and>                                  } 
    token the-operator:sym<or-or>              { <or-or>                                    } 
    token the-operator:sym<plus-plus>          { <plus-plus>                                } 
    token the-operator:sym<minus-minus>        { <minus-minus>                              } 
    token the-operator:sym<comma>              { <.comma>                                   } 
    token the-operator:sym<arrow-star>         { <arrow-star>                               } 
    token the-operator:sym<arrow>              { <arrow>                                   } 
    token the-operator:sym<Parens>             { <.left-paren>   <.right-paren>   } 
    token the-operator:sym<Brak>               { <.left-bracket> <.right-bracket> } 

    proto token literal { * }
    token literal:sym<int>                  { <integer-literal> }
    token literal:sym<char>                 { <character-literal> }
    token literal:sym<float>                { <floating-literal> }

    #Note: are we allowed to have many strings in a row?
    token literal:sym<str>                  { <string-literal> } 

    token literal:sym<bool>                 { <boolean-literal> }
    token literal:sym<ptr>                  { <pointer-literal> }
    token literal:sym<user-defined>         { <user-defined-literal> }
}

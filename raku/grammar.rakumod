use gtype;
use gkeywords;
use gfunction-header;
use gsimple-ifdef;
use block-comment;

our role ParserRules 
does Types
does Keywords
does BlockCommentRole
does Sigils
does SimpleIfdef
does FunctionHeader {

    regex template-identifier {
        <identifier> '<' <.ws> [[<unnamed-arg>]+ %% ["," <.ws>?] ] <.ws> '>'
    }

    token value  { <.identifier> | <.numeric> }

    rule static_const_rhs  { 
        | '=' <braced-array-literal>
        | '=' <default-value>
        | <braced-default-value>
    }

    rule braced-array-literal {
        <braced-array-literal-tree>
    }

    rule braced-array-literal-tree {
        | <braced-array-literal-leaf>
        | <braced-array-literal-leaf-list>
        | <braced-array-literal-leaf-list-list>
    }

    rule braced-array-literal-leaf {
        '{' [ <default-value>+ %% "," ] '}'
    }

    rule braced-array-literal-leaf-list {
        '{' [ <braced-array-literal-leaf>+ %% "," ] '}'
    }

    rule braced-array-literal-leaf-list-list {
        '{' [ <braced-array-literal-leaf-list>+ %% "," ] '}'
    }

   token api-tag {
        | 'GF_API'    | 'GF_LOCAL'
        | 'TF_API'    | 'TF_LOCAL'
        | 'ARCH_API'  | 'ARCH_LOCAL'
        | 'WORK_API'  | 'WORK_LOCAL'
        | 'TRACE_API' | 'TRACE_LOCAL'
        | 'TORCH_API' 
        | 'C10_EXPORT' 
        | 'CAMERAUTIL_API' 
        | 'USDRI_API' 
    }

    #---------------------------------------------
    rule static_const {
        <static> 
        [ <const> | <constexpr> ] 

        #
        <arg>
        #<type> <name> <array-specifier>? 
        #<static_const_rhs>

        ';' <line-comment>?
    }

    rule constexpr-global-block {
        <constexpr-global-item>+
    }

    rule constexpr-global-item {
        <line-comment>*
        <static>? <constexpr> <type> <name> '=' <until-semicolon> ';'
    }
    rule until-semicolon {
        \N+ <?before ';'>
    }

    #does not contain a closing bracket
    #this one may be somehwat ad-hoc
    #it is just to easily parse the rust 
    #struct skeleton out of the somewhat bulky
    #c++ class header
    rule ctor-header {
        <template-prefix>? 
        [<class> | <struct>] 
        <type> 
        <final>? 
        <class-inheritance>? '{'
        [<public> ':']?
        [<use-operator-context-functions> ';']?
        [<use-dispatch-helper> ';']?
    }


    rule using-declaration {
        [
            | <.using> <lhs=type> '=' <rhs=type> ';'
            | <.using> <lhs=type> '=' <rhs=function-sig-type> ';'
            | <.typedef> <rhs=unnamed-arg>  <lhs=type> ';'
        ] <line-comment>?
    }

    rule using-declarations {
        <using-declaration>+
    }

    rule typedef-fn-ptr {
        <.typedef> <rt=unnamed-arg> 
        '(' '*' <name> ')'
        '('<unnamed-args>')' 
        ';'
    }

    token use-operator-context-functions {
        'USE_OPERATOR_CONTEXT_FUNCTIONS'
    }
    token use-dispatch-helper {
        'USE_DISPATCH_HELPER'
    }

    regex class-inheritance {
        ':' 
        <.ws> [[
            [<public> | <private>]?
            <.ws>
            <type> 
            <.ws>
        ]+ %% ["," <.ws>]]
    }

    rule static-constants {
        <.ws> <static_const>+
    }

    rule line-comment-text {
        \N+
    }

    rule line-comment {
        '//' <line-comment-text>
    }
    rule maybe-comments {
        <line-comment>*
    }

    rule return-type {
        <const>? <volatile>? <type> <const2>? [<ref> | [<ptr>+ <ptr-ref>?] ]?
    }

    token namespace {
        <identifier> '::'
    }

    token numeric-value {
        [ '+' | '-' | '~' ]? <[ 0..9 ]>+ [ '.' <[ 0..9 ]>+ ]? [ 'e' <.numeric-value> ]? 
    }

    token numeric-suffix {
        | 'f'
        | 'u'
        | 'U'
    }

    token numeric {
        <numeric-value> <numeric-suffix>? 
    }

    token hexadecimal {
         [ "0x" | '0X' ] <[ A..F a..f 0..9 ]>+     
     }

    token identifier {
        <[A..Z a..z _]> <[A..Z a..z 0..9 _]>*
    }

    token extended-identifier {
        <[A..Z a..z _]> <[A..Z a..z 0..9 _ : < > ]>*
    }

    token namespaced-extended-identifier {
        <extended-identifier>+ %% "::"
    }

    token name {
        <.identifier>
    }

    token empty-array-specifier {
        '[]'
    }

    token array-specifier {
        | <empty-array-specifier>
        | [ '[' <array-dimension> ']' ]+
    }

    token array-dimension {
        [ 
            | <.expression> 
            | <.identifier> 
            | <.numeric> 
            | <.hexadecimal> 
        ]
    }
    rule expression {
        [ 
            | <.identifier>
            | <.numeric>
            | <.hexadecimal>
        ]+ %% <.expression-separator>
    }
    token expression-separator {
        | '+'
        | '*'
        | '-'
        | '|'
        | '/'
        | '>>'
        | '<<'
    }

    token macro-sig {
        <macro-name> 
        ['(' <macro-args> ')']? 
    }

    rule pound-define {
        '#define' 
        <macro-sig>
        <macro-line>+
    }

    token macro-name {
        <.name>
    }

    rule name-list {
        <name>* %% ","
    }

    rule macro-args {
        <name-list> <elipsis>?
    }

    token elipsis {
        '...'
    }

    token macro-line {
        | [\N* \ \n]
        | [\N* <?before <macro-term>>]
    }

    token macro-term {
        \n
    }

    token macro-terminator {
        \ \n
    }

    rule arg {
        | <function-ptr-type>
        | [ <std-function> <name> ]
        | [
            <class>? 
            <const>? 
            <volatile>?
            <struct>?
            <type> 
            <const2>? 
            [<ref> | [<ptr>+ <ptr-ref>?] ]? 
            <const3>? 
            [
                | <name> 
                | '/*' <name>  '*/'
            ]
            <array-specifier>?
            [ '=' <default-value> ]?
        ]
    }

    rule unnamed-arg {
        <class>? 
        <const>? 
        <volatile>?
        <struct>?
        <type> 
        <const2>? 
        [<ref> | [<ptr>+ <ptr-ref>?] ]? 
        <const3>? 
        <array-specifier>?
    }

    rule template-arg {
        [ 'template' '<' 'class' '>']?
        [<class> | <typename> | <type>]? 
        <name> 
        [ '=' <default-value=.type> ]?
    }

    rule default-value-atom {
        || <.expression> 
        || <.constructor-expression>
        || <.identifier> 
        || <.numeric> 
        || <.hexadecimal> 
        || <.extended-identifier> 
        || <.namespaced-extended-identifier> 
        || <.quoted-string>
        || <identifier-cast-as-uarg>
        || '{}'
    }

    rule maybe-braced-default-value-atom-list {
        || <.default-value-atom>
        || '{' [<.default-value-atom>+ %% ","] '}'
    }

    rule braced-default-value {
        '{' [<default-value=default-value-atom>+ %% ","] '}'
    }

    rule default-value {
        <.maybe-braced-default-value-atom-list>
    }

    token identifier-cast-as-uarg {
        '(' <unnamed-arg> ')' <identifier>
    }

    token opening-quote {
        | \"
        | "'"
    }

    token closing-quote {
        | \"
        | "'"
    }

    token quoted-string {
        <.opening-quote>
        [
            <-[ ' " \\ ]>  # regular character
            | \\ .         # escape sequence
        ]*
        <.closing-quote>
    }

    regex args {
        | 'void'
        | [<arg>* % ',']
    }

    regex maybe-unnamed-args {
        | 'void'
        | <maybe-unnamed-arg>* % ','
    }

    regex maybe-unnamed-arg {
        || <arg>
        || <unnamed-arg>
    }

    rule unnamed-args {
        <unnamed-arg>* % ','
    }

    rule template-args {
        <template-arg>* % ','
    }

    rule parenthesized-args {
        | '(' <void> ')'
        | '('  <maybe-unnamed-args> <trailing-elipsis>? ')'
    }

    token function-name {
        | <namespace>? <priv>? <identifier>
        | <namespace>? <function-name-operator-invoke>
        | <namespace>? <function-name-operator-assign>
        | <namespace>? <function-name-operator-prefix-increment>
        | <namespace>? <function-name-operator-prefix-decrement>
        | <namespace>? <function-name-operator-postfix-increment>
        | <namespace>? <function-name-operator-postfix-decrement>
    }

    token function-name-operator-invoke {
        'operator' '(' ')'
    }

    token function-name-operator-assign {
        'operator' '='
    }

    rule function-name-operator-prefix-increment {
        'operator' '++'
    }
    rule function-name-operator-postfix-increment {
        'operator' '++' <?before '(int)'>
    }
    rule function-name-operator-prefix-decrement {
        'operator' '--'
    }
    rule function-name-operator-postfix-decrement {
        'operator' '--' <?before '(int)'>
    }

    rule trailing-elipsis {
        ',' '...' 
    }

    rule function-declaration {
        <line-comment>*
        <api-tag>?  
        <inline>? 
        <static>? 
        <inline>?
        <constexpr>? 
        <return-type>?
        <function-name> 
        <parenthesized-args>
        <const>?
        <noexcept>?
        <override>?
        <final>?
        <terminator>?  
        <line-comment>? 
    }

    rule class-constructor-declaration {
        <line-comment>*
        <api-tag>?
        <explicit>?
        <name>
        <parenthesized-args>
        <terminator>
    }

    rule template-prefix {
        <template> '<' <template-args> '>'
    }

    rule constructor-definition-header {
        <line-comment>* 
        <template-prefix>?
        <constexpr>? 
        <inline>? 
        <explicit>? 
        <namespace>? 
        <type> 
        <parenthesized-args> 
        <constructor-initializers>?
    }

    rule constructor-initializers {
        ':' 
        <constructor-initializer>+ %% ","
    }

    rule constructor-initializer {
        <field-name=.identifier> '(' ~ ')' 
        <field-body=.constructor-initializer-body>?
    }
    rule constructor-initializer-body {
        '&'? [
            | <.constructor-expression>
            | <.identifier> 
            | <.numeric> 
            | <.extended-identifier> 
            | <.quoted-string>
        ]* %% [',' | '.' | '/' | '*' ]
    }
    rule constructor-expression {
        <.type> '(' [
            <constructor-initializer-body>* %% ","
        ] ')'
    }

    rule hashing-function {
        <line-comment>*
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        'hash_value'
        <parenthesized-args>
    }

    rule default-ctor {
        <line-comment>* <type> '()' 
        <constructor-initializers>? 
    }

    rule abstract-function-declaration {
        :sigspace
        [<line-comment> | <block-comment>]*
        <virtual> <return-type> <name> 
        <parenthesized-args>
        <const>? 
        <noexcept>? 
        '=' '0' ';'
    }

    rule abstract-function-declarations {
        <abstract-function-declaration>+
    }

    rule struct-member-declaration-name {
        [
            <name> 
            <array-specifier>?
            [ 
                | '=' <default-value> 
                | <braced-default-value>
            ]? 
        ]
    }
    rule struct-member-declaration-nonfptr {
        <struct>? 
        <const>? 
        <volatile>? 
        <type> 
        <const>? 
        [<ref> | [<ptr>+ <ptr-ref>?] ]?  
        <const2>? 
        [
            <struct-member-declaration-name>+ %% ","
        ]
    }

    rule function-ptr-type {
        <return-type> '(' '*' <name> ')'
        <parenthesized-args>
    }

    rule struct-member-declaration {
        :sigspace
        [<line-comment>* | <block-comment>]
        [
            | <struct-member-declaration-nonfptr>
            | <function-ptr-type>
        ]
        :!sigspace
        ';' 
        [\h* [<line-comment> | <block-comment>]]?
        :sigspace
        <.ws>
    }
    rule destructor {
        '~' <type> '(' ')' 
        <override>?
        <final>?
    }

    rule struct-member-declarations {
        :sigspace
        <struct-member-declaration>+
    }

    rule function-local-type-suffix {
       [<ref> | [<ptr>+ <ptr-ref>?] ]?  <name> <array-specifier>? 
    }

    rule function-local-declaration {
        <line-comment>*
        <type> 
        <function-local-type-suffix>+ % ','
        ';'
    }

    rule function-local-declarations {
        <function-local-declaration>+
    }
}

grammar NakedStripper does ParserRules {
    rule TOP {
        <.ws> [<ref> | [<ptr>+ <ptr-ref>?] ]? <mut>? <identifier>
    }
}

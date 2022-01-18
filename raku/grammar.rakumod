use gtype;
use gkeywords;
use gfunction-header;
use gsimple-ifdef;
use block-comment;
use ident-token;
use numeric-token;
use quoted-string-token;
use rule-braced-array-literal;
use rule-line-comment;
#use Grammar::Tracer;

our role ParserRules 
does Types
does Keywords
does BlockCommentRole
does Sigils
does SimpleIfdef
does QuotedStringToken
does BracedArrayLiteralRule
does LineCommentRule
does IdentToken
does NumericToken
does FunctionHeader {

    rule func-tag {
        | FUNC_ATTR_CONST
        | FUNC_ATTR_ALWAYS_INLINE
        | FUNC_ATTR_NONNULL_RET
        | FUNC_ATTR_MALLOC
        | FUNC_ATTR_UNUSED
        | FUNC_ATTR_NORETURN
        | FUNC_ATTR_NONNULL_ALL
        | FUNC_ATTR_PURE
        | FUNC_ATTR_WARN_UNUSED_RESULT
        | FUNC_ATTR_NO_SANITIZE_UNDEFINED
        | <func-nonnull-arg>
    }

    rule func-nonnull-arg {
        | "FUNC_ATTR_NONNULL_ARG(" [<int-literal>+ %% ", "] ')'
        | "FUNC_ATTR_ALLOC_SIZE(" [<int-literal>+ %% ", "] ')'
        | "FUNC_ATTR_ALLOC_SIZE_PROD(" [<int-literal>+ %% ", "] ')'
    }

    rule func-tags {
        <func-tag>+
    }

    regex template-identifier {
        <identifier> '<' <.ws> [[<unnamed-arg>]+ %% ["," <.ws>?] ] <.ws> '>'
    }

    token value  { 
        | <.identifier> 
        | <.numeric> 
        | <.int-literal> 
        | <.hexadecimal> 
    }

    rule static_const_rhs  { 
        | '=' <braced-array-literal>
        | '=' <default-value>
        | <braced-default-value>
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
        <parenthesized-args>
        ';'
    }

    rule typedef-fn-ptrs {
        <typedef-fn-ptr>+
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

    rule return-type {
        <const>? <volatile>? <type> <const2>? [<ref> | [<ptr>+ <ptr-ref>?] ]?
    }

    token namespace {
        <identifier> '::'
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
        <macro-line>*
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
        || <.braced-array-literal> 
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


    rule class-constructor-declaration {
        <line-comment>*
        <api-tag>?
        <explicit>?
        <plugin-api>?
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
        <virtual> 
        <return-type> 
        <plugin-api>? 
        <name> 
        <parenthesized-args>
        <const>? 
        <noexcept>? 
        '=' '0' ';'
    }
    token plugin-api {
        | 'PLUGIN_API'
        | 'PLUG_API'
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

    rule equals-int {
        '=' <value>
    }

    rule enum-member-declaration-item {
        <id=identifier> <equals-int>?
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

    rule enum-member-declaration {
        :sigspace
        [<line-comment>* | <block-comment>]
        [
            | <enum-member-declaration-item>
        ]
        :!sigspace
        ','
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

    rule enum-member-declarations {
        :sigspace
        <enum-member-declaration>+
    }

    #--------------------------
    rule full-struct {
        | <full-struct-v1>
        | <full-struct-v2>
    }

    rule full-struct-v1 {
        <typedef> <struct> '{'
            <struct-member-declarations>
        '}' <struct-name> ';'
    }

    rule full-struct-v2 {
        <struct> <struct-name> '{'
            <struct-member-declarations>
        '}' ';'
    }

    #--------------------------
    rule full-enum {
        | <full-enum-v1>
    }

    rule full-enum-v1 {
        <typedef> <enum> '{'
            <enum-member-declarations>
        '}' <enum-name> ';'
    }

    rule struct-name { <.identifier> }
    rule enum-name   { <.identifier> }

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

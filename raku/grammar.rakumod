use gtype;
use gkeywords;
use gfunction-header;

our role ParserRules 
does Types
does Keywords
does Sigils
does FunctionHeader {

    regex template-identifier {
        <identifier> '<' [[[<const> <.ws>]? <type>]+ %% ["," <.ws>?] ] '>'
    }

    token value  { <.identifier> | <.numeric> }
    rule static_const_rhs  { <-[  ; ]>+ }

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

    rule static_const {
        <static> <const> <type> <name> '=' <static_const_rhs> ';' <line-comment>?
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
        | <.using> <lhs=type> '=' <rhs=type> ';'
        | <.typedef> <rhs=unnamed-arg>  <lhs=type> ';'
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
        <const>? <volatile>? <type> <const2>? [<ref> | <ptr>+ ]?
    }

    token namespace {
        <identifier> '::'
    }

    token numeric {
        [ '+' | '-' ]? <[ 0..9 ]>+ [ '.' <[ 0..9 ]>+ ]? [ 'e' <.numeric> ]?
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

    token name {
        <.identifier>
    }

    token array-specifier {
        [ '[' <array-dimension> ']' ]+
    }

    token array-dimension {
        [ <.identifier> | <.numeric> | <.hexadecimal> ]
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
        <class>? 
        <const>? 
        <volatile>?
        <struct>?
        <type> 
        <const2>? 
        [<ref> | <ptr>+ ]? 
        <name> 
        <array-specifier>?
        [ '=' <default-value> ]?
    }

    rule unnamed-arg {
        <class>? 
        <const>? 
        <volatile>?
        <struct>?
        <type> 
        <const2>? 
        [<ref> | <ptr>+ ]? 
        <array-specifier>?
    }

    rule template-arg {
        [ 'template' '<' 'class' '>']?
        [<class> | <typename> | <type>]? 
        <name> 
    }

    rule default-value {
        <.identifier> | <.numeric> | <.extended-identifier>
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
        | <unnamed-arg>
        | <arg>
    }

    rule unnamed-args {
        <unnamed-arg>* % ','
    }

    rule template-args {
        <template-arg>* % ','
    }

    rule parenthesized-args {
        '('  <args> ')'
    }

    token function-name {
        <namespace>? <priv>? <identifier>
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
        '(' <args> <trailing-elipsis>?')' 
        <const>?
        <noexcept>?
        <override>?
        <terminator>?  
        <line-comment>? 
    }

    rule class-constructor-declaration {
        <line-comment>*
        <api-tag>?
        <explicit>?
        <name>
        '(' <args> ')' 
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
    }

    rule hashing-function {
        <line-comment>*
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        'hash_value'
        '(' <args> ')'
    }

    rule default-ctor {
        <line-comment>* <type> '()' .*
    }

    rule abstract-function-declaration {
        :sigspace
        <line-comment>*
        <virtual> <return-type> <name> '(' <args> ')' <const>? '=' '0' ';'
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
                | '{' <default-value> '}'
            ]? 
        ]
    }
    rule struct-member-declaration-nonfptr {
        <struct>? 
        <const>? 
        <volatile>? 
        <type> 
        [<ref> | <ptr>+]?  
        [
            <struct-member-declaration-name>+ %% ","
        ]
    }

    rule function-ptr-type {
        <return-type> '(' '*' <name> ')'
        '(' <maybe-unnamed-args>  ')'
    }

    rule struct-member-declaration {
        :sigspace
        <line-comment>*
        [
            | <struct-member-declaration-nonfptr>
            | <function-ptr-type>
        ]
        :!sigspace
        ';' 
        [\h* <line-comment>]?
        :sigspace
        <.ws>
    }
    rule destructor {
        '~' <type> '(' ')' <override>?
    }

    rule struct-member-declarations {
        :sigspace
        <struct-member-declaration>+
    }

    rule function-local-type-suffix {
       [<ref> | <ptr>+]?  <name> <array-specifier>? 
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
        <.ws> [<ref> | <ptr>+]? <mut>? <identifier>
    }
}

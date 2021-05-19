use gtype;
use gkeywords;
use gfunction-header;

our role ParserRules 
does Types
does Keywords
does Sigils
does FunctionHeader {

    token template-identifier {
        <identifier> '<' <nonvector-identifier> '>'
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
    }

    rule static_const {
        <static> <const> <type> <name> '=' <static_const_rhs> ';' <line-comment>?
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
        <const>? <type> <const2>? [<ref> | <ptr> ]?
    }

    token namespace {
        <identifier> '::'
    }

    token numeric {
        <[ 0..9 ]>+ [ '.' <[ 0..9 ]>+ ]?
    }

    token identifier {
        <[A..Z a..z _]> <[A..Z a..z 0..9 _]>*
    }

    token extended-identifier {
        <[A..Z a..z _]> <[A..Z a..z 0..9 _ : < > ]>*
    }

    rule vectorized-identifier {
        [ 'std::' ]? 'vector<' <maybe-vectorized-identifier> '>'
    }

    token maybe-vectorized-identifier {
        | <nonvector-identifier> 
        | <vectorized-identifier>
    }

    token type {
        <maybe-vectorized-identifier>
    }

    token name {
        <.identifier>
    }

    token array-specifier {
        [ '[' <array-dimension> ']' ]+
    }

    token array-dimension {
        [ <.identifier> | <.numeric> ]
    }

    rule arg {
        <class>? 
        <const>? 
        <type> 
        <const2>? 
        [<ref> | <ptr> ]? 
        <name> 
        <array-specifier>?
        [ '=' <default-value> ]?
    }

    rule template-arg {
        [ 'template' '<' 'class' '>']?
        [<class> | <typename>]? 
        <name> 
    }

    rule default-value {
        <.identifier> | <.numeric> | <.extended-identifier>
    }

    rule args {
        <arg>* % ','
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

    rule struct-member-declaration {
        <line-comment>*
        <struct>? <type> [<ref> | <ptr>]?  <name> ';'
    }

    rule struct-member-declarations {
        <struct-member-declaration>+
    }

    rule function-local-type-suffix {
        [<ref> | <ptr>]?  <name> <array-specifier>? 
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
        <.ws> [<ref> | <ptr>]? <mut>? <identifier>
    }
}

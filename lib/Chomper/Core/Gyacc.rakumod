our role Yacc {

    rule yacc-snippet {
        <yacc-item>+
    }

    rule yacc-item {
        <name>
        ':' <subrule>
        [
            '|' <subrule>
        ]*
        ';'
    }

    rule name {
        <.ident>
    }

    rule subrule {
        <subrule-body> <subrule-actions>?
    }

    #--------------------------
    proto token subrule-body-item { * }

    token subrule-body-item:sym<token> {  
         <subrule-token>
    }

    token subrule-body-item:sym<quoted> {  
        <quoted-char>
    }

    rule subrule-body-item:sym<prec-pragma> {
        '%prec' <subrule-token>
    }

    proto token subrule-body { * }

    token subrule-body:sym<basic> {
        <subrule-body-item> [<.ws> <subrule-body-item>]*
    }

    token subrule-body:sym<empty> {
        '%empty'
    }

    #--------------------------
    rule subrule-token {
        <.ident>
    }

    rule ident {
        <[A..Z a..z _ 0..9 \-]>+
    }

    token quoted-char {
        "'" <char> "'"
    }

    token char {
        | <[A..Z a..z _ 0..9]> 
        | '!'
        | '#'
        | '$'
        | '%'
        | '&'
        | '*'
        | '+'
        | ','
        | '-'
        | '.'
        | '/'
        | ':'
        | ';'
        | '<'
        | '='
        | '>'
        | '?'
        | '@'
        | '^'
        | '|'
        | '~'
        | \(
        | \)
        | \[
        | \]
        | \{
        | \} 
    }

    rule subrule-actions {
        '{' ['$$' '=']? <subrule-action-initializer> ';' '}'
    }

    proto rule subrule-action-initializer { * }

    rule subrule-action-initializer:sym<mk-node> {
        <mk-node-initializer>
    }

    rule subrule-action-initializer:sym<mk-atom> {
        <mk-atom-initializer>
    }

    rule subrule-action-initializer:sym<mk-none> {
        <mk-none-initializer>
    }

    rule subrule-action-initializer:sym<ext-node> {
        <ext-node-initializer>
    }

    rule subrule-action-initializer:sym<arg> {
        <arg>
    }

    rule mk-node-initializer {
        'mk_node' '(' <args> ')'
    }

    rule mk-atom-initializer {
        'mk_atom' '(' <arg> ')' 
    }

    rule mk-none-initializer {
        'mk_none' '(' ')' 
    }

    rule ext-node-initializer {
        'ext_node' '(' <args> ')' 
    }

    rule args {
        <arg>+ %% <comma>
    }

    rule int        { <[0..9]>+ }
    rule quoted-str { '"' <ident> '"' }

    #------------------------
    proto rule arg { * }
    rule arg:sym<mk-node>    { <mk-node-initializer> }
    rule arg:sym<mk-atom>    { <mk-atom-initializer> }
    rule arg:sym<mk-none>    { <mk-none-initializer> }
    rule arg:sym<quoted-str> { <quoted-str> }
    rule arg:sym<ident>      { <ident> }
    rule arg:sym<int>        { <[0..9]>+ }
    token arg:sym<dollar-int> { \$ <int> }

    token comma { ',' }
}

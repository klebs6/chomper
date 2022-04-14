our grammar Dotfile {

    rule TOP {
        :my $*DIGRAPH = False;
        <.ws> <graph>
    }

    rule graph {
        ['strict']? [ 'graph' | 'digraph' { $*DIGRAPH = True; } ] <id> '{' <stmt-list> '}'
    }

    rule stmt-list {
        <stmt>* %% ';'
    }

    proto rule stmt { * }

    rule stmt:sym<node> {
        <node-id> <attr-list>?
    }

    rule stmt:sym<edge> {
        [<node-id> | <subgraph>] <edge-rhs> <attr-list>?
    }

    rule stmt:sym<attr> {
        ['graph' | 'node' | 'edge' ] <attr-list>
    }

    token stmt:sym<id> {
        <.id>
    }

    rule stmt:sym<subgraph> {
        [ <subgraph> <id>? ]? '{' <stmt-list> '}'
    }

    token id {
        | <alpha-string>
        | <numeral>
        | <double-quoted-string>
    }

    rule attr-list {
        [ '[' <a-list>? ']' ]+
    }

    rule a-list {
        [<id> '=' <id>]* %% [';' | ',']
    }

    rule edge-rhs {
        [<edge-op> [<node-id> | <subgraph>]]+
    }

    rule node-id {
        <id> <port>?
    }

    rule port {
        | ':' <id> [':' <compass-pt>]?
        | ':' <compass-pt>
    }

    token compass-pt {
        | 'n'
        | 'ne'
        | 'e'
        | 'se'
        | 's'
        | 'sw'
        | 'w'
        | 'nw'
        | 'c'
        | '_'
    }
    token alpha-string {
        <[a..z A..Z _]> 
        <[a..z A..Z 0..9 _]>*
    }

    token numeral {
        '-'? [
            | <[0..9]>+ [ '.' <[0..9]>* ]?
            | '.' <[0..9]>
        ]
    }

    token double-quoted-string {
        '"' ~ '"' <-[ " ]>*
    }

    token edge-op {
        | { $*DIGRAPH == True   } '--'
        | { $*DIGRAPH == False  } '->'
    }
}

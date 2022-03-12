our role UseDeclaration::Rules {

    rule use-declaration {
        <kw-use> 
        <use-tree> 
        <tok-semi>
    }

    proto rule use-tree { * }

    rule use-tree:sym<basic> {
        [
            <simple-path>? 
            <tok-path-sep>
        ]? 
        <tok-star>
    }

    rule use-tree:sym<complex> {
       [ <simple-path>? <tok-path-sep> ]? 
       <tok-lbrace>
       [
           <use-tree>+ %% <tok-comma>
       ]? 
       <tok-rbrace>
    }

    rule use-tree:sym<as> {
        <simple-path>
       [ 
           <kw-as> 
           <identifier-or-underscore>
       ]?
    }
}

our role UseDeclaration::Actions {}

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
            <tok-mod-sep>
        ]? 
        <tok-star>
    }

    rule use-tree:sym<complex> {
       [ <simple-path>? <tok-mod-sep> ]? 
       <tok-lbrack>
       [
           <use-tree>+ %% <tok-comma>
       ]? 
       <tok-rbrack>
    }

    rule use-tree:sym<as> {
        <simple-path>
       [ 
           <kw-as> 
           <identifier-or-underscore>
       ]?
    }
}

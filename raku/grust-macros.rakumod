our role MacroInvocation::Rules {

    rule macro-invocation {
        <simple-path> 
        <tok-bang> 
        <delim-token-tree>
    }

    rule delim-token-tree {
        | <tok-lparen> <token-tree>* <tok-rparen>
        | <tok-lbrack> <token-tree>* <tok-rbrack>
        | <tok-lbrace> <token-tree>* <tok-rbrace>
    }

    proto rule token-tree { * }

    rule token-tree:sym<leaf> { <token-except-delimiters> }

    rule token-tree:sym<tree> { <delim-token-tree> }

    rule macro-invocation-semi {
        | <simple-path> <.tok-bang> <.tok-lparen> <token-tree>* <.tok-rparen> <.tok-semi>
        | <simple-path> <.tok-bang> <.tok-lbrack> <token-tree>* <.tok-rbrack> <.tok-semi>
        | <simple-path> <.tok-bang> <.tok-lbrace> <token-tree>* <.tok-rbrace>
    }

    token kw-macro-rules {
        macro_rules
    }

    rule macro-rules-definition {
        <kw-macro-rules> 
        <tok-bang>
        <identifier>
        <macro-rules-def>
    }

    rule macro-rules-def {
        | <tok-lparen> <macro-rules> <tok-rparen> <tok-semi>
        | <tok-lbrack> <macro-rules> <tok-rbrack> <tok-semi>
        | <tok-lbrace> <macro-rules> <tok-rbrace>
    }

    rule macro-rules {
        <macro-rule>+ %% <tok-semi>
    }

    rule macro-rule {
        <macro-matcher> <tok-fat-rarrow> <macro-transcriber>
    }

    rule macro-matcher {
        | <tok-lparen> <macro-match>* <tok-rparen>
        | <tok-lbrack> <macro-match>* <tok-rbrack>
        | <tok-lbrace> <macro-match>* <tok-rbrace>
    }

    #-----------------
    proto rule macro-match { * }

    rule macro-match:sym<token>   { 
        <token-except-dollar-and-delimiters> 
    }

    rule macro-match:sym<matcher> { 
        <macro-matcher> 
    }

    rule macro-match:sym<single>  { 
        <tok-dollar> 
        <identifier> 
        <tok-colon> 
        <macro-frag-spec> 
    }

    rule macro-match:sym<plural>  { 
        <tok-dollar> 
        <tok-lparen> 
        <macro-match>+ 
        <tok-rparen> 
        <macro-rep-sep>? 
        <macro-rep-op> 
    }

    #-----------------
    proto rule macro-frag-spec { * }

    rule macro-frag-spec:sym<block>     { block }
    rule macro-frag-spec:sym<expr>      { expr }
    rule macro-frag-spec:sym<ident>     { ident }
    rule macro-frag-spec:sym<item>      { item }
    rule macro-frag-spec:sym<lifetime>  { lifetime }
    rule macro-frag-spec:sym<literal>   { literal }
    rule macro-frag-spec:sym<meta>      { meta }
    rule macro-frag-spec:sym<pat>       { pat }
    rule macro-frag-spec:sym<pat_param> { pat_param }
    rule macro-frag-spec:sym<path>      { path }
    rule macro-frag-spec:sym<stmt>      { stmt }
    rule macro-frag-spec:sym<tt>        { tt }
    rule macro-frag-spec:sym<ty>        { ty }
    rule macro-frag-spec:sym<vis>       { vis }

    rule macro-rep-sep {
        <token-except-delimiters-and-repetition-operators>
    }

    proto rule macro-rep-op { * }
    rule macro-rep-op:sym<star>  { <tok-star> }
    rule macro-rep-op:sym<plus>  { <tok-plus> }
    rule macro-rep-op:sym<qmark> { <tok-qmark> }

    rule macro-transcriber {
        <delim-token-tree>
    }
}

our role MacroInvocation::Actions {}

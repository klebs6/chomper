our class MacroExpression {
    has $.simple-path;
    has $.delim-token-tree;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class DelimTokenTree {
    has @.token-trees;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TokenTreeLeaf {
    has $.rust-token-no-delim;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class TokenTree {
    has $.delim-token-tree;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroInvocation {
    has $.maybe-comment;
    has $.simple-path;
    has @.token-trees;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroRulesDefinition {
    has $.identifier;
    has $.macro-rules-def;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroRulesDef {
    has $.maybe-comment;
    has @.macro-rules;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroRule {
    has $.macro-matcher;
    has $.macro-transcriber;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroMatcher {
    has @.macro-matches;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroMatchToken {
    has $.token;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroMatchMatcher {
    has $.macro-matcher;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroMatchSingle {
    has $.identifier;
    has $.macro-frag-spec;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroMatchPlural {
    has @.macro-matches;
    has $.maybe-macro-rep-sep;
    has $.macro-rep-op;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroRepSep {
    has $.token;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroRepOpStar { 

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroRepOpPlus { 

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroRepOpQmark { 

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class MacroTranscriber {
    has $.delim-token-tree;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our role MacroInvocation::Rules {

    rule macro-expression {
        <simple-path> 
        <tok-bang> 
        <delim-token-tree>
    }

    rule delim-token-tree {
        | <tok-lparen> <token-tree>* <tok-rparen>
        | <tok-lbrack> <token-tree>* <tok-rbrack>
        | <tok-lbrace> <token-tree>* <tok-rbrace>
    }

    rule token-trees { <token-tree>* }

    proto rule token-tree { * }

    rule token-tree:sym<leaf> { <rust-token-no-delim> }

    rule token-tree:sym<tree> { <delim-token-tree> }

    rule macro-invocation {
        <comment>? 
        [
            | <simple-path> <.tok-bang> <.tok-lparen> <token-tree>* <.tok-rparen> <.tok-semi>
            | <simple-path> <.tok-bang> <.tok-lbrack> <token-tree>* <.tok-rbrack> <.tok-semi>
            | <simple-path> <.tok-bang> <.tok-lbrace> <token-tree>* <.tok-rbrace>
        ]
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
        | <tok-lparen> <comment>? <macro-rules> <tok-rparen> <tok-semi>
        | <tok-lbrack> <comment>? <macro-rules> <tok-rbrack> <tok-semi>
        | <tok-lbrace> <comment>? <macro-rules> <tok-rbrace>
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

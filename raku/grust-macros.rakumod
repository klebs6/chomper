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

our class MacroRepOpStar { }

our class MacroRepOpPlus { }

our class MacroRepOpQmark { }

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

our class MacroFragSpec::Block    { }
our class MacroFragSpec::Expr     { }
our class MacroFragSpec::Ident    { }
our class MacroFragSpec::Item     { }
our class MacroFragSpec::Lifetime { }
our class MacroFragSpec::Literal  { }
our class MacroFragSpec::Meta     { }
our class MacroFragSpec::Pat      { }
our class MacroFragSpec::PatParam { }
our class MacroFragSpec::Path     { }
our class MacroFragSpec::Stmt     { }
our class MacroFragSpec::Tt       { }
our class MacroFragSpec::Ty       { }
our class MacroFragSpec::Vis      { }

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

our role MacroInvocation::Actions {

    method macro-expression($/) {
        make MacroExpression.new(
            simple-path      => $<simple-path>.made,
            delim-token-tree => $<delim-token-tree>.made,
            text       => $/.Str,
        )
    }

    method delim-token-tree($/) {
        make DelimTokenTree.new(
            token-tree => $<token-tree>.made
            text       => $/.Str,
        )
    }

    method token-trees($/) { make $<token-tree>>>.made }

    method token-tree:sym<leaf>($/) { 
        make TokenTreeLeaf.new(
            rust-token-no-delim => $<rust-token-no-delim>.made
            text       => $/.Str,
        )
    }

    method token-tree:sym<tree>($/) { 
        make TokenTree.new(
            delim-token-tree => $<delim-token-tree>.made
            text       => $/.Str,
        )
    }

    method macro-invocation($/) {
        make MacroInvocation.new(
            maybe-comment => $<comment>.made,
            simple-path   => $<simple-path>.made,
            token-trees   => $<token-tree>>>.made,
            text       => $/.Str,
        )
    }

    method macro-rules-definition($/) {
        make MacroRulesDefinition.new(
            identifier      => $<identifier>.made,
            macro-rules-def => $<macro-rules-def>.made,
            text       => $/.Str,
        }

    method macro-rules-def($/) {
        make MacroRulesDef.new(
            maybe-comment => $<comment>.made,
            macro-rules   => $<macro-rules>.made,
            text       => $/.Str,
        )
    }

    method macro-rules($/) {
        make $<macro-rule>>>.made
    }

    method macro-rule($/) {
        make MacroRule.new(
            macro-matcher     => $<macro-matcher>.made,
            macro-transcriber => $<macro-transcriber>.made,
            text       => $/.Str,
        )
    }

    method macro-matcher($/) {
        make MacroMatcher.new(
            macro-matches => $<macro-match>>>.made,
            text       => $/.Str,
        )
    }

    #-----------------
    method macro-match:sym<token>($/)   { 
        make MacroMatchToken.new(
            token => $<token-except-dollar-and-delimiters>.made,
            text       => $/.Str,
        )
    }

    method macro-match:sym<matcher>($/) { 
        make MacroMatchMatcher.new(
            macro-matcher => $<macro-matcher>.made,
            text       => $/.Str,
        )
    }

    method macro-match:sym<single>($/)  { 
        make MacroMatchSingle.new(
            identifier      => $<identifier>.made,
            macro-frag-spec => $<macro-frag-spec>.made,
            text       => $/.Str,
        )
    }

    method macro-match:sym<plural>($/)  { 
        make MacroMatchPlural.new(
            macro-matches       => $<macro-match>>>.made,
            maybe-macro-rep-sep => $<macro-rep-sep>.made,
            macro-rep-op        => $<macro-rep-op>.made,
            text       => $/.Str,
        )
    }

    #-----------------
    method macro-frag-spec:sym<block>($/)     { make MacroFragSpec::Block.new }
    method macro-frag-spec:sym<expr>($/)      { make MacroFragSpec::Expr.new }
    method macro-frag-spec:sym<ident>($/)     { make MacroFragSpec::Ident.new }
    method macro-frag-spec:sym<item>($/)      { make MacroFragSpec::Item.new }
    method macro-frag-spec:sym<lifetime>($/)  { make MacroFragSpec::Lifetime.new }
    method macro-frag-spec:sym<literal>($/)   { make MacroFragSpec::Literal.new }
    method macro-frag-spec:sym<meta>($/)      { make MacroFragSpec::Meta.new }
    method macro-frag-spec:sym<pat>($/)       { make MacroFragSpec::Pat.new }
    method macro-frag-spec:sym<pat_param>($/) { make MacroFragSpec::PatParam.new }
    method macro-frag-spec:sym<path>($/)      { make MacroFragSpec::Path.new }
    method macro-frag-spec:sym<stmt>($/)      { make MacroFragSpec::Stmt.new }
    method macro-frag-spec:sym<tt>($/)        { make MacroFragSpec::Tt }.new
    method macro-frag-spec:sym<ty>($/)        { make MacroFragSpec::Ty }.new
    method macro-frag-spec:sym<vis>($/)       { make MacroFragSpec::Vis.new }

    method macro-rep-sep($/) {
        make MacroRepSep.new(
            token => $<token-except-delimiters-and-repetition-operators>.made,
            text       => $/.Str,
        )
    }

    method macro-rep-op:sym<star>($/)  { make MacroRepOpStar.new }
    method macro-rep-op:sym<plus>($/)  { make MacroRepOpPlus.new }
    method macro-rep-op:sym<qmark>($/) { make MacroRepOpQmark.new }

    method macro-transcriber($/) {
        make MacroTranscriber.new(
            delim-token-tree => $<delim-token-tree>.made
            text       => $/.Str,
        )
    }
}

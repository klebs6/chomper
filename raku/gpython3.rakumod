use gpython3-keywords;
use gpython3-name;
use gpython3-indent;
use gpython3-numeric;
use gpython3-operators;
use gpython3-strings;
use gpython3-typedargs;
use gpython3-varargs;

our class NEW_INDENTATION { }

#-------------------------------------------------------------------
our role Python3Literal 
does Python3String
does Python3Number
does Python3::Grammar::Name { }

our role Python3 
does Python3Operators
does Python3Braces
does Python3Literal
does Python3::Grammar::VarArgsList
does Python3::Grammar::TypedArgList
does Python3::Grammar::Indent
does Python3Keywords {

    token ws { 
        | <?{$*opened > 0}>  \s*
        | <?{$*opened eq 0}> [\h | \\ \v]* 
    }

    token maybe-vertical-ws {
        \s*
    }

    token TOP {
        :my $*opened = 0;
        :my $*debug = False;
        :my $*indents-needed = 0;
        :my $*dedents-needed = 0;
        :my @*INDENTATION = (0,);
        <file-input>
    }

    token single_input {
        <stmt>? <COMMENT>? <NEWLINE>
    }

    token comment-newline {
        <COMMENT_NONEWLINE>? <NEWLINE>
    }

    #------------------------------
    proto token file-input-item { * }

    token file-input-item:sym<comment-newline> {
        <comment-newline>
    }

    token file-input-item:sym<stmt> {
        <stmt>
    }

    #------------------------------
    token file-input {
        <file-input-item>*
        $
    }

    token eval_input {
        <testlist> <COMMENT>? <NEWLINE>* $
    }

    token at-dotted-name {
        '@' <dotted-name>
    }

    token decorator {
        <at-dotted-name>
        <parenthesized-arglist>?
        <COMMENT_NONEWLINE>? <NEWLINE>
    }

    regex parenthesized-arglist {
        <OPEN_PAREN> 
        <arglist>? 
        <CLOSE_PAREN>
    }

    token decorators {
        <decorator>+
    }

    rule funcdef {
        <DEF>
        <NAME>
        <parameters>
        [ '->' <test> ]?
        <COLON>
        <suite>
    }

    rule parameters {
        <parenthesized-typedarglist>
    }

    #-------------------------

    proto token import-dots { * }
    token import-dots:sym<dot>  { <DOT> }
    token import-dots:sym<dots> { '...' }

    token import-from-src {
        | <import-dots>* <dotted-name>
        | <import-dots>+
    }

    proto token import-from-target { * }
    token import-from-target:sym<*>                             { <STAR> }
    token import-from-target:sym<import-as-names>               { <import-as-names> }
    token import-from-target:sym<parenthesized-import-as-names> { <parenthesized-import-as-names> }

    rule parenthesized-import-as-names {
        <OPEN_PAREN> <COMMENT_NONEWLINE>? <import-as-names> <CLOSE_PAREN>
    }

    rule import-from {
        <FROM>
        <import-from-src>
        <IMPORT>
        <import-from-target>
    }

    rule import-as-name {
        <NAME> [ <AS> <NAME> ]?
    }

    rule dotted-as-name {
        <dotted-name> [ <AS> <NAME> ]?
    }

    rule import-as-names {
        <import-as-name>+ %% <COMMA>
    }

    rule dotted-as-names {
        <dotted-as-name> [ <COMMA> <dotted-as-name> ]*
    }

    #------------------------------------------
    proto token decorated-item { * }

    token decorated-item:sym<class> {
        <classdef>
    }

    token decorated-item:sym<func> {
        <funcdef>
    }

    #------------------------------------------
    proto token compound-stmt { * }

    token compound-stmt:sym<decorated> {
        <decorators>
        <decorated-item>
    }

    rule compound-stmt:sym<if> {
        <IF> <test> <COLON> <COMMENT_NONEWLINE>?
        <suite>
        <elif-suite>*
        <else-suite>?
    }

    rule elif-suite {
        <COMMENT>*
        <ELIF> <test> <COLON> <COMMENT_NONEWLINE>?
        <suite> 
    }

    rule compound-stmt:sym<while> {
        <WHILE> <test> <COLON> <COMMENT_NONEWLINE>?
        <suite>
        <else-suite>?
    }

    rule compound-stmt:sym<for> {
        <FOR> <exprlist> <IN> <testlist> <COLON> <COMMENT_NONEWLINE>?
        <suite>
        <else-suite>?
    }

    rule compound-stmt:sym<try> {
        <TRY> <COLON> 
        <COMMENT_NONEWLINE>?
        <suite>
        <try-control-suite>
    }

    #------------------------
    proto token try-control-suite { * }
    token try-control-suite:sym<full>    { <except-suite> }
    token try-control-suite:sym<finally> { <finally> }

    rule except-suite {
        <COMMENT>*
        <except-clause>+
        <else-suite>?
        <finally>?
    }

    rule except-clause {
        <COMMENT>*
        <except_clause> <COLON> 
        <COMMENT_NONEWLINE>?
        <suite>
    }

    rule else-suite {
        <COMMENT>*
        <ELSE> <COLON> 
        <COMMENT_NONEWLINE>?
        <suite> 
    }

    rule finally {
        <COMMENT>*
        <FINALLY> <COLON> 
        <COMMENT_NONEWLINE>?
        <suite>
    }

    rule compound-stmt:sym<with> {
        <COMMENT>*
        <WITH> <with-item> [ <COMMA> <with-item> ]* <COLON> 
        <COMMENT_NONEWLINE>?
        <suite>
    }

    rule compound-stmt:sym<func>  { <funcdef> }
    rule compound-stmt:sym<class> { <classdef> }

    rule classdef {
        <CLASS> <NAME> <parenthesized-arglist>?  <COLON> 
        <COMMENT_NONEWLINE>?
        <suite>
    }

    proto rule with-item { * }
    rule  with-item:sym<as>    { <test> <AS> <or-expr> }
    rule  with-item:sym<basic> { <test> }

    rule except_clause {
        <EXCEPT> [ <test> [ <AS> <NAME> ]?  ]?
    }

    #----------------------------------------
    proto token stmt { * }
    rule stmt:sym<compound> { <compound-stmt> }
    rule stmt:sym<simple>   { <simple-suite> }
    rule stmt:sym<comment>  { <COMMENT_NONEWLINE> }

    token simple-suite {
        <simple-stmt> <COMMENT>? <NEWLINE>?
    }

    rule simple-stmt {
        <small-stmt> [ ';' <small-stmt> ]* ';'? 
    }

    #-------------------------
    proto token test-or-star-expr { * }
    token test-or-star-expr:sym<test>      { <test> }
    token test-or-star-expr:sym<star-expr> { <star-expr> }

    rule testlist-star-expr {
       <test-or-star-expr>+ %% <COMMA>
    }

    #------------------------------------------------
    proto token small-stmt { * }

    #--------------------
    rule small-stmt:sym<expr-augassign> {
        <testlist-star-expr> 
        <augassign> 
        <expr-augassign-rhs> 
    }

    rule small-stmt:sym<expr-equals> {
        <testlist-star-expr>
        [ <ASSIGN> <expr-equals-rhs> ]*
    }

    #--------------------
    proto token expr-augassign-rhs { * }
    token expr-augassign-rhs:sym<yield>    { <yield-expr> }
    token expr-augassign-rhs:sym<testlist> { <testlist> }

    #--------------------
    proto token expr-equals-rhs { * }
    token expr-equals-rhs:sym<yield>              { <yield-expr> }
    token expr-equals-rhs:sym<testlist-star-expr> { <testlist-star-expr> }

    token small-stmt:sym<return>      { <RETURN> [\h+ <testlist>]? }
    rule small-stmt:sym<raise>        { <RAISE> <raise-clause>?  }
    token small-stmt:sym<import-name> { <IMPORT> \h+ <dotted-as-names> }
    token small-stmt:sym<nonlocal>    { <NONLOCAL> \h+ <NAME> \h* [ <COMMA> \h+ <NAME> ]* }
    token small-stmt:sym<assert>      { <ASSERT> \h+  <test> \h* [ <COMMA> \h+ <test> ]? }
    token small-stmt:sym<pass>        { <PASS> }
    token small-stmt:sym<break>       { <BREAK> }
    token small-stmt:sym<contine>     { <CONTINUE> }
    token small-stmt:sym<yield>       { <yield-expr> }
    token small-stmt:sym<import-from> { <import-from> }
    token small-stmt:sym<global>      { <GLOBAL> \h+  <NAME> \h* [ <COMMA> \h+ <NAME> ]* }
    token small-stmt:sym<del>         { <DEL> \h+ <exprlist> }

    rule raise-clause {
        <test> [ <FROM> <test> ]? 
    }

    #<NEWLINE> <INDENT> <stmt>+ <DEDENT>
    token stmt-suite {

        [<NEWLINE> | <COMMENT>]*

        :my $current-indent = self.peek-indent-stack();
        {so $*debug and say "stmt-suite open. {:$current-indent}";}

        [<?{
            my $peek-indent-stack = self.peek-indent-stack();
            my $b = so $current-indent <= $peek-indent-stack;
            so $*debug and say "checking current-indent $current-indent <= peek-indent-stack $peek-indent-stack -- $b, prematch:\n{$/.prematch}";
            $b
        }> <stmt-maybe-comments>]+ 
    }

    token stmt-maybe-comments {
        <stmt> <COMMENT>*
    }

    proto token suite { * }
    token suite:sym<simple> { <simple-suite> }
    token suite:sym<stmt>   { <stmt-suite> }

    proto rule test { * }
    rule test:sym<basic>   { <or-test> <!before <IF>>}
    rule test:sym<lambdef> { <lambdef> }
    rule test:sym<ternary> { <or-test> <IF> <or-test> <ELSE> <test> }

    proto token test-nocond { * }
    token test-nocond:sym<basic>   { <or-test> }
    token test-nocond:sym<lambdef> { <lambdef_nocond> }

    rule lambdef {
        <LAMBDA> <varargslist>?  <COLON> <test>
    }

    rule lambdef_nocond {
        <LAMBDA> <varargslist>?  <COLON> <test-nocond>
    }

    rule or-test {
        <and-test> [ <OR> <and-test> ]*
    }

    rule and-test {
        <not-test> [  <AND> <not-test> ]*
    }

    rule not-test {
        <NOT>* <comparison>
    }

    token comparison {
        <star-expr> <comparison-operand>*
    }

    rule comparison-operand {
        <comp-op> <star-expr>
    }

    token star-expr {
        <STAR> ** 0..2  <or-expr>
    }

    rule or-expr {
        <xor-expr> [  '|' <xor-expr> ]*
    }

    rule xor-expr {
        <and-expr> [ '^' <and-expr> ]*
    }

    rule and-expr {
        <shift-expr> [ '&' <shift-expr> ]*
    }

    proto rule shift-operand { * }
    rule shift-operand:sym<left>  { '<<' <arith-expr> }
    rule shift-operand:sym<right> { '>>' <arith-expr> }

    rule shift-expr {
        <arith-expr> <shift-operand>*
    }

    #can put comments in here?
    proto rule arith-operand { * }
    rule arith-operand:sym<+> { '+' <term> }
    rule arith-operand:sym<-> { '-' <term> }

    rule arith-expr {
        <term> <arith-operand>*
    }

    rule term {
        <factor> <term-operand>*
    }

    proto rule term-operand { * }
    rule term-operand:sym<*>  { <sym> <factor> }
    rule term-operand:sym</>  { <sym> <factor> }
    rule term-operand:sym<%>  { <sym> <factor> }
    rule term-operand:sym<//> { <sym> <factor> }
    rule term-operand:sym<@>  { <sym> \h+ <factor> }

    proto rule factor { * }
    rule factor:sym<prefix+> { '+' <factor> }
    rule factor:sym<prefix-> { '-' <factor> }
    rule factor:sym<prefix~> { '~' <factor> }
    rule factor:sym<power>   { <power> }

    # dont split this one
    rule power {
        <augmented-atom> [ '**' <factor> ]?
    }


    token augmented-atom {
        <atom> <trailer>*
    }

    proto rule atom { * }
    rule  atom:sym<strings>  { <strings> }
    token atom:sym<NONE>     { <NONE> }
    token atom:sym<true>     { <TRUE> }
    token atom:sym<false>    { <FALSE> }
    token atom:sym<NAME>     { <NAME> }
    token atom:sym<number>   { <number> }
    token atom:sym<ellipsis> { <ELLIPSIS> }
    rule  atom:sym<parens>   { <OPEN_PAREN> <COMMENT>* <parens-inner>?  <COMMENT>* \h* <CLOSE_PAREN> }
    rule  atom:sym<list>     { <OPEN_BRACK> <COMMENT>* <listmaker>?  <COMMENT>* <CLOSE_BRACK> }
    rule  atom:sym<dict>     { <OPEN_BRACE> <COMMENT>* <dictorsetmaker>?  <COMMENT>* <CLOSE_BRACE> }

    proto rule parens-inner { * }
    rule parens-inner:sym<yield>     { <yield-expr> }
    rule parens-inner:sym<listmaker> { <listmaker> }

    rule strings {
        <string> {$*opened++} <string>* {$*opened--}
    }

    proto rule listmaker { * }

    rule listmaker:sym<list-comp> {
        <test> <comp-for>
    }

    rule listmaker:sym<testlist> {
        <test-comma-maybe-comment>* <test> <comma-maybe-comment>?
    }


    rule test-comma-maybe-comment {
        <test> <comma-maybe-comment>  
    }

    #-------------------------------
    proto token trailer { * }

    token trailer:sym<dot-name>      { <DOT> <maybe-vertical-ws>? <NAME> }
    rule  trailer:sym<subscriptlist> { <OPEN_BRACK> <subscriptlist> <CLOSE_BRACK> }
    rule  trailer:sym<arglist>       { <parenthesized-arglist> }

    #-------------------------------
    rule subscriptlist {
        <subscript>+ %% <COMMA>
    }

    proto rule subscript { * }

    rule subscript:sym<slice> {
        <test>?  <COLON> <test>?  <slice-op>?
    }

    rule subscript:sym<test> {
        <test>
    }

    token slice-op {
        <COLON> <test>?
    }

    rule exprlist {
        <star-expr>+ %% <COMMA>
    }

    rule testlist {
        <test>+ %% <COMMA>
    }

    rule setmaker-item-comma-maybe-comment {
        <setmaker-item> <comma-maybe-comment>
    }

    proto rule setmaker-item { * }

    #<COMMENT>? 
    rule setmaker-item:sym<test>       { <test> }
    rule setmaker-item:sym<stars-test> { '**' <COMMENT>? <test> }

    rule dictmaker-item { <COMMENT>? <test> <COLON> <test> }

    rule dictmaker-item-comma-maybe-comment { 
        <dictmaker-item> <comma-maybe-comment>
    }

    proto rule dictorsetmaker { * }

    rule dictorsetmaker:sym<dict> {
        [<dictmaker-item-comma-maybe-comment>]* <dictmaker-item> <comma-maybe-comment>?
    }

    rule dictorsetmaker:sym<dict-comp> {
        <dictmaker-item> <comp-for>
    }

    rule comma-maybe-comment {
        <COMMA> <COMMENT>*
    }

    rule dictorsetmaker:sym<set> {
        <setmaker-item-comma-maybe-comment>* 
        <setmaker-item>
    }

    rule dictorsetmaker:sym<set-with-comma-trailer> {
        <setmaker-item-comma-maybe-comment>* 
    }

    rule dictorsetmaker:sym<set-comp> {
        <setmaker-item> <comp-for>
    }

    rule argument-comma-maybe-comment {
        <argument> <comma-maybe-comment>
    }

    proto rule arglist { * }

    token arglist-kwargs {
        '**' <test>
    }

    token star-arg {
        '*' <test> 
    }

    rule arglist:sym<full> {
        <basic=argument-comma-maybe-comment>+
        '*' <test-comma-maybe-comment>  
        <star=argument-comma-maybe-comment>*  
        <arglist-kwargs>
    }

    rule arglist:sym<basic-and-star-arg> {
        <argument-comma-maybe-comment>+
        <star-arg>
    }

    rule arglist:sym<basic-and-star-arg-with-trailing-comma> {
        <argument-comma-maybe-comment>+
        '*' <test-comma-maybe-comment>  
    }

   rule arglist:sym<basic-and-star-args> {
        <basic=argument-comma-maybe-comment>+
        '*' <test-comma-maybe-comment>  
        <star=argument-comma-maybe-comment>+
    }

    rule arglist:sym<basic-and-kwargs> {
        <argument-comma-maybe-comment>+
        <arglist-kwargs>
    }

    rule arglist:sym<star-and-kwargs2> {
        <star-arg>
        <COMMA>
        <arglist-kwargs>
    }

    rule arglist:sym<star-and-kwargs> {
        '*' <test-comma-maybe-comment>  
        <argument-comma-maybe-comment>*  
        <arglist-kwargs>
    }

    rule arglist:sym<just-basic> {
        <argument-comma-maybe-comment>* <argument>
    }

    rule arglist:sym<just-basic-with-trailing-comment> {
        <argument-comma-maybe-comment>+
    }

    rule arglist:sym<just-star-args> {
        '*' <test> 
    }

    rule arglist:sym<just-kwargs> {
        <arglist-kwargs>
    }

    proto rule argument { * }
    rule argument:sym<test>     { <test> '=' <test> }
    rule argument:sym<comp-for> { <test> <comp-for>? }

    proto token comp-iter { * }
    token comp-iter:sym<for> { <comp-for> }
    token comp-iter:sym<if>  { <comp-if> }

    rule comp-for {
        <FOR>
        <exprlist>
        <IN>
        <or-test>
        <comp-iter>?
    }

    rule comp-if {
        <IF> <test-nocond> <comp-iter>?
    }

    rule yield-expr {
        <YIELD> <yield-arg>?
    }

    proto rule yield-arg { * }

    rule yield-arg:sym<from> {
        <FROM> <test>
    }

    rule yield-arg:sym<testlist> {
        <testlist>
    }
}

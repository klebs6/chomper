use Data::Dump::Tree;

use gcpp-roles;

our class EmptyInitializerList 
does IInitializerList
does IInitializerClause 
does IReturnStatementBody
does IPostfixExpressionTail {
    method gist(:$treemark=False) {
        ""
    }
}

# rule initializer-list { 
#   <initializer-clause> 
#   <ellipsis>? 
#   [ <.comma> <initializer-clause> <ellipsis>? ]* 
# }
our class InitializerList 
does IInitializerList
does IInitializerClause 
does IReturnStatementBody
does IPostfixExpressionTail {

    has IInitializerClause @.clauses is required;

    has $.text;

    method gist(:$treemark=False) {
        @.clauses>>.gist(:$treemark).join(", ")
    }
}

# rule braced-init-list { 
#   <.left-brace> 
#   [ <initializer-list> <.comma>? ]? 
#   <.right-brace> 
# } #-----------------------------
our class BracedInitList 
does IBraceOrEqualInitializer
does IReturnStatementBody 
does IInitializerClause {

    has IInitializerList $.initializer-list;

    has $.text;

    method gist(:$treemark=False) {
        if $.initializer-list {
            "\{" 
            ~ $.initializer-list.gist(:$treemark)
            ~ "}"

        } else {
            "\{" ~ "}"
        }
    }
}

our class AssignInit 
does IBraceOrEqualInitializer
does IInitializerClause {

    has IInitializer $.initializer-clause;

    has $.text;

    method gist(:$treemark=False) {
        " = " ~ $.initializer-clause.gist(:$treemark)
    }
}

# rule expression { <assignment-expression>+ %% <.comma> }
our class Expression 
does IExpression 
does IForRangeInitializer 
does ICondition { 

    has IAssignmentExpression @.assignment-expressions is required;

    has $.text;

    method gist(:$treemark=False) {
        @.assignment-expressions>>.gist(:$treemark).join(", ")
    }
}

# rule constant-expression { <conditional-expression> }
our class ConstantExpression does IConstantExpression {
    has IConditionalExpression $.conditional-expression is required;

    has $.text;

    method gist(:$treemark=False) {
        $.conditional-expression.gist(:$treemark)
    }
}

# rule expression-list { <initializer-list> }
our class ExpressionList 
does IInitializer
does INewInitializer
does IPostfixExpressionTail { 
    has InitializerList $.initializer-list is required;

    has $.text;

    method gist(:$treemark=False) {
        $.initializer-list.gist(:$treemark)
    }
}

# rule initializer:sym<paren-expr-list> { 
#   <.left-paren> 
#   <expression-list> 
#   <.right-paren> 
# }
our class Initializer::ParenExprList does IInitializer {
    has ExpressionList $.expression-list is required;

    has $.text;

    method gist(:$treemark=False) {
        "(" ~ $.expression-list.gist(:$treemark) ~ ")"
    }
}

# rule initializer:sym<brace-or-eq> { 
#   <brace-or-equal-initializer> 
# }
our class Initializer::BraceOrEq does IInitializer {
    has IBraceOrEqualInitializer $.brace-or-equal-initializer is required;

    has $.text;

    method gist(:$treemark=False) {
        $.brace-or-equal-initializer.gist(:$treemark)
    }
}

=begin comment
our class Initializer does IInitializer {
    has $.value is required;

    has $.text;

    method gist(:$treemark=False) {
        $.value.gist(:$treemark)
    }
}
=end comment

# rule brace-or-equal-initializer:sym<assign-init> { 
#   <assign> 
#   <initializer-clause> 
# }
our class BraceOrEqualInitializer::AssignInit does IBraceOrEqualInitializer {
    has IInitializerClause $.initializer-clause is required;

    has $.text;

    method gist(:$treemark=False) {
        " = " ~ $.initializer-clause.gist(:$treemark)
    }
}

# rule brace-or-equal-initializer:sym<braced-init-list> { 
#   <braced-init-list> 
# }
our class BraceOrEqualInitializer::BracedInitList 
does IBraceOrEqualInitializer {

    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist(:$treemark=False) {
        $.braced-init-list.gist(:$treemark)
    }
}

# rule initializer-clause:sym<assignment> { 
#   <comment>? 
#   <assignment-expression> 
# }
our class InitializerClause::Assignment 
does IInitializerClause {

    has IComment              $.comment;
    has IAssignmentExpression $.assignment-expression is required;

    has $.text;

    method gist(:$treemark=False) {

        my $c = $.comment;
        my $x = $.assignment-expression;

        if $c {

            $c.gist(:$treemark) ~ "\n" ~ $x.gist(:$treemark)

        } else {

            $x.gist(:$treemark)
        }
    }
}

# rule initializer-clause:sym<braced> { 
#   <comment>? 
#   <braced-init-list> 
# }
our class InitializerClause::Braced 
does IInitializerClause {

    has IComment       $.comment;
    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist(:$treemark=False) {
        my $c = $.comment;
        my $x = $.braced-init-list;

        if $c {

            $c.gist(:$treemark) ~ "\n" ~ $.x.gist(:$treemark)

        } else {

            $x.gist(:$treemark)
        }
    }
}

our role Expression::Actions {

    # rule expression-list { <initializer-list> } 
    method expression-list($/) {
        make ExpressionList.new(
            initializer-list => $<initializer-list>.made,
            text             => ~$/,
        )
    }

    # rule expression { <assignment-expression>+ %% <.comma> }
    method expression($/) {
        my @exprs = $<assignment-expression>>>.made;

        if @exprs.elems gt 1 {
            make Expression.new(
                assignment-expressions => @exprs,
                text                   => ~$/,
            )
        } else {
            make @exprs[0]
        }
    }

    # rule constant-expression { <conditional-expression> }
    method constant-expression($/) {
        make ConstantExpression.new(
            conditional-expression => $<conditional-expression>.made,
            text                   => ~$/,
        )
    }

    # rule initializer:sym<brace-or-eq> { <brace-or-equal-initializer> }
    method initializer:sym<brace-or-eq>($/) {
        make Initializer::BraceOrEq.new(
            brace-or-equal-initializer => $<brace-or-equal-initializer>.made
        )
    }

    # rule initializer:sym<paren-expr-list> { <.left-paren> <expression-list> <.right-paren> } 
    method initializer:sym<paren-expr-list>($/) {
        make Initializer::ParenExprList.new(
            expression-list => $<expression-list>.made
        )
    }

    # rule brace-or-equal-initializer:sym<assign-init> { <assign> <initializer-clause> }
    method brace-or-equal-initializer:sym<assign-init>($/) {
        make AssignInit.new(
            initializer-clause => $<initializer-clause>.made
        )
    }

    # rule brace-or-equal-initializer:sym<braced-init-list> { <braced-init-list> } 
    method brace-or-equal-initializer:sym<braced-init-list>($/) {
        make BracedInitList.new(
            initializer-list => $<braced-init-list>.made
        )
    }

    # rule initializer-clause:sym<assignment> { <comment>? <assignment-expression> }
    method initializer-clause:sym<assignment>($/) {

        my $comment = $<comment>.made;
        my $base    = $<assignment-expression>.made;

        if $comment {
            make InitializerClause::Assignment.new(
                comment               => $comment,
                assignment-expression => $base,
                text                  => ~$/,
            )
        } else {
            make $base
        }
    }

    # rule initializer-clause:sym<braced> { <comment>? <braced-init-list> } 
    method initializer-clause:sym<braced>($/) {

        my $comment = $<comment>.made;
        my $base    = $<braced-init-list>.made;

        if $comment {
            make InitializerClause::Braced.new(
                comment          => $comment,
                braced-init-list => $base,
                text             => ~$/,
            )
        } else {
            make $base
        }
    }

    # rule initializer-list { <initializer-clause> <ellipsis>? [ <.comma> <initializer-clause> <ellipsis>? ]* }
    method initializer-list($/) {

        my @clauses = $<initializer-clause>>>.made;

        if @clauses {
            make InitializerList.new(
                clauses => @clauses,
                text    => ~$/,
            )
        } else {
            make EmptyInitializerList.new(
                text    => ~$/,
            )
        }
    }

    # rule braced-init-list { <.left-brace> [ <initializer-list> <.comma>? ]? <.right-brace> } 
    method braced-init-list($/) {
        make BracedInitList.new(
            initializer-list => $<initializer-list>.made
        )
    }
}

our role Expression::Rules {

    rule expression-list {
        <initializer-list>
    }

    rule expression {
        <assignment-expression>+ %% <comma>
    }

    rule constant-expression { 
        <conditional-expression> 
    }

    rule expression-statement {
        <expression>? <semi>
    }

    proto rule initializer { * }

    rule initializer:sym<brace-or-eq> {
        <brace-or-equal-initializer>
    }

    rule initializer:sym<paren-expr-list> {
        <left-paren> <expression-list> <right-paren>
    }

    #-----------------------------
    proto rule brace-or-equal-initializer { * }
    rule brace-or-equal-initializer:sym<assign-init>      { <assign> <initializer-clause> }
    rule brace-or-equal-initializer:sym<braced-init-list> { <braced-init-list> }

    #-----------------------------
    proto rule initializer-clause { * }

    rule initializer-clause:sym<assignment> {
        <comment>?
        <assignment-expression>
    }

    rule initializer-clause:sym<braced> {
        <comment>?
        <braced-init-list>
    }

    #-----------------------------
    rule initializer-list {
        <initializer-clause>
        <ellipsis>?
        [ <comma> <initializer-clause> <ellipsis>? ]*
    }

    rule braced-init-list {
        <left-brace> [ <initializer-list> <comma>? ]?  <right-brace>
    }
}

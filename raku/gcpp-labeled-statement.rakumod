
# rule labeled-statement-label-body:sym<id> { 
#   <identifier> 
# }
our class LabeledStatementLabelBody::Id 
does ILabeledStatementLabelBody {

    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule labeled-statement-label-body:sym<case-expr> { 
#   <case> 
#   <constant-expression> 
# }
our class LabeledStatementLabelBody::CaseExpr 
does ILabeledStatementLabelBody {

    has IConstantExpression $.constant-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule labeled-statement-label-body:sym<default> { 
#   <default_> 
# }
our class LabeledStatementLabelBody::Default 
does ILabeledStatementLabelBody {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule labeled-statement-label { 
#   <attribute-specifier-seq>? 
#   <labeled-statement-label-body> 
#   <colon> 
# }
our class LabeledStatementLabel {
    has IAttributeSpecifierSeq     $.attribute-specifier-seq;
    has ILabeledStatementLabelBody $.labeled-statement-label-body is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule labeled-statement { 
#   <labeled-statement-label> 
#   <statement> 
# }
our class LabeledStatement {
    has LabeledStatementLabel $.labeled-statement-label is required;
    has IStatement            $.statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role LabeledStatement::Actions {

    # token statement:sym<labeled> { 
    #   <comment>? 
    #   <labeled-statement> 
    # }
    method statement:sym<labeled>($/) {

        my $comment = $<comment>.made;
        my $body    = $<labeled-statement>.made;

        if not $comment {

            make $body

        } else {

            make Statement::Labeled.new(
                comment           => $comment,
                labeled-statement => $body,
            )
        }
    }

    # rule labeled-statement-label-body:sym<id> { <identifier> }
    method labeled-statement-label-body:sym<id>($/) {
        make $<identifier>.made
    }

    # rule labeled-statement-label-body:sym<case-expr> { <case> <constant-expression> }
    method labeled-statement-label-body:sym<case-expr>($/) {
        make LabeledStatementLabelBody::CaseExpr.new(
            constant-expression => $<constant-expression>.made,
        )
    }

    # rule labeled-statement-label-body:sym<default> { <default_> } 
    method labeled-statement-label-body:sym<default>($/) {
        make LabeledStatementLabelBody::Default.new
    }

    # rule labeled-statement-label { <attribute-specifier-seq>? <labeled-statement-label-body> <colon> }
    method labeled-statement-label($/) {
        make LabeledStatementLabel.new(
            attribute-specifier-seq      => $<attribute-specifier-seq>.made,
            labeled-statement-label-body => $<labeled-statement-label-body>.made,
        )
    }

    # rule labeled-statement { <labeled-statement-label> <statement> }
    method labeled-statement($/) {
        make LabeledStatement.new(
            labeled-statement-label => $<labeled-statement-label>.made,
            statement               => $<statement>.made,
        )
    }
}

our role LabeledStatement::Rules {

    proto rule labeled-statement-label-body { * }
    rule labeled-statement-label-body:sym<id>        { <identifier>                }
    rule labeled-statement-label-body:sym<case-expr> { <case> <constant-expression> }
    rule labeled-statement-label-body:sym<default>   { <default_>                   }

    #-----------------------------
    rule labeled-statement-label {
        <attribute-specifier-seq>?
        <labeled-statement-label-body>
        <colon>
    }

    rule labeled-statement {
        <labeled-statement-label>
        <statement>
    }
}

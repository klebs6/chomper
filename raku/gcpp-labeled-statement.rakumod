
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

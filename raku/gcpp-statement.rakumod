# token statement:sym<attributed> { 
#   <comment>? 
#   <attribute-specifier-seq>? 
#   <attributed-statement-body> 
# }
our class Statement::Attributed does IStatement {
    has IComment                 $.comment;
    has IAttributeSpecifierSeq   $.attribute-specifier-seq;
    has IAttributedStatementBody $.attributed-statement-body is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token statement:sym<labeled> { 
#   <comment>? 
#   <labeled-statement> 
# }
our class Statement::Labeled does IStatement {
    has IComment         $.comment;
    has LabeledStatement $.labeled-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token statement:sym<declaration> { 
#   <comment>? 
#   <declaration-statement> 
# }
our class Statement::Declaration does IStatement {
    has IComment              $.comment;
    has IDeclarationStatement $.declaration-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule declaration-statement { 
#   <block-declaration> 
# }
our class DeclarationStatement does IDeclarationStatement {
    has IBlockDeclaration $.block-declaration is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule expression-statement { 
#   <expression>? 
#   <semi> 
# }
our class ExpressionStatement does IStatement { 
    has IComment    $.comment;
    has IExpression $.expression;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule compound-statement { 
#   <.left-brace> 
#   <statement-seq>? 
#   <.right-brace> 
# }
our class CompoundStatement {
    has StatementSeq $.statement-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex statement-seq { 
#   <statement> 
#   [<.ws> <statement>]* 
# }
our class StatementSeq {
    has IStatement @.statements is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

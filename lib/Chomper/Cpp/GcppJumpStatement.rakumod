use Data::Dump::Tree;

use gcpp-roles;
use gcpp-ident;

# rule jump-statement:sym<break> { 
#   <break_> 
#   <semi> 
# }
our class JumpStatement::Break does IJumpStatement { 
    has IComment $.comment;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        if $.comment {
            $builder ~= $.comment.gist(:$treemark);
        }

        $builder ~ "break;"
    }
}

# rule jump-statement:sym<continue> { 
#   <continue_> 
#   <semi> 
# }
our class JumpStatement::Continue does IJumpStatement {
    has IComment $.comment;

    has $.text;

    method gist(:$treemark=False) {
        my $builder = "";

        if $.comment {
            $builder ~= $.comment.gist(:$treemark);
        }

        $builder ~ "continue;"
    }
}

# rule jump-statement:sym<return> { 
#   <return_> 
#   <return-statement-body>? 
#   <semi> 
# }
our class JumpStatement::Return 
does IAttributedStatementBody 
does IJumpStatement {

    has IComment             $.comment;
    has IReturnStatementBody $.return-statement-body;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        if $.comment {
            $builder ~= $.comment.gist(:$treemark) ~ "\n";
        }

        $builder ~= "return";

        if $.return-statement-body {
            $builder ~= " " ~ $.return-statement-body.gist(:$treemark);
        }

        $builder ~ ";"
    }
}

# rule jump-statement:sym<goto> { 
#   <goto_> 
#   <identifier> 
#   <semi> 
# }
our class JumpStatement::Goto does IJumpStatement {
    has IComment   $.comment;
    has Identifier $.identifier is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "goto " ~ $.identifier ~ ";";

        if $.comment {
            $builder = $.comment.gist(:$treemark) ~ "\n" ~ $builder;
        }

        $builder
    }
}

our role JumpStatement::Actions {

    # rule jump-statement:sym<break> { <break_> <semi> }
    method jump-statement:sym<break>($/) {
        make JumpStatement::Break.new(
            comment => $<semi>.made,
            text    => ~$/,
        )
    }

    # rule jump-statement:sym<continue> { <continue_> <semi> }
    method jump-statement:sym<continue>($/) {
        make JumpStatement::Continue.new(
            comment => $<semi>.made,
            text    => ~$/,
        )
    }

    # rule jump-statement:sym<return> { <return_> <return-statement-body>? <semi> }
    method jump-statement:sym<return>($/) {
        make JumpStatement::Return.new(
            comment               => $<semi>.made,
            return-statement-body => $<return-statement-body>.made,
            text                  => ~$/,
        )
    }

    # rule jump-statement:sym<goto> { <goto_> <identifier> <semi> }
    method jump-statement:sym<goto>($/) {
        make JumpStatement::Goto.new(
            comment    => $<semi>.made,
            identifier => $<identifier>.made,
            text       => ~$/,
        )
    }
}

our role JumpStatement::Rules {

    proto rule jump-statement { * }
    rule jump-statement:sym<break>    { <break_>                                        <semi> } 
    rule jump-statement:sym<continue> { <continue_>                                     <semi> } 
    rule jump-statement:sym<return>   { <return_> <return-statement-body>? <semi> } 
    rule jump-statement:sym<goto>     { <goto_> <identifier>                            <semi> } 
}

unit module Chomper::Cpp::GcppDeleteExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule delete-expression { 
#   <doublecolon>? 
#   <delete> 
#   [ <.left-bracket> <.right-bracket> ]? 
#   <cast-expression> 
# }
our class DeleteExpression { 
    has Bool            $.has-doublecolon is required;
    has Bool            $.has-array       is required;
    has ICastExpression $.cast-expression is required;

    has $.text;

    method gist(:$treemark=False) {
        my $builder = "";

        if $.has-doublecolon {
            $builder ~= "::";
        }

        $builder ~= "delete";

        if $.has-array {
            $builder ~= "[]";
        }

        $builder ~ " " ~ $.cast-expression.gist(:$treemark)
    }
}

our role DeleteExpression::Actions {

    # rule delete-expression { <doublecolon>? <delete> [ <.left-bracket> <.right-bracket> ]? <cast-expression> }
    method delete-expression($/) {
        make DeleteExpression.new(
            cast-expression => $<cast-expression>.made,
            text            => ~$/,
        )
    }
}

our role DeleteExpression::Rules {

    rule delete-expression {
        <doublecolon>?
        <delete>
        [ <left-bracket> <right-bracket> ]?
        <cast-expression>
    }
}
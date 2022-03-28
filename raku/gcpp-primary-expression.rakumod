use Data::Dump::Tree;

use gcpp-roles;
use gcpp-lambda;

# token primary-expression:sym<literal> { <literal>+ }
our class PrimaryExpression::Literal does IPrimaryExpression {
    has ILiteral @.literal is required;

    has $.text;

    method gist(:$treemark=False) {
        @.literal>>.gist(:$treemark).join(" ")
    }
}

# token primary-expression:sym<this>    { <this> }
our class PrimaryExpression::This does IPrimaryExpression { 

    has $.text;

    method gist(:$treemark=False) {
        "this"
    }
}

# token primary-expression:sym<expr>    { 
#   <.left-paren> 
#   <expression> 
#   <.right-paren> 
# }
our class PrimaryExpression::Expr does IPrimaryExpression {
    has IExpression $.expression is required;

    has $.text;

    method gist(:$treemark=False) {
        "(" ~ $.expression.gist(:$treemark) ~ ")"
    }
}

# token primary-expression:sym<id> { 
#   <id-expression> 
# }
our class PrimaryExpression::Id does IPrimaryExpression {
    has IIdExpression $.id-expression is required;

    has $.text;

    method gist(:$treemark=False) {

        $.id-expression.gist(:$treemark)
    }
}

# token primary-expression:sym<lambda> { 
#   <lambda-expression> 
# }
our class PrimaryExpression::Lambda does IPrimaryExpression {
    has LambdaExpression $.lambda-expression is required;

    has $.text;

    method gist(:$treemark=False) {
        $.lambda-expression.gist(:$treemark)
    }
}

our role PrimaryExpression::Actions {

    # token primary-expression:sym<literal> { <literal>+ }
    method primary-expression:sym<literal>($/) {
        my @literals = $<literal>>>.made;

        if @literals.elems gt 1 {
            make @literals
        } else {
            make @literals[0]
        }
    }

    # token primary-expression:sym<this> { <this> }
    method primary-expression:sym<this>($/) {
        make PrimaryExpression::This.new
    }

    # token primary-expression:sym<expr> { <.left-paren> <expression> <.right-paren> }
    method primary-expression:sym<expr>($/) {
        make PrimaryExpression::Expr.new(
            expression => $<expression>.made,
            text       => ~$/,
        )
    }

    # token primary-expression:sym<id> { <id-expression> }
    method primary-expression:sym<id>($/) {
        make PrimaryExpression::Id.new(
            id-expression => $<id-expression>.made,
            text          => ~$/,
        )
    }

    # token primary-expression:sym<lambda> { <lambda-expression> } 
    method primary-expression:sym<lambda>($/) {
        make PrimaryExpression::Lambda.new(
            lambda-expression => $<lambda-expression>.made,
            text              => ~$/,
        )
    }
}

our role PrimaryExpression::Rules {

    proto token primary-expression { * }
    token primary-expression:sym<literal> { <literal>+ }
    token primary-expression:sym<this>    { <this> }
    token primary-expression:sym<expr>    { <left-paren> <expression> <right-paren> }
    token primary-expression:sym<id>      { <id-expression> }
    token primary-expression:sym<lambda>  { <lambda-expression> }
}

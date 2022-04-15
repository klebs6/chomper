unit module Chomper::Cpp::GcppForInit;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppStatement;

# rule for-init-statement:sym<expression-statement> { 
#   <expression-statement> 
# }
our class ForInitStatement::ExpressionStatement 
does IForInitStatement {

    has ExpressionStatement $.expression-statement is required;

    has $.text;

    method gist(:$treemark=False) {
        $.expression-statement.gist(:$treemark)
    }
}

# rule for-init-statement:sym<simple-declaration> { 
#   <simple-declaration> 
# }
our class ForInitStatement::SimpleDeclaration does IForInitStatement {
    has ISimpleDeclaration $.simple-declaration is required;

    has $.text;

    method gist(:$treemark=False) {
        $.simple-declaration.gist(:$treemark)
    }
}

our role ForInitStatement::Actions {

    # rule for-init-statement:sym<expression-statement> { <expression-statement> }
    method for-init-statement:sym<expression-statement>($/) {
        make $<expression-statement>.made
    }

    # rule for-init-statement:sym<simple-declaration> { <simple-declaration> }
    method for-init-statement:sym<simple-declaration>($/) {
        make $<simple-declaration>.made
    }
}

our role ForInitStatement::Rules {

    proto rule for-init-statement { * }
    rule for-init-statement:sym<expression-statement> { <expression-statement> }
    rule for-init-statement:sym<simple-declaration> { <simple-declaration> }
}
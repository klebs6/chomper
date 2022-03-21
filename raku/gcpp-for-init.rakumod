use Data::Dump::Tree;

use gcpp-roles;
use gcpp-statement;

# rule for-init-statement:sym<expression-statement> { 
#   <expression-statement> 
# }
our class ForInitStatement::ExpressionStatement 
does IForInitStatement {

    has ExpressionStatement $.expression-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule for-init-statement:sym<simple-declaration> { 
#   <simple-declaration> 
# }
our class ForInitStatement::SimpleDeclaration does IForInitStatement {
    has ISimpleDeclaration $.simple-declaration is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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

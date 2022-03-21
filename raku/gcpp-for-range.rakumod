use Data::Dump::Tree;

use gcpp-roles;
use gcpp-statement;
use gcpp-expression;
use gcpp-attr;

# rule for-range-declaration { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq> 
#   <declarator> 
# }
our class ForRangeDeclaration {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IDeclSpecifierSeq      $.decl-specifier-seq is required;
    has IDeclarator            $.declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule for-range-initializer:sym<expression> { 
#   <expression> 
# }
our class ForRangeInitializer::Expression does IForRangeInitializer {
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule for-range-initializer:sym<braced-init-list> { 
#   <braced-init-list> 
# }
our class ForRangeInitializer::BracedInitList does IForRangeInitializer {
    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role ForRange::Actions {

    # rule for-range-declaration { <attribute-specifier-seq>? <decl-specifier-seq> <declarator> }
    method for-range-declaration($/) {
        make ForRangeDeclaration.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            decl-specifier-seq      => $<decl-specifier-seq>.made,
            declarator              => $<declarator>.made,
        )
    }

    # rule for-range-initializer:sym<expression> { <expression> }
    method for-range-initializer:sym<expression>($/) {
        make $<expression>.made
    }

    # rule for-range-initializer:sym<braced-init-list> { <braced-init-list> } 
    method for-range-initializer:sym<braced-init-list>($/) {
        make $<braced-init-list>.made
    }
}

our role ForRange::Rules {

    rule for-range-declaration {
        <attribute-specifier-seq>?
        <decl-specifier-seq>
        <declarator>
    }

    proto rule for-range-initializer { * }
    rule for-range-initializer:sym<expression>     { <expression> }
    rule for-range-initializer:sym<braced-init-list> { <braced-init-list> }
}

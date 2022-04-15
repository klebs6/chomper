unit module Chomper::Cpp::GcppForRange;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppStatement;
use Chomper::Cpp::GcppExpression;
use Chomper::Cpp::GcppAttr;

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

    method gist(:$treemark=False) {

        my $builder = "";

        if $.attribute-specifier-seq {
            $builder ~= $.attribute-specifier-seq.gist(:$treemark) ~ " ";
        }

        $builder ~= $.decl-specifier-seq.gist(:$treemark);
        $builder ~= $.declarator.gist(:$treemark);

        $builder
    }
}

# rule for-range-initializer:sym<expression> { 
#   <expression> 
# }
our class ForRangeInitializer::Expression does IForRangeInitializer {
    has IExpression $.expression is required;

    has $.text;

    method gist(:$treemark=False) {
        $.expression.gist(:$treemark)
    }
}

# rule for-range-initializer:sym<braced-init-list> { 
#   <braced-init-list> 
# }
our class ForRangeInitializer::BracedInitList does IForRangeInitializer {
    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist(:$treemark=False) {
        $.braced-init-list.gist(:$treemark)
    }
}

our role ForRange::Actions {

    # rule for-range-declaration { <attribute-specifier-seq>? <decl-specifier-seq> <declarator> }
    method for-range-declaration($/) {
        make ForRangeDeclaration.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            decl-specifier-seq      => $<decl-specifier-seq>.made,
            declarator              => $<declarator>.made,
            text                    => ~$/,
        )
    }

    # rule for-range-initializer:sym<expression> { <expression> }
    method for-range-initializer:sym<expression>($/) {
        make ForRangeInitializer::Expression.new(
            expression => $<expression>.made,
            text       => ~$/,
        )
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
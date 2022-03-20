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



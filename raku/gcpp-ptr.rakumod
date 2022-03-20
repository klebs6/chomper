
# rule pointer-declarator { 
#   <augmented-pointer-operator>* 
#   <no-pointer-declarator> 
# }
our class PointerDeclarator does IDeclarator { 
    has IAugmentedPointerOperator @.augmented-pointer-operators;
    has INoPointerDeclarator      $.no-pointer-declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule augmented-pointer-operator { 
#   <pointer-operator> 
#   <const>? 
# }
our class AugmentedPointerOperator does IAugmentedPointerOperator { 
    has IPointerOperator $.pointer-operator is required;
    has Bool            $.const            is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pointer-operator:sym<ref> { <and_> <attribute-specifier-seq>? }
our class PointerOperator::Ref does IPointerOperator {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pointer-operator:sym<ref-ref> { 
#   <and-and> 
#   <attribute-specifier-seq>? 
# }
our class PointerOperator::RefRef does IPointerOperator {
    has IAndAnd $.and-and is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pointer-operator:sym<star> { 
#   <nested-name-specifier>? 
#   <star> 
#   <attribute-specifier-seq>? 
#   <cvqualifierseq>? 
# }
our class PointerOperator::Star does IPointerOperator {
    has INestedNameSpecifier   $.nested-name-specifier;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has Cvqualifierseq        $.cvqualifierseq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token literal:sym<ptr> { <pointer-literal> }
our class PointerLiteral does ILiteral {

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

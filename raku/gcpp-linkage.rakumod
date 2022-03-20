
# rule linkage-specification-body:sym<seq> { 
#   <.left-brace> 
#   <declarationseq>? 
#   <.right-brace> 
# }
our class LinkageSpecificationBody::Seq does ILinkageSpecificationBody {
    has IDeclarationseq $.declarationseq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule linkage-specification-body:sym<decl> { <declaration> }
our class LinkageSpecificationBody::Decl does ILinkageSpecificationBody {
    has IDeclaration $.declaration is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule linkage-specification { 
#   <extern> 
#   <string-literal> 
#   <linkage-specification-body> 
# }
our class LinkageSpecification { 
    has StringLiteral            $.string-literal is required;
    has ILinkageSpecificationBody $.linkage-specification-body is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

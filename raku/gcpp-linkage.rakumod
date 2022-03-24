use Data::Dump::Tree;

use gcpp-roles;
use gcpp-declaration;
use gcpp-str;

# rule linkage-specification-body:sym<seq> { 
#   <.left-brace> 
#   <declarationseq>? 
#   <.right-brace> 
# }
our class LinkageSpecificationBody::Seq does ILinkageSpecificationBody {
    has IDeclarationseq $.declarationseq;

    has $.text;

    method gist{

        my $buffer ~= "\{";

        if $.declarationseq {
            $buffer ~= $.declarationseq.gist;
        }

        $buffer ~ "}"
    }
}

# rule linkage-specification-body:sym<decl> { <declaration> }
our class LinkageSpecificationBody::Decl does ILinkageSpecificationBody {
    has IDeclaration $.declaration is required;

    has $.text;

    method gist{
        $.declaration.gist
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
        "extern " 
        ~ $.string-literal.gist 
        ~ " " 
        ~ $.linkage-specification-body.gist
    }
}

our role Linkage::Actions {

    # rule linkage-specification-body:sym<seq> { <.left-brace> <declarationseq>? <.right-brace> }
    method linkage-specification-body:sym<seq>($/) {
        make $<declarationseq>.made
    }

    # rule linkage-specification-body:sym<decl> { <declaration> }
    method linkage-specification-body:sym<decl>($/) {
        make $<declaration>.made
    }

    # rule linkage-specification { <extern> <string-literal> <linkage-specification-body> }
    method linkage-specification($/) {
        make LinkageSpecification.new(
            string-literal             => $<string-literal>.made,
            linkage-specification-body => $<linkage-specification-body>.made,
            text                       => ~$/,
        )
    }
}

our role Linkage::Rules {

    proto rule linkage-specification-body { * }
    rule linkage-specification-body:sym<seq>  { <left-brace> <declarationseq>?  <right-brace> }
    rule linkage-specification-body:sym<decl> {  <declaration> }

    rule linkage-specification {
        <extern>
        <string-literal>
        <linkage-specification-body>
    }
}

unit module Chomper::Cpp::GcppLinkage;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppDeclaration;
use Chomper::Cpp::GcppStr;

# rule linkage-specification-body:sym<seq> { 
#   <.left-brace> 
#   <declarationseq>? 
#   <.right-brace> 
# }
our class LinkageSpecificationBody::Seq does ILinkageSpecificationBody {
    has IDeclarationseq $.declarationseq;

    has $.text;

    method gist(:$treemark=False) {

        my $buffer ~= "\{";

        if $.declarationseq {
            $buffer ~= $.declarationseq.gist(:$treemark);
        }

        $buffer ~ "}"
    }
}

# rule linkage-specification-body:sym<decl> { <declaration> }
our class LinkageSpecificationBody::Decl does ILinkageSpecificationBody {
    has IDeclaration $.declaration is required;

    has $.text;

    method gist(:$treemark=False) {
        $.declaration.gist(:$treemark)
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

    method gist(:$treemark=False) {
        "extern " 
        ~ $.string-literal.gist(:$treemark) 
        ~ " " 
        ~ $.linkage-specification-body.gist(:$treemark)
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
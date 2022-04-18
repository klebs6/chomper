unit module Chomper::Cpp::GcppVirtual;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule virtual-specifier-seq { 
#   <virtual-specifier>+ 
# }
class VirtualSpecifierSeq is export { 
    has IVirtualSpecifier @.virtual-specifiers is required;

    has $.text;

    method name {
        'VirtualSpecifierSeq'
    }

    method gist(:$treemark=False) {
        @.virtual-specifiers>>.gist(:$treemark).join(" ")
    }
}

package VirtualSpecifier is export {

    # rule virtual-specifier:sym<override> { 
    #   <override> 
    # }
    class Override does IVirtualSpecifier { 

        has $.text;

        method name {
            'VirtualSpecifier::Override'
        }

        method gist(:$treemark=False) {
            "override"
        }
    }

    # rule virtual-specifier:sym<final> { <final> }
    class Final does IVirtualSpecifier {

        has $.text;

        method name {
            'VirtualSpecifier::Final'
        }

        method gist(:$treemark=False) {
            "final"
        }
    }
}

package VirtualGrammar is export {

    our role Actions {

        # rule virtual-specifier-seq { <virtual-specifier>+ } 
        method virtual-specifier-seq($/) {
            make $<virtual-specifier>>>.made
        }

        # rule virtual-specifier:sym<override> { <override> }
        method virtual-specifier:sym<override>($/) {
            make VirtualSpecifier::Override.new
        }

        # rule virtual-specifier:sym<final> { <final> } 
        method virtual-specifier:sym<final>($/) {
            make VirtualSpecifier::Final.new
        }
    }

    our role Rules {

        rule virtual-specifier-seq {
            <virtual-specifier>+
        }

        proto rule virtual-specifier { * }
        rule virtual-specifier:sym<override> { <override> }
        rule virtual-specifier:sym<final>    { <final> }
    }
}

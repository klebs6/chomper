use Data::Dump::Tree;

use gcpp-roles;

# rule virtual-specifier-seq { 
#   <virtual-specifier>+ 
# }
our class VirtualSpecifierSeq { 
    has IVirtualSpecifier @.virtual-specifiers is required;

    has $.text;

    method gist{
        @.virtual-specifiers>>.gist.join(" ")
    }
}

# rule virtual-specifier:sym<override> { 
#   <override> 
# }
our class VirtualSpecifier::Override does IVirtualSpecifier { 

    has $.text;

    method gist{
        "override"
    }
}

# rule virtual-specifier:sym<final> { <final> }
our class VirtualSpecifier::Final does IVirtualSpecifier {

    has $.text;

    method gist{
        "final"
    }
}

our role Virtual::Actions {

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

our role Virtual::Rules {

    rule virtual-specifier-seq {
        <virtual-specifier>+
    }

    proto rule virtual-specifier { * }
    rule virtual-specifier:sym<override> { <override> }
    rule virtual-specifier:sym<final>    { <final> }
}

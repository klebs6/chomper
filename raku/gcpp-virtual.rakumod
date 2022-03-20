
# rule virtual-specifier-seq { 
#   <virtual-specifier>+ 
# }
our class VirtualSpecifierSeq { 
    has IVirtualSpecifier @.virtual-specifiers is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule virtual-specifier:sym<override> { 
#   <override> 
# }
our class VirtualSpecifier::Override does IVirtualSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule virtual-specifier:sym<final> { <final> }
our class VirtualSpecifier::Final does IVirtualSpecifier {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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

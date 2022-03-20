
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

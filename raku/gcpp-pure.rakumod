use Data::Dump::Tree;

use gcpp-roles;
use gcpp-oct;

# rule pure-specifier { 
#   <assign> 
#   <val=octal-literal> 
#   #|{if($val.text.compareTo("0")!=0) throw new InputMismatchException(this); } 
# }
our class PureSpecifier { 
    has OctalLiteral $.val is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role Pure::Actions {

    # rule pure-specifier { <assign> <val=octal-literal> 
    method pure-specifier($/) {
        make PureSpecifier.new(
            val => $<val>.made,
        )
    }
}

our role Pure::Rules {

    rule pure-specifier {
        <assign>
        <val=octal-literal>
        #|{if($val.text.compareTo("0")!=0) throw new InputMismatchException(this); }
    }
}


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

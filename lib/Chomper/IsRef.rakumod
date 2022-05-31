use Chomper::Cpp;
use Chomper::Rust;

use Data::Dump::Tree;

proto sub is-ref($item) is export { * }

multi sub is-ref($item where Cpp::Identifier) 
returns Bool
{  
    False
}

#this should probably be better
multi sub is-ref($item where Cpp::PointerDeclarator) 
returns Bool
{  
    my @seq = $item.augmented-pointer-operators.grep: Cpp::PointerOperator::Ref;
    so @seq.any;
}


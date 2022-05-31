use Chomper::Cpp;
use Chomper::Rust;

use Data::Dump::Tree;

proto sub is-mut($item) is export { * }

multi sub is-mut($item where Cpp::TypeSpecifier) 
returns Bool
{  
    is-mut($item.value)
}

multi sub is-mut($item where Cpp::Identifier) 
returns Bool
{  
    True
}

multi sub is-mut($item where Cpp::FullTypeName) 
returns Bool
{  
    True
}

multi sub is-mut($item where Cpp::TrailingTypeSpecifier::CvQualifier) 
returns Bool
{  
    $item.cv-qualifier !~~ Cpp::CvQualifier::Const_
}


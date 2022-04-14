use Data::Dump::Tree;

use gcpp-roles;
use gcpp-digit;

our role IntegerLiteral::Actions {

    # token nonzerodigit { <[ 1 .. 9 ]> }
    method nonzerodigit($/) {
        make Nonzerodigit.new(
            value => ~$/,
        )
    }
}

our role IntegerLiteral::Rules {

    proto token integer-literal { * }

    token nonzerodigit {
        <[ 1 .. 9 ]>
    }
}

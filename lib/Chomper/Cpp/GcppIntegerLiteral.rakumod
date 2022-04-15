unit module Chomper::Cpp::GcppIntegerLiteral;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppDigit;

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
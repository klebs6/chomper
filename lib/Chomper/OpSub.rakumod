use Chomper::Util;
use Chomper::TypeInfo;
use Chomper::Operators;

our sub translate-op-sub($submatch, $body, $rclass) {

    my $op-add = Operator.new(
        :$submatch, 
        :$body, 
        :$rclass,
        assign => False,
        trait  => "Sub",
        fn     => "sub",
    );

    $op-add.gist
}

our sub translate-op-sub-eq($submatch, $body, $rclass) {

    my $op-add = Operator.new(
        :$submatch, 
        :$body, 
        :$rclass,
        assign => True,
        trait  => "SubAssign",
        fn     => "sub_assign",
    );

    $op-add.gist
}

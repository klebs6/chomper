use Chomper::Util;
use Chomper::TypeInfo;
use Chomper::Operators;

our sub translate-op-add($submatch, $body, $rclass) {

    my $op-add = Operator.new(
        :$submatch, 
        :$body, 
        :$rclass,
        assign => False,
        trait  => "Add",
        fn     => "add",
    );

    $op-add.gist
}

our sub translate-op-add-eq($submatch, $body, $rclass) {

    my $op-add = Operator.new(
        :$submatch, 
        :$body, 
        :$rclass,
        assign => True,
        trait  => "AddAssign",
        fn     => "add_assign",
    );

    $op-add.gist
}

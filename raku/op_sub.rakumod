use util;
use type-info;
use operators;

our sub translate-op-sub($submatch, $body, $rclass) {

    my $op-add = OperatorSub.new(
        :$submatch, 
        :$body, 
        :$rclass
    );

    $op-add.gist
}

use Chomper::ToRust;

use Data::Dump::Tree;

proto sub translate-condition($condition, Str $mask) is export { * }

multi sub translate-condition($condition, "! I") {
    $condition.gist
}

multi sub translate-condition($condition, "I == - N") {
    to-rust($condition)
}

multi sub translate-condition($condition, "I  > I") {
    to-rust($condition)
}

multi sub translate-condition($condition, "I + I  > I") {
    to-rust($condition)
}

multi sub translate-condition($condition, "* I != N") {
    to-rust($condition)
}

multi sub translate-condition($condition, "! I(Es)") {
    to-rust($condition)
}

multi sub translate-condition($condition, "! I(Es) || (E  < N)") {
    to-rust($condition)
}

multi sub translate-condition($condition, "I(Es) != N") {
    to-rust($condition)
}

multi sub translate-condition($condition, "I == I(Es)") {
    to-rust($condition)
}

multi sub translate-condition($condition, "I") {
    to-rust($condition)
}

multi sub translate-condition($condition, "I  >= L && I  <= L") {
    to-rust($condition)
}

multi sub translate-condition($condition, "! E") {
    "!" ~ to-rust($condition.unary-expression)
}

multi sub translate-condition($condition, "E == E") {
    to-rust($condition)
}

multi sub translate-condition($condition, "I(Es)") {
    to-rust($condition)
}

multi sub translate-condition($condition, "E  >= E") {
    to-rust($condition)
}

multi sub translate-condition($condition, "E != I") {
    to-rust($condition)
}

multi sub translate-condition($condition, "E == I") {
    to-rust($condition)
}

multi sub translate-condition($condition, "! I()") {
    "!" ~ to-rust($condition.unary-expression)
}

multi sub translate-condition($condition, "! T()") {
    "!" ~ to-rust($condition.unary-expression)
}

multi sub translate-condition($condition, "E == E || (! E && E == E)") {
    to-rust($condition)
}

multi sub translate-condition($condition, $treemark) {
    say "need to write method to translate";
    ddt $condition;
    say "treemark => $treemark";
    die "<program terminated>";
}

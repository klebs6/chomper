#`( These keywords have special meaning only in
certain contexts. For example, it is possible to
declare a variable or method with the name union.)
our role WeakKeywords::Rules {
    token kw-union          { union }
    token kw-staticlifetime { \'static }
}

our role WeakKeywords::Actions {}


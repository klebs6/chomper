our role BooleanLiteral::Rules {

    proto token boolean-literal { * }
    token boolean-literal:sym<t> { true }
    token boolean-literal:sym<f> { false }
}

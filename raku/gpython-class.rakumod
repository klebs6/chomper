use gpython-function;

our role PythonClass 
does PythonFunction {

    rule python-class {
        <python-class-header> ':'
        [
            | <python-class-member>+
            | <pass>
        ]
    }

    rule python-class-header {
        <class> 
        <python-class-name>
        <parenthesized-python-class-args>
    }

    rule parenthesized-python-class-args {
        '('
            <python-class-args>
        ')'
    }

    rule python-class-args {
        <python-class-arg>+ %% ","
    }

    token python-class-arg {
        <.ident>
    }

    token python-class-name {
        <.ident>
    }

    rule python-class-member {
        | <python-class-member-variable>
        | <python-class-function>
    }
}

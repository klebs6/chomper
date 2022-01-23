use python-keywords;
use python-doc-comment;

our role PythonFunctionBody {
    regex python-function-body {
        | .*
        | 'pass'
    }
}

our role ParenthesizedPythonFunctionArgs {
    rule parenthesized-python-function-args {
        '('
        <python-function-args>
        ')'
    }

    rule parenthesized-python-class-function-args {
        '('
        <python-class-function-args>
        ')'
    }

    rule python-function-args {
        <python-function-arg>* %% ","
    }

    rule python-class-function-args {
        | 'self'
        | 'self, ' [<python-class-function-arg>+ %% ","]
    }

    rule python-function-arg {
        <name=python-ident> ['=' <python-function-arg-default>]?
    }
    regex python-function-arg-default {
        || <numeric>
        || <python-ident>
    }
}


our role PythonFunction 
does PythonKeywords
does ParenthesizedPythonFunctionArgs
does PythonDocComment 
does PythonFunctionBody {

    rule python-function {
        <python-function-header>
        <python-doc-comment>?
        <python-function-body>?
    }

    rule python-class-function {
        <python-class-function-header>
        <python-doc-comment>?
        <python-function-body>?
    }

    rule python-function-header {
        <def> 
        <python-function-name>
        <parenthesized-python-function-args>
        ':'
    }

    rule python-class-function-header {
        <def> 
        <python-function-name>
        <parenthesized-python-class-function-args>
        ':'
    }

    token python-function-name {
        <.python-ident>
    }
}

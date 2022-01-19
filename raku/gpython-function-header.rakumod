our role PythonDocComment {

    regex python-doc-comment {
        <python-doc-comment-delimiter>
        <python-doc-comment-body>
        <python-doc-comment-delimiter>
    }

    token python-doc-comment-delimiter {
        '"""'
    }
    regex python-doc-comment-body {
        .*
    }
}

our role PythonFunctionBody {
    regex python-function-body {
        .*
    }
}

our role ParenthesizedPythonFunctionArgs {
    rule parenthesized-python-function-args {
        '('
        <python-function-args>
        ')'
    }
    rule python-function-args {
        <python-function-arg>* %% ","
    }

    rule python-function-arg {
        <name=python-ident> ['=' <python-function-arg-default>]?
    }
    regex python-function-arg-default {
        || <numeric>
        || <python-ident>
    }
}

our role PythonFunctionHeader 
does ParenthesizedPythonFunctionArgs
does PythonDocComment 
does PythonFunctionBody {
    rule python-function-header {
        <def> 
        <python-function-name>
        <parenthesized-python-function-args>
        ':'
        <python-doc-comment>?
        <python-function-body>?
    }
    token def { 'def' }
    token python-ident {
        <[A..Z a..z 0..9 _]>+
    }
    token python-function-name {
        <.python-ident>
    }
}

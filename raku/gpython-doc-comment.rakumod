use numeric-token;

our role ParameterSection {

    rule parameters-section {
        <parameters-section-header>
        <parameter-specification>+
    }

    regex parameters-section-header {
        'Parameters' \n
        <.ws>? '-'+
    }

    rule parameter-specification {
        <parameter-names> ':' <parameter-type>
        <parameter-description>?
    }

    rule parameter-names {
        <parameter-name>+ %% ","
    }

    token parameter-name {
        <ident>
    }

    token parameter-type {
        <.ident>
    }

    rule parameter-description {
        <.maybe-undelimited-sentence>+
    }
}

our role ReturnValueSection {

    rule returns-section {
        <returns-section-header>
        <returns-specification>+
    }

    regex returns-section-header {
        'Returns' \n
        <.ws>? '-'+
    }

    rule returns-specification {
        <return-value-names> ':' <return-value-type> <return-value-descriptor>?
        <return-value-description>
    }

    rule return-value-names {
        <return-value-name>+ %% ","
    }

    token return-value-name {
        <ident>
    }

    token return-value-type {
        <.ident>
    }

    rule return-value-description {
        <.sentence>+
    }

    regex return-value-descriptor {
        \N+ <?before \n>
    }
}

our role PythonDocCommentBody 
does ReturnValueSection
does NumericToken
does ParameterSection {

    rule doc-comment-body {
        [<paragraph> | <numeric-block>]+?
        <section>*
    }

    rule section {
        | <parameters-section>
        | <returns-section>
        #| <references-section>
    }

    rule sentence {
        [<sentence-token> <.ws>]+ 
        <sentence-end-delim>
    }

    rule maybe-undelimited-sentence {
        [<sentence-token> <.ws>]+ 
        <sentence-end-delim>?
    }

    token sentence-end-delim {
        | '.'
    }

    token sentence-token {
        [
            || <math-delimiter>
            || <word>
            || <numeric>
            || <parenthesized-text>
            || <bracketed-numeric>
        ]
        <sentence-token-delimiter>?
        <?{~$/ !~~ /Parameters/}>
    }

    regex parenthesized-text {
        '('
        <text>
        ')'
    }

    regex text {
        .*?
    }

    token bracketed-numeric {
        '[' <numeric> ']' _?
    }

    token sentence-token-delimiter {
        | ','
        | '`'
        | '\''
        | ':'
    }

    token math-delimiter {
        | '+'
        | '*'
        | '-'
        | '/'
        | '='
    }

    token word {
        <[A..Z a..z \- _]>+
    }

    rule paragraph {
        <sentence>+
    }

    rule numeric-block {
        <numeric>+
    }

    token ident {
        <[A..Z a..z _ 0..9]>+
    }

    rule references-section {
        <references-section-header>
        <references-specification>+
    }
}

# token literal:sym<str> { <string-literal> }
our class StringLiteral does ILiteral { 
    has Str $.value;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Rawstring { 
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role StringLiteral::Actions {

    # token string-literal-item { 
    #   <encodingprefix>? 
    #   [ || <rawstring> || '"' <schar>* '"' ] 
    # }
    method string-literal-item($/) {
        make ~$/;
    }

    # token string-literal { 
    #   <string-literal-item> 
    #   [<.ws> <string-literal-item>]* 
    # }
    method string-literal($/) {
        my @items = $<string-literal-item>>>.made;

        make StringLiteral.new(
            value => @items.join("\n"),
        )
    }

    # token rawstring { || 'R"' [ || [ || '\\' <[ " ( ) ]> ] || <-[ \r \n ( ]> ] '(' <-[ ) ]>*? ')' [ || [ || '\\' <[ " ( ) ]> ] || <-[ \r \n " ]> ] '"' }
    method rawstring($/) {
        make Rawstring.new(
            value => ~$/,
        )
    }
}

our role StringLiteral::Rules {

    token string-literal-item {
        <encodingprefix>?
        [   
           || <rawstring>
           || '"' <schar>* '"'
        ]
    }

    token string-literal {
        <string-literal-item> 
        [<ws> <string-literal-item>]*
    }

    token rawstring {
        ||  'R"'
            [   ||  [   ||  '\\'
                            <[ " ( ) ]>
                    ]
                ||  <-[ \r \n   ( ]>
            ]
            '('
            <-[ ) ]>*?
            ')'
            [   ||  [   ||  '\\'
                            <[ " ( ) ]>
                    ]
                ||  <-[ \r \n   " ]>
            ]
            '"'
    }
}

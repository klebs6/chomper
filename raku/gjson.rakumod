
=begin comment
our role JSON::Grammar::Actions {

    method json($/) {
        make $<value>.made
    }

    method obj($/) {
        make JSON::Object.new(
            items => $<pair>>>.made
        )
    }

    method pair($/) {  
        given $<STRING>.made {
            when "root" {

            }
            when "crate_version" {

            }
            when "includes_private" {

            }
            when "index" {

            }

        }
        <STRING> ':' <value>
    }

    method array($/) {
        make $<value>>>.made
    }

    method null($/)  { null }
    method true($/)  { true }
    method false($/) { false }

    method value($/) { 
        || <NUMBER>
        || <STRING> 
        || <true>
        || <false>
        || <null>
        || <array>
        || <obj>
    }

    method STRING($/) {
        '"'
        [    
            || <ESC>
            || <SAFECODEPOINT>
        ]*
        '"'
    }

    method ESC($/) {
        '\\'
        [    
          || <[ " \\ / b f n r t ]>
          || <UNICODE>
        ]
    }

    method UNICODE($/) {
        'u' [ <HEX> ** 4 ]
    }

    method HEX($/) {
        <[ 0 .. 9 ]>
    }

    method SAFECODEPOINT($/) {
        <-[ " \\ \x[0000] .. \x[001F] ]>
    }

    method NUMBER($/) {
        '-'?  
        <INT> 
        [ '.' <[ 0 .. 9 ]>+ ]?
        <EXP>?
    }

    method zero($/)  { '0' }
    method comma($/) { ',' }

    method INT($/) {
        || <zero>
        || <[ 1 .. 9 ]> <[ 0 .. 9 ]>*
    }

    method EXP($/) {
        <[ E e ]>
        <[ + \- ]>?
        <INT>
    }

    method WS($/) {
        <[   \t \n \r ]>+
    }
}
=end comment

#relaxed terminating comma constraint
our role JSON::Grammar {

    token json {
        <value>
    }

    rule obj {
        || '{' [ <pair>+ %% <comma> ]  '}'
        || '{' '}'
    }

    rule pair {  
        <STRING> ':' <value>
    }

    rule array {
        | '[' [ <value>+ %% <comma> ]  ']'
        | '[' ']'
    }

    token null  { null }
    token true  { true }
    token false { false }

    token value { 
        || <NUMBER>
        || <STRING> 
        || <true>
        || <false>
        || <null>
        || <array>
        || <obj>
    }

    token STRING {
        '"'
        [    
            || <ESC>
            || <SAFECODEPOINT>
        ]*
        '"'
    }

    token ESC {
        '\\'
        [    
          || <[ " \\ / b f n r t ]>
          || <UNICODE>
        ]
    }

    token UNICODE {
        'u' [ <HEX> ** 4 ]
    }

    token HEX {
        <[ 0 .. 9 ]>
    }

    token SAFECODEPOINT {
        <-[ " \\ \x[0000] .. \x[001F] ]>
    }

    token NUMBER {
        '-'?  
        <INT> 
        [ '.' <[ 0 .. 9 ]>+ ]?
        <EXP>?
    }

    token zero  { '0' }
    token comma { ',' }

    token INT {
        || <zero>
        || <[ 1 .. 9 ]> <[ 0 .. 9 ]>*
    }

    token EXP {
        <[ E e ]>
        <[ + \- ]>?
        <INT>
    }

    token WS {
        <[   \t \n \r ]>+
    }
}

use formatting;
use doxy-comment;
use pyrust;
use numeric-token;
#use Grammar::Tracer;

my $ex = qq:to/END/;
Run code in a new Python process, and monitor peak
memory usage.

Returns
-------
    duration : float
Duration in seconds (including Python startup time)

    peak_memusage : float
    Peak memory usage (rough estimate only) in bytes
END

our role Grammar::ReferencesSection {

    rule references-section-header {
        References \-+
    }

    rule references-specification {
        TODO
    }

    rule references-section {
        <references-section-header>
        <references-specification>+
    }
}

our role Grammar::ReturnValueSection {

    rule returns-section {
        Returns \-+
        <returns-specification>+
    }

    rule returns-specification {
        <return-value-names> ':' <return-value-type> <return-value-descriptor>?
        <return-value-description>?
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
        <.sentence>+?
    }

    regex return-value-descriptor {
        \N+ <?before \n>
    }
}

our role Grammar::ParametersSection {

    rule parameters-section {
        <.ws>
        <parameters-section-header>
        <parameter-specification>+
    }

    rule parameters-section-header {
        || Params \-+
        || Parameters \-+
    }

    rule parameter-specification {
        <parameter-names> ':' <parameter-type>
        <parameter-descriptor>?
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

    regex parameter-descriptor {
        \N+ <?before \n>
    }

    rule parameter-description {
        <.maybe-undelimited-sentence>+
    }
}

our role Grammar::AttributesSection {

    rule attributes-section {
        <.ws>
        <attributes-section-header>
        <attribute-specification>+
    }

    rule attributes-section-header {
        || Attributes \-+
    }

    rule attribute-specification {
        <attribute-names> ':' <attribute-type>
        <attribute-descriptor>?
    }

    rule attribute-names {
        <attribute-name>+ %% ","
    }

    token attribute-name {
        <ident>
    }

    token attribute-type {
        <.ident>
    }

    regex attribute-descriptor {
        \N+ <?before \n>
    }

    rule attribute-description {
        <.maybe-undelimited-sentence>+
    }
}

our role Grammar::Prelude 
does NumericToken
{

    token sentence-end-delim {
        | '.'
    }

    token sentence-token {
        [
            || <math-delimiter>
            || <word>
            || <ellipsis>
            || <numeric>
            || <parenthesized-text>
            || <backticked-text>
            || <bracketed-numeric>
        ]
        <sentence-token-delimiter>?
    }

    token ellipsis {
        '...'
    }

    regex parenthesized-text {
        '('
        <text>
        ')'
    }

    regex backticked-text {
        '``'
        <text>
        '``'
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
        | ';'
    }

    token math-delimiter {
        | '+'
        | '*'
        | '-'
        | '/'
        | '='
        | '^'
        | '|'
    }

    token word {
        <[A..Z a..z \- _]>+
    }


    rule numeric-block {
        <numeric>+
    }

    token ident {
        <[A..Z a..z _ 0..9]>+
    }

    rule sentence {
        [<sentence-token> <.ws>]+ 
        <sentence-end-delim>
    }

    rule maybe-undelimited-sentence {
        [<sentence-token> <.ws>]+ 
        <sentence-end-delim>?
    }

    rule paragraph {
        <maybe-undelimited-sentence>+
    }
}

our class DocComment::Prelude {
    has Str $.text is required;
}

our grammar DocCommentGrammar
does Grammar::ReturnValueSection
does Grammar::ReferencesSection
does Grammar::ParametersSection 
does Grammar::AttributesSection 
does Grammar::Prelude
{

    rule TOP {
        <.ws> <python3-doc-comment-section>
    }

    proto rule python3-doc-comment-section { * }

    rule python3-doc-comment-section:sym<returns> {
        <returns-section>
    }

    rule python3-doc-comment-section:sym<params> {
        <parameters-section>
    }

    rule python3-doc-comment-section:sym<attributes> {
        <attributes-section>
    }

    rule python3-doc-comment-section:sym<references> {
        <references-section>
    }

    rule python3-doc-comment-section:sym<prelude> {
        [<paragraph> | <numeric-block>]+
    }
}

our class DocComment::ReturnSpecification {
    has $.names;
    has $.type;
    has $.descriptor;
    has $.description;
}

our class DocComment::ParameterSpecification {
    has $.names;
    has $.type;
    has $.descriptor;
}

our class DocComment::ReferencesSpecification {

}

our class DocComment::Actions {

    method TOP($/) {
        make $<python3-doc-comment-section>.made
    }

    method return-value-name($/) {
        make $/.Str
    }

    method parameter-name($/) {
        make $/.Str
    }

    method return-value-names($/) {
        make $<return-value-name>>>.made
    }

    method return-value-type($/) {
        make $/.Str
    }

    method return-value-descriptor($/) {
        make $/.Str
    }

    method return-value-description($/) {
        make $/.Str
    }

    method parameter-names($/) {
        make $<parameter-name>>>.made
    }

    method parameter-type($/) {
        make $/.Str
    }

    method parameter-descriptor($/) {
        make $/.Str
    }

    method returns-specification($/) {
        make DocComment::ReturnSpecification.new(
            names        => $<return-value-names>.made,
            type         => $<return-value-type>.made,
            descriptor   => $<return-value-descriptor>.made // Nil,
            description  => $<return-value-description>.made // Nil,
        )
    }

    method parameter-specification($/) {
        make DocComment::ParameterSpecification.new(
            names        => $<parameter-names>.made,
            type         => $<parameter-type>.made,
            descriptor   => $<parameter-descriptor>.made // Nil,
        )
    }

    method references-specification($/) {
        make DocComment::ReferenceSpecification(

        )
    }

    method returns-section($/) {
        make $<returns-specification>>>.made
    }

    method parameters-section($/) {
        make $<parameter-specification>>>.made
    }

    method references-section($/) {
        make $<references-specification>>>.made
    }

    method python3-doc-comment-section:sym<returns>($/) {
        make $<returns-section>.made
    }

    method python3-doc-comment-section:sym<params>($/) {
        make $<parameters-section>.made
    }

    method python3-doc-comment-section:sym<references>($/) {
        make $<references-section>.made
    }

    method python3-doc-comment-section:sym<prelude>($/) {
        make DocComment::Prelude.new(text => $/.Str)
    }
}

our class PythonDocComment {

    has Str   $.text is required;

    has @.blocks;

    has Regex $!delim = rule { 
       | ^^ Returns \-+
       | ^^ Params  \-+
       | ^^ Parameters  \-+
       | ^^ References  \-+
       | ^^ Attributes  \-+
    };

    submethod TWEAK {

        my @indices = $!text.match(:g, $!delim)>>.from;

        if @indices.elems eq 0 {

            self.consume-block($!text);

        } else {

            my $cur = 0;
            my @ranges = do for @indices {
                my $range = $cur..($_ - 1);
                $cur = $_;
                $range
            };

            @ranges.push: @indices[*-1]..*;

            for @ranges {
                my $block = $!text.substr($_);
                self.consume-block($block);
            }
        }
    }

    method consume-block(Str $block) {

        my $parsed = DocCommentGrammar.parse($block, actions => DocComment::Actions.new);

        for $parsed.made {
            @!blocks.push: $_;
        }
    }

    method extract-return-types {
        do for @!blocks {
            if $_ ~~ DocComment::ReturnSpecification {
                convert-type-to-rust($_.type)
            }
        }
    }

    method extract-param-typemap {

        my %map;

        for @!blocks {
            if $_ ~~ DocComment::ParameterSpecification {

                my $type = convert-type-to-rust($_.type);

                for $_.names.list -> $name {
                    %map{$name} = $type;
                }
            }
        }

        %map
    }

    method blocks-only-contains-prelude(--> Bool) {
        my $found-non-prelude = False;

        for @!blocks {
            unless $_ ~~ DocComment::Prelude {
                $found-non-prelude = True;
            }
        }

        !$found-non-prelude
    }

    method as-rust-comment {
        my $formatted = format-python-comment-body($!text);

        if self.blocks-only-contains-prelude() {
            parse-doxy-comment($formatted)

        } else {
            $formatted
        }
    }
}

our sub parse-python-doc-comment(Str $text) {
    if $text {
        PythonDocComment.new( :$text )
    } else {
        ""
    }
}

our sub maybe-extract-return-value($parsed) {
    if $parsed {
        my @rvals = $parsed.extract-return-types();
        given @rvals.elems {
            when 0 {
                ""
            }
            when 1 {
                @rvals[0]
            }
            when 2..* {
                as-tuple(@rvals)
            }
        }
    } else {
        ""
    }
}

our sub as-rust-comment($parsed, :$backup) {

    if $parsed {

        $parsed.as-rust-comment()

    } else {

        if $backup {
             parse-doxy-comment(format-python-comment-body($backup))
         } else {
             Nil
         }
    }
}

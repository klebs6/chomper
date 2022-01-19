use snake-case;
use formatting;
use comments;
use gpython-doc-comment;
use indent-rust-named-type-list;
use wrap-body-todo;

our sub to-python-type($type) {
    my %typemap = %(
        ndarray => "NdArray",
        dict    => "PyDict",
    );

    if %typemap{$type}:exists {
        %typemap{$type}
    } else {
        $type
    }
}


our class RustFnNameFromPythonFnName {
    has Match $.python-function-name is required;

    method gist {
        snake-case(~$!python-function-name)
    }
}

our class RustFnArgsFromPythonFnArgs {
    has Match $.python-function-args is required;
    has $.doc-comment-params is required;
    has @.optionals = [];

    method get {

        my %map; for $!doc-comment-params.List {
            %map{$_[0]} = $_[1];
        };

        my @args = do
        for $!python-function-args<python-function-arg>.List {

            my $arg-name     = ~$_<name>;

            my $arg-type     = 
            %map{~$_<name>}:exists 
            ?? to-python-type(%map{~$_<name>}) 
            !! "Todo";

            my $arg-default  = $_<python-function-arg-default> // Nil;

            if $arg-default {
                @!optionals.push: %(:$arg-name, :$arg-type, :$arg-default);
            }

            $arg-default 
            ?? "$arg-name: Option<$arg-type>" 
            !! "$arg-name: $arg-type"
        };
        (indent-rust-named-type-list(@args), @!optionals.List)
    }
}

our sub format-rust-fn-optionals($optionals) {
    do for $optionals.List -> %optional {
        my $name = %optional<arg-name>;
        "let $name: {%optional<arg-type>} = {$name}.unwrap_or\({%optional<arg-default>}\);"
    }.join("\n")
}

our sub format-python-comment-body($body) {
    qq:to/END/.chomp;
    /**
    {apply-lhs-line($body)}
    */
    END
}

our grammar DocCommentBodyParser 
does PythonDocCommentBody {
    rule TOP {
        <.ws> <doc-comment-body>
    }
}

our class PythonDocComment {

    has Match $.python-doc-comment is required;
    has $.body;
    has $.parsed;

    submethod TWEAK {
        $!body   = ~$!python-doc-comment<python-doc-comment-body>;
        $!parsed = 
        DocCommentBodyParser.parse($!body)<doc-comment-body> // self.trace-parse-and-die();
    }

    method trace-parse-and-die {
        use Grammar::Tracer;
        grammar DocCommentBodyTracerParser 
        does PythonDocCommentBody {
            rule TOP {
                <.ws> <doc-comment-body>
            }
        }
        say DocCommentBodyTracerParser.parse($!body);
        die "could not parse";
    }

    method valid {
        so $!python-doc-comment
    }

    method get-returns {
        my @returns;
        my $sections = $!parsed<section>.List;
        my $returns-section = $sections.grep(*.keys[0].contains("returns"))>>.<returns-section>;
        if $returns-section {
            my $returns-specifications = $returns-section>>.<returns-specification>.List;
            for $returns-specifications[0].List -> $spec {
                my @names = $spec<return-value-names><return-value-name>.List;
                my $type  = $spec<return-value-type>;
                for @names -> $name {
                    @returns.push: [~$name, to-python-type(~$type)];
                }
            }
        }
        @returns
    }

    method get-params {
        my @params;
        my $sections = $!parsed<section>.List;
        my $params-section = $sections.grep(*.keys[0].contains("param"));
        if $params-section {
            my $section0 = $params-section[0]<parameters-section>;
            my $parameter-specifications = $section0<parameter-specification>.List;
            for $parameter-specifications -> $spec {
                my @names = $spec[0]<parameter-names><parameter-name>.List;
                my $type  = $spec[0]<parameter-type>;
                for @names -> $name {
                    @params.push: [~$name, to-python-type(~$type)];
                }
            }
        }
        @params
    }

    method get-as-rust-comment {
        die if not self.valid();

        format-python-comment-body(
           $!body 
        )
    }
}

our class PythonFunctionBody {
    has Match $.python-function-body is required;

    method get {
        if $!python-function-body {
            ~$!python-function-body
        } else {
            Nil
        }
    }
}

our sub translate-python-function-header(
    $submatch, $body, $rclass) {

    my $doc-comment = PythonDocComment.new(
        python-doc-comment => $submatch<python-doc-comment> // Nil
    );

    my $maybe-doc-comment-returns = $doc-comment.get-returns();
    my $maybe-doc-comment-params  = $doc-comment.get-params();

    my $function-body = PythonFunctionBody.new(
        python-function-body => $submatch<python-function-body> // Nil
    ).get;

    my $rust-fn-name = RustFnNameFromPythonFnName.new(
        python-function-name => $submatch<python-function-name>
    ).gist;

    my ($rust-fn-args, $rust-fn-optionals) = RustFnArgsFromPythonFnArgs.new(
        python-function-args => $submatch<parenthesized-python-function-args><python-function-args>,
        doc-comment-params => $maybe-doc-comment-params.List
    ).get;

    my $rust-return-type = $maybe-doc-comment-returns 
    ?? as-tuple($maybe-doc-comment-returns.List>>[1]) 
    !! "Todo";

    my $optionals = format-rust-fn-optionals($rust-fn-optionals);

    qq:to/END/;
    {$doc-comment.valid() ?? $doc-comment.get-as-rust-comment() !! ""}
    pub fn $rust-fn-name\($rust-fn-args\) -> $rust-return-type \{
    {$optionals.chomp.indent(8)}
            {$function-body ?? wrap-body-todo($function-body, python => True) !! ""}
    \}

    END
}

sub as-tuple(@list) {
     "({@list.join(',')})"
}

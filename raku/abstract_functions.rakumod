use util;
use snake-case;
use typemap;
use type-info;
use doxy-comment;
use api;

our class AbstractFunction {

    has @.comments;
    has $.block-comment;
    has Bool $.const is required;
    has Bool $.api   is required;
    has $.rt;
    has $.name is required;
    has $.args;

    method get-rt {
        $!rt ?? " -> $!rt" !! ""
    }

    method get-doc-comments {

        if $!block-comment {
            #return reformat-block-comment($!block-comment);
            return parse-doxy-comment($!block-comment.Str);
        }

        if @!comments.elems > 0 {
            my @doc-comments = do for @!comments {
                make-doc-comment($_).chomp.trim
            };
            @doc-comments.join("\n")
        } else {
            ""
        }
    }

    method get-api {
        get-api-tag($!api)
    }

    method gist {

        my $args = format-rust-function-args($!args);

        my $tag = do if $args.chomp.trim {
            $.const ?? "&self, " !! "&mut self, ";
        } else {
            $.const ?? "&self" !! "&mut self";
        };

        self.get-doc-comments 
        ~ "\n{self.get-api}fn {$!name}({$tag}{$args}){self.get-rt};\n"
    }
}

our class AbstractFunctions {

    has AbstractFunction @.declarations;

    method gist {
        do for @!declarations { $_.gist() }.join("\n")
    }
}

our sub translate-abstract-function-declarations(
    $submatch, $body, $rclass) {

    my $writer = AbstractFunctions.new(declarations => [ ]);

    for $submatch<abstract-function-declaration>.List {

        my $block-comment = $_<block-comment>;

        $writer.declarations.push: AbstractFunction.new(
            comments => get-rcomments-list($_).split("\n")>>.chomp,
            const    => $_<const>:exists,
            name     => snake-case($_<name>.Str),
            api      => $_<plugin-api>:exists,
            args     => get-rfunction-args-list($_),
            rt       => get-rust-return-type($_),
            :$block-comment,
        );
    }

    $writer.gist.indent(4)
}


use Chomper::Api;
use Chomper::Case;
use Chomper::DoxyComment;
use Chomper::LineCommentToBlockComment;
use Chomper::SnakeCase;
use Chomper::TypeInfo;
use Chomper::Typemap;
use Chomper::Util;

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

            my $result = @doc-comments.join("\n");

            if $result {
                $result
                ==> line-comment-to-block-comment()
                ==> parse-doxy-comment()
            } else {
                ""
            }

        } else {
            ""
        }
    }

    method get-api {
        get-api-tag($!api)
    }

    method get-self-tag($args) {
        do if $args.chomp.trim {
            $.const ?? "&self, " !! "&mut self, ";
        } else {
            $.const ?? "&self" !! "&mut self";
        }
    }

    method get-trait-name {
        snake-to-camel($!name)
    }

    method separate-trait-gist {
        my $args = format-rust-function-args($!args);

        my $tag = self.get-self-tag($args);

        my $trait-name = self.get-trait-name();

        qq:to/END/
        pub trait {$trait-name} \{

            {self.get-doc-comments}
            {self.get-api}fn {$!name}({$tag}{$args}){self.get-rt};
        \}
        END
    }

    method internal-abstract-function-gist {

        my $args = format-rust-function-args($!args);

        my $tag = self.get-self-tag($args);

        self.get-doc-comments 
        ~ "\n{self.get-api}fn {$!name}({$tag}{$args}){self.get-rt};\n"
    }
}

our class AbstractFunctions {

    has AbstractFunction @.declarations;

    method internal-abstract-function-gist {
        do for @!declarations { $_.internal-abstract-function-gist() }.join("\n")
    }

    method get-combo-interface {
        my $sub-traits = @!declarations>>.get-trait-name.join("\n+ ");
        qq:to/END/
        pub trait Interface:
        $sub-traits \{\}
        END
    }

    method separate-trait-gist {
        my $separate-traits = do for @!declarations { $_.separate-trait-gist() }.join("\n");
        my $combo-interface = self.get-combo-interface();
        qq:to/END/
        $combo-interface
        $separate-traits
        END
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

    $writer.separate-trait-gist.indent(4)
}


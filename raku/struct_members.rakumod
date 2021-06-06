use util;
use typemap;
use type-info;
use indent-rust-named-type-list;

our class RustStructMember {

    has $.name is required;
    has $.type is required;
    has $.default;
    has @.comments;

    method get-maybe-default-tag {
        if $!default {
            " // default = $!default\n"
        } else {
            ""
        }
    }

    method get-doc-comments {

        if @!comments {
            my @doc-comments = do for @!comments {
                make-doc-comment($_).chomp.trim
            };
            @doc-comments.join("\n") ~ "\n"
        } else {
            ""
        }
    }

    method gist(:$column2-start-index = Nil) {

        my $name-type = self.get-as-name-type;

        $name-type = indent-column2(
            $name-type, 
            $column2-start-index
        );

        my $doc-comments = self.get-doc-comments;

        my $maybe-default-tag = self.get-maybe-default-tag;

        "{$doc-comments}{$name-type},{$maybe-default-tag}"
    }

    method get-as-name-type {
        "$!name: $!type"
    }
}

our class RustStructMembers {

    has RustStructMember @.members;

    method gist {
        my @named-type-list = @!members>>.get-as-name-type;
        my $watermark = get-watermark-from-rargs-list(@named-type-list);
        do for @!members {
            $_.gist(column2-start-index => $watermark)
        }.join("")
    }
}

our sub get-default($submatch) {
    $submatch<default-value>:exists ?? $submatch<default-value>.Str !! "";
}

our sub make-doc-comment($comment) {
    $comment.lines>>.subst(/\/ \/ <.ws>? <?before <-[/]> > /, "/// ")>>.trim.join("\n")
}

our sub translate-struct-member-declarations( $submatch, $body, $rclass) 
{
    my $writer = RustStructMembers.new(members => [ ]);

    for $submatch<struct-member-declaration>.List {

        my $comments = get-rcomments-list($_).split("\n")>>.chomp.trim;
        my $default  = get-default($_);
        my $arg      = get-rust-arg($_);
        my $name = $arg.split(":")[0];
        my $type = $arg.split(":")[1..*].join(" ");

        $writer.members.push: RustStructMember.new(
            name     => $name,
            type     => $type,
            comments => $comments,
            default  => $default,
        );
    }

    $writer.gist.indent(4)
}


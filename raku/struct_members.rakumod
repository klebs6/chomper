use util;
use reformat-block-comment;
use block-comment;
use typemap;
use type-info;
use args;
use snake-case;
use return-type;
use indent-rust-named-type-list;
use line-comment-to-block-comment;

our class RustStructFnMember {

    has $.idx  is required;
    has $.name is required;
    has $.type is required;

    method gist(:$column2-start-index = Nil) {

        indent-column2(
            "$!name: $!type,\n",
            $column2-start-index
        )

=begin comment
        indent-column2(
            "$!name: fn({@!maybe-unnamed-args>>.gist.join(', ')}) -> {$!return-type.gist},",
            $column2-start-index
        )
=end comment
    }

    method get-as-name-type {
        "$!name: x"
    }

    submethod BUILD(:$idx, :$function-ptr-type) {
        $!type = populate-typeinfo($function-ptr-type).vectorized-rtype;
        $!idx  = $idx;
        $!name = snake-case($function-ptr-type<name>.Str);
        return;

=begin comment
        my $unnamed-idx = 0;

        for $function-ptr-type<maybe-unnamed-args><maybe-unnamed-arg>.List {

            if $_<unnamed-arg>:exists {

                @!maybe-unnamed-args.push: RustUnnamedArg.new(
                    idx         => $unnamed-idx,
                    unnamed-arg => $_<unnamed-arg>
                );

                $unnamed-idx += 1;

            } elsif $_<arg>:exists {

                @!maybe-unnamed-args.push: RustNamedArg.new(
                    named-arg => $_<arg>
                );

            }
        }
=end comment
    }
}

our class RustStructMember {

    has $.name        is required;
    has $.idx         is required;
    has $.type        is required;
    has $.default;
    has @.comments;
    has $.block-comment;

    #this is janky. we shouldn't need this
    has Bool $.braced is required;

    method get-maybe-default-tag {
        if $!default {
            if $!braced {
                " // default = \{ $!default \}"
            } else {
                " // default = $!default"

            }
        } else {
            ""
        }
    }

    method get-doc-comments {

        if $!block-comment {
            return reformat-block-comment($!block-comment);
        }

        if @!comments.elems > 0 {
            my @doc-comments = do for @!comments {
                make-doc-comment($_).chomp.trim
            };
            line-comment-to-block-comment(
                @doc-comments.join("\n")
            )
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

        $doc-comments = $doc-comments ?? "\n" ~ $doc-comments ~ "\n" !! "";

        my $maybe-default-tag = self.get-maybe-default-tag;

        my $maybe-sep = $doc-comments ?? "\n" !! "";

        "{$doc-comments}{$name-type},{$maybe-default-tag}{$maybe-sep}"
    }

    method get-as-name-type {
        "$!name: $!type"
    }
}

our class RustStructMembers {

    has RustStructMember   @.members;
    has RustStructFnMember @.fn-members;

    method gist {

        my @named-type-list = [|@!members, |@!fn-members]>>.get-as-name-type;

        my $watermark = get-watermark-from-rargs-list(@named-type-list);

        do for [|@!members, |@!fn-members].sort({
            $^a.idx cmp $^b.idx
        }) {
            $_.gist(column2-start-index => $watermark)
        }.join("\n")
    }
}

our sub default-value-is-braced($submatch) {
    $submatch<braced-default-value>:exists
}

our sub get-default-value($submatch) {

    if $submatch<braced-default-value>:exists {
        $submatch<braced-default-value><default-value>.Str
    } elsif $submatch<default-value>:exists {
        $submatch<default-value>.Str
    } else {
        ""
    }
}

our sub translate-struct-member-declarations( $submatch, $body, $rclass) 
{
    my $writer = RustStructMembers.new(members => [ ]);

    my $idx = 0;

    for $submatch<struct-member-declaration>.List {

        my $block-comment = $_<block-comment>;

        my @comments = get-rcomments-list($_).split("\n")>>.chomp;

        if $_<function-ptr-type>:exists {

            $writer.fn-members.push: RustStructFnMember.new(
                :$idx,
                function-ptr-type => $_<function-ptr-type>,
            );

        } else {

            my $d = $_<struct-member-declaration-nonfptr>;

            my $type     = $d<type>;
            my @names    = $d<struct-member-declaration-name>.List;

            my TypeInfo $info = populate-typeinfo($type);
            my TypeAux  $aux  = get-type-aux($d);

            for @names {

                my $name    = $_<name>;
                my $default = get-default-value($_);
                my Bool $braced = default-value-is-braced($_);


                my ($rname, $rtype) = get-rust-arg-name-type($name, $info, $aux);

                $writer.members.push: RustStructMember.new(
                    name     => snake-case($rname.subst(/_$/, "")), #trim trailing _
                    type     => $rtype,
                    :$braced,
                    :$block-comment,
                    :@comments,
                    :$default,
                    :$idx,
                );
            }

        }

        $idx += 1;
    }

    $writer.gist.indent(4)
}

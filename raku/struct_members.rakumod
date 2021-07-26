use util;
use typemap;
use type-info;
use args;
use snake-case;
use return-type;
use indent-rust-named-type-list;

our class RustStructFnMember {

    has                $.idx         is required;
    has RustReturnType $.return-type is required;
    has                $.name        is required;
    has RustArg        @.maybe-unnamed-args;

    method gist(:$column2-start-index = Nil) {

        indent-column2(
            "$!name: fn({@!maybe-unnamed-args>>.gist.join(', ')}) -> {$!return-type.gist},",
            $column2-start-index
        )
    }

    method get-as-name-type {
        "$!name: x"
    }

    submethod BUILD(:$idx, :$function-ptr-type) {

        $!idx = $idx;

        $!return-type = RustReturnType.new(
            match => $function-ptr-type<return-type>
        );

        $!name = $function-ptr-type<name>.Str;

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
    }
}

our class RustStructMember {

    has $.name is required;
    has $.idx is required;
    has $.type is required;
    has $.default;
    has @.comments;

    method get-maybe-default-tag {
        if $!default {
            " // default = $!default"
        } else {
            ""
        }
    }

    method get-doc-comments {

        if @!comments.elems > 0 {
            my @doc-comments = do for @!comments {
                make-doc-comment($_).chomp.trim
            };
            @doc-comments.join("\n")
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

our sub get-default($submatch) {
    $submatch<default-value>:exists ?? $submatch<default-value>.Str !! "";
}

our sub translate-struct-member-declarations( $submatch, $body, $rclass) 
{
    my $writer = RustStructMembers.new(members => [ ]);

    my $idx = 0;

    for $submatch<struct-member-declaration>.List {

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
                my $default = $_<default-value>;

                my ($rname, $rtype) = get-rust-arg-name-type($name, $info, $aux);

                $writer.members.push: RustStructMember.new(
                    name     => snake-case($rname.subst(/_$/, "")), #trim trailing _
                    type     => $rtype,
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

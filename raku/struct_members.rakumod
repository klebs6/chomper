use util;
use typemap;
use type-info;
use indent-rust-named-type-list;

role RustFnPtrArg {
    method gist {}
}

our class RustNamedArg does RustFnPtrArg {

    has $!match is required;
    has $!rname is required;
    has $!rtype is required;

    submethod BUILD(:$named-arg) {

        $!match = $named-arg;

        my $info = populate-typeinfo($named-arg<type>);
        my $aux  = get-type-aux($named-arg);

        ($!rname, $!rtype) = get-rust-arg-name-type($named-arg<name>.Str, $info, $aux);
    }

    method gist {
        "{$!rname}: {$!rtype}"
    }
}

our class RustUnnamedArg does RustFnPtrArg {

    has $!match is required;
    has $!idx   is required;
    has $!rname is required;
    has $!rtype is required;

    submethod BUILD(:$idx, :$unnamed-arg) {

        $!match = $unnamed-arg;
        $!idx   = $idx;

        my $info = populate-typeinfo($unnamed-arg<type>);
        my $aux  = get-type-aux($unnamed-arg);

        my $name = "_{$idx}";

        ($!rname, $!rtype) = get-rust-arg-name-type(
            $name, 
            $info, 
            $aux
        );
    }

    method gist {
        "{$!rname}: {$!rtype}"
    }
}

our class RustReturnType {

    has $!match is required;
    has $!rtype is required;

    submethod BUILD(:$match) {
        $!match = $match;
        my $info = populate-typeinfo($match<type>);
        my $aux  = get-type-aux($match);
        my ($rname, $rtype) = get-rust-arg-name-type("_", $info, $aux);
        $!rtype = $rtype;
    }

    method gist {
        $!rtype
    }
}

our class RustStructFnMember {

    has                $.idx         is required;
    has RustReturnType $.return-type is required;
    has                $.name        is required;

    has RustFnPtrArg   @.maybe-unnamed-args;

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
                    name     => $rname.subst(/_$/, ""), #trim trailing _
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

our sub get-rust-arg-name-type($name, TypeInfo $info, TypeAux $aux) {

    my $rarg = get-rust-arg-impl($name, $info, $aux);

    my $len = $rarg.chars;
    my $idx = $rarg.index(":");

    my $rname = $rarg.substr(0, $idx ).trim;

    my $rtype = $rarg.substr($idx + 1, $len ).trim;

    ($rname, $rtype)
}

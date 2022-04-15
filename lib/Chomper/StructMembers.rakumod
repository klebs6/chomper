use Chomper::Util;
use Chomper::DoxyComment;
use Chomper::ReformatBlockComment;
use Chomper::BlockComment;
use Chomper::Typemap;
use Chomper::TypeInfo;
use Chomper::Args;
use Chomper::SnakeCase;
use Chomper::ReturnType;
use Chomper::Rust::IndentRustNamedTypeList;
use Chomper::LineCommentToBlockComment;
use Chomper::Comments;

our class RustStructFnMember {

    has $.idx  is required;
    has $.name is required;
    has $.type is required;

    has $.block-comment;
    has @.comments;

    method get-doc-comments {

        if $!block-comment {
            #return reformat-block-comment($!block-comment);
            return parse-doxy-comment($!block-comment.Str);
        }

        format-comments(@!comments)
    }

    method gist(:$column2-start-index = Nil) {

        my $doc-comments = self.get-doc-comments;

        my $decl = indent-column2(
            "$!name: $!type,\n",
            $column2-start-index
        );

        qq:to/END/;
        $doc-comments
        $decl
        END
    }

    method get-as-name-type {
        "$!name: x"
    }

    submethod BUILD(:$idx, :$function-ptr-type, :$block-comment, :@comments) {
        $!block-comment = $block-comment;
        @!comments      = @comments;
        $!type          = populate-typeinfo($function-ptr-type).vectorized-rtype;
        $!idx           = $idx;
        $!name          = snake-case($function-ptr-type<name>.Str);
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
            #return reformat-block-comment($!block-comment);
            return parse-doxy-comment($!block-comment.Str);
        }

        format-comments(@!comments)
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
                :$block-comment,
                :@comments,
                function-ptr-type => $_<function-ptr-type>,
            );

        } else {

            my $d = $_<struct-member-declaration-nonfptr>;

            my $type     = $d<type>;
            my @names    = $d<struct-member-declaration-name>.List;

            my TypeInfo $info = populate-typeinfo($type);

            #wow what a bogus c/c++ parse when we
            #have multiple names in a declaration
            #
            #there might be a handful of structs
            #with incorrect members because of
            #this...
            #
            #perhaps i will need to flag them
            my TypeAux  $paux  = get-type-aux($d);

            for @names {

                my $name    = $_<name>;
                my $default = get-default-value($_);
                my Bool $braced = default-value-is-braced($_);

                my TypeAux  $aux  = merge-type-aux($paux,get-type-aux($_));

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

use util;
use hungarian;
use case;
use doxy-comment;
use reformat-block-comment;
use block-comment;
use typemap;
use type-info;
use args;
use snake-case;
use return-type;
use indent-rust-named-type-list;
use line-comment-to-block-comment;
use comments;

our class RustEnumMember {

    has $.id         is required;
    has $.val        is required;
    has $.idx        is required;

    has @.comments;
    has $.block-comment;

    method get-doc-comments {

        if $!block-comment {
            #return reformat-block-comment($!block-comment);
            return parse-doxy-comment($!block-comment.Str);
        }

        format-comments(@!comments)
    }

    method gist {

        my $doc-comments = self.get-doc-comments;

        $doc-comments = $doc-comments ?? "\n" ~ $doc-comments ~ "\n" !! "";

        my $maybe-sep = $doc-comments ?? "\n" !! "";
        my $maybe-val = $!val ?? " = $!val" !! "";

        "{$doc-comments}{$!id}{$maybe-val},{$maybe-sep}"
    }
}

our class RustEnumMembers {

    has RustEnumMember   @.members;

    method gist {

        do for [|@!members ].sort({
            $^a.idx cmp $^b.idx
        }) {
            $_.gist()
        }.join("\n")
    }
}

our sub translate-enum-member-declarations( $submatch, $body, $rclass) 
{
    my $writer = RustEnumMembers.new(members => [ ]);

    my $idx = 0;

    for $submatch<enum-member-declaration>.List {

        my $block-comment = $_<block-comment>;

        my @comments = get-rcomments-list($_).split("\n")>>.chomp;

        my $item         = $_<enum-member-declaration-item>;
        my $id           = remove-hungarian-constant-prefix(~$item<id>);
        my $equals-int   = $item<equals-int><value> // Nil;

        $writer.members.push: RustEnumMember.new(
            id     => snake-to-camel($id.subst(/_$/, "")), #trim trailing _
            val    => $equals-int,
            :$block-comment,
            :@comments,
            :$idx,
        );

        $idx += 1;
    }

    $writer.gist.indent(4)
}

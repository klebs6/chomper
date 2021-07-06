use util;
use typemap;
use type-info;
use comments;

our sub find-semicolons(@lines) {
    do for @lines {
        $_.indices(":")[0]
    }
}

our sub insert-spaces-after-semicolon-up-to-high-watermark(
    @lines, 
    @semicolon-indices, 
    $high-watermark) {

        my @lines-builder = @lines;

        for @lines-builder Z @semicolon-indices -> ($line is rw, $semicolon-index) {
            my $diff = $high-watermark - $semicolon-index;
            if $diff {
                $line.substr-rw($high-watermark - 1,0) = " " x $diff;
            }
        }

        @lines-builder

}

class Writer {

    has @.globals is required;

    method gist {

        my @lines = @!globals>>.gist>>.trim;

=begin comment
        my @semicolon-indices = find-semicolons(@lines);

        my $high-watermark = @semicolon-indices.max;

        my @indented-lines = 
        insert-spaces-after-semicolon-up-to-high-watermark(
            @lines, 
            @semicolon-indices, 
            $high-watermark);

        @indented-lines.join("\n")
=end comment
        @lines.join("\n")

    }
}


class ConstexprGlobalDef does GetDocComments {
    has $.name is required;
    has $.type is required;
    has $.expr is required;
    has @.comments;

    method gist {

        my $doc-comments = self.get-doc-comments(@!comments).chomp;

        $doc-comments ~
        "pub const $.name: $.type = $.expr;"

    }
}

our sub translate-constexpr-global-block($submatch, $body, $rclass) {

    my $writer = Writer.new(globals => [ ]);

    for $submatch<constexpr-global-item>.List {

        my @comments = get-rcomments-list($_).split("\n")>>.chomp;

        $writer.globals.push: ConstexprGlobalDef.new(
            name     => $_<name>.Str,
            type     => get-rust-type($_<type>),
            expr     => $_<until-semicolon>.Str,
            comments => @comments,
        );
    }

    $writer.gist
}

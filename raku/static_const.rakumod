use util;
use typemap;

our sub translate-static-const($submatch, $body, $rclass) {

    my @items = [];

    for $submatch<static_const> {
        my $type     = $_<type>.Str;
        my $name     = $_<name>.Str;
        my $rhs      = $_<static_const_rhs>.Str;
        my $comment  = $_<line-comment>:exists ?? "// {$_<line-comment><line-comment-text>.Str}" !! "";

        my $rtype = %*typemap{$type};

        my $rust = qq:to/END/.chomp.trim;
        pub const {$name}: $rtype = {$rhs}; {$comment.chomp.trim}
        END
        @items.push: $rust;
    }
    @items.join("\n").chomp.trim
}

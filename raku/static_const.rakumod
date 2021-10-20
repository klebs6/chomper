use util;
use typemap;
use snake-case;
use type-info;
use textwidth;
use align-column;
use braced-array-literal;

our sub translate-static-const-rhs(Match $static_const) {
    $static_const<arg><default-value>.Str
=begin comment

    my $rhs = $static_const<static_const_rhs>;

    if $rhs<braced-array-literal>:exists {
        BracedArrayLiteral.new(
            match => $rhs<braced-array-literal>
        ).gist

    } elsif $rhs<braced-default-value>:exists {
        $rhs<braced-default-value><default-value>.Str
    } else {
        $rhs<default-value>.Str
    }
=end comment
}

our sub translate-static-const($submatch, $body, $rclass) {

    my @items = [];

    for $submatch<static_const> {

        my Bool $has-array-specifier = $_<array-specifier>:exists;

        my $type     = $_<arg><type>;
        my $name     = snake-case($_<arg><name>.Str);
        my $rhs      = translate-static-const-rhs($_);
        my $comment  = $_<line-comment>:exists ?? "// {$_<line-comment><line-comment-text>.Str}" !! "";

        my TypeInfo $info = populate-typeinfo($type);
        my TypeAux  $aux  = get-type-aux($_<arg>);
        my $rtype = get-augmented-rust-type($info, $aux);

        #das brutal hack
        if $rtype ~~ "*mut u8" or $rtype ~~ "*const u8" {
            $rtype = "&'static str";
        }

        #my $rtype = %*typemap{$type};

        my $rust = qq:to/END/.chomp.trim;
        pub const {$name}: $rtype = {$rhs}; {$comment.chomp.trim}
        END
        @items.push: $rust;
    }

    my $result = @items.join("\n").chomp.trim;

    align-columns($result, 3)
}

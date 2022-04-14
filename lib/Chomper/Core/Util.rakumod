use type-info;
use snake-case;
use indent-rust-named-type-list;

our sub make-doc-comment($comment) {
    $comment.lines>>.subst(/<!after <[/]>> \/ \/ <.ws>? <?before <-[/]> > /, "/// ")>>.trim.join("\n")
}

our sub format-option-defaults-initlist($list) {

    if $list {

        my @list = $list.chomp.split("\n");
        @list = do for @list -> $item is rw {
            if $item.chars > 60 {
                #long line
                $item = $item.subst("=", "=\n        ")
            }
            $item.indent(4)
        };
        "\n" ~ @list.join("\n") ~ "\n"

    } else {
        ""
    }
}

our sub say-typemap {
    say %*typemap;
}

our sub get-naked($rtype) {
    grammar Strip {
        rule TOP {
            <.ws> [<ref> | <ptr>+ ]? <mut>? <ident>
        }
        token ref { '&' }
        token ptr { '*' }
        token mut { 'mut' }
        token const { 'const' }
        token ident { <[A..Z a..z 0..9 _]>+ }
    }
    my $result = Strip.parse($rtype.Str)<ident>.Str;
    $result
}

our sub chop_function_body($in) {
    my $lidx = $in.indices('{')[0];
    my $ridx = $in.indices('}')[*-1];
    my $head = $in.substr(0 .. $lidx - 1);
    my $body = $in.substr($lidx + 1 .. $ridx - 1);

    ($head, $body)
}

our sub get-template-args($header) {
    if $header<template-prefix>:exists {
        $header<template-prefix><template-args><template-arg>>><name>.Str
    } else {
        Nil
    }
}

our sub extract_comments($m) {
    if $m {
        my @comments = [];
        for $m {
            @comments.push: $_.Str.trim;
        }
        @comments.join("\n");

    } else {
        ""
    }
}

our sub get_rust_qualifier($arg) {

    my $const = 
    $arg<const>:exists 
        or $arg<const2>:exists;

    if $const and $arg<ref>:exists and $arg<ref><double-ref>:!exists {
        $arg<ref>.Str

    } elsif $arg<ref>:exists and $arg<ref><double-ref>:!exists {
        "{$arg<ref>.Str}mut "

    } else {
        ""
    }
}

our sub optionize-rtype($rtype-base, $option_levels is rw) {

    my $result = $rtype-base;

    while $option_levels > 0 {
        $option_levels -= 1;
        $result = "Option<{$result}>";
    }

    $result;
}

#TODO: eliminate some redundancy with 
# get-rust-return-type
our sub get-roperand($header, $idx) {
    ParenthesizedArgs.new(
        parenthesized-args => $header<parenthesized-args>
    ).type-for-arg-at-index($idx)
}

our sub get-option-defaults-initlist($header) {
    ParenthesizedArgs.new(
        parenthesized-args => 
        $header<parenthesized-args>
    ).get-option-defaults-initlist;
}

our sub get-num-args($header) {
    ParenthesizedArgs.new(
        parenthesized-args => $header<parenthesized-args>).num-args
}

our sub get-maybe-self-args($header) {

    if $header<static>:exists { 
        return ""
    }

    my $num = get-num-args($header);

    my $const = $header<const>:exists or 
    $header<const2>:exists;

    if $num == 0 {
        return $const ?? "&self" !! "&mut self";

    } else {
        return $const ?? "&self, " !! "&mut self, ";
    }
}

our sub rparse-hasher-mock($header) {
    ('//here is a comment'),
    'MyClass',
}

our sub rparse-hasher($header) {
    #rparse-hasher-mock($header)
    get-rcomments-list($header),
    get-roperand($header,0),
    get-rinline($header),
}

our sub rparse-function-header-mock($header) {
        '#[inline] ',
        'MyType',
        'function_name',
        'f64',
        ('x: T', 'y: T'),
        ('let x: f64 = x.unwrap_or(54.0)'),
        '&mut self',
        ('//here is a comment')
}

our sub rparse-function-header($header) {
    #rparse-function-header-mock($header)
    get-rinline($header),
    get-rfunction-name($header),
    get-return-string($header),
    get-rfunction-args-list($header),
    get-option-defaults-initlist($header),
    get-maybe-self-args($header),
    get-rcomments-list($header),
}

our sub rparse-operator-ostream-mock($header) {
    ('//here is a comment'), 
    'MyType',
}

our sub rparse-operator-ostream($header, $user_class) {
#rparse-operator-mul($header)
    get-rcomments-list($header),
    $user_class ?? $user_class !! get-roperand($header,0),
}

our sub rparse-operator-mul-mock($header) {
        ('//here is a comment'), 
        '#[inline] ',
        'MyType',
        'f64',
        'f32',
        ('x: T', 'y: T'),
}

our sub rparse-operator-mul($header, $user_class) {
#rparse-operator-mul($header)
    get-rcomments-list($header),
    get-rinline($header),
    get-rust-return-type($header, augment => False),
    $user_class ?? $user_class             !! get-roperand($header,0),
    $user_class ?? get-roperand($header,0) !! get-roperand($header,1),
}

our sub rparse-operator-mock($header) {
        ('//here is a comment'), 
        '#[inline] ',
        'MyType',
        'f64',
        'f32',
        ('x: T', 'y: T'),
}

our sub rparse-operator-compare($header,$user_class) {
    get-rcomments-list($header),
    get-rinline($header),
    get-rust-return-type($header, augment => False),
}

our sub rparse-operator($header,$user_class) {
    #rparse-operator-mock($header)
    get-rcomments-list($header),
    get-rinline($header),
    get-rust-return-type($header, augment => False),
    $user_class ?? $user_class             !! get-roperand($header,0),
    $user_class ?? get-roperand($header,0) !! get-roperand($header,1),
}

our sub rparse-operator-into-bool($header) {
    get-rcomments-list($header),
    get-rinline($header),
    get-rust-return-type($header, augment => False),
}

our sub rparse-operator-index-mock($header) {
        ('//here is a comment'), 
        '#[inline] ',
        True,
        'f64',
        'MyType',
        'usize',
        ('x: T', 'y: T'),
}

our sub rparse-operator-index($header,$user_class) {
#rparse-operator-mock($header)
    get-rcomments-list($header),
    get-rinline($header),
    get-rconst($header),
    get-rust-return-type($header, augment => False),
    $user_class ?? $user_class             !! get-roperand($header,0),
    $user_class ?? get-roperand($header,0) !! get-roperand($header,1),
    get-rfunction-args-list($header)
}

our sub rparse-operator-negate-mock($header) {
        ('//here is a comment'), 
        '#[inline] ',
        'MyType',
        'f64',
        ('x: T', 'y: T'),
}

our sub rparse-operator-negate($header) {
#rparse-operator-negate-mock($header)
    get-rcomments-list($header),
    get-rinline($header),
    get-rust-return-type($header, augment => False)
}

our sub rparse-operator-assign-mock($header) {
        ('//here is a comment'), 
        '#[inline] ',
        'MyType',
        'f64',
        ('x: T', 'y: T'),
}

our sub rparse-operator-assign($header) {
    #rparse-operator-assign-mock($header)
    get-rcomments-list($header),
    get-rinline($header),
    get-rust-return-type($header, augment => False),
    get-roperand($header,0),
    get-rfunction-args-list($header)
}


#we expect this sort of output in this order
our sub rparse-template-header-mock($header) {
        ('T'), 
        ('//here is a comment'), 
        '#[inline] ',
        'T',
        'my_rust_function',
        ('x: T', 'y: T'),
}

our sub rparse-template-header($template-header) {
    get-rtemplate-args-list($template-header),
        get-rcomments-list($template-header),
        get-rinline($template-header),
        get-return-string($template-header),
        get-rfunction-name($template-header),
        get-rfunction-args-list($template-header),
        get-option-defaults-initlist($template-header),
        get-maybe-self-args($template-header),
}

our sub format-rust-comments($rcomments-list) {
    $rcomments-list.join("\n")
}

our sub format-rust-template-args($rtemplate-args-list) {
    $rtemplate-args-list.join(", ")
}

#may want to move some of this into a separate subroutine because
#it contains the column indenting logic which can be used in 
#struct bodies (for example) too
our sub format-rust-function-args($rfunction-args-list) {

    indent-rust-named-type-list($rfunction-args-list.List)
}

our sub get-rtemplate-args-list($template-header, :$write-default = True) {

    my $template-args = $template-header<template-args>;

    my @result = [];

    for $template-args<template-arg> {

        my $prefix;

        if $_<type>:exists {

            $prefix = "const {$_<name>.Str}: {%*typemap{$_<type>.Str}}";

        } else {

            $prefix = $_<name>.Str;

        }

        if $_<default-value>:exists and $write-default {

            my $def = populate-typeinfo($_<default-value>).vectorized-rtype;

            @result.push: "$prefix = $def";

        } else {

            @result.push: "$prefix";
        }
    }

    @result
}

our sub get-rcomments-list($template-header) {
    if $template-header<line-comment>:exists {
        $template-header<line-comment>>>.Str.trim
    } else {
       [] 
    }
}

our sub get-rinline($template-header) {
    my $inline = $template-header<inline>;
    if $inline.elems > 0 {
        if $inline[0]<inline-force>:exists {
            "#[inline(always)] "
        } elsif $inline[0]<inline-never>:exists {
            "#[inline(never)] "
        } else {
            "#[inline] "
        }
    } else {
        ''
    }
}

our sub get-rinline-b(Match $m) {
    $m<inline>.elems > 0 
}

our sub get-rconst($template-header) {

    my $const = 
    $template-header<const>:exists 
        or $template-header<const2>:exists;

    $const ??  True !! False 
}

our sub get-rfunction-name($template-header, $default-prefix = "") {

    my $prefix = "prefix".IO.e ?? "prefix".IO.slurp.chomp !! $default-prefix;

    #allows us to toggle active status 
    #in the prefix file itself
    if $prefix.starts-with(".") {
        $prefix = "";
    }

    if $template-header<function-name><function-name-operator-invoke>:exists {
        return "invoke";
    }

    if $template-header<function-name><function-name-operator-prefix-increment>:exists {
        return "prefix_increment";
    }

    if $template-header<function-name><function-name-operator-prefix-decrement>:exists {
        return "prefix_decrement";
    }

    if $template-header<function-name><function-name-operator-postfix-increment>:exists {
        return "postfix_increment";
    }

    if $template-header<function-name><function-name-operator-postfix-decrement>:exists {
        return "postfix_decrement";
    }

    if $template-header<function-name><function-name-operator-assign>:exists {
        return "assign_from";
    }

    my $priv    = $template-header<function-name><priv>:exists;
    my $old     = $template-header<function-name><identifier>.Str;
    my $new     = "{$prefix}{snake-case($old)}";
    my $mapping = $priv ?? "_{$old} $new" !! "{$old} $new";
    spurt %*ENV<WORK> ~ "/repo/translator/raku/function-mappings", "$mapping\n", :append;
    $new
}

our sub get-rctor-function-name($header) {
    $header<namespace>:exists 
    ??  %*typemap{$header<namespace><identifier>} 
    !! ""
}

our sub get-rfunction-args-list(Match $header) {
    ParenthesizedArgs.new(
        parenthesized-args => $header<parenthesized-args>).get-rust-args
}

#decl must be something with a 
#return-type match as a keyed value
our sub get-rust-return-type($decl, :$augment = True) {

    if not $decl<return-type>:exists {
        return "";
    } 

    my $rt = $decl<return-type>;

    if $rt<type>.Str eq "void" {
        return "";
    }

    my $const = 
    $rt<const>:exists or $rt<const2>:exists;

    my $ref   = $rt<ref>:exists and $rt<ref><double-ref>:!exists;
    my $ptr   = $rt<ptr>.elems;
    my $vol   = $rt<volatile>:exists;
    my Bool $ptr-ref = get-ptr-refness($rt);

    my TypeInfo $info = populate-typeinfo($rt<type>);

    my $vectorized-rtype = $info.vectorized-rtype;

    if $augment {
        return augment-rtype(
            $vectorized-rtype, 
            $const, 
            $ref, 
            $ptr-ref,
            $ptr, 
            $vol
        );

    } else {
        return $vectorized-rtype;
    }
}

our sub get-return-string($decl) {

    my $rtype = get-rust-return-type($decl);

     $rtype ??  "-> $rtype" !!  ""
}

our sub get_parts($in, $chop) {

    my ($head, $body) = do if $chop {

        chop_function_body($in)

    } else {

        ($in, "")

    };

    ($head, $body)
}


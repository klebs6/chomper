use type-info;

our sub say-typemap {
    say %*typemap;
}
our sub get-naked($rtype) {
    grammar Strip {
        rule TOP {
            <.ws> [<ref> | <ptr> ]? <mut>? <ident>
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

our sub snake-case($name) {
    my $result = $name;
    $result ~~ s:g/<?after <[a..z]>> (<[A..Z]> ** 1) <?before <[a..z]>>/_{$0.lc}/; 
    $result ~~ s:g/<?after <[a..z]>> (<[A..Z 0..9]> ** 2..*) <?before <[a..z]>>/_{$0.lc}/; 
    $result ~~ s:g/<wb> (<[A..Z 0..9]>)/{$0.lc}/; 
    $result ~~ s:g/<?after _> (<[A..Z]>) ** 1 <?before <[a..z]>>/{$0.lc}/;
    $result
}

our sub get_rust_qualifier($arg) {

    my $const = 
    $arg<const>:exists 
        or $arg<const2>:exists;

    if $const and $arg<ref>:exists {
        $arg<ref>.Str

    } elsif $arg<ref>:exists {
        "{$arg<ref>.Str}mut "

    } else {
        ""
    }
}

our sub get-arr-type($rtype, @dim_stack) {

    my $builder = $rtype;

    for @dim_stack {
        $builder = "[{$builder}; {$_}]";
    }

    $builder
}

our sub get-rust-array-arg(
        $name, 
        $const, 
        $ref, 
        $ptr, 
        $rtype, 
        @dim_stack) 
{

    my $arr-type = get-arr-type($rtype, @dim_stack);

    my $augmented = augment-rtype(
        $arr-type, 
        $const, 
        $ref, 
        $ptr
    );

    return "$name: $augmented";
}

our sub get-dim-stack($arg) {

    my $arr = $arg<array-specifier>;

    my @dim_stack = [];

    if $arr {
        for $arr<array-dimension> {
            @dim_stack.push: $_.Str;
        }
    }

    @dim_stack
}

our sub optionize-rtype($rtype-base, $option_levels is rw) {

    my $result = $rtype-base;

    while $option_levels > 0 {
        $option_levels -= 1;
        $result = "Option<{$result}>";
    }

    $result;
}

our sub get-rust-arg($arg, $compute_const = True ) {

    my $name = snake-case($arg<name>.trim);

    my $ident = $arg<type><maybe-vectorized-identifier>;

    my TypeInfo $info = populate-typeinfo($ident);

    my $vectorized-rtype = $info.vectorized-rtype;

    my $const  = $compute_const ?? 
    (($arg<const> || $arg<const2>) !~~ Nil) !! False;

    my $ref = $arg<ref>:exists;
    my $ptr = $arg<ptr>:exists;

    my @dim_stack = get-dim-stack($arg);

    if @dim_stack.elems > 0 {
        return get-rust-array-arg(
            $name, 
            $const, 
            $ref, 
            $ptr, 
            $vectorized-rtype, 
            @dim_stack);

    } else {

        my $augmented = augment-rtype(
            $vectorized-rtype, 
            $const, 
            $ref, 
            $ptr
        );
        return "$name: $augmented";
    }
}

#TODO: eliminate some redundancy with 
# get-rust-return-type
our sub get-roperand($header, $idx) {
    my $operand = $header<args><arg>[$idx];

    my $ident = $operand<type><maybe-vectorized-identifier>;

    my TypeInfo $info = populate-typeinfo($ident);

    $info.vectorized-rtype
}

our sub get-option-defaults-initlist($header) {
    my @defaults = [];

    my $idx = 0;
    for $header<args><arg> {

        my $name = snake-case($_<name>.Str);
        my $rtype = get-roperand($header,$idx);

        if $_<default-value>:exists {

            my $default = $_<default-value>.Str;

            @defaults.push: 
            "let $name: $rtype = {$name}.unwrap_or({$default});\n";
        }

        $idx += 1;
    }
    @defaults.join("")

}

our sub get-num-args($header) {
    $header<args><arg>.elems
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

our sub rparse-operator-eq-mock($header) {
        ('//here is a comment'), 
        '#[inline] ',
        'f64',
        'f32',
}

our sub rparse-operator-eq($header, $user_class) {
    #rparse-operator-eq-mock($header)
    get-rcomments-list($header),
    get-rinline($header),
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
        get-rust-return-type($template-header),
        get-rfunction-name($template-header),
        get-rfunction-args-list($template-header)
}

#we expect this sort of output in this order
our sub rparse-ctor-header-mock($ctor-header) {
    ('Scl', 'T'), #Nil,
    'MyClass',
    ('x: i32', 'y: i16'),
    ('//here is a comment'), 
}

our sub rparse-ctor-header($header) {
    #rparse-ctor-header-mock($header)
    get-template-args($header),
    get-rctor-function-name($header),
    get-rfunction-args-list($header<parenthesized-args>),
    get-rcomments-list($header)
}

#we expect this sort of output in this order
our sub rparse-default-header-mock($ctor-header) {
    ('//here is a comment'), 
}

our sub rparse-default-header($header) {
    get-rcomments-list($header)
}

our sub format-rust-comments($rcomments-list) {
    $rcomments-list.join("\n")
}

our sub format-rust-template-args($rtemplate-args-list) {
    $rtemplate-args-list.join(", ")
}

our sub format-rust-function-args($rfunction-args-list) {
    $rfunction-args-list.join(",\n")
}

our sub get-rtemplate-args-list($template-header) {

    my $template-args = $template-header<template-args>;

    my @result = [];

    for $template-args<template-arg> {
        @result.push: $_<name>.Str;
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
    $template-header<inline>:exists ??  '#[inline] ' !! ''
}

our sub get-rconst($template-header) {

    my $const = 
    $template-header<const>:exists 
        or $template-header<const2>:exists;

    $const ??  True !! False 
}

our sub get-rfunction-name($template-header) {
    my $priv    = $template-header<function-name><priv>:exists;
    my $old     = $template-header<function-name><identifier>.Str;
    my $new     = snake-case($old);
    my $mapping = $priv ?? "_$old $new" !! "$old $new";
    spurt "raku/function-mappings", "$mapping\n", :append;
    $new
}

our sub get-rctor-function-name($header) {
    $header<namespace>:exists 
    ??  %*typemap{$header<namespace><identifier>} 
    !! ""
}

our sub get-rfunction-args-list($template-header) {
    my @result = [];
    for $template-header<args><arg> {
        @result.push: get-rust-arg($_);
    }

    if $template-header<trailing-elipsis>:exists {
        @result.push: 'args: &[&str]';
    }

    @result
}

our sub augment-rtype($vectorized-rtype, $const, $ref, $ptr) {

    if $ref {

        return $const 
        ??  "&$vectorized-rtype" 
        !!  "&mut $vectorized-rtype";
    }

    if $ptr {

        return $const 
        ??  "*const $vectorized-rtype" 
        !!  "*mut $vectorized-rtype";
    }

    $vectorized-rtype

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

    my $ref   = $rt<ref>:exists;
    my $ptr   = $rt<ptr>:exists;
    my $ident = $rt<type><maybe-vectorized-identifier>;

    my TypeInfo $info = populate-typeinfo($ident);

    my $vectorized-rtype = $info.vectorized-rtype;

    if $augment {
        return augment-rtype(
            $vectorized-rtype, $const, $ref, $ptr);

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


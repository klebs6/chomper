sub is-unique($type)           { $type<unique-ptr>:exists }
sub is-c10-optional($type)     { $type<c10-optional>:exists }
sub is-list($type)             { $type<std-list>:exists }
sub is-shared($type)           { $type<shared-ptr>:exists }
sub is-generic-template($type) { $type<template-identifier>:exists }
sub is-set($type)              { $type<std-set>:exists }
sub is-deque($type)            { $type<std-deque>:exists }
sub is-bit-set($type)          { $type<bit-set>:exists }
sub is-unordered-set($type)    { $type<unordered-set>:exists }
sub is-unordered-map($type)    { $type<unordered-map>:exists }
sub is-pair($type)             { $type<std-pair>:exists }
sub is-tuple($type)            { $type<std-tuple>:exists }
sub is-vector($type)           { $type<std-vector>:exists }
sub is-atomic($type)           { $type<std-atomic>:exists }
sub is-queue($type)            { $type<std-queue>:exists }

my %mini-typemap = %(
    'unique-ptr'    => 'Box',
    'std-list'      => 'LinkedList',
    'std-set'       => 'HashSet',
    'std-pair'      => '( _x_ )',
    'std-tuple'     => '( _x_ )',
    'shared-ptr'    => 'Arc',
    'std-deque'     => 'VecDeque',
    'c10-optional'  => 'Option',
    'bit-set'       => 'BitSet',
    'unordered-set' => 'HashSet',
    'unordered-map' => 'HashMap',
    'std-vector'    => 'Vec',
    'std-atomic'    => 'Atomic',
    'std-queue'    => 'SegQueue',
);

sub extract-unique($type) {
    'unique-ptr',
    ($type<unique-ptr><type>)
}

sub extract-atomic($type) {
    'std-atomic',
    ($type<std-atomic><type>)
}

sub extract-queue($type) {
    'std-queue',
    ($type<std-queue><type>)
}

sub extract-list($type) {
    'std-list',
    ($type<std-list><type>)
}

sub extract-set($type) {
    'std-set',
    ($type<std-set><type>)
}

sub extract-pair($type) {
    'std-pair',
    |(
        $type<std-pair><type>[0],
        $type<std-pair><type>[1]
    )
}

sub extract-tuple($type) {
    my $len = $type<std-tuple><type>.elems;

    my @children = do for 0..$len {
        $type<std-tuple><type>[$_]
    };

    'std-tuple', |@children
}

sub extract-vector($type) {

    'std-vector', ( $type<std-vector><type> )
}

sub extract-generic-template($type) {
    my $template-parent = $type<template-identifier><identifier>.Str;

    my $len = $type<template-identifier><type>.elems;

    my @children = do for 0..($len - 1) {
        $type<template-identifier><type>[$_]
    };
    
    $template-parent, |@children
}

sub extract-shared($type) {
    'shared-ptr',
    ($type<shared-ptr><type>)
}

sub extract-deque($type) {
    'std-deque',
    ($type<std-deque><type>)
}

sub extract-c10-optional($type) {
    'c10-optional',
    ($type<c10-optional><type>)
}

sub extract-bit-set($type) {
    'bit-set',
    ($type<bit-set><type>)
}

sub extract-unordered-set($type) {
    'unordered-set',
    ($type<unordered-set><type>)
}

sub extract-unordered-map($type) {
    'unordered-map',
    |(
        $type<unordered-map><type>[0],
        $type<unordered-map><type>[1]
    )
}

sub extract-default($type) {
    $type.Str, |()
}

our class TypeInfo {

    has Str  $.cpp-parent     is required;
    has      @.cpp-children   is required;

    method vectorized-rtype {

        my $outer = 
        %mini-typemap{$!cpp-parent} // %*typemap{$!cpp-parent};

        my @inner;

        for @!cpp-children -> $type {
            if $type {
                my $child-type-info = populate-typeinfo($type);

                @inner.push: $child-type-info.vectorized-rtype();
            }
        }
        my $if-pair  = @inner.elems > 0 ?? "({@inner.join(',')})" !! "";
        my $if-other = @inner.elems > 0 ?? "{$outer}<{@inner.join(',')}>" !! $outer;

        my $base = is-pair-or-tuple($!cpp-parent) ?? $if-pair !! $if-other;

        $base
    }
}

sub is-pair-or-tuple($x) {
    my $pair  = $x ~~ 'std-pair';
    my $tuple = $x ~~ 'std-tuple';
    $pair or $tuple
}

our sub populate-typeinfo($type) {

    my $cpp-parent   = "";
    my @cpp-children = ();

    for [
        (is-vector($type),           &extract-vector),
        (is-unique($type),           &extract-unique),
        (is-list($type),             &extract-list),
        (is-set($type),              &extract-set),
        (is-pair($type),             &extract-pair),
        (is-tuple($type),            &extract-tuple),
        (is-shared($type),           &extract-shared),
        (is-deque($type),            &extract-deque),
        (is-c10-optional($type),     &extract-c10-optional),
        (is-bit-set($type),          &extract-bit-set),
        (is-unordered-set($type),    &extract-unordered-set),
        (is-generic-template($type), &extract-generic-template), 
        (is-atomic($type),           &extract-atomic), 
        (is-unordered-map($type),    &extract-unordered-map),
        (is-queue($type),            &extract-queue),
        (1,                          &extract-default),
    ] 
    -> ($gate, &sub) {
        if $gate {
            ($cpp-parent, @cpp-children) = &sub($type);
            last;
        }
    }

    TypeInfo.new(
        cpp-parent          => $cpp-parent,
        cpp-children        => @cpp-children,
    )
}

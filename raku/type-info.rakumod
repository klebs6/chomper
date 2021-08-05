use snake-case;
use indent-rust-named-type-list;

our class TypeAux {
    has Bool $.const    is required;
    has Bool $.ref      is required;
    has Int $.ptr       is required; #number of levels of ptrness
    has Bool $.volatile is required;
    has @.dim_stack     is required;
}

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
sub is-function($type)         { $type<std-function>:exists }

my %mini-typemap = %(
    'unique-ptr'    => 'Box',
    'unique_ptr'    => 'Box',
    'std-list'      => 'LinkedList',
    'std-set'       => 'HashSet',
    'std-pair'      => '( _x_ )',
    'std-tuple'     => '( _x_ )',
    'shared-ptr'    => 'Arc',
    'shared_ptr'    => 'Arc',
    'std-deque'     => 'VecDeque',
    'c10-optional'  => 'Option',
    'bit-set'       => 'BitSet',
    'unordered-set' => 'HashSet',
    'unordered_set' => 'HashSet',
    'unordered-map' => 'HashMap',
    'std-vector'    => 'Vec',
    'vector'        => 'Vec',
    'std-atomic'    => 'Atomic',
    'std-queue'     => 'SegQueue',
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

    my $len = $type<template-identifier><unnamed-arg>.elems;

    my @children = do for 0..($len - 1) {
        $type<template-identifier><unnamed-arg>[$_]
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

role TypeInfo {
    method vectorized-rtype() { ... }    
}

our class TemplateMemberAccessTypeInfo does TypeInfo {
    has Bool $.mutable     is required;
    has @.parent-templates is required;
    has $.child-typename   is required;

    method vectorized-rtype {
        my $result = "{@.parent-templates.join('::')}::{$.child-typename}";
        maybe-wrap-ref-cell($!mutable, $result)
    }
}

our class FunctionTypeInfo does TypeInfo {

    #these are match objects
    has Bool $.mutable             is required;
    has $.std-function-return-type is required;
    has $.std-function-args        is required;

    method vectorized-rtype {

        my $rust-return-type = do if $!std-function-return-type<void>:exists {
            "()"
        } else {
            populate-typeinfo($!std-function-return-type<type>).vectorized-rtype
        };

        my $count = 0;

        my $rust-args = do if $!std-function-args<void>:exists {
            ""
        } else {

            my $unnamed-count = 0;
            my $unnamed-prefix = "_u";

            my @rust-args = do for $!std-function-args<type-or-arg>.List {
                if $_<type>:exists {
                    my $rust-arg-name = "{$unnamed-prefix}{$unnamed-count}";
                    my $rust-arg-type = populate-typeinfo($_<type>).vectorized-rtype;
                    $unnamed-count += 1;
                    "$rust-arg-name: $rust-arg-type"
                } else {
                    get-rust-arg($_<arg>)
                }
            };

            $count = @rust-args.elems;

            indent-rust-named-type-list(@rust-args)
        };

        my $result = do if $count > 2 {
            "fn($rust-args
) -> $rust-return-type"
        } else {
            "fn($rust-args) -> $rust-return-type"
        };

        maybe-wrap-ref-cell($!mutable, $result)
    }
}

our class BasicTypeInfo does TypeInfo {

    has Bool $.mutable        is required;
    has Str  $.cpp-parent     is required;
    has      @.cpp-children   is required;

    method vectorized-rtype {

        my $outer = 
        %mini-typemap{$!cpp-parent} // %*typemap{$!cpp-parent};

        my @inner;

        for @!cpp-children -> $child {
            if $child {
                if $child<type>:exists {

                    my TypeInfo $info = populate-typeinfo($child<type>);
                    my TypeAux  $aux  = get-type-aux($child);
                    @inner.push: get-augmented-rust-type($info, $aux);

                } else {
                    my $child-type-info = populate-typeinfo($child);

                    @inner.push: $child-type-info.vectorized-rtype();
                }
            }
        }
        my $if-pair  = @inner.elems > 0 ?? "({@inner.join(',')})" !! "";
        my $if-other = @inner.elems > 0 ?? "{$outer}<{@inner.join(',')}>" !! $outer;

        my $base = is-pair-or-tuple($!cpp-parent) ?? $if-pair !! $if-other;

        maybe-wrap-ref-cell($!mutable, $base)
    }
}

sub is-pair-or-tuple($x) {
    my $pair  = $x ~~ 'std-pair';
    my $tuple = $x ~~ 'std-tuple';
    $pair or $tuple
}

our sub maybe-wrap-ref-cell($mutable, $result) {
    if $mutable {
        "RefCell<$result>"
    } else {
        $result
    }
}

our sub populate-typeinfo($type) {

    my $cpp-parent   = "";
    my @cpp-children = ();

    my Bool $mutable = $type<mutable>:exists;

    if $type<typename>:exists {
        return TemplateMemberAccessTypeInfo.new(
            mutable          => $mutable,
            parent-templates => $type<parent>.List,
            child-typename   => $type<child>.Str,
        );
    }

    if is-function($type) {

        my $func = $type<std-function>;

        return FunctionTypeInfo.new(
            mutable                  => $mutable,
            std-function-return-type => $func<std-function-return-type>,
            std-function-args        => $func<std-function-args>,
        );
    }

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

    BasicTypeInfo.new(
        mutable             => $mutable,
        cpp-parent          => $cpp-parent,
        cpp-children        => @cpp-children,
    )
}

our sub get-rust-type($cpp-type) {

    populate-typeinfo($cpp-type).vectorized-rtype 
}

our sub get-constness($arg) {
    ($arg<const> || $arg<const2>) !~~ Nil
}

our sub get-refness($arg) {
    $arg<ref>:exists and $arg<ref><double-ref>:!exists
}

our sub get-ptrness($arg) {
    $arg<ptr>.elems
}

our sub get-volatileness($arg) {
    $arg<volatile>:exists
}

our sub get-type-aux(Match $match, $compute_const = True) {

    my Bool $const  = $compute_const ??  get-constness($match) !! False;

    TypeAux.new(
        const     => $const,
        ref       => get-refness($match),
        ptr       => get-ptrness($match),
        volatile  => get-volatileness($match),
        dim_stack => get-dim-stack($match),
    )
}

our sub get-rust-arg-impl(
    $name, 
    TypeInfo $info, 
    TypeAux $aux) {

    my $vectorized-rtype = $info.vectorized-rtype;

    my $augmented = do if $aux.dim_stack.elems > 0 {
        get-rust-array-arg(
            $aux.const, 
            $aux.ref, 
            $aux.ptr, 
            $aux.volatile,
            $vectorized-rtype, 
            $aux.dim_stack)

    } else {

        augment-rtype(
            $vectorized-rtype, 
            $aux.const, 
            $aux.ref, 
            $aux.ptr,
            $aux.volatile
        )
    }

    "$name: $augmented"
}

our sub get-augmented-rust-type(
    TypeInfo $info, 
    TypeAux $aux) {

    my $vectorized-rtype = $info.vectorized-rtype;

    if $aux.dim_stack.elems > 0 {

        get-rust-array-arg(
            $aux.const, 
            $aux.ref, 
            $aux.ptr, 
            $aux.volatile,
            $vectorized-rtype, 
            $aux.dim_stack)

    } else {

        augment-rtype(
            $vectorized-rtype, 
            $aux.const, 
            $aux.ref, 
            $aux.ptr,
            $aux.volatile
        )
    }
}

our sub get-rust-arg($arg, $compute_const = True ) {

    my $name = snake-case($arg<name>.trim);

    my TypeInfo $info = populate-typeinfo($arg<type>);

    my TypeAux  $aux  = get-type-aux($arg, $compute_const);

    get-rust-arg-impl($name, $info, $aux)
}

our sub get-array-specifier($arg) {

    #this is a brutal, temporary hack and will not scale

    if $arg<struct-member-declaration-name>:exists {

        $arg<struct-member-declaration-name>.List[0]<array-specifier>

    } else {
        $arg<array-specifier>
    }
}

our sub get-dim-stack($arg) {

    my $arr = get-array-specifier($arg);

    my @dim_stack = [];

    if $arr {

        for $arr<array-dimension> {
            @dim_stack.push: $_.Str;
        }
    }

    @dim_stack
}

our sub get-rust-array-arg(
        $const, 
        $ref, 
        $ptr, 
        $volatile,
        $rtype, 
        @dim_stack) 
{
    my $arr-type = get-arr-type($rtype, @dim_stack);

    augment-rtype(
        $arr-type, 
        $const, 
        $ref, 
        $ptr,
        $volatile
    )
}

our sub augmented-rtype-from-qualified-cpp-type($qualified-type) {
    my $rust-type = get-rust-type($qualified-type<type>);
    my $const     = get-constness($qualified-type);
    my $ref       = get-refness($qualified-type);
    my $ptr       = get-ptrness($qualified-type);
    my $volatile  = get-volatileness($qualified-type);
    augment-rtype($rust-type, $const, $ref, $ptr, $volatile)
}

our sub augment-rtype($vectorized-rtype, $const, $ref, $ptr, $volatile) {

    my $result;

    if $ref {

        $result = $const 
        ??  "&$vectorized-rtype" 
        !!  "&mut $vectorized-rtype";

    } elsif $ptr {

        my $tag = $const 
        ??  "*const " x $ptr.Int
        !!  "*mut "   x $ptr.Int;

        $result = "{$tag.trim} $vectorized-rtype";

    } else {
        $result = $vectorized-rtype;
    }

    if $volatile {
        "Volatile<$result>"

    } else {
        "$result"
    }
}

our sub get-arr-type($rtype, @dim_stack) {

    my $builder = $rtype;

    for @dim_stack {
        $builder = "[{$builder}; {$_}]";
    }

    $builder
}


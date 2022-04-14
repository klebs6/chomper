use snake-case;
use indent-rust-named-type-list;

our class TypeAux {
    has Bool $.const    is required;
    has Bool $.ref      is required;
    has Bool $.ptr-ref  is required;
    has Int $.ptr       is required; #number of levels of ptrness
    has Bool $.volatile is required;
    has @.dim_stack     is required;

    method as-cast {
        augment-rtype-noarg(
            $!const, 
            $!ref, 
            $!ptr-ref, 
            $!ptr,
            $!volatile
        )
    }
}

our sub merge-type-aux(TypeAux $a1, TypeAux $a2) {

    #how should we do this? 
    #
    #this so far only happens in the case where we
    #have multiple struct members on a given
    #declaration line
    #
    #in this case, I use a1 as the *parent*

    TypeAux.new:
        const     => $a1.const    || $a2.const,
        ref       => $a1.ref      || $a2.ref,
        ptr-ref   => $a1.ptr-ref  || $a2.ptr-ref,
        ptr       => $a1.ptr + $a2.ptr,
        volatile  => $a1.volatile || $a2.volatile,
        dim_stack => $a2.dim_stack
}

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
sub is-std-function($type)     { $type<std-function>:exists }

my %mini-typemap = %(
    'std-list'      => 'LinkedList',
    'std-set'       => 'HashSet',
    'std-pair'      => '( _x_ )',
    'std-tuple'     => '( _x_ )',
    'tuple'         => '( _x_ )',
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

sub extract-default(Match:D $type) {

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

#-------------------------------------------------------[Function TypeInfo]
our sub vectorize-function-type(TypeInfo $self, Bool $mutable) {

    my $rust-return-type        = $self.get-return-type;

    my ($arg-count, $rust-args) = $self.get-rust-args;

    my $result = format-function-type-result(
        $rust-args, 
        $arg-count, 
        $rust-return-type
    );

    maybe-wrap-ref-cell($mutable, $result)
}

our sub get-function-type-return-type(Match $type) {
    if $type<void>:exists or $type.Str ~~ "void" {
        "()"
    } else {
        my TypeInfo $info = populate-typeinfo($type<type>);
        my TypeAux  $aux  = get-type-aux($type);
        get-augmented-rust-type($info, $aux)
    }
}

our sub is-standard-arg($arg) {
    $arg<function-ptr-type>:!exists
        and
    $arg<std-function>:!exists
}

our class ParenthesizedArgs {

    has @.maybe-unnamed-args;
    has Bool $.trailing-elipsis = False;

    multi submethod BUILD(
        :@!maybe-unnamed-args!,
        :$!trailing-elipsis!
    ) {
        #binding takes care of attribute
        #assignment
    }

    multi submethod BUILD(Match :$parenthesized-args!) {
        @!maybe-unnamed-args = $parenthesized-args<maybe-unnamed-args><maybe-unnamed-arg>.List;
        $!trailing-elipsis   = $parenthesized-args<trailing-elipsis>:exists;
    }

    method num-args {

        my $extra = $!trailing-elipsis ?? 1 !! 0;

        @!maybe-unnamed-args.elems + $extra
    }

    method type-for-arg-at-index($idx) {

        die "index $idx OOB, num-args: {self.num-args}" 
        if $idx >= self.num-args;

        my @args = self.get-rust-args;

        my $arg  = @args[$idx];

        my $split = $arg.index(":");

        $arg.substr($split + 1, *).trim
    }


    method get-option-defaults-initlist {

        my @defaults = [];

        my $idx = 0;

        for @!maybe-unnamed-args {

            if $_<arg>:exists {

                if is-standard-arg($_<arg>) {

                    my $name = snake-case($_<arg><name>.Str);
                    my $rtype = self.type-for-arg-at-index($idx);

                    if $_<arg><default-value>:exists {

                        my $default = $_<arg><default-value>.Str;

                        @defaults.push: 
                        "let $name: $rtype = {$name}.unwrap_or({$default});\n";
                    }
                }
            }

            $idx += 1;
        }

        @defaults.join("")
    }

    method get-maybe-unnamed-args {

        my $count  = 0;
        my $unnamed-prefix = "_";

        #is this a hack?
        if not @!maybe-unnamed-args[0] {
            return [];
        }

        sub unnamed($arg) {

            my $rust-arg-name = "{$unnamed-prefix}{$count}";

            my TypeInfo $info = populate-typeinfo($arg<type>);
            my TypeAux  $aux  = get-type-aux($arg);
            my $rust-arg-type = get-augmented-rust-type($info, $aux);

            $count += 1;
            "$rust-arg-name: $rust-arg-type"
        }

        do for @!maybe-unnamed-args.List {

            if $_<type>:exists {
                unnamed($_)

            } elsif $_<unnamed-arg>:exists {
                #this branch looks like a bug somewhere upstream
                unnamed($_<unnamed-arg>)

            } else {
                $count += 1;
                get-rust-arg($_<arg>)
            }
        }
    }

    method get-rust-args {

        my @result = self.get-maybe-unnamed-args;

        if $!trailing-elipsis {
            @result.push: 'args: &[&str]';
        }

        @result
    }
}


our sub get-rust-args-from-function-like(Bool $void-body, @args) {

    my $arg-count = 0;

    my $rust-args = do if $void-body {
        ""
    } else {

        #TODO: wtf is going on with construction
        my $p-args = ParenthesizedArgs.new(
            maybe-unnamed-args => @args,
            trailing-elipsis   =>  False,
        );

        my @rust-args = $p-args.get-rust-args;

        $arg-count = @rust-args.elems;

        indent-rust-named-type-list(@rust-args)
    };

    ($arg-count, $rust-args)
}

our sub get-rust-args-from-parenthesized(Bool $void-body, ParenthesizedArgs $args) {
    if $void-body or $args.num-args eq 0 {
        (0, "")
    } else {
        ($args.num-args, $args.get-rust-args())
    }
}

our class FunctionPtrTypeInfo does TypeInfo {

    has Bool $.mutable       is required;
    has $.return-type        is required;
    has ParenthesizedArgs $.parenthesized-args is required;

    method get-return-type {
        get-function-type-return-type($!return-type)
    }

    method get-rust-args {

        my $void-body = $!parenthesized-args<void>:exists;
        get-rust-args-from-parenthesized($void-body, $!parenthesized-args)
    }

    method vectorized-rtype {
        vectorize-function-type(self, $!mutable)
    }
}

our class FunctionTypeInfo does TypeInfo {

    #these are match objects
    has Bool $.mutable             is required;
    has $.std-function-return-type is required;
    has ParenthesizedArgs $.parenthesized-args       is required;

    method get-return-type {
        if $!std-function-return-type {

            get-function-type-return-type($!std-function-return-type)
        } else {
            "()"
        }
    }

    method get-rust-args {
        my $void-body = $!parenthesized-args<void>:exists;
        get-rust-args-from-parenthesized($void-body, $!parenthesized-args)
    }

    method vectorized-rtype {
        vectorize-function-type(self, $!mutable)
    }
}

our sub format-function-type-result($rust-args, Int $arg-count, $rust-return-type) {

    my $wm = get-watermark-from-rargs-list($rust-args.List);

    my $indented = indent-rust-named-type-list($rust-args.List).trim;

    if $arg-count > 2 {
        "fn(
        $indented
) -> $rust-return-type"
    } else {
        my $joined-args = $rust-args.List.join(", ");
        "fn($joined-args) -> $rust-return-type"
    }
}

our class BasicTypeInfo does TypeInfo {

    has Bool $.mutable        is required;
    has Str  $.cpp-parent     is required;
    has      @.cpp-children   is required;

    method vectorized-rtype {

        my $outer = 
        %mini-typemap{$!cpp-parent} // %*typemap{$!cpp-parent} ;

        my @inner;

        for @!cpp-children -> $child {

            if $child {

                #if $child<type>:exists {
                if not $child<type>.Str ~~ "" {

                    if $child<typename>:exists {

                        @inner.push: $child<type>.List.join("::");

                    } else {
                        my TypeInfo $info = populate-typeinfo($child<type>);
                        my TypeAux  $aux  = get-type-aux($child);

                        @inner.push: get-augmented-rust-type($info, $aux);

                    }

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

=begin comment
    if not $result {
        say Backtrace.new.Str;
    }
=end comment

    if $mutable {
        "RefCell<$result>"
    } else {

        $result
    }
}

our sub populate-typeinfo($type) {

    if not $type {
        say Backtrace.new.Str;
        die "populate-typeinfo called with invalid type";
    }

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

    if is-std-function($type) {

        my $func = $type<std-function>;

        my $parenthesized-args = $func<parenthesized-args>;

        return FunctionTypeInfo.new(
            mutable                  => $mutable,
            std-function-return-type => $func<std-function-return-type><return-type>,
            parenthesized-args       => ParenthesizedArgs.new(
                parenthesized-args => $func<parenthesized-args>
            ),
        );
    }

    if $type<function-ptr-type>:exists {

        my $func = $type<function-ptr-type>;

        return FunctionPtrTypeInfo.new(
            mutable            => $mutable,
            return-type        => $func<return-type>,
            parenthesized-args => ParenthesizedArgs.new(
                parenthesized-args => $func<parenthesized-args>
            ),
        );
    }

    if $type<return-type>:exists {

        #TODO: ensure this doesnt catch anything 
        #else unwanted
        
        my $func = $type; #function-sig-type

        return FunctionPtrTypeInfo.new(
            mutable            => $mutable,
            return-type        => $func<return-type>,
            parenthesized-args => ParenthesizedArgs.new(
                parenthesized-args => $func<parenthesized-args>
            ),
        );
    }

    for [
        (is-vector($type),           &extract-vector),
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

    if $mutable {
        $cpp-parent = $cpp-parent.subst("mutable ","");
    }

    BasicTypeInfo.new(
        mutable             => $mutable,
        cpp-parent          => $cpp-parent,
        cpp-children        => @cpp-children,
    )
}

our sub get-rust-type(Match:D $cpp-type) {
    populate-typeinfo($cpp-type).vectorized-rtype 
}

our sub get-constness($arg) {
    ($arg<const> || $arg<const2>) !~~ Nil
}

our sub get-refness($arg) {
    $arg<ref>:exists and $arg<ref><double-ref>:!exists
}

our sub get-ptr-refness($arg) {
    $arg<ptr-ref>:exists
}

our sub get-ptrness($arg) {
    #$arg<ptr>.elems
    $arg<ptr> ?? $arg<ptr>.elems !! 0
}

our sub get-volatileness($arg) {
    $arg<volatile>:exists
}

our sub get-type-aux-default( ) {

    TypeAux.new(
        const     => False,
        ref       => False,
        ptr       => 0,
        ptr-ref   => False,
        volatile  => False,
        dim_stack => [],
    )
}

our sub get-type-aux(Match $match, $compute_const = True) {

    my Bool $const  = $compute_const ??  get-constness($match) !! False;

    TypeAux.new(
        const     => $const,
        ref       => get-refness($match),
        ptr-ref   => get-ptr-refness($match),
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
            $aux.ptr-ref, 
            $aux.ptr, 
            $aux.volatile,
            $vectorized-rtype, 
            $aux.dim_stack)

    } else {

        augment-rtype(
            $vectorized-rtype, 
            $aux.const, 
            $aux.ref, 
            $aux.ptr-ref, 
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
            $aux.ptr-ref, 
            $aux.ptr, 
            $aux.volatile,
            $vectorized-rtype, 
            $aux.dim_stack)

    } else {

        augment-rtype(
            $vectorized-rtype, 
            $aux.const, 
            $aux.ref, 
            $aux.ptr-ref, 
            $aux.ptr,
            $aux.volatile
        )
    }
}

our sub get-rust-function-ptr-arg($arg, $compute_const = True ) {

    my $f-ptr = $arg<function-ptr-type>;

    my $name = snake-case($f-ptr<name>.trim);

    my TypeInfo $info = populate-typeinfo($arg);

    my TypeAux  $aux  = get-type-aux-default();

    get-rust-arg-impl($name, $info, $aux)
}

our sub get-rust-std-function-arg($arg, $compute_const = True ) {

    my $name = snake-case($arg<name>.trim);

    my TypeInfo $info = populate-typeinfo($arg);

    my TypeAux  $aux  = get-type-aux-default();

    get-rust-arg-impl($name, $info, $aux)
}

our sub get-rust-arg($arg, $compute_const = True ) {

    if not $arg {
        say Backtrace.new.Str;
        say "get-rust-arg called with invalid arg";
    }

    if $arg<function-ptr-type>:exists {
        return get-rust-function-ptr-arg($arg, $compute_const);
    } 

    if $arg<std-function>:exists {
        return get-rust-std-function-arg($arg, $compute_const);
    } 

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

our class JustASlice { }

our sub get-dim-stack($arg) {

    my $arr = get-array-specifier($arg);

    my @dim_stack = [];

    if $arr {

        if $arr<empty-array-specifier>:exists {

            @dim_stack.push: JustASlice.new;

        } else {

            for $arr<array-dimension> {
                @dim_stack.push: $_.Str;
            }
        }
    }

    @dim_stack
}

#this function has been modified
#and needs to be checked
our sub get-rust-array-arg(
        $const, 
        $ref, 
        $ptr-ref,
        $ptr, 
        $volatile,
        $rtype, 
        @dim_stack) 
{
    #my $arr-type = get-arr-type($rtype, @dim_stack);

    my $builder   = $rtype;

    my $augmented = False;

    if $ptr {

        $builder = augment-rtype(
            $builder, 
            $const, 
            $ref, 
            $ptr-ref,
            $ptr,
            $volatile
        );
        $augmented = True;
    }

    if @dim_stack[0] ~~ JustASlice {

        $builder = "&\[{$builder}\]";

    } else {

        for @dim_stack {
            $builder = "[{$builder}; {$_}]";
        }
    }

    my $arr-type = $builder;

    if not $augmented {
        augment-rtype(
            $arr-type, 
            $const, 
            $ref, 
            $ptr-ref,
            $ptr,
            $volatile
        )
    } else {
        $builder
    }
}

our sub augmented-rtype-from-qualified-cpp-type($qualified-type) {

    my $rust-type = get-rust-type($qualified-type<type>);
    my $const     = get-constness($qualified-type);
    my $ref       = get-refness($qualified-type);
    my $ptr-ref   = get-ptr-refness($qualified-type);
    my $ptr       = get-ptrness($qualified-type);
    my $volatile  = get-volatileness($qualified-type);
    augment-rtype($rust-type, $const, $ref, $ptr-ref, $ptr, $volatile)
}

our sub augment-rtype(
    $vectorized-rtype, 
    $const, 
    $ref, 
    $ptr-ref, 
    $ptr, 
    $volatile) {

    my $result;

    if $ref {

        $result = $const 
        ??  "&$vectorized-rtype" 
        !!  "&mut $vectorized-rtype";

    } elsif $ptr {

        my $tag = $const 
        ??  "*const " x $ptr.Int
        !!  "*mut "   x $ptr.Int;

        if $ptr-ref {
            $tag = "&mut $tag";
        }

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

our sub augment-rtype-noarg(
    $const, 
    $ref, 
    $ptr-ref, 
    $ptr, 
    $volatile) {

    my $result;

    if $ref {

        $result = $const 
        ??  "&" 
        !!  "&mut ";

    } elsif $ptr {

        my $tag = $const 
        ??  "*const " x $ptr.Int
        !!  "*mut "   x $ptr.Int;

        if $ptr-ref {
            $tag = "&mut $tag";
        }

        $result = "{$tag.trim} ";

    } else {
        $result = "";
    }

    if $volatile {
        "Volatile<$result>"

    } else {
        "$result"
    }
}

our sub get-arr-type($rtype, @dim_stack) {

    my $builder = $rtype;

    if @dim_stack[0] ~~ JustASlice {

        $builder = "&\[{$builder}\]";

    } else {

        for @dim_stack {
            $builder = "[{$builder}; {$_}]";
        }
    }

    $builder
}

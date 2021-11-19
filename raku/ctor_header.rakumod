use util;
use locations;
use case;
use typemap;
use type-info;
use snake-case;
use hungarian;

#use Grammar::Tracer;

#config
my Bool $strip-hungarian                      = current-project-needs-strip-hungarian();
my Bool $store-properly-formatted-struct-name = True;
my Bool $map-hungarian-to-non                 = True;
my Bool $translate-base-type                  = True;

#usually want this to be false
my Bool $add-mod              = False;

our sub get-generic-type($submatch, :$write-default ) {

    my $type = $submatch<type>.Str;

    my $h = HungarianStruct.parse($type);

    if $h && $strip-hungarian {

        my $non-hungarian = $h<hungarian-ident><camel-case-ident>.Str;

        if $map-hungarian-to-non {
            text-typemap($type, $non-hungarian);
        }

        if $store-properly-formatted-struct-name {
            whitelist($non-hungarian);
        }

        $type     = $non-hungarian;
    }

    if $translate-base-type {
        if not is-camel-case($type) {
            $type = populate-typeinfo($type).vectorized-rtype;
        } else {
            whitelist($type);
        }
    }

    if $submatch<template-prefix>:exists {
        my $rtemplate-args 
        = get-rtemplate-args-list(
            $submatch<template-prefix>, 
            :$write-default
        );
        $type = $type ~ '<' ~ $rtemplate-args.join(",") ~ '>';
    }
    $type
}

our sub translate-ctor-header( $submatch, $body, $rclass) 
{
    my $maybe-generic-type = 
    get-generic-type($submatch, write-default => True );

    my $maybe-generic-type-nodefault = 
    get-generic-type($submatch, write-default => False );

    my $directive  = $submatch<use-operator-context-functions> // "";
    my $directive2 = $submatch<use-dispatch-helper> // "";

    if $directive  { $directive = "//{$directive.Str}"; }
    if $directive2 { $directive2 = "//{$directive2.Str}"; }

    my @bases;

    if $submatch<class-inheritance>:exists {
        my $idx = 1;
        for $submatch<class-inheritance><type>.List {
            my $rtype = populate-typeinfo($_).vectorized-rtype;
            @bases.push: "base{$idx gt 1 ?? $idx !! ''}: {$rtype.Str}," ;
            $idx += 1;
        }
    }

    my $struct-body = qq:to/END/.chomp.trim;
    $directive
    $directive2
    {@bases.join("\n")}
    END

    if $add-mod {

        qq:to/END/
        pub struct $maybe-generic-type \{
        {$struct-body.indent(4)}
        \}
        pub mod {snake-case($maybe-generic-type)} \{

        \}
        impl $maybe-generic-type-nodefault \{

        \}
        END
    } else {
        qq:to/END/
        pub struct $maybe-generic-type \{
        {$struct-body.indent(4)}
        \}
        impl $maybe-generic-type-nodefault \{

        \}
        END
    }
}

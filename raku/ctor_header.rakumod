use util;
use typemap;
use type-info;

our sub translate-ctor-header( $submatch, $body, $rclass) 
{
    my $maybe-generic-type = do {
        my $type = $submatch<type>.Str;
        if $submatch<template-prefix>:exists {
            my $rtemplate-args = get-rtemplate-args-list($submatch<template-prefix>);
            $type = $type ~ '<' ~ $rtemplate-args.join(",") ~ '>';
        }
        $type
    };

    my $directive  = $submatch<use-operator-context-functions> // "";
    my $directive2 = $submatch<use-dispatch-helper> // "";

    if $directive  { $directive = "//{$directive.Str}"; }
    if $directive2 { $directive2 = "//{$directive2.Str}"; }

    my @bases;

    if $submatch<class-inheritance>:exists {
        my $idx = 0;
        for $submatch<class-inheritance><type>.List {
            my $rtype = populate-typeinfo($_).vectorized-rtype;
            @bases.push: "base{$idx}: {$rtype.Str}," ;
            $idx += 1;
        }
    }

    my $struct-body = qq:to/END/.chomp.trim;
    $directive
    $directive2
    {@bases.join("\n")}
    END

    qq:to/END/
    pub struct $maybe-generic-type \{
    {$struct-body.indent(4)}
    \}
    impl $maybe-generic-type \{

    \}
    END

}


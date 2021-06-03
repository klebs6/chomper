use util;
use typemap;

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

    my $base-member = $submatch<class-inheritance>:exists ?? 
    "base: {$submatch<class-inheritance><type>.Str}," !! "";

    my $struct-body = qq:to/END/.chomp.trim;
    $directive
    $directive2
    $base-member
    END

    qq:to/END/
    pub struct $maybe-generic-type \{
        $struct-body
    \}
    impl $maybe-generic-type \{

    \}
    END

}


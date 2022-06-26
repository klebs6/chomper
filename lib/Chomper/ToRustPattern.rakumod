use Chomper::Cpp;
use Chomper::Rust;
use Chomper::SnakeCase;
use Chomper::ToRust;
use Chomper::ToRustIdent;
use Chomper::TranslateIo;

use Data::Dump::Tree;

proto sub to-rust-pattern($x, Bool :$is-ref, Bool :$is-mutable) is export { * }

multi sub to-rust-pattern(
    $x where Cpp::Identifier, 
    Bool :$is-ref, 
    Bool :$is-mutable) 
{
    Rust::Pattern.new(
        pattern-no-top-alts => [
            Rust::IdentifierPattern.new(
                ref              => $is-ref,
                mutable          => $is-mutable,
                identifier       => to-rust-ident($x, snake-case => True),
                maybe-at-pattern => Nil,
            )
        ]
    )
}

multi sub to-rust-pattern(
    $x where Cpp::StructuredBindingBody, 
    Bool :$is-ref, 
    Bool :$is-mutable) 
{
    debug "to-rust-pattern for StructuredBindingBody";
    debug "will ignore is-ref and is-mutable because we can determine from x";

    my Bool $calc-is-ref = $x.refqualifier ~~ Cpp::RefQualifier::And;
    my Bool $calc-is-mutable = $x.is-mutable();

    Rust::Pattern.new(
        pattern-no-top-alts => [
            Rust::IdentifierPattern.new(
                ref              => $calc-is-ref,
                mutable          => $calc-is-mutable,
                identifier       => to-rust-ident($x, snake-case => True),
                maybe-at-pattern => Nil,
            )
        ]
    )
}

multi sub to-rust-pattern($x, Bool :$is-ref, Bool :$is-mutable) {
    die "need implement for {$x.WHAT}"
}

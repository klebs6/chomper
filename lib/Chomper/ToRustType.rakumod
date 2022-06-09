use Chomper::Cpp;
use Chomper::Rust;
use Chomper::ToRustIdent;
use Chomper::IsConst;
use Chomper::TranslateIo;
use Data::Dump::Tree;

proto sub to-rust-type($x) is export { * }

sub to-rust-generic-args($x where Cpp::TemplateArgumentList) {

    my @args = do for $x.template-arguments {
        to-rust-type($_)
    };

    Rust::GenericArgs.new(
        args => @args,
    )
}

multi sub to-rust-type($x where Cpp::SimpleTemplateId) {  

    my Rust::Identifier $template-name = to-rust-type($x.template-name);

    my $rust-generic-args = to-rust-generic-args($x.template-arguments);

    Rust::TypePath.new(
        type-path-segments => [
            Rust::TypePathSegment.new(
                path-ident-segment => $template-name,
                maybe-type-path-segment-suffix => Rust::TypePathSegmentSuffixGeneric.new(
                    generic-args => $rust-generic-args,
                ),
            )
        ]
    )
}

multi sub to-rust-type($x where Cpp::SimpleIntTypeSpecifier) {  

    my Bool $unsigned 
    = $x.simple-type-signedness-modifier ~~ Cpp::SimpleTypeSignednessModifier::Unsigned;

    my $value = $unsigned ?? "u32" !! "i32";

    Rust::TypePath.new(
        type-path-segments => [
            Rust::TypePathSegment.new(
                path-ident-segment => Rust::Identifier.new(
                    value => $value,
                )
            )
        ]
    )
}

multi sub to-rust-type($x where Cpp::SimpleDoubleTypeSpecifier) {  

    Rust::TypePath.new(
        type-path-segments => [
            Rust::TypePathSegment.new(
                path-ident-segment => Rust::Identifier.new(
                    value => "f64",
                )
            )
        ]
    )
}

multi sub to-rust-type($x where Cpp::SimpleCharTypeSpecifier) {  

    my Bool $unsigned 
    = $x.simple-type-signedness-modifier ~~ Cpp::SimpleTypeSignednessModifier::Unsigned;

    my $value = $unsigned ?? "u8" !! "i8";

    Rust::TypePath.new(
        type-path-segments => [
            Rust::TypePathSegment.new(
                path-ident-segment => Rust::Identifier.new(
                    value => $value,
                )
            )
        ]
    )
}

multi sub to-rust-type($x where Cpp::TheTypeId) {  

    my $base = to-rust-type($x.type-specifier-seq);

    if $x.abstract-declarator {

        Rust::RawPtrType.new(
            mutable        => not is-const-type($x.type-specifier-seq),
            type-no-bounds => $base,
        )

    } else {

        $base
    }
}

multi sub to-rust-type($x where Cpp::Identifier) {

    my $val = to-rust-ident($x, snake-case => False).value;

    if not %*typemap{$val}:exists {
        die "$val dne in typemap!";
    }

    Rust::Identifier.new(
        value => %*typemap{$val}
    )
}

multi sub to-rust-type($x where Cpp::TypeSpecifier) {  
    to-rust-type($x.value)
}

multi sub to-rust-type($x where Cpp::SimpleTypeSpecifier::Auto_) {  
    Nil
}

multi sub to-rust-type($x where Cpp::DeclSpecifierSeq) {  
    to-rust-type($x.decl-specifiers);
}

multi sub to-rust-type(Positional $x) {  

    my $name = $x.List>>.gist.join(" ");

    Rust::Identifier.new(
        value => %*typemap{$name}
    )
}

multi sub to-rust-type($x where Cpp::SimpleTypeSpecifier::Bool_) {  
    Rust::Identifier.new(
        value => "bool"
    )
}

multi sub to-rust-type($x where Cpp::TrailingTypeSpecifier::CvQualifier) {  

    #in rust, the CvQualifier is not part of the
    #type

    to-rust-type($x.simple-type-specifier)
}

multi sub to-rust-type($x where Cpp::FullTypeName) {  
 
    my $nns = $x.nested-name-specifier;

    #TODO:
    #should we drop the nested name specifier?
    #
    #no. this is broken. we need it. consider
    #vector<char>::iterator

    to-rust-type($x.the-type-name)
}

multi sub to-rust-type($x) {  
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT.^name;
}

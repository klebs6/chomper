use wrap-body-todo;
use remove-double-newlines;
use indent-rust-named-type-list;
use snake-case;
use python3-suite;
use python3-prelude;
use python3-lambdef;
use python3-expr;

our sub format-type-list(@list) {
    if @list.elems gt 0 {
        my $text = indent-rust-named-type-list(@list);
        $text.split("\n")>>.trim.join("\n")
    } 
}

our sub convert-type-to-rust($type) {

    my %typemap = %(
        float    => "f32",
        ndarray  => "NdArray",
        dict     => "PyDict",
        int      => "i32",
        sequence => "Sequence",
    );

    %typemap{$type} // $type
}

our sub get-function-prefix(:$private, :$is-test) {
    if $is-test {
        "#[test] "
    } else {
        $private ?? "" !! "pub "
    }
}

our sub create-rust-function(
    Str   :$comment,
    Bool  :$private,
    Bool  :$is-test,
    Str   :$name,
    Str   :$return-value,
    Str   :$rust-args,
          :@rust-attrs,
          :$optional-initializers,
    Str   :$body) {

    my $maybe-return-value = $return-value ?? "-> {$return-value} " !! "";
    my $prefix = get-function-prefix(:$private, :$is-test);

    my $args = do if $rust-args eq "&mut self" && $is-test {
        ""
    } else {
        $rust-args
    };

    my $attrs = @rust-attrs.elems ?? @rust-attrs.join("\n") ~ "\n" !! "";
    my $text = qq:to/END/;

    {$comment}
    {$attrs}{$prefix}fn {$name}($args) {$maybe-return-value}\{
        {$optional-initializers}
        {wrap-body-todo($body)}
    \}
    END

    remove-double-newlines($text)
}

our sub create-rust-struct-def(
    :$comment,
    :$struct-name,
    :@struct-args) {
    if @struct-args.elems {
        qq:to/END/
        {$comment ?? $comment !! "" }
        pub struct $struct-name \{
        {format-type-list(@struct-args).indent(4)}
        \}
        END
    } else {
        qq:to/END/
        {$comment ?? $comment !! "" }
        pub struct $struct-name \{ \}
        END
    }
}

#------------------------------
our sub format-static-members-for-module(@static-members) {
    @static-members>>.gist.join("\n")
}

our sub format-misc-class-stmts-for-module(@misc-class-stmts) {
    @misc-class-stmts>>.gist.join("\n")
}

our sub create-rust-module(
    :$comment,
    :$struct-name,
    :@test-scaffolds,
    :@misc-class-stmts,
    :@static-members,
    :$solo-test-module,
    ) {

    qq:to/END/
    {$comment ?? $comment !! "" }
    {$solo-test-module ?? "#[cfg(test)]" !! ""}
    pub mod {snake-case($struct-name)} \{
    {format-static-members-for-module(@static-members).indent(4)}
    {format-misc-class-stmts-for-module(@misc-class-stmts).indent(4)}
    {@test-scaffolds.join("\n").indent(4)}
    \}
    END
} 

our sub create-rust-impl-block(
    :$struct-name,
    :@impls
    ) {
    qq:to/END/
    impl $struct-name \{

    {@impls.join("\n").indent(4)}
    \}
    END
}

our sub create-rust-special($struct-name, $stmt) {
    $stmt
}

our sub create-rust-specials(
    :$struct-name,
    :@stmts
    ) {
    do for @stmts {
        create-rust-special($struct-name,$_)
    }.join("\n")
}

our sub pymodel-to-rust-type($x) {
    given $x {
        when Python3::Name      { "PyObj" }
        when Python3::Strings   { "String" }
        when Python3::False     { "bool" }
        when Python3::True      { "bool" }
        when Python3::Float     { "f32" }
        when Python3::Imaginary { "Complex" }
        when Python3::None      { "PyObj" }
        when Python3::Integer   { "i32" }
        when Python3::OrExpr    { pymodel-to-rust-type($_.operands[0]) }
        default                 { "PyObj" }
    }
}

our sub lambda-to-rust-type(Python3::Lambdef $x) {
    #TODO likely a better way to do this
    "Lambda"
}

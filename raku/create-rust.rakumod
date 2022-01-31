use wrap-body-todo;
use indent-rust-named-type-list;
use snake-case;

our sub format-type-list(@list) {
    if @list.elems gt 0 {
        my $text = indent-rust-named-type-list(@list);
        $text.split("\n")>>.trim.join("\n")
    } 
}

our sub convert-type-to-rust($type) {

    my %typemap = %(
        float   => "f32",
        ndarray => "NdArray",
        dict    => "PyDict",
    );

    %typemap{$type} // $type
}

our sub create-rust-function(
    Str :$comment,
    Bool :$private,
    Bool :$python,
    Str  :$name,
    Str  :$return-value,
    Str  :$rust-args,
    :$optional-initializers,
    Str  :$body) {

    my $maybe-return-value = $return-value ?? "-> {$return-value} " !! "";

    qq:to/END/

    {$comment}
    {$private ?? "" !! "pub"} fn {$name}($rust-args) {$maybe-return-value}\{
        {$optional-initializers}
        {wrap-body-todo($body, :$python)}
    \}
    END
}

our sub create-rust-struct-def(
    :$comment,
    :$struct-name,
    :@struct-args) {
    if @struct-args.elems {
        qq:to/END/
        $comment
        pub struct $struct-name \{
        {format-type-list(@struct-args).indent(4)}
        \}
        END
    } else {
        qq:to/END/
        $comment
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

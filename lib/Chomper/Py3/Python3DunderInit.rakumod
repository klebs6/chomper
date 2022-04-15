use Chomper::Py3::Python3Dunder;
use Chomper::Py3::Python3Suite;
use Chomper::Py3::Python3Comment;
use Chomper::WrapBodyTodo;

our class Python3::DunderFunc::Init does Python3::IDunderFunc {

    method translate-as-default-fn($cls-name) {

        qq:to/END/
        {$.rust-comment // ""}
        impl Default for {$cls-name} \{

            fn default() -> Self \{
                {wrap-body-todo($.suite.text)}
            \}
        \}

        END
    }

    method translate-as-from-fn(
        $cls-name, 
        Python3::AugmentedTfpdef $src) 
    {
        my ($src-name, $src-type) = $src.tfpdef.as-rust-name-type(
            default => $src.default 
        );

        my $args = $.parameters.convert-to-rust(
            no-self => True, 
            typemap => $.param-typemap
        );

        if $.param-typemap{$src-name}:exists {
            $src-type = $.param-typemap{$src-name};
        }

        qq:to/END/
        {$.rust-comment}
        impl From<$src-type> for {$cls-name} \{

            fn from($args) -> Self \{

        {$.optional-initializers.indent(8)}

                {wrap-body-todo($.suite.text)}
            \}
        \}

        END
    }

    method translate-as-standard-new-fn($cls-name, $parameters) {

        my $args = $parameters.convert-to-rust(
            no-self => True, 
            typemap => $.param-typemap
        );

        qq:to/END/
        {$.rust-comment}
        impl {$cls-name} \{

            fn new({$args}) -> Self \{

        {$.optional-initializers.indent(8)}

                {wrap-body-todo($.suite.text)}
            \}
        \}

        END
    }

    method translate-dunder-init($cls-name) {

        die if not $.parameters.is-first-parameter-self();

        my $nargs = $.parameters.count();

        given $nargs {
            when 1 {
                self.translate-as-default-fn($cls-name)
            }
            when 2 {
                my $src = $.parameters.basic-args[1];
                self.translate-as-from-fn($cls-name, $src)
            }
            when 3..* {
                self.translate-as-standard-new-fn($cls-name,$.parameters)
            }
        }
    }

    method translate-special-function-to-rust($cls-name) {  
        self.translate-dunder-init($cls-name)
    }
}

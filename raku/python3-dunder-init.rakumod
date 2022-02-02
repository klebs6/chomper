use python3-dunder;
use wrap-body-todo;

our class Python3::DunderFunc::Init does Python3::IDunderFunc {

    method translate-as-default-fn($cls-name) {
        qq:to/END/
        impl Default for {$cls-name} \{

            fn default() -> Self \{
                {wrap-body-todo($.suite.text, python => True)}
            \}
        \}

        END
    }

    method translate-as-from-fn(
        $cls-name, 
        Python3::AugmentedTfpdef $src,
        $optional-initializers) 
    {
        my ($src-name, $src-type) = $src.tfpdef.as-rust-name-type(
            default => $src.default 
        );

        qq:to/END/
        impl From<$src-type> for {$cls-name} \{

            fn from({$src-name}: $src-type) -> Self \{
                $optional-initializers
                {wrap-body-todo($.suite.text, python => True)}
            \}
        \}

        END
    }

    method translate-as-standard-new-fn($cls-name, $parameters) {

        my $optional-initializers = $parameters.optional-initializers();
        my $args                  = $parameters.convert-to-rust(no-self => True);

        qq:to/END/
        impl {$cls-name} \{

            fn new({$args}) -> Self \{
                $optional-initializers
                {wrap-body-todo($.suite.text, python => True)}
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
                my $optional-initializers = $.parameters.optional-initializers();
                self.translate-as-from-fn($cls-name, $src, $optional-initializers)
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


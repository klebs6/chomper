use Chomper::ToRust;
use Chomper::TranslateIo;
use Chomper::Cpp;
use Chomper::Rust;

our sub to-rust-block-expression($statements) {

    my @statements = $statements.List;

    my $block-expression = do if @statements.elems eq 1 and @statements[0] ~~ Cpp::CompoundStatement {

        to-rust(@statements[0])

    } else {
        Rust::BlockExpression.new(
            statements => Rust::Statements.new(
                statements => @statements>>.&to-rust,
            )
        )
    };

    $block-expression
}

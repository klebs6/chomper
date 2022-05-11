use Chomper::TranslateIo;
use Chomper::ToRust;
use Chomper::ToRustPathExprSegment;
use Chomper::Cpp;
use Chomper::Rust;

use Data::Dump::Tree;

proto sub to-rust-match-arm-item($item) is export { * }

multi sub to-rust-match-arm-item(
    $item where Cpp::LabeledStatement)
{
    my $label = $item.labeled-statement-label;
    my $body  = $label.labeled-statement-label-body;

    my Bool $default-expr = $body ~~ Cpp::LabeledStatementLabelBody::Default_;

    my $case-expr = do if $default-expr {

        Rust::PathExprSegment.new(
            path-ident-segment => Rust::Identifier.new(
                value => "_",
            )
        )

    } else {

        my $cpp = $item
        .labeled-statement-label
        .labeled-statement-label-body
        .constant-expression;

        to-rust-path-expr-segment($cpp)
    };


    my $match-arm = Rust::MatchArm.new(
        pattern => Rust::Pattern.new(
            pattern-no-top-alts => [
                $case-expr
            ]
        )
    );

    my @statements = $item.statement.List>>.&to-rust;

    my $expression-with-block 
    = Rust::BlockExpression.new(
        statements => Rust::Statements.new(
            statements => @statements,
        )
    );

    Rust::MatchArmsInnerItemWithBlock.new(
        :$match-arm,
        :$expression-with-block,
    )
}

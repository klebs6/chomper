use Chomper::TranslateIo;
use Chomper::ToRust;
use Chomper::ToRustPathExprSegment;
use Chomper::Cpp;
use Chomper::Rust;

use Data::Dump::Tree;

our sub rust-match-catchall-arm(@statements) {

    Rust::MatchArmsOuterItem.new(
        match-arm => Rust::MatchArm.new(
            pattern => Rust::Pattern.new(
                pattern-no-top-alts => [
                    Rust::PathInExpression.new(
                        path-expr-segments => [
                            Rust::PathExprSegment.new(
                                path-ident-segment => Rust::Identifier.new(
                                    value => "_",
                                )
                            )
                        ]
                    )
                ]
            )
        ),
        expression => Rust::BlockExpression.new(
            statements => Rust::Statements.new(
                statements => @statements,
            )
        )
    )
}

proto sub to-rust-match-arm-item($item) is export { * }

multi sub to-rust-match-arm-item(
    $item where Cpp::LabeledStatement)
{
    my $case-expr 
    = $item.labeled-statement-label.labeled-statement-label-body.constant-expression;

    my $match-arm = Rust::MatchArm.new(
        pattern => Rust::Pattern.new(
            pattern-no-top-alts => [
                to-rust-path-expr-segment($case-expr)
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

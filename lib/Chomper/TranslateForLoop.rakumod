use Data::Dump::Tree;
use Chomper::ToRustIdent;
use Chomper::ToRustParams;
use Chomper::ToRust;
use Chomper::ToRustType;
use Chomper::SnakeCase;
use Chomper::Cpp;
use Chomper::Rust;

proto sub translate-for-loop(
    $item where Cpp::IterationStatement::For, 
    Positional $token-types) 
is export { * }

multi sub translate-for-loop(
    $item, 
    Positional $token-types) 
{ 
    say "need write translate-for-loop for 
    token-types: {$item.token-types()}";
    ddt $item;
    exit;
}

multi sub translate-for-loop(
    $item, 
    [
        'BasicDeclaration',
        'RelationalExpression',
        'PostfixExpression',
    ]) 
{ 
    translate-for-loop(
        $item, 
        [
            'BasicDeclaration',
            'RelationalExpression',
            'UnaryExpressionCase::PlusPlus',
        ])
}

multi sub translate-for-loop(
    $item, 
    [
        'BasicDeclaration',
        'RelationalExpression',
        'UnaryExpressionCase::PlusPlus',
    ]) 
{ 
    say "translate-for-loop for 
    token-types: {$item.token-types()}";

    #I want to know what our loop variable is
    #called, and what its bounds are
    my Cpp::BasicDeclaration              $basic-declaration = $item.for-init-statement;
    my Cpp::RelationalExpression          $relational-expr   = $item.condition;

    my  $increment-expr = $item.expression;

    my $loop-ident      = to-rust-ident($basic-declaration.init-declarator-list[0].declarator, snake-case => True);

    #do we even need this check?
    if $basic-declaration.decl-specifier-seq {
        my $loop-ident-type = to-rust-type($basic-declaration.decl-specifier-seq.value);

        die if not $loop-ident-type.gist (elem) ["i32","usize"];
    }

    my $min-bound = to-rust($basic-declaration.init-declarator-list[0].initializer.brace-or-equal-initializer.initializer-clause); #TODO
    my $max-bound = to-rust($relational-expr.relational-expression-tail[0].shift-expression); #TODO

    my $operator = $relational-expr.relational-expression-tail[0].relational-operator;

    my $t = do given $operator {
        when Cpp::RelationalOperator::Less {
            Rust::RangeExpressionFull.new
        }
        when Cpp::RelationalOperator::LessEq {
            Rust::RangeExpressionFullEq.new
        }
        default {
            die "bug!";
        }
    };

    $t.binary-oror-expressions = [
        Rust::SuffixedExpression.new(
            base-expression => Rust::BaseExpression.new(
                expression-item => $min-bound,
            )
        ),
        Rust::SuffixedExpression.new(
            base-expression => Rust::BaseExpression.new(
                expression-item => $max-bound,
            )
        ),
    ];

    my @statements = $item.statements>>.&to-rust;

    Rust::LoopExpressionIterator.new(
        maybe-loop-label => Nil,
        pattern => Rust::Pattern.new(
            pattern-no-top-alts => [
                Rust::IdentifierPattern.new(
                    ref        => False,
                    mutable    => False,
                    identifier => $loop-ident,
                )
            ],
        ),
        expression-nostruct => $t,
        block-expression => Rust::BlockExpression.new(
            statements => Rust::Statements.new(
                statements => @statements,
            )
        )
    )
}

multi sub translate-for-loop(
    $item, 
    [
        'BasicDeclaration',
        'LogicalAndExpression',
        'Expression',
    ]) 
{ 
    my @statements = $item.statements>>.&to-rust;

    my @loop-continue = $item.expression.assignment-expressions>>.&to-rust;

    my $for-init-stmt = to-rust($item.for-init-statement);

    Rust::Statements.new(
        statements => [
            $for-init-stmt,
            Rust::LoopExpressionPredicate.new(
                maybe-loop-label => Nil,
                expression-nostruct => to-rust($item.condition),
                block-expression => Rust::BlockExpression.new(
                    statements => Rust::Statements.new(
                        statements => [
                            |@statements,
                            |@loop-continue
                        ],
                    )
                )
            )
        ]
    )
}

use Chomper::TranslateIo;
use Chomper::Cpp;
use Chomper::Rust;
use Chomper::ToRust;
use Chomper::ToRustIdent;
use Chomper::ToRustType;
use Chomper::ToRustParams;
use Chomper::TranslateCondition;
use Chomper::TranslateNoPointerDeclarator;
use Chomper::TranslateConditionalExpression;
use Chomper::TranslateAdditiveExpression;
use Chomper::TranslateMultiplicativeExpression;

use Data::Dump::Tree;

our sub translate-cpp-ir-to-rust($typename, $item where Cpp::IStatement)
{
    my $rust = do given $item.name {
        when "TryBlock"                     { to-rust($item) }
        when "ExpressionStatement"          { to-rust($item) }
        when "CompoundStatement"            { to-rust($item) }
        when "Statement::Declaration"       { to-rust($item) }
        when "JumpStatement::Return"        { to-rust($item) }
        when "JumpStatement::Continue"      { to-rust($item) }
        when "IterationStatement::ForRange" { to-rust($item) }
        when "IterationStatement::While"    { to-rust($item) }
        when "IterationStatement::For"      { to-rust($item) }
        when "IterationStatement::Do"       { to-rust($item) }
        when "BasicDeclaration"             { to-rust($item) }
        when "SelectionStatement::If"       { to-rust($item) }
        default {
            die "need to add {$item.name} to translate-cpp-ir-to-rust";
        }
    };

    $rust.gist
}

multi sub to-rust(
    $item where Cpp::Statement::Declaration)
{
    debug "will translate Statement::Declaration to Rust!";
    my $comment = to-rust($item.comment);
    my $stmt = to-rust($item.declaration-statement);

    Rust::ExpressionStatementNoBlock.new(
        maybe-comment      => $comment,
        expression-noblock => $stmt,
    )
}

multi sub to-rust(
    $item where Cpp::UnaryOperator::Minus)
{
    Rust::UnaryPrefixMinus.new
}

multi sub to-rust(
    $item where Cpp::UnaryOperator::Not)
{
    Rust::UnaryPrefixBang.new
}

multi sub to-rust(
    $item where Cpp::UnaryOperator::Star)
{
    Rust::UnaryPrefixStar.new
}

multi sub to-rust(
    $item where Cpp::MultiLineComment)
{
    debug "will translate MultiLineComment to Rust!";

    Rust::Comment.new(
        line => True,
        text => $item.line-comments>>.value.join("\n"),
    )
}

multi sub to-rust(
    $item where Cpp::AttributedStatement)
{
    debug "will translate AttributedStatement to Rust!";

    Rust::ExpressionStatementNoBlock.new(
        maybe-comment      => to-rust($item.comment),
        expression-noblock => to-rust($item.attributed-statement-body),
    )
}

multi sub to-rust(
    $item where Cpp::CompoundStatement)
{
    debug "will translate CompoundStatement to Rust!";

    Rust::Statements.new(
        statements => $item.statement-seq.List>>.&to-rust,
    )
}

multi sub to-rust(
    $item where Cpp::PointerLiteral)
{
    'std::ptr::null_mut()'
}

multi sub to-rust(
    $item where Cpp::CharacterLiteral)
{
    to-rust-param($item)
}

multi sub to-rust(
    $item where Cpp::InitializerList)
{
    $item.clauses>>.&to-rust-param
}

multi sub to-rust(
    $item where Cpp::ConstantExpression)
{
    translate-conditional-expression($item.conditional-expression)
}

multi sub to-rust(
    $item where Cpp::CastExpression)
{
    debug "will translate CastExpression to Rust!";
    Rust::CastExpression.new(
        borrow-expression => to-rust($item.unary-expression),
        cast-targets      => $item.the-type-ids>>.&to-rust-type,
    )
}

multi sub to-rust(
    $item where Cpp::NoPointerDeclarator)
{
    debug "will translate NoPointerDeclarator to Rust!";
    translate-no-pointer-declarator($item, $item.token-types)
}

multi sub to-rust($item where Cpp::EqualityExpression) {

    my $relational-expr = $item.relational-expression;
    my @tail            = $item.equality-expression-tail;
    my $translation     = to-rust($relational-expr).gist;

    for @tail {
        $translation ~= " " ~ ~$_.equality-operator.gist ~ " ";
        $translation ~= to-rust($_.relational-expression).gist;
    }

    $translation
}

multi sub to-rust(
    $item where Cpp::Identifier)
{
    to-rust-ident($item).gist
}

multi sub to-rust(
    $item where Cpp::SelectionStatement::If)
{
    debug "will translate SelectionStatement::If to Rust!";
    my $condition  = $item.condition;
    my @statements = $item.statements;

    my $rust-condition = translate-condition(
        $condition,
        $condition.gist(treemark => True)
    );

    Rust::IfExpression.new(
        expression-nostruct => $rust-condition,
        block-expression    => Rust::BlockExpression.new(
            statements => Rust::Statements.new(
                statements => @statements>>.&to-rust,
            )
        )
    )
}

multi sub to-rust(
    $item where Cpp::BooleanLiteral::F:D)
{
    $item.gist
}

multi sub to-rust(
    $item where Cpp::IntegerLiteral::Dec)
{
    Rust::IntegerLiteral.new(
        value => $item.decimal-literal.value
    )
}

multi sub to-rust(
    $item where Cpp::IntegerLiteral::Oct)
{
    Rust::IntegerLiteral.new(
        value => $item.octal-literal.value
    )
}

multi sub to-rust(
    $item where Cpp::PrimaryExpression::Id:D)
{
    $item.gist
}

multi sub to-rust(
    $item where Cpp::BooleanLiteral::T:D)
{
    $item.gist
}

multi sub to-rust(
    $item where Cpp::BasicDeclaration)
{
    use Chomper::TranslateBasicDeclaration;
    debug "will translate BasicDeclaration to Rust!";
    my $mask = $item.gist(treemark => True);
    translate-basic-declaration-to-rust($mask, $item)
}

multi sub to-rust(
    $item where Cpp::ExpressionStatement)
{
    debug "will translate ExpressionStatement to Rust!";
    to-rust($item.expression) ~ ";"
}

multi sub to-rust(
    $item where Cpp::LogicalAndExpression)
{
    debug "will translate LogicalAndExpression to Rust!";

    my @exprs = $item.inclusive-or-expressions>>.&to-rust;

    @exprs.join(" && ")
}

multi sub to-rust(
    $item where Cpp::RelationalExpression)
{
    debug "will translate RelationalExpression to Rust!";

    die "unhandled" if $item.relational-expression-tail.elems gt 1;

    my $lhs = to-rust($item.shift-expression);
    my $rhs = to-rust($item.relational-expression-tail[0].shift-expression);

    do given $item.relational-expression-tail[0].relational-operator {
        when Cpp::RelationalOperator::Greater {
            Rust::BinaryGtExpression.new(
                binary-lt-expressions => [
                    $lhs,
                    $rhs,
                ]
            ).gist
        }
        when Cpp::RelationalOperator::Less {
            Rust::BinaryLtExpression.new(
                binary-ge-expressions => [
                    $lhs,
                    $rhs,
                ]
            ).gist
        }
        when Cpp::RelationalOperator::GreaterEq {
            Rust::BinaryGeExpression.new(
                binary-le-expressions => [
                    $lhs,
                    $rhs,
                ]
            ).gist
        }
        when Cpp::RelationalOperator::LessEq {
            Rust::BinaryLeExpression.new(
                binary-or-expressions => [
                    $lhs,
                    $rhs,
                ]
            ).gist
        }
        default {
            die "need handle this case!";
        }
    }
}

multi sub to-rust(
    $item where Cpp::UnaryOperator::Star)
{
    Rust::UnaryPrefixStar.new
}

multi sub to-rust(
    $item where Cpp::UnaryExpressionCase::PlusPlus)
{
    debug "will translate UnaryExpressioncase::PlusPlus to Rust!";

    my $m1 = Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => Rust::IntegerLiteral.new(
                value => 1,
            )
        )
    );

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => Rust::AddEqExpression.new(
            minuseq-expressions => [
                to-rust($item.unary-expression),
                $m1
            ]
        )
    ).gist
}

multi sub to-rust(
    $item where Cpp::UnaryExpressionCase::UnaryOp)
{
    debug "will translate UnaryOp to Rust!";

    my $expr = to-rust($item.unary-expression);

    if ($item.unary-operator ~~ Cpp::UnaryOperator::And) {

        Rust::BorrowExpression.new(
            borrow-expression-prefixes => [
                Rust::BorrowExpressionPrefix.new(
                    borrow-count => 1,
                    mutable      => False,
                )
            ],
            unary-expression => $expr,
        )

    } else {
        Rust::UnaryExpression.new(
            unary-prefixes => [
                to-rust($item.unary-operator)
            ],
            suffixed-expression => $expr
        )
    }
}

multi sub to-rust(
    $item where Cpp::AssignmentExpression::Basic)
{
    debug "will translate AssignmentExpression::Basic to Rust!";

    my $lhs = to-rust($item.logical-or-expression);
    my $rhs = to-rust($item.initializer-clause);

    do given $item.assignment-operator {
        when Cpp::AssignmentOperator::Assign {
            "{$lhs.gist} = {$rhs.gist}"
        }
        when Cpp::AssignmentOperator::StarAssign {
            "{$lhs.gist} *= {$rhs.gist}"
        }
        when Cpp::AssignmentOperator::DivAssign {
            "{$lhs.gist} /= {$rhs.gist}"
        }
        when Cpp::AssignmentOperator::ModAssign {
            "{$lhs.gist} %= {$rhs.gist}"
        }
        when Cpp::AssignmentOperator::PlusAssign {
            "{$lhs.gist} += {$rhs.gist}"
        }
        when Cpp::AssignmentOperator::MinusAssign {
            "{$lhs.gist} -= {$rhs.gist}"
        }
        when Cpp::AssignmentOperator::LShiftAssign {
            "{$lhs.gist} <<= {$rhs.gist}"
        }
        when Cpp::AssignmentOperator::RShiftAssign {
            "{$lhs.gist} >>= {$rhs.gist}"
        }
        when Cpp::AssignmentOperator::AndAssign {
            "{$lhs.gist} &= {$rhs.gist}"
        }
        when Cpp::AssignmentOperator::XorAssign {
            "{$lhs.gist} ^= {$rhs.gist}"
        }
        when Cpp::AssignmentOperator::OrAssign {
            "{$lhs.gist} |= {$rhs.gist}"
        }
        default {
            say "need implement case for $item.assignment-operator";
            exit;
        }
    }
}

multi sub to-rust(
    $item where Cpp::SimpleTemplateId)
{
    debug "will translate SimpleTemplateId to Rust!";
    my $name = to-rust-ident($item.template-name).gist;
    my $args = $item.template-arguments>>.&to-rust>>.gist.join(", ");
    $name ~ "<" ~ $args ~ ">"
}

multi sub to-rust(
    $item where Cpp::TypeSpecifier)
{
    debug "will translate TypeSpecifier to Rust!";
    to-rust($item.value)
}

multi sub to-rust(
    $item where Cpp::SimpleTypeSpecifier::Float_)
{
    debug "will translate SimpleTypeSpecifier::Float_ to Rust!";
    "f32"
}

multi sub to-rust(
    $item where Cpp::LogicalOrExpression)
{
    debug "will translate LogicalOrExpression to Rust!";

    my @exprs = $item.logical-and-expressions>>.&to-rust;

    @exprs.join(" || ")
}

multi sub to-rust(
    $item where Cpp::AdditiveExpression)
{
    debug "will translate AdditiveExpression to Rust!";
    translate-additive-expression($item)
}

multi sub to-rust(
    $item where Cpp::IAdditiveOperator)
{
    debug "will translate AdditiveOperator to Rust!";
    translate-additive-operator($item)
}

multi sub to-rust(
    $item where Cpp::AdditiveExpressionTail)
{
    debug "will translate AdditiveExpressionTail to Rust!";
    translate-additive-expression-tail($item)
}

multi sub to-rust(
    $item where Cpp::PrimaryExpression::Expr)
{
    debug "will translate PrimaryExpression::Expr to Rust!";
    "(" ~ to-rust($item.expression) ~ ")"
}

multi sub to-rust(
    $item where Cpp::MultiplicativeExpression)
{
    debug "will translate MultiplicativeExpression to Rust!";
    translate-multiplicative-expression($item)
}

multi sub to-rust(
    $item where Cpp::IMultiplicativeOperator)
{
    debug "will translate MultiplicativeOperator to Rust!";
    translate-multiplicative-operator($item)
}

multi sub to-rust(
    $item where Cpp::MultiplicativeExpressionTail)
{
    debug "will translate MultiplicativeExpressionTail to Rust!";
    translate-multiplicative-expression-tail($item)
}

multi sub to-rust(
    $item where Cpp::PostfixExpression)
{
    use Chomper::TranslatePostfixExpression;
    translate-postfix-expression($item, $item.token-types)
}

multi sub to-rust(
    $item where Cpp::PostfixExpressionList)
{
    use Chomper::TranslatePostfixExpressionList;
    translate-postfix-expression-list($item, $item.token-types)
}

multi sub to-rust(
    $item where Cpp::IterationStatement::ForRange)
{
    debug "will translate IterationStatement::ForRange to Rust!";
    ddt $item;
    exit;
}

multi sub to-rust(
    $item where Cpp::IterationStatement::For)
{
    debug "will translate IterationStatement::For to Rust!";
    use Chomper::TranslateForLoop;
    translate-for-loop($item, $item.token-types)
}

multi sub to-rust(
    $item where Cpp::IterationStatement::While)
{
    debug "will translate IterationStatement::While to Rust!";

    my $rust-condition  = to-rust($item.condition);
    my @rust-statements = $item.statements.List>>.&to-rust;

    Rust::LoopExpressionPredicate.new(
        expression-nostruct => $rust-condition,
        block-expression => Rust::BlockExpression.new(
            statements => Rust::Statements.new(
                statements => @rust-statements,
            )
        ),
    ).gist
}

multi sub to-rust(
    $item where Cpp::JumpStatement::Return)
{
    debug "will translate JumpStatement::Return to Rust!";

    if $item.return-statement-body {
        "return " ~ to-rust($item.return-statement-body)

    } else {
        "return;"
    }
}

multi sub to-rust(
    $item where Cpp::JumpStatement::Continue)
{
    debug "will translate JumpStatement::Continue to Rust!";

}

multi sub to-rust($item where Cpp::TryBlock)
{
    debug "will translate TryBlock to Rust!";

}

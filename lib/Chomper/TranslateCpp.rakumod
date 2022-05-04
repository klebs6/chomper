use Chomper::TranslateIo;
use Chomper::Cpp;
use Chomper::Rust;
use Chomper::ToRust;
use Chomper::ToRustIdent;
use Chomper::ToRustType;
use Chomper::ToRustPathInExpression;
use Chomper::ToRustMatchArm;
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
        when "AttributedStatement"          { to-rust($item) }
        when "Statement::Declaration"       { to-rust($item) }
        when "JumpStatement::Return"        { to-rust($item) }
        when "JumpStatement::Continue"      { to-rust($item) }
        when "JumpStatement::Break"         { to-rust($item) }
        when "IterationStatement::ForRange" { to-rust($item) }
        when "IterationStatement::While"    { to-rust($item) }
        when "IterationStatement::For"      { to-rust($item) }
        when "IterationStatement::Do"       { to-rust($item) }
        when "BasicDeclaration"             { to-rust($item) }
        when "SelectionStatement::If"       { to-rust($item) }
        when "SelectionStatement::Switch"   { to-rust($item) }
        default {
            die "need to add {$item.name} to translate-cpp-ir-to-rust";
        }
    };

    $rust.gist
}

multi sub to-rust(
    $item where Cpp::AttributedStatement)
{
    debug "will translate AttributedStatement to Rust!";

    my $comment = to-rust($item.comment);
    my $body    = to-rust($item.attributed-statement-body);

    Rust::CommentWrapped.new(
        maybe-comment => $comment,
        wrapped       => $body,
    )
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
    $item where Cpp::IntegerLiteral::Hex)
{
    to-rust-param($item)
}

multi sub to-rust(
    $item where Cpp::NestedNameSpecifierPrefix::Type)
{
    to-rust($item.the-type-name)
}

multi sub to-rust(
    $item where Cpp::ConditionalExpression)
{
    debug "will translate ConditionalExpression to Rust!";

    my $expr-a = to-rust($item.conditional-expression-tail.question-expression);
    my $expr-b = to-rust($item.conditional-expression-tail.assignment-expression);

    Rust::MatchExpression.new(
        scrutinee => to-rust($item.logical-or-expression),
        maybe-match-arms => Rust::MatchArms.new(
            items => [
                Rust::MatchArmsInnerItemWithoutBlock.new(
                    match-arm => Rust::MatchArm.new(
                        pattern => "true ",
                    ),
                    expression-noblock => $expr-a,
                ),
                Rust::MatchArmsOuterItem.new(
                    match-arm => Rust::MatchArm.new(
                        pattern => "false",
                    ),
                    expression => $expr-b,
                ),
            ],
        )
    ).gist
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
    $item where Cpp::SimpleTypeSpecifier::Bool_)
{
    to-rust-type($item)
}

multi sub to-rust(
    $item where Cpp::BooleanLiteral::T)
{
    Rust::BooleanLiteral.new(
        value => "true"
    ).gist
}

multi sub to-rust(
    $item where Cpp::BooleanLiteral::F)
{
    Rust::BooleanLiteral.new(
        value => "false"
    ).gist
}

multi sub to-rust(
    $item where Cpp::StringLiteral)
{
    Rust::StringLiteral.new(
        value => $item.value
    ).gist
}

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

multi sub to-rust(
    $item where Cpp::SelectionStatement::Switch)
{
    debug "will translate SelectionStatement::Switch to Rust!";

    my $condition 
    = to-rust($item.condition);

    my @arms 
    = $item.statement.statement-seq.List>>.&to-rust-match-arm-item;

    my $match-arms = Rust::MatchArms.new(
        items => @arms,
    );

    my $match-expression = Rust::MatchExpression.new(
        scrutinee        => $condition,
        maybe-match-arms => $match-arms,
    );

    Rust::ExpressionStatementBlock.new(
        expression-with-block => $match-expression
    )
}

multi sub to-rust(
    $item where Cpp::SelectionStatement::If)
{
    debug "will translate SelectionStatement::If to Rust!";

    my $condition  = $item.condition;
    my @statements = $item.statements;

    my $rust-condition = to-rust($condition);

    my $cpp-else = $item.else-statements[0];

    my $maybe-else-clause = do if $cpp-else {

        my $rust-else = to-rust($cpp-else);

        if $rust-else.WHAT.^name ~~ /Statements/ {
            $rust-else = Rust::BlockExpression.new(
                statements => $rust-else,
            );
        }

        Rust::ElseClause.new(
            else-clause-variant => $rust-else,
        )

    } else {
        Nil
    };

    Rust::IfExpression.new(
        expression-nostruct => $rust-condition,
        block-expression    => Rust::BlockExpression.new(
            statements => Rust::Statements.new(
                statements => @statements>>.&to-rust,
            )
        ),
        maybe-else-clause => $maybe-else-clause,
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
    ).gist
}

multi sub to-rust(
    $item where Cpp::IntegerLiteral::Oct)
{
    Rust::IntegerLiteral.new(
        value => $item.octal-literal.value
    ).gist
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
    $item where Cpp::ThrowExpression)
{
    debug "will translate ThrowExpression to Rust!";

    my @err-params = [
        to-rust($item.assignment-expression)
    ];

    my $err = Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::Identifier.new(
                        value => "Err",
                    )
                ],
            )
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => @err-params
            )
        ]
    );

    Rust::ReturnExpression.new(
        maybe-expression => $err,
    )
}

multi sub to-rust(
    $item where Cpp::AssignmentExpression::Throw)
{
    debug "will translate AssignmentExpression::Throw to Rust!";
    to-rust($item.throw-expression)
}

multi sub to-rust(
    $item where Cpp::ExpressionStatement)
{
    debug "will translate ExpressionStatement to Rust!";

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => to-rust($item.expression),
    )
}

multi sub to-rust(
    $item where Cpp::LogicalAndExpression)
{
    debug "will translate LogicalAndExpression to Rust!";

    my @exprs = $item.inclusive-or-expressions>>.&to-rust;

    @exprs.join(" && ")
}

multi sub to-rust(
    $item where Cpp::ShiftExpression)
{
    debug "will translate ShiftExpression to Rust!";

    Rust::BinaryShiftExpression.new(
        additive-expression => to-rust($item.additive-expression),
        binary-shift-expression-tail => $item.shift-expression-tail>>.&to-rust,
    ).gist
}

multi sub to-rust(
    $item where Cpp::ShiftOperator::Right)
{
    Rust::BinaryShiftOperator::Right.new
}

multi sub to-rust(
    $item where Cpp::ShiftOperator::Left)
{
    Rust::BinaryShiftOperator::Left.new
}

multi sub to-rust(
    $item where Cpp::ShiftExpressionTail)
{
    debug "will translate ShiftExpressionTail to Rust!";

    Rust::BinaryShiftExpressionTail.new(
        binary-shift-operator => to-rust($item.shift-operator),
        additive-expression   => to-rust($item.additive-expression),
    ).gist
}

multi sub to-rust(
    $item where Cpp::AndExpression)
{
    debug "will translate AndExpression to Rust!";

    my @exprs = $item.equality-expressions>>.&to-rust;

    @exprs.join(" & ")
}

multi sub to-rust(
    $item where Cpp::ExclusiveOrExpression)
{
    debug "will translate ExclusiveOrExpression to Rust!";

    my @exprs = $item.and-expressions>>.&to-rust;

    @exprs.join(" ^ ")
}

multi sub to-rust(
    $item where Cpp::InclusiveOrExpression)
{
    debug "will translate InclusiveOrExpression to Rust!";

    my @exprs = $item.exclusive-or-expressions>>.&to-rust;

    @exprs.join(" | ")
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
    $item where Cpp::UnaryOperator::Tilde)
{
    Rust::UnaryPrefixBang.new
}

multi sub to-rust(
    $item where Cpp::UnaryExpressionCase::PlusPlus)
{
    debug "will translate UnaryExpressionCase::PlusPlus to Rust!";

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
        ).gist
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
    $item where Cpp::TemplateArgumentList)
{
    debug "will translate TemplateArgumentList to Rust!";
    $item.template-arguments>>.&to-rust-type>>.gist.join(",")
}

multi sub to-rust(
    $item where Cpp::SimpleTemplateId)
{
    debug "will translate SimpleTemplateId to Rust!";
    my $name = to-rust-ident($item.template-name).gist;
    my $args = to-rust($item.template-arguments).gist;
    $name ~ "<" ~ $args ~ ">"
}

multi sub to-rust(
    $item where Cpp::TypeSpecifier)
{
    debug "will translate TypeSpecifier to Rust!";
    to-rust($item.value)
}

multi sub to-rust(
    $item where Cpp::FullTypeName)
{
    debug "will translate FullTypeName to Rust!";
    to-rust-path-in-expression($item)
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
    use Chomper::TranslateForRangeLoop;
    translate-for-range-loop($item, $item.token-types)
}

multi sub to-rust(
    $item where Cpp::IterationStatement::For)
{
    debug "will translate IterationStatement::For to Rust!";
    use Chomper::TranslateForLoop;
    translate-for-loop($item, $item.token-types)
}

multi sub to-rust(
    $item where Cpp::BracedInitList)
{
    debug "will translate BracedInitList to Rust!";

    Rust::MacroInvocation.new(
        simple-path => "vec",
        delim-kind  => Rust::DelimKind::<Brace>,
        token-trees => [],
    )
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
    $item where Cpp::JumpStatement::Break)
{
    debug "will translate JumpStatement::Break to Rust!";

    die "impl this" if so $item.comment;

    "break;"
}

multi sub to-rust(
    $item where Cpp::JumpStatement::Return)
{
    debug "will translate JumpStatement::Return to Rust!";

    if $item.return-statement-body {
        "return " ~ to-rust($item.return-statement-body) ~ ";"

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

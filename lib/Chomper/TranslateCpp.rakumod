use Chomper::TranslateIo;
use Chomper::Cpp;
use Chomper::Rust;
use Chomper::DefaultInitializer;
use Chomper::ToRust;
use Chomper::ToRustIdent;
use Chomper::SuffixedExpression;
use Chomper::MatchArms;
use Chomper::ToRustBlockExpression;
use Chomper::ToRustType;
use Chomper::ToRustPattern;
use Chomper::ToRustPathInExpression;
use Chomper::ToRustMatchArm;
use Chomper::ToRustParams;
use Chomper::TranslateCondition;
use Chomper::TranslateNoPointerDeclarator;
use Chomper::TranslateConditionalExpression;
use Chomper::TranslateAdditiveExpression;
use Chomper::TranslateMultiplicativeExpression;
use Chomper::TranslateLambda;

use Data::Dump::Tree;

#our sub translate-cpp-ir-to-rust($typename, $item where Cpp::IStatement)
our sub translate-cpp-ir-to-rust($typename, $item)
{
    my $rust = do given $item.name {
        when "TryBlock"                     { to-rust($item) }
        when "ExpressionStatement"          { to-rust($item) }
        when "ConstructorInitializer"       { to-rust($item) }
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
        when "StructuredBinding::Eq"        { to-rust($item) }
        when "StructuredBinding::Braces"    { to-rust($item) }
        when "StructuredBinding::Parens"    { to-rust($item) }
        default {
            die "need to add {$item.name} to translate-cpp-ir-to-rust";
        }
    };

    $rust.gist
}

multi sub to-rust(
    $item where Cpp::ConstructorInitializer)
{
    debug "will translate ConstructorInitializer to Rust!";
    ddt $item;
    exit;
}

multi sub to-rust(
    $item where Cpp::PrimaryExpression::Lambda)
{
    debug "will translate PrimaryExpression::Lambda to Rust!";

    translate-lambda-expression($item.lambda-expression)
}

multi sub to-rust(
    $item where Cpp::LambdaExpression)
{
    debug "will translate LambdaExpression to Rust!";

    translate-lambda-expression($item)
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
    $item where Cpp::BlockComment)
{
    debug "will translate BlockComment to Rust!";

    $item.gist
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

our sub empty-block {
    Rust::BlockExpression.new(
        statements => Rust::Statements.new(
            statements => [],
        )
    )
}

multi sub to-rust(
    $item where Cpp::CompoundStatement)
{
    debug "will translate CompoundStatement to Rust!";

    Rust::BlockExpression.new(
        statements => Rust::Statements.new(
            statements => $item.statement-seq.List>>.&to-rust,
        )
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
    $item.clauses.List>>.&to-rust-param
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
    $item where Cpp::NestedNameSpecifierPrefix::Null)
{
    ""
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
    ).gist
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
    to-rust-ident($item, snake-case => True).gist
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

sub to-basic-declaration($item where Cpp::Condition::Decl) 
returns Cpp::BasicDeclaration 
{
    my $initializer-clause = $item.condition-decl-tail.initializer-clause;

    Cpp::BasicDeclaration.new(
        decl-specifier-seq => $item.decl-specifier-seq,
        init-declarator-list => [
            Cpp::InitDeclarator.new(
                declarator  => $item.declarator,
                initializer => Cpp::Initializer::BraceOrEq.new(
                    brace-or-equal-initializer => Cpp::AssignInit.new(
                        initializer-clause => $initializer-clause
                    )
                ),
            )
        ]
    )
}

multi sub to-rust(
    $item where Cpp::PrimaryExpression::This)
{
    Rust::PathExpressionGrammar::IdentSelfValue.new
}

multi sub to-rust(
    $item where Cpp::Condition::Decl)
{
    debug "will translate Condition::Decl to Rust!";

    use Chomper::TranslateBasicDeclaration;

    my $bd = to-basic-declaration($item);

    to-rust($bd)
}

multi sub to-rust(
    $item where Cpp::SelectionStatement::If)
{
    debug "will translate SelectionStatement::If to Rust!";

    my $condition        = $item.condition;
    my $block-expression = to-rust-block-expression($item.statements);

    #this is a weird construct, but
    #
    my ($rust-condition, $maybe-cond-decl) 
        = $condition ~~ Cpp::Condition::Decl 
        ?? (to-rust-ident($condition), to-rust($condition)) 
        !! (to-rust($condition), Nil);

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

    my $if-expression = 
    Rust::IfExpression.new(
        expression-nostruct => $rust-condition,
        block-expression    => $block-expression,
        maybe-else-clause => $maybe-else-clause,
    );

    #----------------------
    my @output-statements = [];

    if $maybe-cond-decl {
        @output-statements.push: $maybe-cond-decl;
    }

    @output-statements.push: $if-expression;

    Rust::Statements.new(
        statements => @output-statements
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
    to-rust($item.id-expression)
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

    given $mask {
        when /^^ 'T I = ' / {
            $mask = "T I = E;";
        }

        when /^^ 'constexpr T I = ' / {
            $mask = "constexpr T I = E;";
        }

        when /^^ 'static constexpr T I{' .* '};' / {
            $mask = 'constexpr T I{E};';
        }

        when /^^ 'static constexpr T I = NI;' / {
            $mask = 'constexpr T I = E;';
        }

        when /^^ 'static T I{' .* '};' / {
            $mask = 'static T I{E};';
        }

        when /^^ 'static T I = ' .* ';' / {
            $mask = 'static T I = E;';
        }

        when /^^ 'I = ' / {
            $mask = "I = E;";
        }

        when /^^ 'T T I = ' / {
            $mask = "T I = E;";
        }

        when /^^ 'T &I = ' / {
            $mask = "T &I = E;";
        }

        when /^^ 'T *I = ' / {
            $mask = "T *I = E;";
        }

        when rule { ^^ 'T' ['*I'+ %% ", "] ';' } {
            $mask = "T *I;";
        }

        when /^^ 'T *I{' .* '}' / {
            $mask = 'T *I{E};';
        }

        when /^^ 'I[I] = ' / {
            $mask = "I[I] = E;";
        }

        when /^^ 'I[I][I] = ' / {
            $mask = "I[I][I] = E;";
        }

        when /^^ 'I[N] = ' / {
            $mask = "I[N] = E;";
        }

        when /^^ 'I[I + N] = ' / {
            $mask = "I[E] = E;";
        }

        when /^^ 'I[I | N] = ' / {
            $mask = "I[E] = E;";
        }

        when /^^ 'I[I & ~ N] = ' / {
            $mask = "I[E] = E;";
        }

        when /^^ 'T T I[' .* '] = ' / {
            $mask = "T I[E] = E;";
        }

        when /^^ 'T I[' .* '] = ' / {
            $mask = "T I[E] = E;";
        }

        when /^^ 'T I{' .* '};' / {
            $mask = 'T I{E};';
        }

        when /^^ 'T &I{' .* '};' / {
            $mask = 'T &I{E};';
        }

        when /^^ 'T &I(' .* ');' / {
            $mask = 'T &I(E);';
        }

        when /^^ 'I[' .* '] =' / {
            $mask = 'I[E] = E;';
        }

    }

    translate-basic-declaration-to-rust($mask, $item)
}

multi sub to-rust($x where Cpp::PostfixExpressionTypeId) {

    debug "will translate PostfixExpressionTypeId to Rust!";

    my $type-id = to-rust($x.the-type-id);

    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => $type-id 
        ),
        suffixed-expression-suffix => [
            Rust::MethodCallExpressionSuffix.new(
                path-expr-segment => Rust::PathExprSegment.new(
                    path-ident-segment => Rust::Identifier.new(
                        value => "type_id"
                    )
                )
            )
        ]
    )
}

multi sub to-rust($x where Cpp::StructuredBinding::Eq) {
    debug "will translate StructuredBinding::Eq to Rust!";

    my $rust-expr = to-rust($x.expression);

    my Bool $is-ref = $x.structured-binding-body.refqualifier ~~ Cpp::RefQualifier::And;

    my Bool $is-mutable = $x.structured-binding-body.is-mutable();

    my @pats = $x.structured-binding-body.identifier-list.List>>.&to-rust-pattern(:$is-ref, :$is-mutable);

    Rust::LetStatement.new(
        maybe-comment    => Nil,
        outer-attributes => [],
        pattern-no-top-alt => Rust::TupleStructItems.new(
            patterns => @pats,
        ),
        maybe-type       => Nil,
        maybe-expression => $rust-expr,
    )
}

multi sub to-rust($x where Cpp::StructuredBinding::Braces) {
    debug "will translate StructuredBinding::Braces to Rust!";
    ddt $x;
    exit;
}

multi sub to-rust($x where Cpp::StructuredBinding::Parens) {
    debug "will translate StructuredBinding::Parens to Rust!";
    ddt $x;
    exit;
}

multi sub to-rust($x where Cpp::NewExpression::NewTypeId) {

    my $rust-type = to-rust-type($x.new-type-id);

    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            outer-attributes => [],
            expression-item => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => $rust-type,
                    ),
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => "new",
                        )
                    ),
                ]
            )
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => Nil,
            )
        ]
    )
}

multi sub to-rust($item where Cpp::UnaryExpressionCase::Sizeof)
{
    my $body = to-rust($item.unary-expression.expression);

    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            outer-attributes => [],
            expression-item => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => "size_of_val",
                        )
                    )
                ]
            )
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => [
                    Rust::BorrowExpression.new(
                        borrow-expression-prefixes => [
                            Rust::BorrowExpressionPrefix.new(
                                borrow-count => 1,
                                mutable      => False,
                            )
                        ],
                        unary-expression => $body
                    ),
                ]
            )
        ]
    ).gist
}

multi sub to-rust($item where Cpp::UnaryExpressionCase::SizeofTypeId)
{
    my $rust-type = to-rust-type($item.the-type-id);

    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            outer-attributes => [],
            expression-item => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => "size_of",
                        ),
                        maybe-generic-args => Rust::GenericArgs.new(
                            args => [
                                Rust::TypePath.new(
                                    type-path-segments => [
                                        Rust::TypePathSegment.new(
                                            path-ident-segment => $rust-type,
                                        )
                                    ]
                                )
                            ]
                        )
                    )
                ]
            )
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => Nil,
            )
        ]
    )
}

multi sub to-rust(
    $item where Cpp::ThrowExpression)
{
    debug "will translate ThrowExpression to Rust!";

    my @err-params = $item.assignment-expression ?? [
        to-rust($item.assignment-expression)
    ] !! Rust::Identifier.new(value => "e");

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

    if $item.expression {
        Rust::ExpressionStatementNoBlock.new(
            expression-noblock => to-rust($item.expression),
        )

    } else {
        Nil
    }
}

multi sub to-rust(
    $item where Cpp::FloatingLiteral::Frac)
{
    $item.gist
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

    my $base = to-rust($item.unary-expression);

    my @statements = [
        Rust::ExpressionStatementNoBlock.new(
            expression-noblock => Rust::AddEqExpression.new(
                minuseq-expressions => [
                    $base,
                    $m1
                ]
            )
        ).gist
    ];

    Rust::BlockExpression.new(
        statements => Rust::Statements.new(
            statements => @statements,
            maybe-expression-noblock => $base
        )
    )

}

multi sub to-rust(
    $item where Cpp::ParametersAndQualifiers)
{
    debug "will translate Cpp::ParametersAndQualifiers to Rust!";

    if [
        $item.parameter-declaration-clause,
        $item.cvqualifierseq,
        $item.refqualifier,
        $item.exception-specification,
        $item.attribute-specifier-seq,
    ].any {

        die "handle this";

    } else {

        Rust::CallExpressionSuffix.new(
            maybe-call-params => Nil,
        )
    }
}

multi sub to-rust(
    $item where Cpp::UnaryExpressionCase::MinusMinus)
{
    debug "will translate UnaryExpressionCase::MinusMinus to Rust!";

    my $m1 = Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => Rust::IntegerLiteral.new(
                value => 1,
            )
        )
    );

    my $base = to-rust($item.unary-expression);

    my @statements = [
        Rust::ExpressionStatementNoBlock.new(
            expression-noblock => Rust::MinusEqExpression.new(
                stareq-expressions => [
                    $base,
                    $m1
                ]
            )
        ).gist
    ];

    Rust::BlockExpression.new(
        statements => Rust::Statements.new(
            statements => @statements,
            maybe-expression-noblock => $base
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
        ).gist

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
    $item where Cpp::PostfixExpressionCast)
{
    use Chomper::TranslatePostfixExpressionCast;
    translate-postfix-expression-cast($item)
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
    $item where Cpp::AssignInit)
{
    debug "will translate AssignInit to Rust!";
    to-rust($item.initializer-clause)
}

multi sub to-rust(
    $item where Cpp::InitDeclarator)
{
    debug "will translate InitDeclarator to Rust!";

    my $lhs  = $item.declarator;
    my $rhs = $item.initializer;

    Rust::AssignExpression.new(
        addeq-expressions => [
            to-rust($lhs),
            to-rust($rhs),
        ]
    )
}

multi sub to-rust(
    $item where Cpp::Initializer::BraceOrEq)
{
    debug "will translate Initializer::BraceOrEq to Rust!";
    to-rust($item.brace-or-equal-initializer)
}

multi sub to-rust(
    $item where Cpp::QualifiedId)
{
    debug "will translate QualifiedId to Rust!";

    if $item.gist ~~ "std::nullopt" {
        return "None";
    } else {
        to-rust-ident($item).gist
    }
}

multi sub to-rust(
    $item where Cpp::BracedInitList)
{
    debug "will translate BracedInitList to Rust!";

    my $init-list = $item.initializer-list;

    my $initializer = do if $init-list {

        if $init-list.clauses.elems gt 1 {

            Rust::MacroInvocation.new(
                simple-path => "vec",
                delim-kind  => Rust::DelimKind::<Brace>,
                token-trees => [to-rust($init-list)>>.chomp.join(",")],
            ).gist

        } else {
            to-rust($init-list.clauses[0])
        }

    } else {
        #empty braced-init-list means default
        #construct default-construct

        create-default-initializer("Default")
    }

    $initializer
}

multi sub to-rust(
    $item where Cpp::IterationStatement::While)
{
    debug "will translate IterationStatement::While to Rust!";

    my $rust-condition  = to-rust($item.condition);

    Rust::LoopExpressionPredicate.new(
        expression-nostruct => $rust-condition,
        block-expression => to-rust-block-expression($item.statements),
    ).gist
}

our sub invert-condition($rust-condition) {
    Rust::UnaryExpression.new(
        unary-prefixes => [
            Rust::UnaryPrefixBang.new,
        ],
        suffixed-expression => $rust-condition,
    )
}

our sub break-if-not($rust-condition) {

    my $block-expression = Rust::BlockExpression.new(
        statements => Rust::Statements.new(
            statements => [
                Rust::ExpressionStatementNoBlock.new(
                    expression-noblock => Rust::BreakExpression.new(
                        maybe-lifetime-or-label => Nil,
                        maybe-expression        => Nil,
                    )
                )
            ]
        )
    );

    Rust::IfExpression.new(

        expression-nostruct => invert-condition($rust-condition),

        block-expression => $block-expression,
    )
}

multi sub to-rust(
    $item where Cpp::ElaboratedTypeSpecifier::ClassIdent)
{
    to-rust($item.identifier)
}

multi sub to-rust(
    $item where Cpp::IterationStatement::Do)
{
    debug "will translate IterationStatement::Do to Rust!";

    my $loop-expression  = to-rust($item.expression);

    my $statement = to-rust($item.statement);

    $statement.statements.statements.push: 
    break-if-not($loop-expression);

    Rust::LoopExpressionInfinite.new(
        maybe-loop-label => Nil,
        block-expression => $statement,
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
        "return " ~ to-rust($item.return-statement-body).gist ~ ";"

    } else {
        "return;"
    }
}

multi sub to-rust(
    $item where Cpp::JumpStatement::Continue)
{
    debug "will translate JumpStatement::Continue to Rust!";

    Rust::Statements.new(
        statements => [
            Rust::ExpressionStatementNoBlock.new(
                expression-noblock => Rust::SuffixedExpression.new(
                    base-expression => Rust::BaseExpression.new(
                        expression-item => Rust::ContinueExpression.new(
                            maybe-lifetime-or-label => Nil,
                        )
                    )
                )
            )
        ]
    )
}

our sub create-static-str-ref {

    my $static-lifetime = Rust::Lifetime.new(
        lifetime-or-label => Rust::LifetimeOrLabel.new(
            non-keyword-identifier => "static",
        )
    );

    my $str-type = Rust::TypePath.new(
        type-path-segments => [
            Rust::TypePathSegment.new(
                path-ident-segment => Rust::Identifier.new(
                    value => "str",
                )
            )
        ],
    );

    my $static-string-ref = Rust::ReferenceType.new(
        maybe-lifetime => $static-lifetime,
        mutable        => False,
        type-no-bounds => $str-type,
    );

    $static-string-ref
}

our sub create-closure-throwable-error {
    #create-static-str-ref()
    Rust::Identifier.new(
        value => "StdException",
    )
}

our sub construct-new-object(:$typename, :$initializer, :$ctor-name = "new") {

    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            outer-attributes => [],
            expression-item => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => $typename,
                        )
                    ),
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => $ctor-name,
                        )
                    ),
                ]
            ),
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => [
                    Rust::SuffixedExpression.new(
                        base-expression => Rust::BaseExpression.new(
                            expression-item => $initializer
                        )
                    )
                ]
            )
        ]
    )
}

multi sub to-rust($item where Cpp::DecimalLiteral) {
    Rust::IntegerLiteral.new(
        value => $item.value
    )
}

multi sub to-rust($item where Cpp::OctalLiteral) {
    Rust::IntegerLiteral.new(
        value => $item.value
    )
}

multi sub to-rust($item where Cpp::UserDefinedIntegerLiteral::Dec) {
    my $decimal-literal = to-rust($item.decimal-literal);
    my $suffix          = $item.suffix.value;

    given $suffix {
        when "s" {
            construct-new-object(typename => "Seconds", initializer => $decimal-literal)
        }
        when "min" {
            construct-new-object(typename => "Minutes", initializer => $decimal-literal)
        }
        when "us" {
            construct-new-object(typename => "Microseconds", initializer => $decimal-literal)
        }
        default {
            die "unknown userdefined integer literal suffix! $suffix";
        }
    }
}

multi sub to-rust($item where Cpp::UserDefinedIntegerLiteral::Oct) {
    my $octal-literal = to-rust($item.octal-literal);
    my $suffix          = $item.suffix.value;

    given $suffix {
        when "s" {
            construct-new-object(typename => "Seconds", initializer => $octal-literal)
        }
        when "min" {
            construct-new-object(typename => "Minutes", initializer => $octal-literal)
        }
        when "us" {
            construct-new-object(typename => "Microseconds", initializer => $octal-literal)
        }
        default {
            die "unknown userdefined integer literal suffix! $suffix";
        }
    }
}

proto sub extract-varname($declarator) { * }

multi sub extract-varname($declarator where Cpp::PointerDeclarator) {
    $declarator.no-pointer-declarator.value
}

our sub match-on-filtered-error-list(@handler-seq) {

    #we will build this from the input list
    my $match-arms = Rust::MatchArms.new(
        items => [],
    );

    my Bool $added-default-case = False;

    for @handler-seq -> $handler {
        my $exception-declaration = $handler.exception-declaration;
        my $block                 = to-rust($handler.compound-statement);

        if $exception-declaration ~~ Cpp::ExceptionDeclaration::Ellipsis {

            $match-arms.items.push: create-default-match-arm(:$block);
            $added-default-case = True;

        } else {
            die "handle this" if not $exception-declaration ~~ Cpp::BasicExceptionDeclaration;
            ddt $exception-declaration;
            my $rust-type    = to-rust-type($exception-declaration.type-specifier-seq);
            my $what-varname = extract-varname($exception-declaration.some-declarator);
            $match-arms.items.push: create-exception-unpacking-match-arm(:$rust-type,:$what-varname,:$block);
        }
    }

    if not $added-default-case {
        $match-arms.items.push: create-default-match-arm(block => empty-block());
        $added-default-case = True;
    }

    Rust::MatchExpression.new(
        scrutinee        => create-basic-match-scrutinee(single-variable => "e"),
        inner-attributes => [],
        maybe-match-arms => $match-arms,
    )
}

#need rewrite this for multiple catch blocks
our sub create-rust-recovery-block-from-cpp-exception-handler-seq(@handler-seq) {

    if @handler-seq.elems eq 1 {

        my @do-these-if-fail = @handler-seq[0].compound-statement.statement-seq.List>>.&to-rust;

        Rust::BlockExpression.new(
            statements => Rust::Statements.new(
                statements => @do-these-if-fail,
            ),
        )

    } else {

        Rust::BlockExpression.new(
            statements => Rust::Statements.new(
                statements => [
                    match-on-filtered-error-list(@handler-seq),
                ],
            ),
        )
    }
}

multi sub to-rust($item where Cpp::TryBlock)
{
    debug "will translate TryBlock to Rust!";

    #die "try block with more than one handler unimplemented" if not $item.handler-seq.List.elems eq 1;

    my @try-these        = $item.compound-statement.statement-seq.List>>.&to-rust;

    my $recovery-block = create-rust-recovery-block-from-cpp-exception-handler-seq($item.handler-seq);

    my $inferred-type = Rust::InferredType.new;

    my $closure-throwable-error = create-closure-throwable-error();

    my $closure-return-type = Rust::TypePath.new(
        type-path-segments => [
            Rust::TypePathSegment.new(
                path-ident-segment => Rust::Identifier.new(
                    value => "TryBlockResult",
                ),
                maybe-type-path-segment-suffix => Rust::TypePathSegmentSuffixGeneric.new(
                    generic-args => Rust::GenericArgs.new(
                        args => [
                            $inferred-type,
                            $closure-throwable-error,
                        ],
                    ),
                ),
            )
        ],
    );

    my $success = Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => "TryBlockResult",
                        )
                    ),
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => "Success",
                        )
                    )
                ]
            )
        )
    );

    my $closure-block = Rust::BlockExpression.new(
        statements => Rust::Statements.new(
            statements               => @try-these,
            maybe-expression-noblock => $success
        )
    );

    my $possible-failure-statement = Rust::LetStatement.new(
        pattern-no-top-alt => Rust::IdentifierPattern.new(
            ref     => False,
            mutable => False,
            identifier => Rust::Identifier.new(
                value => "try_block",
            ),
        ),
        maybe-expression => Rust::SuffixedExpression.new(
            base-expression => Rust::BaseExpression.new(
                expression-item => Rust::ClosureExpression.new(
                    move             => False,
                    maybe-parameters => Nil,
                    body             => Rust::ClosureBodyWithReturnTypeAndBlock.new(
                        return-type      => $closure-return-type,
                        block-expression => $closure-block,
                    ),
                )
            )
        )
    );

    my $recovery-scrutinee = Rust::Scrutinee.new(
        expression-nostruct => Rust::SuffixedExpression.new(
            base-expression => Rust::BaseExpression.new(
                expression-item => Rust::PathInExpression.new(
                    path-expr-segments => [
                        Rust::PathExprSegment.new(
                            path-ident-segment => Rust::Identifier.new(
                                value => "try_block",
                            )
                        )
                    ]
                )
            ),
            suffixed-expression-suffix => [
                Rust::CallExpressionSuffix.new(
                    maybe-call-params => Nil,
                )
            ]
        ),
    );

    my $v = Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => "v",
                        )
                    )
                ]
            )
        )
    );

    my $return-v = Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => Rust::ReturnExpression.new(
                maybe-expression => $v
            )
        )
    );

    my $match-arm-return-pattern = Rust::TupleStructPattern.new(
        path-in-expression => Rust::PathInExpression.new(
            path-expr-segments => [
                Rust::PathExprSegment.new(
                    path-ident-segment => Rust::Identifier.new(
                        value => "TryBlockResult",
                    )
                ),
                Rust::PathExprSegment.new(
                    path-ident-segment => Rust::Identifier.new(
                        value => "Return",
                    )
                ),
            ]
        ),
        maybe-tuple-struct-items => [
            Rust::Pattern.new(
                pattern-no-top-alts => [
                    Rust::IdentifierPattern.new(
                        ref     => False,
                        mutable => False,
                        identifier => Rust::Identifier.new(
                            value => "v",
                        )
                    )
                ]
            )
        ]
    );

    my $match-arm-return = Rust::MatchArmsInnerItemWithoutBlock.new(
        match-arm => Rust::MatchArm.new(
            pattern => Rust::Pattern.new(
                pattern-no-top-alts => [
                    $match-arm-return-pattern
                ]
            )
        ),
        expression-noblock => $return-v
    );

    my $match-arm-error-pattern = Rust::TupleStructPattern.new(
        path-in-expression => Rust::PathInExpression.new(
            path-expr-segments => [
                Rust::PathExprSegment.new(
                    path-ident-segment => Rust::Identifier.new(
                        value => "TryBlockResult",
                    )
                ),
                Rust::PathExprSegment.new(
                    path-ident-segment => Rust::Identifier.new(
                        value => "Err",
                    )
                ),
            ]
        ),
        maybe-tuple-struct-items => [
            Rust::Pattern.new(
                pattern-no-top-alts => [
                    Rust::IdentifierPattern.new(
                        ref     => False,
                        mutable => False,
                        identifier => Rust::Identifier.new(
                            value => "e",
                        )
                    )
                ]
            )
        ]
    );

    my $match-arm-error = Rust::MatchArmsInnerItemWithBlock.new(
        match-arm => Rust::MatchArm.new(
            pattern => Rust::Pattern.new(
                pattern-no-top-alts => [
                    $match-arm-error-pattern
                ]
            )
        ),
        expression-with-block => $recovery-block,
    );

    my $match-arm-success = Rust::MatchArmsOuterItem.new(
        match-arm => Rust::MatchArm.new(
            pattern => Rust::Pattern.new(
                pattern-no-top-alts => [
                    Rust::PathInExpression.new(
                        path-expr-segments => [
                            Rust::PathExprSegment.new(
                                path-ident-segment => Rust::Identifier.new(
                                    value => "TryBlockResult",
                                )
                            ),
                            Rust::PathExprSegment.new(
                                path-ident-segment => Rust::Identifier.new(
                                    value => "Success",
                                )
                            )
                        ]
                    ),
                ]
            )
        ),
        expression => Rust::BlockExpression.new(
            statements => Rust::Statements.new(
                statements => []
            )
        )
    );

    my $maybe-match-arms = Rust::MatchArms.new(
        items => [
            $match-arm-return,
            $match-arm-error,
            $match-arm-success,
        ]
    );

    my $recovery-statement = Rust::ExpressionStatementBlock.new(
        expression-with-block => Rust::MatchExpression.new(
            scrutinee        => $recovery-scrutinee,
            maybe-match-arms => $maybe-match-arms,
        ),
    );

    Rust::Statements.new(
        statements => [
            $possible-failure-statement,
            $recovery-statement,
        ]
    )
}

use Chomper::TranslateIo;
use Chomper::Cpp;
use Chomper::Rust;
use Chomper::ToRust;
use Chomper::ToRustIdent;
use Chomper::TranslateCondition;
use Chomper::TranslateNoPointerDeclarator;
use Chomper::TranslateConditionalExpression;

use Data::Dump::Tree;

our sub translate-cpp-ir-to-rust($typename, $item where Cpp::IStatement)
{
    given $item.name {
        when "TryBlock"                     { to-rust($item) }
        when "ExpressionStatement"          { to-rust($item) }
        when "CompoundStatement"            { to-rust($item) }
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
    }
}

multi sub to-rust(
    $item where Cpp::CompoundStatement)
{
    debug "will translate CompoundStatement to Rust!";

    do for $item.statement-seq.List {
        to-rust($_)
    }.join("\n")
}

multi sub to-rust(
    $item where Cpp::PointerLiteral)
{
    'std::ptr::null_mut()'
}

multi sub to-rust(
    $item where Cpp::ConstantExpression)
{
    translate-conditional-expression($item.conditional-expression)
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

    my $statements = @statements>>.&to-rust.join("\n");

    qq:to/END/
    if $rust-condition \{
    $statements.indent(4)
    \}
    END
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
    ddt $item;
    exit;
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
    ddt $item;
    exit;
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

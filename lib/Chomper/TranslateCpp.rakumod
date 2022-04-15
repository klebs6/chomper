use Chomper::TranslateIo;
use Chomper::Rust::ToRustType;
use Chomper::Rust::ToRustIdent;
use Chomper::Rust::ToRustParams;
use Chomper::TranslatePostfixExpressionList;
use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppTry;
use Chomper::Cpp::GcppPrimaryExpression;
use Chomper::Cpp::GcppStatement;
use Chomper::Cpp::GcppEqExpression;
use Chomper::Cpp::GcppLogicalExpression;
use Chomper::Cpp::GcppDeclaration;
use Chomper::Cpp::GcppSelection;
use Chomper::Cpp::GcppIteration;
use Chomper::Cpp::GcppJumpStatement;
use Chomper::Cpp::GcppBool;
use Chomper::Cpp::GcppPostfixExpression;
use Data::Dump::Tree;

proto sub to-rust($x) is export { * };

our sub translate-cpp-ir-to-rust($typename, IStatement $item)
{
    given $typename {
        when "TryBlock"                     { to-rust($item) }
        when "ExpressionStatement"          { to-rust($item) }
        when "CompoundStatement"            { to-rust($item) }
        when "JumpStatement::Return"        { to-rust($item) }
        when "JumpStatement::Continue"      { to-rust($item) }
        when "IterationStatement::ForRange" { to-rust($item) }
        when "IterationStatement::While"    { to-rust($item) }
        when "IterationStatement::For"      { to-rust($item) }
        when "SimpleDeclaration::Basic"     { to-rust($item) }
        when "SelectionStatement::If"       { to-rust($item) }
        default {
            die "need to add $typename to translate-cpp-ir-to-rust";
        }
    }
}

multi sub to-rust(
    CompoundStatement $item)
{
    debug "will translate CompoundStatement to Rust!";

    do for $item.statement-seq.List {
        to-rust($_)
    }.join("\n")
}

multi sub to-rust(EqualityExpression $item) {
    ddt $item;
    exit;
}

multi sub translate-condition($condition, "! I") {
    $condition.gist
}

multi sub translate-condition($condition, "! E") {
    "!" ~ to-rust($condition.unary-expression)
}

multi sub translate-condition($condition, "E == E") {
    to-rust($condition)
}

multi sub translate-condition($condition, "E != I") {
    to-rust($condition)
}

multi sub translate-condition($condition, "E == I") {
    to-rust($condition)
}

multi sub translate-condition($condition, "! I()") {

    "!" ~ to-rust($condition.unary-expression)
}

multi sub translate-condition($condition, "E == E || (! E && E == E)") {
    to-rust($condition)
}

multi sub translate-condition($condition, $treemark) {
    say "need to write method to translate";
    say $condition;
    say "treemark => $treemark";
    die "<program terminated>";
}

multi sub to-rust(
    SelectionStatement::If $item)
{
    debug "will translate SelectionStatement::If to Rust!";
    my $condition  = $item.condition;
    my @statements = $item.statements;

    my $rust-condition = translate-condition(
        $condition,
        $condition.gist(treemark => True)
    );

    my $statements = @statements>>.&to-rust.join("\n");

    say "--------------translation:";
    say qq:to/END/
    if $rust-condition \{
    $statements.indent(4)
    \}
    END
}

multi sub to-rust(
    BooleanLiteral::F:D $item)
{
    $item.gist
}

multi sub to-rust(
    PrimaryExpression::Id:D $item)
{
    $item.gist
}

multi sub to-rust(
    BooleanLiteral::T:D $item)
{
    $item.gist
}

multi sub to-rust(
    SimpleDeclaration::Basic $item)
{
    debug "will translate SimpleDeclaration::Basic to Rust!";
    my $mask = $item.gist(treemark => True);
    translate-simple-declaration-to-rust($mask, $item)
}

multi sub translate-simple-declaration-to-rust(
    Str $mask,
    SimpleDeclaration::Basic $item) 
{
    die "need write hook for mask! $mask";
}

multi sub translate-simple-declaration-to-rust(
     "I I = T(Es);",
    SimpleDeclaration::Basic:D $item) 
{
    debug "mask I I = T(Es);";
}

multi sub translate-simple-declaration-to-rust(
    "T I;",
    SimpleDeclaration::Basic $item) 
{
    debug "mask T I;";
}

multi sub translate-simple-declaration-to-rust(
    "I(Es);",
    SimpleDeclaration::Basic $item) 
{
    debug "mask I(Es);";
    ddt $item;
    exit;
}

multi sub translate-simple-declaration-to-rust(
    "I (I);",
    SimpleDeclaration::Basic $item) 
{
    debug "mask I (I);";
}

multi sub translate-simple-declaration-to-rust(
    "T I = E;",
    SimpleDeclaration::Basic $item) 
{
    debug "mask T I = E;";
    ddt $item;
}

multi sub translate-simple-declaration-to-rust(
    "T I(Es);",
    SimpleDeclaration::Basic $item) 
{
    debug "mask T I(Es);";
    my $rust-type   = to-rust-type($item.decl-specifier-seq);
    my $rust-ident  = to-rust-ident($item.init-declarator-list[0].declarator);
    my $rust-params = to-rust-params($item.init-declarator-list[0].initializer);
    qq:to/END/
    let {$rust-ident}: {$rust-type} = {$rust-type}::new($rust-params);
    END
}

multi sub to-rust(
    ExpressionStatement $item)
{
    debug "will translate ExpressionStatement to Rust!";

}

multi sub to-rust(
    LogicalAndExpression $item)
{
    debug "will translate LogicalAndExpression to Rust!";

}

multi sub to-rust(
    LogicalOrExpression $item)
{
    debug "will translate LogicalOrExpression to Rust!";

}

multi sub to-rust(
    PostfixExpression $item)
{
    debug "will translate PostfixExpression to Rust!";
    ddt $item;
    say $item.gist(treemark => True);
    exit;

}

multi sub to-rust(
    PostfixExpressionList $item)
{
    translate-postfix-expression-list($item, $item.token-types)
}

multi sub to-rust(
    IterationStatement::ForRange $item)
{
    debug "will translate IterationStatement::ForRange to Rust!";

}

multi sub to-rust(
    IterationStatement::For $item)
{
    debug "will translate IterationStatement::For to Rust!";

}

multi sub to-rust(
    IterationStatement::While $item)
{
    debug "will translate IterationStatement::While to Rust!";

}

multi sub to-rust(
    IterationStatement::ForRange $item)
{
    debug "will translate IterationStatement::ForRange to Rust!";

}

multi sub to-rust(
    IterationStatement::For $item)
{
    debug "will translate IterationStatement::For to Rust!";

}

multi sub to-rust(
    IterationStatement::While $item)
{
    debug "will translate IterationStatement::While to Rust!";

}

multi sub to-rust(
    JumpStatement::Return $item)
{
    debug "will translate JumpStatement::Return to Rust!";

    if $item.return-statement-body {
        "return " ~ to-rust($item.return-statement-body) ~ ";"

    } else {
        "return;"
    }
}

multi sub to-rust(
    JumpStatement::Continue $item)
{
    debug "will translate JumpStatement::Continue to Rust!";

}

multi sub to-rust(TryBlock $item)
{
    debug "will translate TryBlock to Rust!";

}

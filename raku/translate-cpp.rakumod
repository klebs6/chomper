use translate-io;
use gcpp-roles;

our sub translate-cpp-ir-to-rust($typename, IStatement $item)
{
    given $typename {
        when "TryBlock" {
            use translate-cpp-tryblock;
            to-rust($item);
        }
        when "ExpressionStatement" {
            use translate-cpp-expression;
            to-rust($item);
        }
        when "CompoundStatement" {
            use translate-cpp-statement;
            to-rust($item);
        }
        when "JumpStatement::Return" {
            use translate-cpp-jump;
            return-statement-to-rust($item);
        }
        when "JumpStatement::Continue" {
            use translate-cpp-jump;
            continue-statement-to-rust($item);
        }
        when "IterationStatement::ForRange" {
            use translate-cpp-iteration;
            for-range-to-rust($item);
        }
        when "IterationStatement::While" {
            use translate-cpp-iteration;
            while-statement-to-rust($item);
        }
        when "IterationStatement::For" {
            use translate-cpp-iteration;
            for-statement-to-rust($item);
        }
        when "SimpleDeclaration::Basic" {
            use translate-cpp-declaration;
            to-rust($item);
        }
        when "SelectionStatement::If" {
            use translate-cpp-selection;
            to-rust($item);
        }
        default {
            die "need to add $typename to translate-cpp-ir-to-rust";
        }
    }
}

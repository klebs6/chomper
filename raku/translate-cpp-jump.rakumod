use translate-io;
use gcpp-jump-statement;

our sub return-statement-to-rust(
    JumpStatement::Return $item)
{
    debug "will translate JumpStatement::Return to Rust!";

}

our sub continue-statement-to-rust(
    JumpStatement::Continue $item)
{
    debug "will translate JumpStatement::Continue to Rust!";

}

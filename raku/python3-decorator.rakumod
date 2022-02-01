use python3-prelude;
use python3-args;

our class Python3::Decorator {
    has Python3::DottedName $.name is required;
    has Python3::Comment    $.comment;
    has Python3::ArgList    $.arglist;

    method to-rust-attr {
        my @names = $.name.names;
        "#[{@names[0].value}]"
    }
}


# an exception class makes it easier to test for
# specific error conditions in unit tests, but
# also in regular code
enum ErrorMode <TooMuch TooLittle NotSeenBefore>;

class X::Pythonesque::WrongIndentation is Exception {
    has Int $.got is required;
    has Int $.expected;
    has ErrorMode $.mode is required;
    method message() {
        if $.mode == TooMuch {
            return "Inconsistent indentation: expected "
                 ~ "at most $.expected, got $.got spaces";
        }
        elsif $.mode == TooLittle {
            return "Inconsistent indentation: expected "
                 ~ "more than $.expected, got $.got spaces";
        }
        else {
            return "Unexpected indentation level: $.got.";
        }
    }
}

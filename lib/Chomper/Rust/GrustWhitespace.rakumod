use Data::Dump::Tree;

#`(
Whitespace is any non-empty string containing only
characters that have the Pattern_White_Space
Unicode property, namely:

Rust is a "free-form" language, meaning that all
forms of whitespace serve only to separate tokens
in the grammar, and have no semantic significance.

A Rust program has identical meaning if each
whitespace element is replaced with any other
legal whitespace element, such as a single space
character.
)
our role Whitespace::Rules {
    token whitespace {
        | \x[0009] #(horizontal tab, '\t')
        | \x[000A] #(line feed, '\n')
        | \x[000B] #(vertical tab)
        | \x[000C] #(form feed)
        | \x[000D] #(carriage return, '\r')
        | \x[0020] #(space, ' ')
        | \x[0085] #(next line)
        | \x[200E] #(left-to-right mark)
        | \x[200F] #(right-to-left mark)
        | \x[2028] #(line separator)
        | \x[2029] #(paragraph separator)
    }
}

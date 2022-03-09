=begin comment
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
=end comment
our role Whitespace::Rules {
    token whitespace {
        | \u0009 #(horizontal tab, '\t')
        | \u000A #(line feed, '\n')
        | \u000B #(vertical tab)
        | \u000C #(form feed)
        | \u000D #(carriage return, '\r')
        | \u0020 #(space, ' ')
        | \u0085 #(next line)
        | \u200E #(left-to-right mark)
        | \u200F #(right-to-left mark)
        | \u2028 #(line separator)
        | \u2029 #(paragraph separator)
    }
}

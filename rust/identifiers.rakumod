sub is-not-crate-self-super-or-Self($token) {
    $token !~~ /crate | self | super | Self/
}

sub is-not-strict-or-reserved-keyword($token) {
=begin comment
    my $strict   = $StrictKeywords::strict-keywords;
    my $reserved = $ReservedKeywords::reserved-keywords;

    $token !~~ /$strict | $reserved/
=end comment
}

our role Identifiers::Rules {

    proto rule identifier-or-keyword { * }
    rule identifier-or-keyword:sym<a> { <xid-start> <xid-continue>* }
    rule identifier-or-keyword:sym<b> { _ <xid-continue>* }

    rule raw-identifier {
        "r#" 
        (<identifier-or-keyword>) <?{is-not-crate-self-super-or-Self($0)}>
    }

    rule non-keyword-identifier {
        (<identifier-or-keyword>) <?{is-not-strict-or-reserved-keyword($0)}>
    }

    proto rule identifier { * }
    rule identifier:sym<a> { <non-keyword-identifier> }
    rule identifier:sym<b> { <raw-identifier> }
}

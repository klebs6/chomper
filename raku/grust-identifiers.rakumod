use grust-strict-keywords;
use grust-reserved-keywords;

sub is-not-crate-self-super-or-Self($token) {
    $token !~~ /crate | self | super | Self/
}

sub is-not-strict-or-reserved-keyword($token) {
    my $strict   = $StrictKeywords::strict-keyword;
    my $reserved = $ReservedKeywords::reserved-keyword;

    $token !~~ /$strict | $reserved/
}

our role Identifiers::Rules {

    proto token identifier-or-keyword { * }
    token identifier-or-keyword:sym<a> { <xid-start> <xid-continue>* }
    token identifier-or-keyword:sym<b> { _ <xid-continue>* }

    token raw-identifier {
        "r#" 
        (<identifier-or-keyword>) <?{is-not-crate-self-super-or-Self($0)}>
    }

    token non-keyword-identifier {
        (<identifier-or-keyword>) <?{is-not-strict-or-reserved-keyword($0)}>
    }

    proto token identifier { * }
    token identifier:sym<a> { <non-keyword-identifier> }
    token identifier:sym<b> { <raw-identifier> }

    #---------------------
    proto rule identifier-or-underscore { * }

    rule identifier-or-underscore:sym<identifier> {
        <identifier>
    }

    rule identifier-or-underscore:sym<underscore> {
        <tok-underscore>
    }
}

our role Identifiers::Actions {}

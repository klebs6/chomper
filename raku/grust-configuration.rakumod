our role ConfigurationPredicate::Rules {

    proto rule configuration-predicate { * }

    rule configuration-predicate:sym<option> {
        <identifier> [ <tok-eq> <any-str-literal> ]?
    }

    rule configuration-predicate:sym<all> {
        <kw-all>
        <tok-lparen>
        <configuration-predicate-list>?
        <tok-rparen>
    }

    rule configuration-predicate:sym<any> {
        <kw-any>
        <tok-lparen>
        <configuration-predicate-list>?
        <tok-rparen>
    }

    rule configuration-predicate:sym<not> {
        <kw-not>
        <tok-lparen>
        <configuration-predicate>?
        <tok-rparen>
    }

    #---------------------
    proto token any-str-literal { * }

    token any-str-literal:sym<basic> {
        <string-literal>
    }

    token any-str-literal:sym<raw> {
        <raw-string-literal>
    }

    rule configuration-predicate-list {
        <configuration-predicate>+ %% <tok-comma>
    }
}

our role ConfigurationPredicate::Actions {

}

our role ConfigurationPredicate::Rules {

    proto rule configuration-predicate { * }

    rule configuration-predicate:sym<option> {
        <configuration-option>
    }

    rule configuration-predicate:sym<all> {
        <configuration-all>
    }

    rule configuration-predicate:sym<any> {
        <configuration-any>
    }

    rule configuration-predicate:sym<not> {
        <configuration-not>
    }

    #---------------------
    proto token any-str-literal { * }

    token any-str-literal:sym<basic> {
        <string-literal>
    }

    token any-str-literal:sym<raw> {
        <raw-string-literal>
    }

    rule configuration-option {
        <identifier> [ <tok-eq> <any-str-literal> ]?
    }

    rule configuration-all {
        <kw-all>
        <tok-lparen>
        <configuration-predicate-list>?
        <tok-rparen>
    }

    rule configuration-any {
        <kw-any>
        <tok-lparen>
        <configuration-predicate-list>?
        <tok-rparen>
    }

    rule configuration-not {
        <kw-not>
        <tok-lparen>
        <configuration-predicate>?
        <tok-rparen>
    }

    rule configuration-predicate-list {
        <configuration-predicate>+ %% <tok-comma>
    }
}

our role ConfigurationPredicate::Actions {

}

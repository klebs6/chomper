use Data::Dump::Tree;

our class ConfigurationPredicateOption {
    has $.identifier;
    has $.maybe-str-literal;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ConfigurationPredicateAll {
    has @.predicates;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ConfigurationPredicateAny {
    has @.predicates;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ConfigurationPredicateNot {
    has $.predicate;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

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

    method configuration-predicate:sym<option>($/) {
        make ConfigurationPredicateOption.new(
            identifier        => $<identifier>.made,
            maybe-str-literal => $<any-str-literal>.made,
            text => $/.Str,
        )
    }

    method configuration-predicate:sym<all>($/) {
        make ConfigurationPredicateAll.new(
            predicates => $<configuration-predicate-list>>>.made,
            text => $/.Str,
        )
    }

    method configuration-predicate:sym<any>($/) {
        make ConfigurationPredicateAny.new(
            predicates => $<configuration-predicate-list>>>.made,
            text => $/.Str,
        )
    }

    method configuration-predicate:sym<not>($/) {
        make ConfigurationPredicateNot.new(
            predicate => $<configuration-predicate-list>.made,
            text => $/.Str,
        )
    }

    #---------------------
    method any-str-literal:sym<basic>($/) {
        make $<string-literal>.made
    }

    method any-str-literal:sym<raw>($/) {
        make $<raw-string-literal>.made
    }

    method configuration-predicate-list($/) {
        make $<configuration-predicate>>>.made
    }
}

unit module Chomper::Rust::GrustConfiguration;

use Data::Dump::Tree;

class ConfigurationPredicateOption is export {
    has $.identifier;
    has $.maybe-str-literal;

    has $.text;

    method gist {

        my $builder = $.identifier.gist;

        if $.maybe-str-literal {

            $builder ~= "= " ~ $.any-str-literal.gist;
        }

        $builder
    }
}

class ConfigurationPredicateAll is export {
    has @.predicates;

    has $.text;

    method gist {
        "all(" ~ @.predicates.join(", ") ~ ")"
    }
}

class ConfigurationPredicateAny is export {
    has @.predicates;

    has $.text;

    method gist {
        "any(" ~ @.predicates.join(", ") ~ ")"
    }
}

class ConfigurationPredicateNot is export {
    has $.predicate;

    has $.text;

    method gist {
        "not(" ~ $.predicate.gist ~ ")"
    }
}

package ConfigurationPredicateGrammar is export {

    our role Rules {

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

    our role Actions {

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
}
